import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Dumbbell, Users, Sparkles } from 'lucide-react';
import { CtaBand, PageHeader, PhoneFrame, StatusBadge } from '../components/ui';
import { features, type Feature } from '../data/features';
import { shot } from '../data/screenshots';

type Tab = 'client' | 'coach';

export default function Features() {
  const [tab, setTab] = useState<Tab>('client');
  const everyone = features.filter((f) => f.audience === 'everyone');
  const list = features.filter((f) => f.audience === tab);

  return (
    <>
      <PageHeader
        eyebrow="Features"
        title="Built for clients and the coaches who guide them"
        intro="Envision gives each side of the coaching relationship its own experience, with one shared space that connects them."
      >
        <Legend />
      </PageHeader>

      {/* Showcase */}
      <section className="container-page mt-16" aria-labelledby="showcase">
        <h2 id="showcase" className="sr-only">App preview</h2>
        <div className="grid items-center gap-12 lg:grid-cols-2">
          <div className="reveal">
            <p className="eyebrow">One app, two experiences</p>
            <h2 className="mt-2 text-3xl font-extrabold sm:text-4xl">From invite code to daily tracking in minutes</h2>
            <p className="mt-4 text-lg leading-8 text-muted">
              Clients join their coach with a code and land on a dashboard that shows their day at a glance. Coaches set
              up a space that reflects how and what they coach.
            </p>
            <ul className="mt-8 grid gap-4 sm:grid-cols-2">
              {everyone.map((f) => (
                <MiniFeature key={f.title} f={f} />
              ))}
            </ul>
          </div>
          <div className="reveal relative mx-auto flex w-full max-w-md justify-center">
            <div aria-hidden="true" className="absolute inset-10 rounded-full bg-brand/20 blur-3xl" />
            <PhoneFrame shot={shot('client-join')} className="relative mt-16 w-[44%] -rotate-3" />
            <PhoneFrame shot={shot('client-dashboard')} className="relative -ml-6 w-[50%] rotate-2" />
          </div>
        </div>
      </section>

      {/* Audience tabs */}
      <section className="container-page mt-24" aria-labelledby="by-role">
        <div className="flex flex-col items-start justify-between gap-6 sm:flex-row sm:items-end">
          <div>
            <p className="eyebrow">By role</p>
            <h2 id="by-role" className="mt-2 text-3xl font-extrabold">What you can do</h2>
          </div>
          <div role="tablist" aria-label="Choose audience" className="inline-flex rounded-full border border-line bg-surface p-1">
            {(['client', 'coach'] as Tab[]).map((t) => (
              <button
                key={t}
                role="tab"
                id={`tab-${t}`}
                aria-selected={tab === t}
                aria-controls={`panel-${t}`}
                tabIndex={tab === t ? 0 : -1}
                onClick={() => setTab(t)}
                onKeyDown={(e) => {
                  if (e.key === 'ArrowRight' || e.key === 'ArrowLeft') {
                    const next = t === 'client' ? 'coach' : 'client';
                    setTab(next);
                    document.getElementById(`tab-${next}`)?.focus();
                  }
                }}
                className={`inline-flex items-center gap-2 rounded-full px-5 py-2.5 text-sm font-semibold transition ${
                  tab === t ? 'bg-white text-ink shadow-sm' : 'text-muted hover:text-ink'
                }`}
              >
                {t === 'client' ? <Dumbbell className="h-4 w-4" aria-hidden="true" /> : <Users className="h-4 w-4" aria-hidden="true" />}
                For {t === 'client' ? 'clients' : 'coaches'}
              </button>
            ))}
          </div>
        </div>

        <div role="tabpanel" id={`panel-${tab}`} aria-labelledby={`tab-${tab}`} className="mt-10 space-y-6">
          {list.map((f, i) => (
            <FeatureRow key={f.title} f={f} flip={i % 2 === 1} />
          ))}
        </div>
      </section>

      <section className="container-page mt-20">
        <div className="reveal card flex flex-col items-start gap-4 bg-surface p-8 sm:flex-row sm:items-center">
          <Sparkles className="h-8 w-8 shrink-0 text-brand-ink" aria-hidden="true" />
          <p className="text-[15px] leading-7 text-[#30353d]">
            Envision is in active development. Features marked <StatusBadge status="development" /> are planned or only
            partly built, and are shown so you know what&apos;s coming, not as finished functionality. See the{' '}
            <Link to="/guide" className="link">user guide</Link> for how each feature works today.
          </p>
        </div>
      </section>

      <CtaBand />
    </>
  );
}

function Legend() {
  return (
    <div className="flex flex-wrap items-center gap-2 text-sm text-muted">
      <span>Status key:</span>
      <StatusBadge status="available" />
      <StatusBadge status="early" />
      <StatusBadge status="development" />
    </div>
  );
}

function MiniFeature({ f }: { f: Feature }) {
  return (
    <li className="flex gap-3">
      <span className="inline-flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-brand-soft text-brand-ink">
        <f.icon className="h-5 w-5" aria-hidden="true" />
      </span>
      <div>
        <h3 className="font-sans text-[15px] font-semibold">{f.title}</h3>
        <p className="mt-0.5 text-sm leading-6 text-muted">{f.body}</p>
      </div>
    </li>
  );
}

function FeatureRow({ f, flip }: { f: Feature; flip: boolean }) {
  const s = f.screenshot ? shot(f.screenshot) : null;
  return (
    <article className="reveal card overflow-hidden">
      <div className={`grid items-center gap-8 p-6 sm:p-10 ${s ? 'md:grid-cols-[minmax(0,1fr)_220px]' : ''}`}>
        <div className={flip && s ? 'md:order-2' : ''}>
          <div className="flex flex-wrap items-center gap-3">
            <span className="inline-flex h-12 w-12 items-center justify-center rounded-2xl bg-ink text-white">
              <f.icon className="h-6 w-6" aria-hidden="true" />
            </span>
            <StatusBadge status={f.status} />
          </div>
          <h3 className="mt-5 text-2xl font-bold">{f.title}</h3>
          <p className="mt-2 max-w-lg text-[15px] leading-7 text-muted">{f.body}</p>
        </div>
        {s ? (
          <PhoneFrame shot={s} className={`mx-auto w-[200px] ${flip ? 'md:order-1' : ''}`} />
        ) : null}
      </div>
    </article>
  );
}
