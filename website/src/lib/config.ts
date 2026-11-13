// Resolve a file in /public against the deployed base path

export const asset = (path: string) => `${import.meta.env.BASE_URL}${path.replace(/^\//, '')}`;

const raw = (import.meta.env.VITE_ENVISION_WEB_URL as string | undefined)?.trim() ?? '';

// Published FlutterFlow web app URL

export const ENVISION_WEB_URL: string | null = (() => {
  if (!raw) return null;
  try {
    const u = new URL(raw);
    return u.protocol === 'https:' || u.protocol === 'http:' ? u.toString() : null;
  } catch {
    return null;
  }
})();
