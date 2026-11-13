import { useEffect } from 'react';
import { Outlet, useLocation } from 'react-router-dom';
import Navbar from './Navbar';
import Footer from './Footer';

const titles: Record<string, string> = {
  '/': 'Envision: Fitness coaching and tracking',
  '/features': 'Features | Envision',
  '/guide': 'User Guide | Envision',
  '/try': 'Try Envision',
  '/faq': 'FAQ | Envision',
  '/about': 'About | Envision',
  '/privacy': 'Privacy & Data | Envision',
  '/community': 'Community Data | Envision',
};

// Scrolls to top on route change, or to the #hash target when present

function useScrollManagement() {
  const { pathname, hash } = useLocation();
  useEffect(() => {
    document.title = titles[pathname] ?? 'Page not found | Envision';
    if (hash) {

      // Defer until the new page has rendered

      const t = window.setTimeout(() => {
        const el = document.getElementById(decodeURIComponent(hash.slice(1)));
        if (el) el.scrollIntoView({ behavior: 'instant' });
        else window.scrollTo({ top: 0, behavior: 'instant' });
      }, 30);
      return () => window.clearTimeout(t);
    }
    // Jump to the top on page changes

    window.scrollTo({ top: 0, behavior: 'instant' });
  }, [pathname, hash]);
}

// Fades in elements with the .reveal class as they are scrolled into view

function useReveal() {
  useEffect(() => {
    const pending = () => document.querySelectorAll<HTMLElement>('.reveal:not(.is-visible)');
    if (!('IntersectionObserver' in window) || !('MutationObserver' in window)) {
      const showAll = () => pending().forEach((el) => el.classList.add('is-visible'));
      showAll();
      const t = setInterval(showAll, 500);
      return () => clearInterval(t);
    }
    const io = new IntersectionObserver(
      (entries) =>
        entries.forEach((e) => {
          if (e.isIntersecting) {
            e.target.classList.add('is-visible');
            io.unobserve(e.target);
          }
        }),
      { rootMargin: '0px 0px -8% 0px' },
    );
    const observeAll = () => pending().forEach((el) => io.observe(el));
    observeAll();

    // Pick up elements rendered later 

    const mo = new MutationObserver(observeAll);
    mo.observe(document.body, { childList: true, subtree: true });
    return () => {
      io.disconnect();
      mo.disconnect();
    };
  }, []);
}

export default function Layout() {
  useScrollManagement();
  useReveal();
  return (
    <div className="flex min-h-screen flex-col">
      <a
        href="#main"
        className="sr-only z-[100] rounded-full bg-ink px-4 py-2 text-white focus:not-sr-only focus:fixed focus:top-3 focus:left-3"
      >
        Skip to content
      </a>
      <Navbar />
      <main id="main" tabIndex={-1} className="flex-1 outline-none">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}
