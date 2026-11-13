import { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Search, ArrowRight } from 'lucide-react';
import { AccordionItem, CtaBand, PageHeader } from '../components/ui';
import { faqGroups } from '../data/faq';

export default function FAQ() {
  const [query, setQuery] = useState('');
  const groups = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return faqGroups;
    return faqGroups
      .map((g) => ({ ...g, items: g.items.filter((i) => `${i.q} ${i.a}`.toLowerCase().includes(q)) }))
      .filter((g) => g.items.length);
  }, [query]);
  const count = groups.reduce((n, g) => n + g.items.length, 0);

  return (
    <>
      <PageHeader
        eyebrow="Help"
        title="Frequently asked questions"
        intro="Quick answers about using Envision, working with a coach, and how your data is handled."
      >
        <label className="relative block max-w-lg">
          <span className="sr-only">Search questions</span>
          <Search className="pointer-events-none absolute top-1/2 left-4 h-5 w-5 -translate-y-1/2 text-muted" aria-hidden="true" />
          <input
            type="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search questions…"
            className="w-full rounded-full border border-line bg-white py-3.5 pr-4 pl-12 text-[15px] shadow-sm outline-none focus:border-brand focus:ring-4 focus:ring-brand/15"
          />
        </label>
      </PageHeader>

      <div className="container-page mt-12 grid gap-12 lg:grid-cols-[minmax(0,1fr)_300px]">
        <div className="min-w-0">
          <p className="sr-only" aria-live="polite">{count} questions shown</p>
          {groups.length === 0 && (
            <div className="card p-8 text-center">
              <p className="font-semibold">No questions match “{query}”.</p>
              <p className="mt-1 text-sm text-muted">
                Try another word, or browse the <Link to="/guide" className="link">user guide</Link>.
              </p>
            </div>
          )}
          {groups.map((g) => (
            <section key={g.title} className="mb-10" aria-labelledby={`faq-${g.title}`}>
              <h2 id={`faq-${g.title}`} className="mb-2 text-xl font-bold">{g.title}</h2>
              <div className="card px-5 sm:px-6">
                {g.items.map((item) => (
                  <AccordionItem key={item.q} title={item.q} defaultOpen={!!query}>
                    <p>{item.a}</p>
                    {item.links && (
                      <p className="mt-3 flex flex-wrap gap-x-5 gap-y-2">
                        {item.links.map((l) => (
                          <Link key={l.to} to={l.to} className="inline-flex items-center gap-1 font-semibold text-brand-ink hover:underline underline-offset-4">
                            {l.label} <ArrowRight className="h-4 w-4" aria-hidden="true" />
                          </Link>
                        ))}
                      </p>
                    )}
                  </AccordionItem>
                ))}
              </div>
            </section>
          ))}
        </div>

        <aside className="space-y-4 lg:sticky lg:top-24 lg:self-start">
          <div className="card p-6">
            <h2 className="font-sans text-lg font-bold">Still stuck?</h2>
            <p className="mt-1 text-sm leading-6 text-muted">The user guide covers every screen step by step, with troubleshooting tips.</p>
            <Link to="/guide" className="btn-primary mt-4 w-full">Read the User Guide</Link>
            <Link to="/guide#troubleshooting" className="btn-secondary mt-2 w-full">Troubleshooting</Link>
          </div>
          <div className="card p-6">
            <h2 className="font-sans text-lg font-bold">See it for yourself</h2>
            <p className="mt-1 text-sm leading-6 text-muted">Try the live web app without leaving this site.</p>
            <Link to="/try" className="btn-secondary mt-4 w-full">Try Envision</Link>
          </div>
        </aside>
      </div>

      <CtaBand />
    </>
  );
}
