# Only `just` and `docker` are required on the host.

default: serve

# Serve the static site at http://localhost:<port> (inside Docker)
serve port="8000":
    @echo "Serving on http://localhost:{{port}}  (Ctrl+C to stop)"
    docker run --rm -p {{port}}:8000 -v "$PWD":/site:ro -w /site python:3.12-alpine python -m http.server 8000

# Open the page in the default browser (host-only recipe)
open port="8000":
    xdg-open http://localhost:{{port}}

# Run the engine self-test inside Docker
test:
    docker run --rm -v "$PWD":/site:ro -w /site node:22-alpine node tests/run.js

# Capture screenshots (375px / 1280px, light / dark) into ./screenshots using headless Chromium in Docker
shots:
    mkdir -p screenshots
    for w in 375 1280; do for t in light dark; do \
      flag=""; [ "$t" = dark ] && flag="--force-dark-mode --enable-features=WebContentsForceDark"; \
      docker run --rm -v "$PWD":/site -w /site zenika/alpine-chrome:124 --no-sandbox --hide-scrollbars $flag \
        --window-size=$w,2400 --screenshot=/site/screenshots/$w-$t.png file:///site/index.html; \
    done; done
