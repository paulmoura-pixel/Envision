import { useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Play, BookOpen, Share2, Check, ArrowRight, Globe, BadgeDollarSign, GraduationCap, ShieldCheck,
  ChevronDown, Mail, FileText, LifeBuoy, Lock, Database, Smartphone, Info,
} from 'lucide-react';
import ScreenshotCarousel from '../components/ScreenshotCarousel';
import { StatusBadge, TextLink } from '../components/ui';
import { app, longDescription } from '../data/app';
import { screenshots } from '../data/screenshots';
import { features } from '../data/features';
import { asset } from '../lib/config';

export default function Home() {
  return (
    <>
      <ListingHeader />
      <div className="container-page">
        <p className="mt-6 flex items-start gap-2 rounded-xl bg-surface px-4 py-3 text-xs leading-5 text-muted">
          <Info className="mt-0.5 h-4 w-4 shrink-0" aria-hidden="true" />
          {app.notice}
        </p>

        <section aria-labelledby="screens-heading" className="mt-10">
          <h2 id="screens-heading" className="sr-only">Screenshots</h2>
          <ScreenshotCarousel shots={screenshots} />
        </section>

        <div className="mt-12 grid gap-12 lg:grid-cols-[minmax(0,1fr)_320px]">
          <div className="min-w-0 space-y-14">
            <AboutThisApp />
            <Highlights />
            <DataSafety />
            <WhatsNew />
            <AppInfo />
          </div>
          <Sidebar />
        </div>
      </div>
    </>
  );
}

// ------------------------------------------------------------------ 

function ListingHeader() {
  const [copied, setCopied] = useState(false);

  const share = async () => {
    const url = window.location.href;
    try {
      if (navigator.share) {
        await navigator.share({ title: 'Envision', text: app.shortDescription, url });
        return;
      }
      await navigator.clipboard.writeText(url);
      setCopied(true);
      setTimeout(() => setCopied(false), 2200);
    } catch {

      // user cancelled the share sheet or the clipboard is unavailable 
      
    }
  };

  const meta = [
    { icon: Globe, top: 'Web', bottom: 'Platform' },
    { icon: BadgeDollarSign, top: 'Free', bottom: 'Demo' },
    { icon: GraduationCap, top: 'Student', bottom: 'Project' },
    { icon: ShieldCheck, top: 'Google / Apple', bottom: 'Sign-in' },
  ];

  return (
    <section className="relative overflow-hidden">
      <div aria-hidden="true" className="pointer-events-none absolute inset-0">
        <div className="absolute -top-48 right-[-8%] h-[28rem] w-[28rem] rounded-full bg-brand/12 blur-3xl" />
        <div className="absolute top-24 left-[-12%] h-72 w-72 rounded-full bg-[#ffd9bd]/30 blur-3xl" />
      </div>
      <div className="container-page relative grid items-center gap-10 pt-10 pb-4 sm:pt-14 lg:grid-cols-[minmax(0,1fr)_auto]">
        <div className="min-w-0">
          <div className="flex items-start gap-4 sm:gap-5">
            <img
              src={asset('images/app-icon-512.png')}
              alt="Envision app icon"
              width={96}
              height={96}
              className="h-20 w-20 shrink-0 animate-fade-up rounded-[22%] shadow-lg shadow-black/15 ring-1 ring-black/5 sm:h-24 sm:w-24 lg:hidden"
            />
            <div className="min-w-0 animate-fade-up">
              <h1 className="text-4xl font-extrabold sm:text-6xl">Envision</h1>
              <p className="mt-2">
                <Link to="/about" className="font-semibold text-brand-ink hover:underline underline-offset-4">
                  {app.developer}
                </Link>
              </p>
              <p className="mt-1 text-sm text-muted">{app.category} · In active development</p>
            </div>
          </div>

          <p className="mt-6 max-w-2xl animate-fade-up text-lg leading-8 text-[#30353d]">
            <span className="font-semibold text-ink">{app.headline}</span> {app.tagline}
          </p>

          <dl className="mt-7 flex max-w-xl animate-fade-up divide-x divide-line overflow-x-auto no-scrollbar">
            {meta.map((m) => (
              <div key={m.bottom} className="flex shrink-0 flex-col items-center px-4 text-center first:pl-0 sm:flex-1 sm:px-3">
                <dt className="sr-only">{m.bottom}</dt>
                <dd className="flex items-center gap-1 text-sm font-semibold whitespace-nowrap text-ink">
                  <m.icon className="h-4 w-4 text-brand-ink" aria-hidden="true" />
                  {m.top}
                </dd>
                <dd className="mt-1 text-xs text-muted" aria-hidden="true">
                  {m.bottom}
                </dd>
              </div>
            ))}
          </dl>

          <div className="mt-8 flex animate-fade-up flex-wrap items-center gap-3">
            <Link to="/try" className="btn-primary px-8 py-3.5 text-base">
              <Play className="h-4 w-4 fill-current" aria-hidden="true" />
              Try Envision
            </Link>
            <Link to="/guide" className="btn-secondary px-6 py-3.5 text-base">
              <BookOpen className="h-4 w-4" aria-hidden="true" />
              Read User Guide
            </Link>
            <button type="button" onClick={share} className="btn-ghost px-4 py-3.5" aria-live="polite">
              {copied ? <Check className="h-4 w-4" aria-hidden="true" /> : <Share2 className="h-4 w-4" aria-hidden="true" />}
              {copied ? 'Link copied' : 'Share'}
            </button>
          </div>
          <p className="mt-3 flex items-center gap-1.5 text-sm text-muted">
            <Smartphone className="h-4 w-4" aria-hidden="true" />
            Runs in your browser on phones, tablets and computers.
          </p>
        </div>

        <div className="relative hidden animate-fade-up lg:block">
          <img
            src={asset('images/app-icon-512.png')}
            alt="Envision app icon"
            width={240}
            height={240}
            className="h-60 w-60 rounded-[22%] shadow-2xl shadow-black/25 ring-1 ring-black/5"
          />
        </div>
      </div>
    </section>
  );
}

function SectionTitle({ id, children, to }: { id: string; children: string; to?: string }) {
  return (
    <div className="flex items-center justify-between gap-4">
      <h2 id={id} className="text-2xl font-bold">
        {children}
      </h2>
      {to && (
        <Link
          to={to}
          className="inline-flex h-10 w-10 items-center justify-center rounded-full hover:bg-surface"
          aria-label={`More: ${children}`}
        >
          <ArrowRight className="h-5 w-5" aria-hidden="true" />
        </Link>
      )}
    </div>
  );
}

function AboutThisApp() {
  const [expanded, setExpanded] = useState(false);
  return (
    <section aria-labelledby="about-app" className="reveal">
      <SectionTitle id="about-app" to="/features">About this app</SectionTitle>
      <p className="mt-4 text-[17px] leading-7 text-[#30353d]">{app.shortDescription}</p>

      <div className="relative mt-4">
        <div
          id="long-description"
          className={`space-y-5 overflow-hidden text-[15px] leading-7 text-[#3a3f47] transition-[max-height] duration-500 ${
            expanded ? 'max-h-[2400px]' : 'max-h-44'
          }`}
        >
          {longDescription.map((b, i) => (
            <div key={i}>
              {b.heading && <h3 className="mb-1.5 font-sans text-base font-semibold text-ink">{b.heading}</h3>}
              {b.text && <p>{b.text}</p>}
              {b.bullets && (
                <ul className="list-disc space-y-1 pl-5 marker:text-brand">
                  {b.bullets.map((x) => (
                    <li key={x}>{x}</li>
                  ))}
                </ul>
              )}
            </div>
          ))}
        </div>
        {!expanded && (
          <div aria-hidden="true" className="pointer-events-none absolute inset-x-0 bottom-0 h-20 bg-gradient-to-t from-white" />
        )}
      </div>
      <button
        type="button"
        onClick={() => setExpanded((v) => !v)}
        aria-expanded={expanded}
        aria-controls="long-description"
        className="mt-3 inline-flex items-center gap-1 rounded-full px-1 font-semibold text-brand-ink hover:underline underline-offset-4"
      >
        {expanded ? 'Show less' : 'Read more'}
        <ChevronDown className={`h-4 w-4 transition-transform ${expanded ? 'rotate-180' : ''}`} aria-hidden="true" />
      </button>

      <div className="mt-6 flex flex-wrap gap-2">
        {['Health & Fitness', 'Personal training', 'Nutrition', 'Coaching'].map((t) => (
          <span key={t} className="rounded-full border border-line px-3.5 py-1.5 text-sm text-[#374151]">
            {t}
          </span>
        ))}
      </div>
    </section>
  );
}

function Highlights() {
  const picks = features.filter((f) =>
    ['Join your coach with a code', 'Nutrition tracking', 'Client and coach accounts', 'Your own training space', 'Pick up where you left off', 'Training'].includes(f.title),
  );
  return (
    <section aria-labelledby="highlights" className="reveal">
      <SectionTitle id="highlights" to="/features">Feature highlights</SectionTitle>
      <ul className="mt-6 grid gap-4 sm:grid-cols-2">
        {picks.map((f) => (
          <li key={f.title} className="card group p-5 transition hover:-translate-y-0.5 hover:shadow-xl hover:shadow-black/5">
            <div className="flex items-start justify-between gap-3">
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-2xl bg-brand-soft text-brand-ink transition group-hover:bg-brand group-hover:text-white">
                <f.icon className="h-5 w-5" aria-hidden="true" />
              </span>
              <StatusBadge status={f.status} />
            </div>
            <h3 className="mt-4 font-sans text-base font-semibold">{f.title}</h3>
            <p className="mt-1.5 text-sm leading-6 text-muted">{f.body}</p>
          </li>
        ))}
      </ul>
    </section>
  );
}

function DataSafety() {
  const rows = [
    { icon: Lock, text: 'Sign-in handled by Firebase Authentication through Google or Apple. No passwords are stored by Envision.' },
    { icon: Database, text: 'Profile details, your coach link and nutrition entries are stored in Google Cloud Firestore.' },
    { icon: ShieldCheck, text: 'No public profiles, leaderboards or directories. This website shows no user data.' },
  ];
  return (
    <section aria-labelledby="data-safety" className="reveal">
      <SectionTitle id="data-safety" to="/privacy">Data &amp; privacy</SectionTitle>
      <p className="mt-3 text-[15px] leading-7 text-muted">
        A summary of how Envision handles data, based on how the app is built. Details still being confirmed are marked
        on the privacy page.
      </p>
      <div className="card mt-5 divide-y divide-line">
        {rows.map((r) => (
          <div key={r.text} className="flex gap-4 p-5">
            <r.icon className="mt-0.5 h-5 w-5 shrink-0 text-muted" aria-hidden="true" />
            <p className="text-[15px] leading-6 text-[#30353d]">{r.text}</p>
          </div>
        ))}
        <div className="p-5">
          <TextLink to="/privacy">See details</TextLink>
        </div>
      </div>
    </section>
  );
}

function WhatsNew() {
  return (
    <section aria-labelledby="whats-new" className="reveal">
      <SectionTitle id="whats-new">What&apos;s new</SectionTitle>
      <p className="mt-1 text-sm text-muted">Latest web build · {app.updated}</p>
      <ul className="mt-4 list-disc space-y-1.5 pl-5 text-[15px] leading-7 text-[#3a3f47] marker:text-brand">
        <li>New welcome screen with Google and Apple sign-in.</li>
        <li>Client dashboard with daily calories, macros and a meal log.</li>
        <li>Coaches can create a training space and choose their specialties.</li>
        <li>Clients join a coach with an invite code; the optional &quot;Maybe later&quot; path is being tested.</li>
      </ul>
    </section>
  );
}

function AppInfo() {
  const rows: [string, string][] = [
    ['Category', app.category],
    ['Platform', app.platform],
    ['Price', app.price],
    ['Sign-in', app.signIn],
    ['Built with', app.builtWith],
    ['Status', app.status],
    ['Developer', app.developer],
    ['Updated', app.updated],
  ];
  return (
    <section aria-labelledby="app-info" className="reveal">
      <SectionTitle id="app-info">App information</SectionTitle>
      <dl className="mt-5 grid gap-x-8 gap-y-5 sm:grid-cols-2">
        {rows.map(([k, v]) => (
          <div key={k} className="border-b border-line pb-4">
            <dt className="text-sm font-semibold text-ink">{k}</dt>
            <dd className="mt-1 text-[15px] text-muted">{v}</dd>
          </div>
        ))}
      </dl>
      <p className="mt-5 text-xs leading-5 text-muted">
        Ratings, reviews, download counts and an age rating are not shown because Envision has not been published to
        an app store.
      </p>
    </section>
  );
}

function Sidebar() {
  const [open, setOpen] = useState(true);
  return (
    <aside className="space-y-6 lg:sticky lg:top-24 lg:self-start" aria-label="App support and preview">
      <div className="card p-5">
        <button
          type="button"
          onClick={() => setOpen((v) => !v)}
          aria-expanded={open}
          aria-controls="support-links"
          className="flex w-full items-center justify-between text-left"
        >
          <h2 className="font-sans text-lg font-bold">App support</h2>
          <ChevronDown className={`h-5 w-5 transition-transform ${open ? 'rotate-180' : ''}`} aria-hidden="true" />
        </button>
        <ul id="support-links" hidden={!open} className="mt-4 space-y-1">
          {[
            { to: '/guide', icon: LifeBuoy, label: 'User guide', sub: 'Step-by-step instructions' },
            { to: '/faq', icon: Mail, label: 'Frequently asked questions', sub: 'Quick answers' },
            { to: '/privacy', icon: FileText, label: 'Privacy & data', sub: 'What the app stores' },
            { to: '/about', icon: GraduationCap, label: 'About the project', sub: 'Team and technology' },
          ].map((l) => (
            <li key={l.to}>
              <Link to={l.to} className="flex items-center gap-3 rounded-xl p-2.5 hover:bg-surface">
                <l.icon className="h-5 w-5 text-muted" aria-hidden="true" />
                <span>
                  <span className="block text-sm font-semibold">{l.label}</span>
                  <span className="block text-xs text-muted">{l.sub}</span>
                </span>
              </Link>
            </li>
          ))}
        </ul>
      </div>

      <div className="card overflow-hidden">
        <img
          src={asset('images/feature-graphic.png')}
          alt="Envision feature graphic: the Envision logo and the line 'Plan workouts, track progress, and connect with your fitness coach' beside two app screens."
          className="block aspect-[1024/500] w-full object-cover"
          loading="lazy"
        />
        <div className="p-5">
          <h2 className="font-sans text-lg font-bold">Try it in your browser</h2>
          <p className="mt-1 text-sm leading-6 text-muted">The live Envision web app, embedded on this site.</p>
          <Link to="/try" className="btn-primary mt-4 w-full">
            <Play className="h-4 w-4 fill-current" aria-hidden="true" /> Try Envision
          </Link>
        </div>
      </div>
    </aside>
  );
}
