// Checks whether a URL allows being embedded in an iframe on another origin.
// Usage: npm run check:embed [-- https://your-app.flutterflow.app]
import { readFileSync, existsSync } from 'node:fs';

let url = process.argv[2];
if (!url && existsSync('.env')) {
  const m = readFileSync('.env', 'utf8').match(/^VITE_ENVISION_WEB_URL=(.+)$/m);
  url = m?.[1]?.trim();
}
if (!url) {
  console.error('No URL given and VITE_ENVISION_WEB_URL is not set in .env');
  process.exit(1);
}

const res = await fetch(url, { redirect: 'follow' });
const xfo = res.headers.get('x-frame-options');
const csp = res.headers.get('content-security-policy');
const html = await res.text();
const metaCsp = html.match(/<meta[^>]+http-equiv=["']Content-Security-Policy["'][^>]*>/i)?.[0];
const frameAncestors = csp?.match(/frame-ancestors[^;]*/i)?.[0];

console.log(`URL:                ${url}`);
console.log(`Status:             ${res.status}`);
console.log(`X-Frame-Options:    ${xfo ?? '(not set)'}`);
console.log(`CSP frame-ancestors:${frameAncestors ? ' ' + frameAncestors : ' (not set)'}`);
console.log(`<meta> CSP:         ${metaCsp ? 'present (frame-ancestors is ignored in meta tags)' : '(none)'}`);

const blocked =
  (xfo && /deny|sameorigin/i.test(xfo)) ||
  (frameAncestors && !/\*/.test(frameAncestors) && !/github\.io/.test(frameAncestors));
console.log(blocked
  ? '\nResult: embedding is BLOCKED by response headers. The Try page will rely on the "Open in new tab" fallback.'
  : '\nResult: no header blocks cross-origin embedding. The iframe should load.');
