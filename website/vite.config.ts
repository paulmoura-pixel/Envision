import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// GitHub Pages project sites live under /Envision/. The base path is
// configurable so the same code works locally, on a project site, or on a
// user/org site or custom domain (set VITE_BASE_PATH=/).
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  let base = env.VITE_BASE_PATH || (mode === 'production' ? '/Envision/' : '/');
  if (!base.startsWith('/')) base = `/${base}`;
  if (!base.endsWith('/')) base = `${base}/`;
  return {
    base,
    plugins: [react(), tailwindcss()],
  };
});
