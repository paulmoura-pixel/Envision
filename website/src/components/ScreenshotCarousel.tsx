import { useCallback, useEffect, useRef, useState } from 'react';
import { ChevronLeft, ChevronRight, X } from 'lucide-react';
import { asset } from '../lib/config';
import type { Screenshot } from '../data/screenshots';

// Horizontal and scroll snapping screenshot in the format of google play store listing. 

export default function ScreenshotCarousel({ shots }: { shots: Screenshot[] }) {
  const track = useRef<HTMLUListElement>(null);
  const [canPrev, setCanPrev] = useState(false);
  const [canNext, setCanNext] = useState(true);
  const [active, setActive] = useState<number | null>(null);

  const update = useCallback(() => {
    const el = track.current;
    if (!el) return;
    setCanPrev(el.scrollLeft > 4);
    setCanNext(el.scrollLeft + el.clientWidth < el.scrollWidth - 4);
  }, []);

  useEffect(() => {
    update();
    const el = track.current;
    el?.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', update);
    return () => {
      el?.removeEventListener('scroll', update);
      window.removeEventListener('resize', update);
    };
  }, [update]);

  const page = (dir: 1 | -1) => {
    const el = track.current;
    if (!el) return;
    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    el.scrollBy({ left: dir * el.clientWidth * 0.8, behavior: reduce ? 'auto' : 'smooth' });
  };

  return (
    <div className="relative">
      <ul
        ref={track}
        aria-label="App screenshots"
        className="no-scrollbar -mx-4 flex snap-x snap-mandatory gap-3 overflow-x-auto scroll-px-4 px-4 pb-2 sm:-mx-0 sm:scroll-px-0 sm:px-0"
      >
        {shots.map((s, i) => (
          <li key={s.src} className="shrink-0 snap-start">
            <button
              type="button"
              onClick={() => setActive(i)}
              className="group block overflow-hidden rounded-2xl border border-line bg-surface transition hover:shadow-lg hover:shadow-black/10"
              aria-label={`Enlarge screenshot ${i + 1} of ${shots.length}: ${s.title}`}
            >
              <img
                src={asset(s.src)}
                alt={s.alt}
                loading={i < 3 ? 'eager' : 'lazy'}
                decoding="async"
                className="h-[340px] w-auto max-w-none transition duration-500 group-hover:scale-[1.02] sm:h-[420px]"
              />
            </button>
            <p className="mt-2 text-xs font-medium text-muted">{s.title}</p>
          </li>
        ))}
      </ul>

      <button
        type="button"
        onClick={() => page(-1)}
        disabled={!canPrev}
        aria-label="Previous screenshots"
        className="absolute top-[170px] -left-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full border border-line bg-white shadow-md transition hover:bg-surface disabled:pointer-events-none disabled:opacity-0 sm:top-[210px] md:inline-flex"
      >
        <ChevronLeft className="h-5 w-5" />
      </button>
      <button
        type="button"
        onClick={() => page(1)}
        disabled={!canNext}
        aria-label="Next screenshots"
        className="absolute top-[170px] -right-4 hidden h-11 w-11 -translate-y-1/2 items-center justify-center rounded-full border border-line bg-white shadow-md transition hover:bg-surface disabled:pointer-events-none disabled:opacity-0 sm:top-[210px] md:inline-flex"
      >
        <ChevronRight className="h-5 w-5" />
      </button>

      {active !== null && (
        <Lightbox shots={shots} index={active} onChange={setActive} onClose={() => setActive(null)} />
      )}
    </div>
  );
}

function Lightbox({
  shots, index, onChange, onClose,
}: { shots: Screenshot[]; index: number; onChange: (i: number) => void; onClose: () => void }) {
  const dialog = useRef<HTMLDialogElement>(null);
  const s = shots[index];
  const go = useCallback((d: number) => onChange((index + d + shots.length) % shots.length), [index, onChange, shots.length]);

  useEffect(() => {
    const d = dialog.current;
    if (d && !d.open) d.showModal();
    document.body.style.overflow = 'hidden';
    return () => {
      document.body.style.overflow = '';
    };
  }, []);

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight') go(1);
      if (e.key === 'ArrowLeft') go(-1);
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [go]);

  return (
    <dialog
      ref={dialog}
      onClose={onClose}
      onClick={(e) => e.target === dialog.current && onClose()}
      aria-label={`Screenshot: ${s.title}`}
      className="m-auto max-h-none max-w-none bg-transparent p-0 backdrop:bg-black/80 backdrop:backdrop-blur-sm"
    >
      <div className="flex h-[100dvh] w-screen items-center justify-center gap-2 p-4 sm:gap-6">
        <button
          type="button"
          onClick={() => go(-1)}
          aria-label="Previous screenshot"
          className="inline-flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
        >
          <ChevronLeft className="h-6 w-6" />
        </button>
        <figure className="flex max-h-full min-w-0 flex-col items-center">
          <img
            src={asset(s.src)}
            alt={s.alt}
            className="h-auto max-h-[calc(100dvh-8rem)] w-[min(68vw,420px)] rounded-2xl bg-white object-contain shadow-2xl"
          />
          <figcaption className="mt-3 text-center text-sm text-white">
            <span className="font-semibold">{s.title}</span>
            <span className="text-white/70"> · {s.caption}</span>
            <span className="ml-2 text-white/50">
              {index + 1}/{shots.length}
            </span>
          </figcaption>
        </figure>
        <button
          type="button"
          onClick={() => go(1)}
          aria-label="Next screenshot"
          className="inline-flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
        >
          <ChevronRight className="h-6 w-6" />
        </button>
        <button
          type="button"
          onClick={() => dialog.current?.close()}
          aria-label="Close"
          autoFocus
          className="absolute top-4 right-4 inline-flex h-11 w-11 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
        >
          <X className="h-6 w-6" />
        </button>
      </div>
    </dialog>
  );
}
