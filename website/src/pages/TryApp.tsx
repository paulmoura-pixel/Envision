import { useEffect, useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import {
  ExternalLink, Smartphone, Monitor, RotateCw, AlertTriangle, Loader2, BookOpen, LogIn, UserRoundCheck,
  KeyRound, LayoutDashboard, WifiOff,
} from 'lucide-react';
import { Callout, PageHeader } from '../components/ui';
import { ENVISION_WEB_URL } from '../lib/config';

type View = 'phone' | 'full';
type LoadState = 'loading' | 'loaded' | 'slow';

const SLOW_AFTER_MS = 15000;

export default function TryApp() {
  const [view, setView] = useState<View>('phone');
  return (
    <>
      <PageHeader
        eyebrow="Live demo"
        title="Try Envision"
        intro="Experience Envision for yourself. Explore the interface, create your profile, and discover how Envision connects fitness tracking with personal coaching."
      >
        {ENVISION_WEB_URL && (
          <a href={ENVISION_WEB_URL} target="_blank" rel="noopener noreferrer" className="btn-primary">
            <ExternalLink className="h-4 w-4" aria-hidden="true" />
            Open Envision in a new tab
            <span className="sr-only">(opens in a new tab)</span>
          </a>
        )}
      </PageHeader>

      <div
        className={`container-page mt-10 grid gap-10 ${view === 'full' ? '' : 'lg:grid-cols-[minmax(0,1fr)_340px]'}`}
      >
        <div className="min-w-0">
          {ENVISION_WEB_URL ? <Embed url={ENVISION_WEB_URL} view={view} setView={setView} /> : <NotConfigured />}
        </div>
        <Instructions wide={view === 'full'} />
      </div>
    </>
  );
}

function Embed({ url, view, setView }: { url: string; view: View; setView: (v: View) => void }) {
  const [state, setState] = useState<LoadState>('loading');
  const [reloadKey, setReloadKey] = useState(0);
  const timer = useRef<number | undefined>(undefined);

  useEffect(() => {
    setState('loading');
    window.clearTimeout(timer.current);
    timer.current = window.setTimeout(() => setState((s) => (s === 'loading' ? 'slow' : s)), SLOW_AFTER_MS);
    return () => window.clearTimeout(timer.current);
  }, [reloadKey]);

  const onLoad = () => {
    window.clearTimeout(timer.current);
    setState('loaded');
  };

  const isPhone = view === 'phone';

  return (
    <section aria-labelledby="demo-heading">
      <h2 id="demo-heading" className="sr-only">Embedded Envision web app</h2>

      <Callout type="warning" title="This demo uses the real Envision backend">
        Signing in creates a real account in the project&apos;s Firebase database, and anything you enter is saved.
        Your Google or Apple name and email are shared with the app when you sign in. Please don&apos;t enter sensitive
        health information.
      </Callout>

      <div className="mb-4 flex flex-wrap items-center justify-between gap-3">
        <div role="group" aria-label="Display size" className="hidden rounded-full border border-line bg-surface p-1 md:inline-flex">
          <ToggleBtn active={isPhone} onClick={() => setView('phone')} icon={<Smartphone className="h-4 w-4" />}>
            Phone
          </ToggleBtn>
          <ToggleBtn active={!isPhone} onClick={() => setView('full')} icon={<Monitor className="h-4 w-4" />}>
            Full width
          </ToggleBtn>
        </div>
        <div className="flex gap-2">
          <button type="button" onClick={() => setReloadKey((k) => k + 1)} className="btn-secondary px-4 py-2 text-sm">
            <RotateCw className="h-4 w-4" aria-hidden="true" /> Reload
          </button>
          <a href={url} target="_blank" rel="noopener noreferrer" className="btn-secondary px-4 py-2 text-sm">
            <ExternalLink className="h-4 w-4" aria-hidden="true" /> New tab
            <span className="sr-only">(opens in a new tab)</span>
          </a>
        </div>
      </div>

      <div
        className={`relative mx-auto ${
          isPhone
            ? 'w-full md:w-[390px] md:rounded-[3rem] md:bg-ink md:p-3 md:shadow-[0_40px_80px_-30px_rgba(17,17,17,0.45)]'
            : 'w-full'
        }`}
      >
        <div
          className={`relative overflow-hidden bg-white ${
            isPhone
              ? 'h-[78dvh] min-h-[560px] rounded-2xl border border-line md:h-[780px] md:min-h-0 md:rounded-[2.3rem] md:border-0'
              : 'h-[78dvh] min-h-[560px] rounded-2xl border border-line md:h-[820px]'
          }`}
        >
          {state !== 'loaded' && (
            <div className="absolute inset-0 z-10 flex flex-col items-center justify-center gap-4 bg-white p-6 text-center" role="status" aria-live="polite">
              {state === 'loading' ? (
                <>
                  <Loader2 className="h-9 w-9 animate-spin text-brand" aria-hidden="true" />
                  <p className="font-semibold">Loading Envision…</p>
                  <p className="max-w-xs text-sm text-muted">Flutter web apps can take a few seconds to start the first time.</p>
                </>
              ) : (
                <>
                  <WifiOff className="h-9 w-9 text-muted" aria-hidden="true" />
                  <p className="font-semibold">This is taking longer than usual</p>
                  <p className="max-w-xs text-sm text-muted">
                    The embedded app hasn&apos;t finished loading. Your network, an extension, or a browser privacy setting
                    may be blocking it.
                  </p>
                  <div className="flex flex-wrap justify-center gap-2">
                    <a href={url} target="_blank" rel="noopener noreferrer" className="btn-primary px-5 py-2.5 text-sm">
                      <ExternalLink className="h-4 w-4" aria-hidden="true" /> Open in new tab
                    </a>
                    <button type="button" onClick={() => setReloadKey((k) => k + 1)} className="btn-secondary px-5 py-2.5 text-sm">
                      <RotateCw className="h-4 w-4" aria-hidden="true" /> Try again
                    </button>
                  </div>
                </>
              )}
            </div>
          )}
          <iframe
            key={reloadKey}
            src={url}
            title="Envision web app (interactive demo)"
            onLoad={onLoad}
            className="h-full w-full border-0"
            allow="clipboard-write; fullscreen; camera"
            referrerPolicy="strict-origin-when-cross-origin"
          />
        </div>
      </div>

      <p className="mx-auto mt-4 max-w-xl text-center text-sm text-muted">
        Blank screen, an error, or sign-in not working?{' '}
        <a href={url} target="_blank" rel="noopener noreferrer" className="link">
          Open Envision directly
        </a>
        . Some browsers block sign-in pop-ups inside embedded pages.
      </p>

      <EmbedNotes />
    </section>
  );
}

function ToggleBtn({
  active, onClick, icon, children,
}: { active: boolean; onClick: () => void; icon: React.ReactNode; children: string }) {
  return (
    <button
      type="button"
      aria-pressed={active}
      onClick={onClick}
      className={`inline-flex items-center gap-2 rounded-full px-4 py-2 text-sm font-semibold transition ${
        active ? 'bg-white text-ink shadow-sm' : 'text-muted hover:text-ink'
      }`}
    >
      <span aria-hidden="true">{icon}</span>
      {children}
    </button>
  );
}

function NotConfigured() {
  return (
    <div className="card flex flex-col items-center p-10 text-center">
      <AlertTriangle className="h-10 w-10 text-[#8a5a00]" aria-hidden="true" />
      <h2 className="mt-4 text-2xl font-bold">The live demo isn&apos;t connected yet</h2>
      <p className="mt-2 max-w-md text-muted">
        The address of the Envision web app hasn&apos;t been configured for this build of the website. In the meantime,
        the user guide walks through every screen with screenshots.
      </p>
      <Link to="/guide" className="btn-primary mt-6">
        <BookOpen className="h-4 w-4" aria-hidden="true" /> Read the User Guide
      </Link>
      <p className="mt-6 max-w-md text-xs text-muted">
        Site maintainers: set <code className="rounded bg-surface px-1.5 py-0.5">VITE_ENVISION_WEB_URL</code> in{' '}
        <code className="rounded bg-surface px-1.5 py-0.5">.env</code> or as a GitHub Actions variable, then rebuild.
      </p>
    </div>
  );
}

function EmbedNotes() {
  return (
    <details className="card mt-8 p-5 text-sm leading-6 text-[#3a3f47] [&_summary]:cursor-pointer">
      <summary className="font-semibold text-ink">About the embedded view</summary>
      <ul className="mt-3 list-disc space-y-2 pl-5">
        <li>
          The app is loaded straight from its FlutterFlow hosting. It isn&apos;t a copy or a recording, and this website
          can&apos;t see anything you do inside it.
        </li>
        <li>
          The app&apos;s server currently sends no <code>X-Frame-Options</code> or <code>Content-Security-Policy</code>{' '}
          header, so browsers allow it to be embedded (checked November 2026). If that changes, the frame may go blank;
          use &quot;Open in new tab&quot; instead.
        </li>
        <li>
          Google and Apple sign-in open a pop-up window. Safari, Firefox and Chrome with strict privacy settings may
          block pop-ups or third-party storage inside embedded pages. If sign-in fails or you are signed out after
          reloading, use the app in its own tab.
        </li>
        <li>On phones, the app works best in its own tab, where it can use the whole screen.</li>
      </ul>
    </details>
  );
}

function Instructions({ wide }: { wide: boolean }) {
  const steps = [
    { icon: LogIn, title: 'Sign in', body: 'Choose "Continue with Gmail" or "Continue with Apple". A pop-up asks you to confirm your account.' },
    { icon: UserRoundCheck, title: 'Pick a role', body: 'Select Client to track your fitness, or Coach to create a training space.' },
    { icon: KeyRound, title: 'Join or set up', body: 'Clients enter a coach\'s invite code (or tap "Maybe later" if shown). Coaches name their space and choose specialties.' },
    { icon: LayoutDashboard, title: 'Explore', body: 'Clients land on their dashboard with nutrition tracking. Training and Progress are still in development.' },
  ];
  return (
    <aside aria-labelledby="how-to" className={wide ? 'mx-auto w-full max-w-3xl' : 'lg:sticky lg:top-24 lg:self-start'}>
      <div className="card p-6">
        <h2 id="how-to" className="font-sans text-lg font-bold">How to try it</h2>
        <ol className="mt-5 space-y-5">
          {steps.map((s, i) => (
            <li key={s.title} className="flex gap-3.5">
              <span className="relative inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-brand-soft text-brand-ink">
                <s.icon className="h-4 w-4" aria-hidden="true" />
                <span className="absolute -top-1 -right-1 inline-flex h-4.5 w-4.5 items-center justify-center rounded-full bg-ink text-[10px] font-bold text-white">
                  {i + 1}
                </span>
              </span>
              <div>
                <h3 className="font-sans text-[15px] font-semibold">{s.title}</h3>
                <p className="mt-0.5 text-sm leading-6 text-muted">{s.body}</p>
              </div>
            </li>
          ))}
        </ol>
        <Callout type="tip" title="No invite code?">
          You need a real code from a coach to join a training space. If you only want to look around, sign up as a
          coach, or use &quot;Maybe later&quot; when it appears.
        </Callout>
        <Link to="/guide" className="btn-secondary w-full">
          <BookOpen className="h-4 w-4" aria-hidden="true" /> Full user guide
        </Link>
      </div>
    </aside>
  );
}
