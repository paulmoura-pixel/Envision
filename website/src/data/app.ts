export const app = {
  name: 'Envision',
  developer: 'Envision team',
  category: 'Health & Fitness',
  shortDescription: 'Plan workouts, track progress, and connect with your fitness coach.',
  headline: 'Your fitness journey. Your vision. Envision.',
  tagline:
    'Stay organized, monitor your progress, and connect with your personal trainer through one streamlined fitness experience.',
  platform: 'Web browser (Flutter web build)',
  builtWith: 'FlutterFlow and Firebase',
  status: 'URI CSC305 project, in active development',
  price: 'Free demo',
  updated: 'November 2026',
  signIn: 'Google account',
  notice:
    'Envision is a URI CSC305 software project. This page is a Google Play inspired app listing',
};

type Block = { heading?: string; text?: string; bullets?: string[] };

/** Long description written to store-listing guidelines: no superlatives, no unverifiable claims. */
export const longDescription: Block[] = [
  {
    text: "Envision brings personal coaching and everyday fitness tracking into one app. Clients join their trainer's training space with a simple invite code, then keep their nutrition and training organized in one place. Coaches set up a space for their gym or coaching business and bring their clients together.",
  },
  {
    heading: 'Who it is for',
    text: 'Envision is designed for people working with a personal trainer, for people who want a structured way to follow their own routine, and for independent coaches and small gyms that want one shared home for their clients.',
  },
  {
    heading: 'For clients',
    bullets: [
      'Join your coach by entering the invite code from your trainer or gym.',
      'Not working with a coach yet? Choose "Maybe later" and set up on your own.',
      'Create your profile with a name, a username, and date of birth.',
      'See your daily calories and macros (protein, carbs and fat) and set a calorie goal.',
      'Move between days with the date picker and keep a log of your meals.',
      'Training and Progress tabs are in development.',
    ],
  },
  {
    heading: 'For coaches',
    bullets: [
      'Create a training space with your gym or coaching name and an optional photo.',
      'Say whether you coach in person, online or hybrid.',
      'List your specialties, from strength and bodybuilding to mobility and group fitness.',
      'Share your invite code so clients can link to your space.',
    ],
  },
  {
    heading: 'Why Envision',
    text: 'Progress depends on consistency, and consistency is easier when your plan, your nutrition and your coach live in the same place. Envision keeps setup short, remembers where you left off, and sends every user to the experience built for their role.',
  },
  {
    heading: 'About this project',
    text: 'Envision is being built by students for URI CSC305 software development class using FlutterFlow and Google Firebase. Some features are still in development.',
  },
];
