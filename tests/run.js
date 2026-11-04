// Runs the engine self-test extracted from index.html (no DOM needed).
const fs = require('fs');
const vm = require('vm');
const html = fs.readFileSync(__dirname + '/../index.html', 'utf8');
const m = html.match(/<script id="engine">([\s\S]*?)<\/script>/);
if (!m) { console.error('engine script not found'); process.exit(1); }
const Engine = vm.runInNewContext(m[1] + '\n;Engine', { console });
const results = Engine.selfTest({ log: false });
results.forEach(r => console.log((r.ok ? 'ok   ' : 'FAIL ') + r.name));
const failed = results.filter(r => !r.ok).length;
console.log(`\n${results.length - failed}/${results.length} passed`);
process.exit(failed ? 1 : 0);
