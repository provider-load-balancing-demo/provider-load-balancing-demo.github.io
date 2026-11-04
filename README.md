# Provider Load Balancing Demo

A static, single-page demo that visualizes how patients are distributed between providers by **load factor** (assigned patients ÷ weekly hours), and why a skew appears when a provider is added or someone's hours change: the provider with the lowest load factor receives *every* new patient until the others are caught up.

Features: editable providers, history timeline with read-only snapshots, skew indicator, ready-made scenarios, and a strategy dropdown (Current, Fair start, Batch cap, Smooth weighted round-robin) to compare fixes. Plain HTML/CSS/JS, no dependencies.

## Run locally

Requires only `just` and `docker`.

```sh
just serve        # http://localhost:8000 (python:3.12-alpine in Docker)
just serve 9000   # custom port
just open         # open in the browser
just test         # engine self-test (node:22-alpine in Docker)
```

## GitHub Pages

Settings → Pages → Deploy from a branch → `main` / root. All paths are relative, so no extra configuration is needed.
