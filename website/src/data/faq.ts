export type FaqItem = { q: string; a: string; links?: { to: string; label: string }[] };
export type FaqGroup = { title: string; items: FaqItem[] };

export const faqGroups: FaqGroup[] = [
  {
    title: 'Getting started',
    items: [
      {
        q: 'What is Envision?',
        a: 'Envision is a fitness coaching and tracking app that connects personal trainers with their clients. Clients join a coach with an invite code and track their nutrition; coaches set up a training space for their gym or coaching business. It is a university software development project.',
        links: [{ to: '/about', label: 'About the project' }],
      },
      {
        q: 'Can I use Envision in a browser?',
        a: 'Yes. Envision currently runs as a web app built with Flutter. You can open it in a current version of Chrome, Edge, Safari or Firefox on a computer or phone, or try it right on this website.',
        links: [{ to: '/try', label: 'Try Envision' }],
      },
      {
        q: 'Is Envision on Google Play or the App Store?',
        a: 'No. Envision is not published on any app store. The homepage of this site is styled like a Google Play listing for a class assignment, but the app is only available as a web demo.',
      },
      {
        q: 'Does Envision cost anything?',
        a: 'No. The web demo is free to use. Envision is a student project and does not sell subscriptions or take payments.',
      },
      {
        q: 'How do I create an account?',
        a: 'Open Envision and choose "Continue with Gmail" or "Continue with Apple". Your account is created the first time you sign in. Envision does not use separate passwords.',
        links: [{ to: '/guide#create-account', label: 'Step-by-step guide' }],
      },
    ],
  },
  {
    title: 'Coaches and clients',
    items: [
      {
        q: 'Is a coach required?',
        a: 'Not always. Clients are asked for an invite code, but some accounts also see a "Maybe later" button that lets them continue without a coach. Whether that button appears is decided by an experiment in the app, so not everyone sees it. If you do not see it, you will need a code from a coach to continue.',
        links: [{ to: '/guide#skip-invite', label: 'Skipping the invitation' }],
      },
      {
        q: 'How do I connect to my coach?',
        a: 'Ask your coach or gym for their Envision invite code. During setup, choose Client, type the code on the "Join your trainer" screen and tap "Find training space". Confirm that the space shown is the right one to finish linking.',
        links: [{ to: '/guide#join-coach', label: 'Joining a coach' }],
      },
      {
        q: 'I am a coach. How do clients find me?',
        a: 'Clients join your training space with your invite code. Share the code with each client directly. Envision has no public coach directory, so only people with your code can join.',
        links: [{ to: '/guide#invitations', label: 'How invitations work' }],
      },
      {
        q: 'Can I switch between client and coach?',
        a: 'The role screen says you can change your choice later. A self-service role switch is not finished in the current build, so pick the role that fits you best when you sign up.',
      },
    ],
  },
  {
    title: 'Using the app',
    items: [
      {
        q: 'What happens if I close the app during onboarding?',
        a: 'Your progress is saved as you go. The next time you sign in with the same account, Envision checks how far you got and takes you back to the step you were on instead of starting over.',
      },
      {
        q: 'Can I update my profile?',
        a: 'You set your name, username, optional date of birth and optional photo during onboarding. Editing your profile after setup is still being built and may not be available in every part of the app yet.',
      },
      {
        q: 'Can I track workouts and progress?',
        a: 'The client dashboard has Training and Progress tabs, but these areas are still in development. Nutrition tracking is the most complete part of the dashboard today.',
        links: [{ to: '/features', label: 'See feature status' }],
      },
    ],
  },
  {
    title: 'Data and privacy',
    items: [
      {
        q: 'How is my information stored?',
        a: 'Sign-in is handled by Firebase Authentication (Google or Apple). Your profile, role, training-space link and nutrition entries are stored in Cloud Firestore, and an uploaded profile or training-space photo is stored in Firebase Storage. Firebase Analytics collects usage events. This website is separate and stores none of your app data.',
        links: [{ to: '/privacy', label: 'Privacy & data' }],
      },
      {
        q: 'Is the demo using real data?',
        a: 'Yes. The demo connects to the project\'s live Firebase backend. Anything you enter, including your Google or Apple account name and email, is saved. Use an account you are comfortable using for a student project and avoid entering sensitive health details.',
      },
      {
        q: 'Can other people see my fitness data?',
        a: 'Envision has no public profiles, leaderboards or community feed. Your data is tied to your signed-in account. This website does not display any user data.',
        links: [{ to: '/community', label: 'Why there is no public community page' }],
      },
    ],
  },
];
