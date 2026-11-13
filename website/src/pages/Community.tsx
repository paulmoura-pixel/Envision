import { Link } from 'react-router-dom';
import { EyeOff, ShieldCheck, Lock, ListChecks, Check, X } from 'lucide-react';
import { Callout, PageHeader } from '../components/ui';

const notShown = [
  'Email addresses or names of users',
  'Personal health, fitness or nutrition records',
  'Progress photos or body measurements',
  'Which clients are linked to which coaches',
  'Any Firestore record that requires signing in to read',
];

const wouldNeed = [
  'A feature inside the app where users explicitly choose to make something public (opt-in)',
  'A separate, public-only collection, kept apart from private data',
  'Firestore security rules that allow anonymous reads of only that collection',
  'Aggregated or anonymised data only, such as total training spaces created, never individual records',
];

export default function Community() {
  return (
    <>
      <PageHeader
        eyebrow="Community & backend data"
        title="Why there is no public community page"
        intro="Many app websites show live data from their backend, like leaderboards or member directories. For Envision, we decided against it to protect user privacy."
      />

      <div className="container-page mt-12 max-w-4xl space-y-14">
        <section aria-labelledby="decision">
          <h2 id="decision" className="text-2xl font-bold">The decision</h2>
          <p className="mt-3 text-[16px] leading-7 text-[#30353d]">
            Everything Envision stores is personal: who someone trains with, what they eat, how their body is changing.
            The app has no feature where users choose to share anything publicly. Showing any of this on an open website
            would expose people who never agreed to it. So this website reads <strong>no data</strong> from the Envision
            backend, and it has no API keys or database access of its own.
          </p>
          <Callout type="info" title="Assignment note">
            The course asks for a community-level view of backend data <em>when appropriate</em>. This page documents why
            that view was intentionally left out for Envision.
          </Callout>
        </section>

        <section aria-labelledby="not-shown" className="grid gap-6 md:grid-cols-2">
          <div className="card p-6">
            <div className="flex items-center gap-3">
              <EyeOff className="h-6 w-6 text-brand-ink" aria-hidden="true" />
              <h2 id="not-shown" className="font-sans text-lg font-bold">Never shown publicly</h2>
            </div>
            <ul className="mt-4 space-y-2.5">
              {notShown.map((t) => (
                <li key={t} className="flex gap-2.5 text-[15px] leading-6 text-[#30353d]">
                  <X className="mt-0.5 h-4 w-4 shrink-0 text-[#b42318]" aria-hidden="true" /> {t}
                </li>
              ))}
            </ul>
          </div>
          <div className="card p-6">
            <div className="flex items-center gap-3">
              <ListChecks className="h-6 w-6 text-brand-ink" aria-hidden="true" />
              <h2 className="font-sans text-lg font-bold">What a future public view would need</h2>
            </div>
            <ul className="mt-4 space-y-2.5">
              {wouldNeed.map((t) => (
                <li key={t} className="flex gap-2.5 text-[15px] leading-6 text-[#30353d]">
                  <Check className="mt-0.5 h-4 w-4 shrink-0 text-[#17663a]" aria-hidden="true" /> {t}
                </li>
              ))}
            </ul>
          </div>
        </section>

        <section aria-labelledby="instead" className="grid gap-4 sm:grid-cols-2">
          <h2 id="instead" className="sr-only">What you can do instead</h2>
          <Link to="/try" className="card group flex gap-4 p-6 transition hover:shadow-lg hover:shadow-black/5">
            <Lock className="h-6 w-6 shrink-0 text-muted" aria-hidden="true" />
            <span>
              <span className="block font-semibold group-hover:text-brand-ink">See your own data in the app</span>
              <span className="mt-1 block text-sm text-muted">Sign in to Envision to see your dashboard. Only you can see it.</span>
            </span>
          </Link>
          <Link to="/privacy" className="card group flex gap-4 p-6 transition hover:shadow-lg hover:shadow-black/5">
            <ShieldCheck className="h-6 w-6 shrink-0 text-muted" aria-hidden="true" />
            <span>
              <span className="block font-semibold group-hover:text-brand-ink">Read about data handling</span>
              <span className="mt-1 block text-sm text-muted">What Envision stores and where.</span>
            </span>
          </Link>
        </section>
      </div>
    </>
  );
}
