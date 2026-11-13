import { useEffect, useState, type ReactNode } from 'react';
import { Link } from 'react-router-dom';
import {
  LogOut, Bell, CalendarDays, CircleUserRound, Plus, House, Users, ChevronLeft, ChevronRight, List, Printer,
} from 'lucide-react';
import { AccordionItem, Callout, CtaBand, PageHeader, PhoneFrame, StatusBadge } from '../components/ui';
import { shot } from '../data/screenshots';
import { ENVISION_WEB_URL } from '../lib/config';

type TocEntry = { id: string; label: string; children?: { id: string; label: string }[] };

const toc: TocEntry[] = [
  {
    id: 'getting-started',
    label: 'Getting started',
    children: [
      { id: 'access', label: 'Accessing Envision' },
      { id: 'create-account', label: 'Creating an account' },
      { id: 'sign-in', label: 'Signing in' },
      { id: 'choose-role', label: 'Choosing client or coach' },
    ],
  },
  {
    id: 'clients',
    label: 'For clients',
    children: [
      { id: 'join-coach', label: 'Joining a coach' },
      { id: 'skip-invite', label: 'Skipping the invitation' },
      { id: 'confirm-space', label: 'Confirming a training space' },
      { id: 'profile', label: 'Completing your profile' },
      { id: 'photo', label: 'Adding a profile photo' },
      { id: 'dashboard', label: 'The client dashboard' },
      { id: 'nutrition', label: 'Nutrition' },
      { id: 'training', label: 'Training' },
      { id: 'progress', label: 'Progress' },
      { id: 'sign-out', label: 'Signing out' },
    ],
  },
  {
    id: 'coaches',
    label: 'For coaches',
    children: [
      { id: 'coach-signup', label: 'Signing up as a coach' },
      { id: 'coach-dashboard', label: 'The coach dashboard' },
      { id: 'invitations', label: 'How invitations work' },
      { id: 'coach-clients', label: 'Connected clients' },
    ],
  },
  { id: 'troubleshooting', label: 'Troubleshooting' },
  { id: 'faq', label: 'FAQ' },
];

export default function Guide() {
  const active = useActiveSection();
  return (
    <>
      <PageHeader
        eyebrow="User documentation"
        title="Envision User Guide"
        intro="Everything you need to get started with Envision, whether you're joining a coach or coaching clients of your own. No technical knowledge needed."
      >
        <div className="flex flex-wrap gap-3">
          <a href="#getting-started" className="btn-primary">Start reading</a>
          <button type="button" onClick={() => window.print()} className="btn-secondary">
            <Printer className="h-4 w-4" aria-hidden="true" /> Print guide
          </button>
        </div>
        <p className="mt-5 text-sm text-muted">
          Written for the November 2026 web build. Features marked <StatusBadge status="development" /> are still being
          built and may not work yet.
        </p>
      </PageHeader>

      <div className="container-page mt-10 grid gap-10 lg:grid-cols-[240px_minmax(0,1fr)]">
        <TableOfContents active={active} />

        <article className="prose-guide min-w-0 max-w-3xl">
          {/* ---------------- GETTING STARTED ---------------- */}
          <Section id="getting-started" title="Getting started" kicker="Part 1">
            <p>
              Envision connects people who train with the coaches who guide them. This part covers how to open the app,
              create an account and choose the experience that fits you.
            </p>
          </Section>

          <Sub id="access" title="Accessing Envision">
            <p>
              Envision runs in your web browser. There&apos;s nothing to install, and it works on phones, tablets and
              computers.
            </p>
            <Steps>
              <Step>
                Go to the <Link to="/try" className="link">Try Envision</Link> page on this website to use the app
                embedded in the page, or
              </Step>
              <Step>
                open the app on its own:{' '}
                {ENVISION_WEB_URL ? (
                  <a href={ENVISION_WEB_URL} target="_blank" rel="noopener noreferrer" className="link break-all">
                    {ENVISION_WEB_URL.replace(/^https?:\/\//, '').replace(/\/$/, '')}
                  </a>
                ) : (
                  <span className="italic">[web app address to be configured]</span>
                )}
                .
              </Step>
              <Step>Wait a few seconds while the app loads. You&apos;ll see the Envision logo, then the welcome screen.</Step>
            </Steps>
            <Callout type="tip">
              On a phone, open the app in its own browser tab for the full-screen experience. Most phone browsers can
              also add it to your home screen from the Share or menu button.
            </Callout>
          </Sub>

          <Sub id="create-account" title="Creating an account">
            <Figure name="sign-in" side>
              <p>
                Envision doesn&apos;t use separate usernames and passwords to sign in. You create an account with an
                existing <strong>Google</strong> or <strong>Apple</strong> account.
              </p>
              <Steps>
                <Step>On the welcome screen (&quot;Personal coaching that works.&quot;), choose <B>Continue with Gmail</B> or <B>Continue with Apple</B>.</Step>
                <Step>A window from Google or Apple opens. Pick the account you want to use and approve the request.</Step>
                <Step>The first time you do this, Envision creates your account and takes you to setup.</Step>
              </Steps>
              <Callout type="info">
                Envision receives your name, email address and (for Google) profile picture from your Google or Apple
                account. It never sees your Google or Apple password.
              </Callout>
            </Figure>
          </Sub>

          <Sub id="sign-in" title="Signing in">
            <p>
              Signing in later works the same way. Choose the same Google or Apple option you used before. Envision
              recognises your account and takes you to the right place:
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 marker:text-brand">
              <li>If you finished setup, you go straight to your dashboard.</li>
              <li>If you stopped partway through, you go back to the step you were on.</li>
              <li>If you haven&apos;t chosen a role yet, you go to the role screen.</li>
            </ul>
            <Callout type="warning" title="Use the same sign-in option each time">
              Signing in with Apple when you originally used Google (or the other way round) can create a second,
              separate account. You won&apos;t see your existing data there.
            </Callout>
          </Sub>

          <Sub id="choose-role" title="Choosing the client or coach experience">
            <Figure name="role-select" side>
              <p>After your first sign-in, Envision asks <em>How will you use Envision?</em></p>
              <ul className="mt-3 space-y-3">
                <li><B>Client</B>: join a coach, log your nutrition and training, and track your progress.</li>
                <li><B>Coach</B>: create a training space for your gym or coaching business and work with clients.</li>
              </ul>
              <Steps>
                <Step>Tap the card that describes you. A check mark shows your choice.</Step>
                <Step>Tap <B>Continue</B>.</Step>
              </Steps>
              <Callout type="planned" title="Changing roles later">
                The screen mentions you can change this later, but switching roles yourself isn&apos;t finished in the
                current build. Choose carefully.
              </Callout>
            </Figure>
          </Sub>

          {/* ---------------- CLIENTS ---------------- */}
          <Section id="clients" title="For clients" kicker="Part 2">
            <p>
              Follow these steps if you chose <B>Client</B>. Setup takes a couple of minutes: join your coach, create
              your profile and you&apos;re on your dashboard.
            </p>
          </Section>

          <Sub id="join-coach" title="Joining a coach with an invitation code">
            <Figure name="client-join" side>
              <p>
                Coaches and gyms using Envision have an <strong>invite code</strong> for their training space, a short
                code such as <code className="rounded bg-surface px-1.5 py-0.5">RSF728</code>. Ask your coach for theirs.
              </p>
              <Steps>
                <Step>On <em>Join your trainer</em>, tap the <B>Invite code</B> field.</Step>
                <Step>Type the code exactly as your coach gave it to you.</Step>
                <Step>Tap <B>Find training space</B>. Envision checks the code.</Step>
                <Step>If the code is valid, you&apos;ll be asked to confirm the training space (see below).</Step>
              </Steps>
              <Callout type="tip">
                The code in the screenshot is only an example. Codes are tied to real training spaces, so a made-up code
                won&apos;t work.
              </Callout>
            </Figure>
          </Sub>

          <Sub id="skip-invite" title="Skipping the coach invitation (when available)">
            <p>
              Some people see a <B>Maybe later…</B> button under <em>Find training space</em>. Tapping it lets you finish
              setup and use Envision on your own, without a coach.
            </p>
            <Callout type="info" title="Why don't I see “Maybe later”?">
              The Envision team is testing whether this option helps new users, so it&apos;s switched on for some
              accounts and not others. That&apos;s expected. If it isn&apos;t shown, you&apos;ll need an invite code to
              continue.
            </Callout>
          </Sub>

          <Sub id="confirm-space" title="Confirming a training space">
            <p>
              After Envision finds the code, it shows you which training space it belongs to so you can make sure
              it&apos;s the right one before you join.
            </p>
            <Steps>
              <Step>Check the training-space name (and photo, if the coach added one).</Step>
              <Step>If it&apos;s correct, confirm to link your account to that coach.</Step>
              <Step>If it isn&apos;t, go back and re-enter the code, or check it with your coach.</Step>
            </Steps>
          </Sub>

          <Sub id="profile" title="Completing your profile">
            <p>Next, Envision asks for a few details so your coach can recognise you:</p>
            <dl className="mt-4 overflow-hidden rounded-2xl border border-line">
              {[
                ['Name', 'Required', 'Your first and last name, as you want your coach to see it.'],
                ['Username', 'Required', 'A unique handle. If someone already uses it, you\'ll be asked to choose another.'],
                ['Date of birth', 'Optional', 'You can leave this blank.'],
                ['Profile photo', 'Optional', 'See the next section.'],
              ].map(([k, req, v]) => (
                <div key={k} className="grid gap-1 border-b border-line p-4 last:border-b-0 sm:grid-cols-[150px_90px_1fr] sm:gap-4">
                  <dt className="font-semibold">{k}</dt>
                  <dd className={`text-sm font-medium ${req === 'Required' ? 'text-brand-ink' : 'text-muted'}`}>{req}</dd>
                  <dd className="text-[15px] text-[#3a3f47]">{v}</dd>
                </div>
              ))}
            </dl>
            <p className="mt-4">
              Fill in the fields and tap the button to continue. Your progress is saved as you go, so if you close the
              app, you can pick up where you left off.
            </p>
          </Sub>

          <Sub id="photo" title="Uploading an optional profile picture">
            <Steps>
              <Step>Tap the photo area on the profile step.</Step>
              <Step>Choose a picture from your device. On a phone you may also be able to take a new photo.</Step>
              <Step>Wait for the preview to appear before you continue.</Step>
            </Steps>
            <Callout type="tip">
              Use a JPG or PNG under a few megabytes. Very large images take longer to upload on slow connections.
              You can skip this step and continue without a photo.
            </Callout>
          </Sub>

          <Sub id="dashboard" title="Understanding the client dashboard">
            <Figure name="client-dashboard" side>
              <p>When setup is done you land on your dashboard. Here&apos;s what everything does:</p>
              <ul className="mt-4 space-y-3 text-[15px]">
                <IconRow icon={<CalendarDays />} label="Calendar">Opens the calendar view.</IconRow>
                <IconRow icon={<Bell />} label="Notifications">Shows updates. An orange dot means something new.</IconRow>
                <IconRow icon={<LogOut />} label="Sign out">Signs you out of Envision.</IconRow>
                <IconRow icon={<CircleUserRound />} label="Profile">Your profile picture or a placeholder avatar.</IconRow>
                <IconRow icon={<><ChevronLeft /><ChevronRight /></>} label="Date">Move between days, or tap the date to pick one.</IconRow>
                <IconRow icon={<Plus />} label="Add (+)">The orange button logs a new entry, such as a meal.</IconRow>
                <IconRow icon={<House />} label="Home">Returns to this dashboard.</IconRow>
                <IconRow icon={<Users />} label="People">Opens the coaching and community area (in development).</IconRow>
              </ul>
              <p className="mt-4">
                The three tabs, <B>Nutrition</B>, <B>Training</B> and <B>Progress</B>, switch what the dashboard shows.
              </p>
            </Figure>
          </Sub>

          <Sub id="nutrition" title="Using nutrition features">
            <div className="mb-2"><StatusBadge status="early" /></div>
            <p>The Nutrition tab shows your intake for the selected day.</p>
            <Steps>
              <Step><B>Set your goal.</B> Tap <B>Set Goal</B> on the Calories card and enter your daily calorie target.</Step>
              <Step><B>Read the ring.</B> The circle shows the percentage of your goal you&apos;ve eaten so far.</Step>
              <Step><B>Check macros.</B> Protein, Carbs and Fat show grams eaten against your target.</Step>
              <Step><B>Log a meal.</B> Tap the orange <B>+</B> button and add what you ate. It appears under <em>Meal Logs</em> with its calories.</Step>
              <Step><B>Look back.</B> Use the arrows or the date button to see another day.</Step>
            </Steps>
            <Callout type="info">
              New accounts start at 0 for everything. The numbers fill in once you set a goal and log meals.
            </Callout>
          </Sub>

          <Sub id="training" title="Accessing workout features">
            <div className="mb-2"><StatusBadge status="development" /></div>
            <p>
              The <B>Training</B> tab is where workout plans and exercises will live. It&apos;s still being built, so it
              may be empty or show placeholder content. Talk to your coach directly about your program until it&apos;s
              ready.
            </p>
          </Sub>

          <Sub id="progress" title="Viewing progress and fitness information">
            <div className="mb-2"><StatusBadge status="development" /></div>
            <p>
              The <B>Progress</B> tab is planned for tracking measurements and how you change over time. Like Training,
              it&apos;s in development and may not show data yet.
            </p>
          </Sub>

          <Sub id="sign-out" title="Signing out">
            <Steps>
              <Step>Tap the <B>sign-out</B> icon <LogOut className="inline h-4 w-4 align-[-2px]" aria-label="sign out icon" /> at the top right of your dashboard.</Step>
              <Step>You return to the welcome screen. Your data stays saved in your account.</Step>
            </Steps>
            <Callout type="tip">
              Always sign out on shared or public computers. Closing the tab alone may keep you signed in.
            </Callout>
          </Sub>

          {/* ---------------- COACHES ---------------- */}
          <Section id="coaches" title="For coaches" kicker="Part 3">
            <p>
              Follow these steps if you chose <B>Coach</B>. You&apos;ll set up a training space that your clients join
              with your invite code.
            </p>
          </Section>

          <Sub id="coach-signup" title="Signing up as a coach">
            <Figure name="coach-space" side>
              <p className="font-semibold text-ink">Step 1: Create your training space</p>
              <Steps>
                <Step>Enter your <B>Gym or coaching name</B>, for example &quot;Riverside Strength&quot;.</Step>
                <Step>Optionally, tap the large photo area to add a picture of your gym or yourself.</Step>
                <Step>Under <em>How do you coach?</em> choose <B>In-person</B>, <B>Online</B> or <B>Hybrid</B>.</Step>
                <Step>Tap <B>Continue</B>.</Step>
              </Steps>
            </Figure>
            <Figure name="coach-specialties" side>
              <p className="font-semibold text-ink">Step 2: Choose your specialties</p>
              <Steps>
                <Step>On <em>What do you coach?</em>, tap every specialty that applies. Selected ones turn orange.</Step>
                <Step>Options include Strength, Bodybuilding, Weight loss, Sports performance, Group fitness and Mobility.</Step>
                <Step>Tap <B>Finish setup</B>.</Step>
              </Steps>
              <p className="mt-3">You can update these later as your coaching changes.</p>
            </Figure>
          </Sub>

          <Sub id="coach-dashboard" title="Understanding the coach dashboard">
            <div className="mb-2"><StatusBadge status="early" /></div>
            <p>
              After setup, coaches go to the coach dashboard instead of the client dashboard. It&apos;s the home for your
              training space and the clients connected to it. The coach dashboard is an early version and its layout
              may change as features are added.
            </p>
          </Sub>

          <Sub id="invitations" title="Understanding how client invitations work">
            <ol className="mt-2 space-y-4">
              {[
                ['Your space gets a code', 'Each training space has its own invite code.'],
                ['You share it', 'Send the code to your client in person, by text or by email. Envision has no public directory, so only people with your code can join.'],
                ['Your client enters it', 'During client setup they type the code on "Join your trainer" and tap "Find training space".'],
                ['Envision checks and links', 'If the code matches your space, the client confirms and their account is linked to yours.'],
              ].map(([t, d], i) => (
                <li key={t} className="flex gap-4">
                  <span className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-ink text-sm font-bold text-white">{i + 1}</span>
                  <div><p className="font-semibold text-ink">{t}</p><p className="!mt-0.5">{d}</p></div>
                </li>
              ))}
            </ol>
            <Callout type="planned" title="Where to find your code">
              Where the invite code is shown in the coach dashboard may move while the app is in development.{' '}
              <span className="italic">[Team to confirm: exact screen and label for the coach invite code.]</span>
            </Callout>
          </Sub>

          <Sub id="coach-clients" title="Finding and managing connected clients">
            <div className="mb-2"><StatusBadge status="early" /></div>
            <p>
              Clients who join with your code are connected to your training space. Tools to browse your client list
              and see client details (such as their nutrition logs) are being built.
            </p>
            <Callout type="planned" title="Viewing client information">
              Viewing a client&apos;s training, nutrition and progress from the coach side is planned and isn&apos;t
              complete in the current build.
            </Callout>
          </Sub>

          {/* ---------------- TROUBLESHOOTING ---------------- */}
          <Section id="troubleshooting" title="Troubleshooting" kicker="Part 4">
            <p>Most problems have a quick fix. Find yours below.</p>
            <div className="card mt-6 px-5 sm:px-6">
              <AccordionItem title="“Invalid code” or no training space found">
                <ul className="list-disc space-y-1 pl-5">
                  <li>Check every character. Watch for 0 (zero) vs O and 1 vs I.</li>
                  <li>Remove any spaces before or after the code.</li>
                  <li>Ask your coach to confirm the code. They may have created a new space.</li>
                  <li>If you see <B>Maybe later</B>, you can continue now and join your coach afterwards.</li>
                </ul>
              </AccordionItem>
              <AccordionItem title="“Username already taken”">
                Usernames are unique across Envision. Try adding numbers, an underscore or your initials (for example{' '}
                <code>alex_r24</code>). Your username doesn&apos;t affect how you sign in.
              </AccordionItem>
              <AccordionItem title="I closed the app during onboarding">
                Nothing is lost. Open Envision and sign in with the <em>same</em> Google or Apple account. Envision takes
                you back to the step you were on. If you land on the role screen again, your earlier steps may not have
                saved. Just complete them again.
              </AccordionItem>
              <AccordionItem title="I can't sign in">
                <ul className="list-disc space-y-1 pl-5">
                  <li>Allow pop-ups for the Envision site. Google and Apple sign-in open in a pop-up window.</li>
                  <li>If you&apos;re using the embedded demo on this website, <Link to="/try" className="link">open Envision in a new tab</Link> instead. Some browsers block sign-in inside embedded pages.</li>
                  <li>Check you&apos;re choosing the same provider (Google or Apple) you used before.</li>
                  <li>Turn off strict tracking protection for the site, or try a private window.</li>
                </ul>
              </AccordionItem>
              <AccordionItem title="My photo won't upload">
                <ul className="list-disc space-y-1 pl-5">
                  <li>Use a JPG or PNG image. Some formats, such as HEIC from iPhones, may not be supported in every browser.</li>
                  <li>Try a smaller image (under ~5 MB) or a stronger connection.</li>
                  <li>Make sure your browser has permission to access photos or the camera.</li>
                  <li>The photo is optional. You can skip it and finish setup.</li>
                </ul>
              </AccordionItem>
              <AccordionItem title="Which browsers are supported?">
                Envision is a Flutter web app and works best in the latest <B>Chrome</B>, <B>Edge</B>, <B>Safari</B> or{' '}
                <B>Firefox</B>. Internet Explorer and very old browsers aren&apos;t supported. If text looks blurry or
                buttons don&apos;t respond, update your browser.
              </AccordionItem>
              <AccordionItem title="General tips">
                <ol className="list-decimal space-y-1 pl-5">
                  <li>Reload the page.</li>
                  <li>Check your internet connection. Envision needs to be online.</li>
                  <li>Sign out and back in.</li>
                  <li>Clear the site&apos;s data in your browser settings, then sign in again.</li>
                  <li>Try another browser or device.</li>
                </ol>
              </AccordionItem>
            </div>
          </Section>

          {/* ---------------- FAQ ---------------- */}
          <Section id="faq" title="Frequently asked questions" kicker="Part 5">
            <div className="card mt-4 px-5 sm:px-6">
              <AccordionItem title="Is a coach required?">
                Not always. If you see <B>Maybe later</B> on the invitation screen, you can use Envision without a coach.
                That option is being tested, so not every account has it.
              </AccordionItem>
              <AccordionItem title="Can I use Envision in a browser?">
                Yes. Envision currently runs only in the browser, on any modern phone, tablet or computer.
              </AccordionItem>
              <AccordionItem title="How do I connect to my coach?">
                Get your coach&apos;s invite code, choose <B>Client</B>, enter the code and tap <B>Find training space</B>.{' '}
                <a href="#join-coach" className="link">See the steps</a>.
              </AccordionItem>
              <AccordionItem title="What happens if I close the app during onboarding?">
                Your progress is saved. Sign in again with the same account to continue where you stopped.
              </AccordionItem>
              <AccordionItem title="Can I update my profile?">
                You set up your profile during onboarding. Editing it afterwards is still being built.
              </AccordionItem>
              <AccordionItem title="How is my information stored?">
                Your account is managed by Firebase Authentication. Your profile and app data are stored in Google Cloud
                Firestore, and photos in Firebase Storage. <Link to="/privacy" className="link">Read more about data</Link>.
              </AccordionItem>
            </div>
            <p className="mt-6">
              More questions? See the full <Link to="/faq" className="link">FAQ page</Link>.
            </p>
          </Section>
        </article>
      </div>

      <CtaBand title="Ready to try it?" body="Open the live Envision web app and follow along with this guide." />
    </>
  );
}

// ---------------- helpers ---------------- 

function useActiveSection() {
  const [active, setActive] = useState('getting-started');
  useEffect(() => {
    const ids = toc.flatMap((t) => [t.id, ...(t.children?.map((c) => c.id) ?? [])]);
    const els = ids.map((id) => document.getElementById(id)).filter(Boolean) as HTMLElement[];
    const io = new IntersectionObserver(
      (entries) => {
        const visible = entries.filter((e) => e.isIntersecting).sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top);
        if (visible[0]) setActive(visible[0].target.id);
      },
      { rootMargin: '-80px 0px -65% 0px' },
    );
    els.forEach((el) => io.observe(el));
    return () => io.disconnect();
  }, []);
  return active;
}

function TableOfContents({ active }: { active: string }) {
  const [open, setOpen] = useState(false);
  const parentOf = (id: string) => toc.find((t) => t.id === id || t.children?.some((c) => c.id === id))?.id;
  const activeParent = parentOf(active);
  const link = (id: string, label: string, child = false) => (
    <a
      href={`#${id}`}
      onClick={() => setOpen(false)}
      aria-current={active === id ? 'location' : undefined}
      className={`block rounded-lg py-1.5 transition-colors ${child ? 'pl-4 text-[13px]' : 'pl-2 text-sm font-semibold'} ${
        active === id ? 'bg-brand-soft text-brand-ink' : child ? 'text-muted hover:text-ink' : 'text-ink hover:text-brand-ink'
      }`}
    >
      {label}
    </a>
  );
  return (
    <nav aria-label="Guide contents" className="lg:sticky lg:top-24 lg:max-h-[calc(100vh-7rem)] lg:self-start lg:overflow-y-auto print:hidden">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        aria-controls="guide-toc"
        className="btn-secondary w-full justify-between lg:hidden"
      >
        <span className="inline-flex items-center gap-2"><List className="h-4 w-4" aria-hidden="true" /> Contents</span>
        <ChevronRight className={`h-4 w-4 transition-transform ${open ? 'rotate-90' : ''}`} aria-hidden="true" />
      </button>
      <p className="mb-3 hidden text-xs font-semibold tracking-[0.14em] text-muted uppercase lg:block">On this page</p>
      <ol id="guide-toc" className={`${open ? 'mt-3 block' : 'hidden'} card space-y-1 p-3 lg:block lg:border-0 lg:p-0`}>
        {toc.map((t) => (
          <li key={t.id}>
            {link(t.id, t.label)}
            {t.children && (
              <ol className={`mt-0.5 mb-2 space-y-0.5 border-l border-line ${activeParent === t.id || open ? '' : 'lg:hidden'}`}>
                {t.children.map((c) => (
                  <li key={c.id}>{link(c.id, c.label, true)}</li>
                ))}
              </ol>
            )}
          </li>
        ))}
      </ol>
    </nav>
  );
}

function Section({ id, title, kicker, children }: { id: string; title: string; kicker: string; children: ReactNode }) {
  return (
    <section id={id} aria-labelledby={`${id}-h`} className="border-t border-line pt-10 first:border-t-0 first:pt-0 [&:not(:first-child)]:mt-16">
      <p className="eyebrow">{kicker}</p>
      <h2 id={`${id}-h`} className="mt-2 text-3xl font-extrabold sm:text-4xl">{title}</h2>
      <div className="mt-4">{children}</div>
    </section>
  );
}

function Sub({ id, title, children }: { id: string; title: string; children: ReactNode }) {
  return (
    <section id={id} aria-labelledby={`${id}-h`} className="mt-12">
      <h3 id={`${id}-h`} className="mb-3 text-xl font-bold sm:text-2xl">
        <a href={`#${id}`} className="hover:text-brand-ink">{title}</a>
      </h3>
      {children}
    </section>
  );
}

function Figure({ name, children }: { name: string; side?: boolean; children: ReactNode }) {
  const s = shot(name);
  return (
    <div className="mt-2 grid items-start gap-6 sm:grid-cols-[minmax(0,1fr)_200px]">
      <div className="min-w-0">{children}</div>
      <div className="mx-auto w-[200px] sm:sticky sm:top-24">
        <PhoneFrame shot={s} />
        <p className="mt-2 text-center text-xs text-muted">{s.title}</p>
      </div>
    </div>
  );
}

function Steps({ children }: { children: ReactNode }) {
  return <ol className="mt-4 list-none space-y-3 [counter-reset:step]">{children}</ol>;
}

function Step({ children }: { children: ReactNode }) {
  return (
    <li className="relative pl-10 leading-7 text-[#2b2f36] [counter-increment:step] before:absolute before:top-0.5 before:left-0 before:inline-flex before:h-6 before:w-6 before:items-center before:justify-center before:rounded-full before:bg-brand-soft before:text-xs before:font-bold before:text-brand-ink before:content-[counter(step)]">
      {children}
    </li>
  );
}

function B({ children }: { children: ReactNode }) {
  return <strong className="font-semibold text-ink">{children}</strong>;
}

function IconRow({ icon, label, children }: { icon: ReactNode; label: string; children: ReactNode }) {
  return (
    <li className="flex items-start gap-3">
      <span className="inline-flex h-8 min-w-8 shrink-0 items-center justify-center rounded-lg bg-surface px-1.5 text-ink [&_svg]:h-4 [&_svg]:w-4" aria-hidden="true">
        {icon}
      </span>
      <span>
        <span className="font-semibold text-ink">{label}:</span> <span className="text-[#3a3f47]">{children}</span>
      </span>
    </li>
  );
}
