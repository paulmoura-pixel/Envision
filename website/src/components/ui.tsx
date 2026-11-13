import { useId, useState, type ReactNode } from 'react';
import { Link } from 'react-router-dom';
import { ChevronDown, Info, AlertTriangle, Lightbulb, Construction, ArrowRight, BookOpen, Play } from 'lucide-react';
import { asset } from '../lib/config';
import type { FeatureStatus } from '../data/features';
import { statusLabel } from '../data/features';
import type { Screenshot } from '../data/screenshots';

// ---------- Phone frame ---------- 

export function PhoneFrame({
  shot, className = '', priority = false,
}: { shot: Screenshot; className?: string; priority?: boolean }) {
  return (
    <figure className={`relative ${className}`}>
      <div className="rounded-[2.2rem] bg-ink p-[7px] shadow-[0_30px_60px_-20px_rgba(17,17,17,0.35)] ring-1 ring-black/10">
        <div className="overflow-hidden rounded-[1.8rem] bg-white">
          <img
            src={asset(shot.src)}
            alt={shot.alt}
            loading={priority ? 'eager' : 'lazy'}
            decoding="async"
            className="block aspect-[9/19] w-full object-cover object-top"
          />
        </div>
      </div>
    </figure>
  );
}

// ---------- Status badge ---------- 

const badgeStyle: Record<FeatureStatus, string> = {
  available: 'bg-[#e8f6ee] text-[#17663a]',
  early: 'bg-[#eef2ff] text-[#3740a5]',
  development: 'bg-[#fff4e5] text-[#8a4b00]',
};
export function StatusBadge({ status }: { status: FeatureStatus }) {
  return (
    <span className={`inline-flex items-center gap-1 rounded-full px-2.5 py-1 text-xs font-semibold ${badgeStyle[status]}`}>
      {status === 'development' && <Construction className="h-3.5 w-3.5" aria-hidden="true" />}
      {statusLabel[status]}
    </span>
  );
}

// ---------- Callout ---------- 

const calloutStyles = {
  info: { icon: Info, cls: 'border-[#c9d7ff] bg-[#f3f6ff]', iconCls: 'text-[#3348c4]', label: 'Note' },
  tip: { icon: Lightbulb, cls: 'border-[#ffd8b8] bg-brand-soft', iconCls: 'text-brand-ink', label: 'Tip' },
  warning: { icon: AlertTriangle, cls: 'border-[#f5d48a] bg-[#fffaeb]', iconCls: 'text-[#8a5a00]', label: 'Important' },
  planned: { icon: Construction, cls: 'border-line bg-surface', iconCls: 'text-muted', label: 'In development' },
} as const;

export function Callout({
  type = 'info', title, children,
}: { type?: keyof typeof calloutStyles; title?: string; children: ReactNode }) {
  const s = calloutStyles[type];
  const Icon = s.icon;
  return (
    <aside className={`my-5 flex gap-3 rounded-2xl border p-4 text-[15px] leading-6 ${s.cls}`} role="note">
      <Icon className={`mt-0.5 h-5 w-5 shrink-0 ${s.iconCls}`} aria-hidden="true" />
      <div>
        <p className="font-semibold text-ink">{title ?? s.label}</p>
        <div className="mt-0.5 text-[#30353d]">{children}</div>
      </div>
    </aside>
  );
}

// ---------- Accordion ---------- 

export function AccordionItem({
  title, children, defaultOpen = false,
}: { title: ReactNode; children: ReactNode; defaultOpen?: boolean }) {
  const [open, setOpen] = useState(defaultOpen);
  const id = useId();
  return (
    <div className="border-b border-line last:border-b-0">
      <h3 className="font-sans">
        <button
          type="button"
          aria-expanded={open}
          aria-controls={`${id}-panel`}
          id={`${id}-btn`}
          onClick={() => setOpen((v) => !v)}
          className="flex w-full items-center justify-between gap-4 py-5 text-left text-base font-semibold text-ink hover:text-brand-ink"
        >
          <span>{title}</span>
          <ChevronDown
            className={`h-5 w-5 shrink-0 text-muted transition-transform duration-300 ${open ? 'rotate-180' : ''}`}
            aria-hidden="true"
          />
        </button>
      </h3>
      <div
        id={`${id}-panel`}
        role="region"
        aria-labelledby={`${id}-btn`}
        className={`grid transition-[grid-template-rows] duration-300 ease-out ${open ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}
      >
        <div className="overflow-hidden" inert={!open}>
          <div className="pb-5 text-[15px] leading-7 text-[#3a3f47]">{children}</div>
        </div>
      </div>
    </div>
  );
}

// ---------- Page header ----------

export function PageHeader({
  eyebrow, title, intro, children,
}: { eyebrow: string; title: string; intro?: ReactNode; children?: ReactNode }) {
  return (
    <section className="relative overflow-hidden border-b border-line bg-surface">
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-40 right-[-10%] h-80 w-80 rounded-full bg-brand/15 blur-3xl"
      />
      <div className="container-page relative py-14 sm:py-20">
        <p className="eyebrow animate-fade-up">{eyebrow}</p>
        <h1 className="mt-3 max-w-3xl animate-fade-up text-4xl font-extrabold sm:text-5xl">{title}</h1>
        {intro && <p className="mt-4 max-w-2xl animate-fade-up text-lg leading-8 text-muted">{intro}</p>}
        {children && <div className="mt-7 animate-fade-up">{children}</div>}
      </div>
    </section>
  );
}

// ---------- CTA band ---------- 

export function CtaBand({
  title = 'Ready to see Envision in action?',
  body = 'Open the live web app right here, or read the guide first.',
}: { title?: string; body?: string }) {
  return (
    <section className="container-page mt-20">
      <div className="reveal relative overflow-hidden rounded-[2rem] bg-ink px-6 py-12 text-white sm:px-12">
        <div aria-hidden="true" className="absolute -right-20 -bottom-24 h-72 w-72 rounded-full bg-brand/40 blur-3xl" />
        <div className="relative flex flex-col gap-6 md:flex-row md:items-center md:justify-between">
          <div className="max-w-xl">
            <h2 className="text-3xl font-extrabold">{title}</h2>
            <p className="mt-2 text-[#d1d5db]">{body}</p>
          </div>
          <div className="flex flex-wrap gap-3">
            <Link to="/try" className="btn bg-white text-ink hover:bg-brand-soft">
              <Play className="h-4 w-4 fill-current" aria-hidden="true" /> Try Envision
            </Link>
            <Link to="/guide" className="btn border border-white/25 text-white hover:bg-white/10">
              <BookOpen className="h-4 w-4" aria-hidden="true" /> Read User Guide
            </Link>
          </div>
        </div>
      </div>
    </section>
  );
}

export function TextLink({ to, children }: { to: string; children: ReactNode }) {
  return (
    <Link to={to} className="group inline-flex items-center gap-1 font-semibold text-brand-ink">
      {children}
      <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-0.5" aria-hidden="true" />
    </Link>
  );
}
