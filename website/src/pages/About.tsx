import { GraduationCap, Target, Users, Layers, Flame, KeyRound, Database, BarChart3, FlaskConical, Image, Code2, Globe } from 'lucide-react';
import { CtaBand, PageHeader, PhoneFrame } from '../components/ui';
import { shot } from '../data/screenshots';

const stack = [
  { icon: Code2, name: 'FlutterFlow & Flutter', role: 'Visual app builder generating a Flutter app, published here as a web build.' },
  { icon: KeyRound, name: 'Firebase Authentication', role: 'Google and Apple sign-in and account sessions.' },
  { icon: Database, name: 'Cloud Firestore', role: 'Profiles, roles, training spaces, invitations and nutrition entries.' },
  { icon: Flame, name: 'Cloud Functions', role: 'Server-side logic such as checking invite codes and linking clients to coaches.' },
  { icon: Image, name: 'Firebase Storage', role: 'Profile and training-space photos.' },
  { icon: BarChart3, name: 'Firebase Analytics', role: 'Anonymous usage events that help the team improve the app.' },
  { icon: FlaskConical, name: 'Firebase Remote Config', role: 'Feature flags and A/B tests, like the optional "Maybe later" path.' },
  { icon: Globe, name: 'This website', role: 'React, TypeScript, Vite and Tailwind CSS, hosted on GitHub Pages.' },
];

export default function About() {
  return (
    <>
      <PageHeader
        eyebrow="About Envision"
        title="A university project with a real-world goal"
        intro="Envision is being designed and built by students for a university software development course. The aim is a fitness app that people could actually use: one that connects coaches and clients in a single shared space."
      />

      <section className="container-page mt-16 grid gap-12 lg:grid-cols-[minmax(0,1fr)_280px]">
        <div className="space-y-12">
          <Block icon={Target} title="The problem">
            <p>
              Personal training usually runs across too many tools: workout plans in a spreadsheet or PDF, meals in a
              separate calorie app, check-ins over text, progress photos in a camera roll. Clients lose track, and coaches
              spend time chasing updates instead of coaching.
            </p>
          </Block>
          <Block icon={Layers} title="Our approach">
            <p>
              Envision puts the coach and the client in the same app. A coach creates a training space; clients join it
              with an invite code. From there, the client&apos;s nutrition, training and progress live in one place that
              both sides can rely on. People without a coach yet can still use Envision on their own.
            </p>
          </Block>
          <Block icon={Users} title="Who it's for">
            <ul className="list-disc space-y-1.5 pl-5 marker:text-brand">
              <li><strong>Clients</strong> working with a personal trainer, in person or online.</li>
              <li><strong>Self-guided users</strong> who want structure before they find a coach.</li>
              <li><strong>Independent coaches and small gyms</strong> that want one home for their clients.</li>
            </ul>
          </Block>
          <Block icon={GraduationCap} title="Project status">
            <p>
              Envision is a work in progress built for a course. Sign-in, role selection, coach invitations, coach setup
              and the nutrition dashboard are in the current build. Training plans, progress tracking and fuller coach
              tools are in development. Envision isn&apos;t published on any app store and isn&apos;t a commercial
              product.
            </p>
          </Block>
        </div>
        <div className="mx-auto hidden w-[240px] lg:block">
          <div className="sticky top-24">
            <PhoneFrame shot={shot('role-select')} />
          </div>
        </div>
      </section>

      <section className="container-page mt-24" aria-labelledby="tech">
        <p className="eyebrow">Technology</p>
        <h2 id="tech" className="mt-2 text-3xl font-extrabold">How it&apos;s built</h2>
        <p className="mt-3 max-w-2xl text-muted">
          The app and this website are separate. The app runs on Google Firebase; this site is a static marketing and
          documentation site that stores no user data.
        </p>
        <ul className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {stack.map((s) => (
            <li key={s.name} className="reveal card p-5 transition hover:-translate-y-0.5 hover:shadow-lg hover:shadow-black/5">
              <s.icon className="h-6 w-6 text-brand-ink" aria-hidden="true" />
              <h3 className="mt-4 font-sans text-[15px] font-semibold">{s.name}</h3>
              <p className="mt-1 text-sm leading-6 text-muted">{s.role}</p>
            </li>
          ))}
        </ul>
      </section>

      <CtaBand />
    </>
  );
}

function Block({ icon: Icon, title, children }: { icon: typeof Target; title: string; children: React.ReactNode }) {
  return (
    <div className="reveal flex gap-5">
      <span className="inline-flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-brand-soft text-brand-ink">
        <Icon className="h-6 w-6" aria-hidden="true" />
      </span>
      <div className="text-[16px] leading-7 text-[#30353d]">
        <h2 className="mb-2 text-2xl font-bold text-ink">{title}</h2>
        {children}
      </div>
    </div>
  );
}
