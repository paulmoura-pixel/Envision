import sharp from 'sharp';
import { mkdirSync } from 'node:fs';

const SRC = 'source-screenshots';
const OUT_SHOTS = 'public/screenshots';
const OUT_IMG = 'public/images';
mkdirSync(OUT_SHOTS, { recursive: true });
mkdirSync(OUT_IMG, { recursive: true });


const shots = [
  { src: '6.png', out: 'splash.png', top: 22, pad: 0 },
  { src: '2.png', out: 'role-select.png', top: 22, height: 680, pad: 0 },
  { src: '3.png', out: 'client-join.png', top: 22, pad: 0 },
  { src: '1.png', out: 'client-dashboard.png', top: 17, pad: 14, bg: '#ffffff' },
  { src: '4.png', out: 'coach-space.png', top: 22, pad: 0 },
  { src: '5.png', out: 'coach-specialties.png', top: 22, pad: 0 },
];

for (const s of shots) {
  const img = sharp(`${SRC}/${s.src}`);
  const { width, height } = await img.metadata();
  const border = 2;
  const h = (s.height ?? height - border) - s.top;
  let pipe = sharp(`${SRC}/${s.src}`).extract({
    left: border,
    top: s.top,
    width: width - border * 2,
    height: Math.min(h, height - s.top - border),
  });
  if (s.pad) pipe = pipe.extend({ top: s.pad, background: s.bg });

  // Normalise to 720px wide for better display on high-DPI screens

  await pipe.resize({ width: 720 }).png({ compressionLevel: 9 }).toFile(`${OUT_SHOTS}/${s.out}`);
  console.log('screenshot', s.out);
}

const bars = (color, sw = 14) => `
  <g stroke="${color}" stroke-width="${sw}" stroke-linecap="round" fill="none">
    <line x1="52" y1="38" x2="94" y2="27"/>
    <line x1="40" y1="61" x2="88" y2="49"/>
    <line x1="33" y1="84" x2="72" y2="74"/>
  </g>`;

// 512x512 app icon 

const iconSvg = `<svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 120 120">
  <defs><radialGradient id="g" cx="0.75" cy="0.15" r="1"><stop offset="0" stop-color="#2a1a0f"/><stop offset="0.6" stop-color="#111111"/></radialGradient></defs>
  <rect width="120" height="120" fill="url(#g)"/>
  <g transform="translate(-3 1)">${bars('#FF6B00', 13)}</g>
</svg>`;
await sharp(Buffer.from(iconSvg)).png().toFile(`${OUT_IMG}/app-icon-512.png`);
await sharp(Buffer.from(iconSvg)).resize(192).png().toFile(`${OUT_IMG}/app-icon-192.png`);
await sharp(Buffer.from(iconSvg)).resize(180).png().toFile('public/apple-touch-icon.png');
console.log('icon');

// 1024x500 feature graphic.

const shotA = await sharp(`${OUT_SHOTS}/client-dashboard.png`).resize({ width: 200 }).toBuffer();
const shotB = await sharp(`${OUT_SHOTS}/client-join.png`).resize({ width: 200 }).toBuffer();
const rounded = async (buf) => {
  const m = await sharp(buf).metadata();
  const mask = Buffer.from(`<svg width="${m.width}" height="${m.height}"><rect width="${m.width}" height="${m.height}" rx="22" ry="22"/></svg>`);
  return sharp(buf).composite([{ input: mask, blend: 'dest-in' }]).png().toBuffer();
};
const a = await rounded(shotA);
const b = await rounded(shotB);
const fgSvg = `<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="500">
  <defs>
    <radialGradient id="glow" cx="0.78" cy="0.5" r="0.55"><stop offset="0" stop-color="#FF6B00" stop-opacity="0.55"/><stop offset="1" stop-color="#FF6B00" stop-opacity="0"/></radialGradient>
  </defs>
  <rect width="1024" height="500" fill="#111111"/>
  <rect width="1024" height="500" fill="url(#glow)"/>
  <g transform="translate(64 120) scale(0.9)">${bars('#FF6B00', 13)}</g>
  <text x="170" y="200" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-weight="700" font-size="64" fill="#ffffff">Envision</text>
  <text x="72" y="270" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="30" fill="#e5e7eb">Plan workouts, track progress,</text>
  <text x="72" y="312" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="30" fill="#e5e7eb">and connect with your fitness coach.</text>
  <rect x="72" y="350" width="64" height="5" rx="2.5" fill="#FF6B00"/>
  <rect x="606" y="54" width="208" height="452" rx="28" fill="#000" opacity="0.6"/>
  <rect x="806" y="84" width="208" height="452" rx="28" fill="#000" opacity="0.6"/>
</svg>`;
await sharp(Buffer.from(fgSvg))
  .composite([
    { input: b, left: 610, top: 58 },
    { input: a, left: 810, top: 88 },
  ])
  .png()
  .toFile(`${OUT_IMG}/feature-graphic.png`);
console.log('feature graphic');

// Live sign-in screen 


await sharp(`${SRC}/7-signin-live.jpg`)
  .extract({ left: 0, top: 0, width: 400, height: 815 })
  .resize({ width: 720 })
  .png({ compressionLevel: 9 })
  .toFile(`${OUT_SHOTS}/sign-in.png`);
console.log('screenshot sign-in.png');
