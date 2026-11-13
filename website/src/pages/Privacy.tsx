import { Link } from 'react-router-dom';
import { KeyRound, UserRound, Link2, Salad, Image, BarChart3, FlaskConical, Globe, Server } from 'lucide-react';
import { Callout, PageHeader } from '../components/ui';

const categories = [
  {
    icon: KeyRound,
    title: 'Account and sign-in',
    items: ['Name and email address from your Google or Apple account', 'Profile picture URL from Google (if available)', 'A unique account ID created by Firebase Authentication'],
    where: 'Firebase Authentication',
  },
  {
    icon: UserRound,
    title: 'Profile',
    items: ['Name and username', 'Date of birth (optional)', 'Your role: client or coach', 'How far you are through onboarding'],
    where: 'Cloud Firestore',
  },
  {
    icon: Link2,
    title: 'Coaching relationship',
    items: ["Training spaces a coach creates (name, coaching style, specialties)", 'Invite codes', 'Which coach a client is linked to'],
    where: 'Cloud Firestore',
  },
  {
    icon: Salad,
    title: 'Fitness and nutrition',
    items: ['Calorie and macro goals', 'Meal log entries', 'Training and progress data, once those features are released'],
    where: 'Cloud Firestore',
  },
  {
    icon: Image,
    title: 'Photos',
    items: ['Optional profile photo', 'Optional training-space photo (coaches)'],
    where: 'Firebase Storage',
  },
  {
    icon: BarChart3,
    title: 'Usage analytics',
    items: ['Screens viewed and actions taken', 'Device, browser and approximate region as collected by Firebase Analytics'],
    where: 'Firebase Analytics (Google Analytics)',
  },
  {
    icon: FlaskConical,
    title: 'Experiments',
    items: ['Which version of a feature you see, such as whether "Maybe later" is offered'],
    where: 'Firebase Remote Config',
  },
];

function Placeholder({ children }: { children: React.ReactNode }) {
  return (
    <span className="rounded-md border border-dashed border-[#d9a441] bg-[#fffaeb] px-1.5 py-0.5 text-[0.95em] text-[#7a4f00]">
      {children}
    </span>
  );
}

export default function Privacy() {
  return (
    <>
      <PageHeader
        eyebrow="Privacy & data"
        title="How Envision handles your information"
        intro="A plain-language overview of the data the Envision app works with, based on how the app is built. This is not a formal privacy policy."
      />

      <div className="container-page mt-12 max-w-4xl">
        <Callout type="warning" title="Draft for a student project">
          Envision is a university project, not a commercial service. Items shown like{' '}
          <Placeholder>[this]</Placeholder> still need to be confirmed by the project team before this page can be treated
          as a privacy policy.
        </Callout>

        <section aria-labelledby="two-systems" className="mt-12">
          <h2 id="two-systems" className="text-2xl font-bold">Two separate systems</h2>
          <div className="mt-5 grid gap-4 sm:grid-cols-2">
            <div className="card p-6">
              <Globe className="h-6 w-6 text-brand-ink" aria-hidden="true" />
              <h3 className="mt-3 font-sans text-base font-semibold">This website</h3>
              <p className="mt-1 text-sm leading-6 text-muted">
                A static site hosted on GitHub Pages. It has no accounts, no forms, no cookies of its own and no analytics,
                and it never reads or displays app data. GitHub may log standard request information (like IP address) as
                the host.
              </p>
            </div>
            <div className="card p-6">
              <Server className="h-6 w-6 text-brand-ink" aria-hidden="true" />
              <h3 className="mt-3 font-sans text-base font-semibold">The Envision app</h3>
              <p className="mt-1 text-sm leading-6 text-muted">
                A Flutter web app hosted by FlutterFlow that stores data in Google Firebase. When you use the app,
                including inside the <Link to="/try" className="link">Try Envision</Link> page, your data goes to Firebase,
                not to this website.
              </p>
            </div>
          </div>
        </section>

        <section aria-labelledby="categories" className="mt-14">
          <h2 id="categories" className="text-2xl font-bold">Data the app handles</h2>
          <p className="mt-2 text-muted">Categories of information, and the Firebase service that stores each one.</p>
          <ul className="mt-6 grid gap-4 md:grid-cols-2">
            {categories.map((c) => (
              <li key={c.title} className="card p-6">
                <div className="flex items-center gap-3">
                  <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-surface">
                    <c.icon className="h-5 w-5" aria-hidden="true" />
                  </span>
                  <h3 className="font-sans text-base font-semibold">{c.title}</h3>
                </div>
                <ul className="mt-4 list-disc space-y-1 pl-5 text-sm leading-6 text-[#3a3f47] marker:text-brand">
                  {c.items.map((i) => <li key={i}>{i}</li>)}
                </ul>
                <p className="mt-4 text-xs font-medium text-muted">Stored in: {c.where}</p>
              </li>
            ))}
          </ul>
        </section>

        <section aria-labelledby="use" className="mt-14 space-y-4 text-[15px] leading-7 text-[#30353d]">
          <h2 id="use" className="text-2xl font-bold text-ink">How it&apos;s used and who can see it</h2>
          <ul className="list-disc space-y-2 pl-5 marker:text-brand">
            <li>Your data is used to run the app: to sign you in, route you to the right screens, link you to your coach and show your dashboard.</li>
            <li>A coach you join can be connected to your client account. What a coach can view is <Placeholder>[team to confirm: exact client fields visible to a linked coach]</Placeholder>.</li>
            <li>There are no public profiles, leaderboards or community feeds.</li>
            <li>Data is not sold. Envision has no advertising. <Placeholder>[team to confirm]</Placeholder></li>
            <li>Analytics help the team understand which features are used and run experiments like the &quot;Maybe later&quot; test.</li>
          </ul>
        </section>

        <section aria-labelledby="tbd" className="mt-14">
          <h2 id="tbd" className="text-2xl font-bold">Details still to be confirmed</h2>
          <dl className="card mt-5 divide-y divide-line">
            {[
              ['Data retention', 'How long account and fitness data is kept, including after a course ends.'],
              ['Account deletion', 'Whether and how users can delete their account and data. No self-service deletion is documented yet.'],
              ['Data export', 'Whether users can download a copy of their data.'],
              ['Security rules', 'A summary of the Firestore and Storage security rules that limit who can read each record.'],
              ['Contact', 'Who to contact with privacy questions or requests.'],
              ['Region', 'Which Google Cloud region stores the data.'],
            ].map(([k, v]) => (
              <div key={k} className="grid gap-1 p-5 sm:grid-cols-[180px_1fr] sm:gap-6">
                <dt className="font-semibold">{k}</dt>
                <dd className="text-sm leading-6 text-muted">
                  <Placeholder>[To be confirmed]</Placeholder> {v}
                </dd>
              </div>
            ))}
          </dl>
          <p className="mt-6 text-sm leading-6 text-muted">
            This page doesn&apos;t claim compliance with any specific law or certification. Firebase is provided by
            Google; see Google&apos;s own Firebase privacy documentation for how Google processes data on behalf of
            app developers.
          </p>
        </section>

        <section className="mt-14">
          <Callout type="tip" title="Using the demo safely">
            Anything entered in the demo is saved to the project&apos;s live Firebase backend. Avoid entering sensitive
            health information, and use a Google or Apple account you&apos;re comfortable using with a student project.
          </Callout>
        </section>
      </div>
    </>
  );
}
