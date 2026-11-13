export type Screenshot = {
  src: string;
  alt: string;
  title: string;
  caption: string;
  role: 'all' | 'client' | 'coach';
};

// Regenerate with 'npm run assets'

export const screenshots: Screenshot[] = [
  {
    src: 'screenshots/sign-in.png',
    title: 'Sign in',
    caption: 'Continue with your Google or Apple account.',
    alt: 'Envision welcome screen with the headline "Personal coaching that works." and buttons to continue with Gmail or Apple.',
    role: 'all',
  },
  {
    src: 'screenshots/role-select.png',
    title: 'Choose your role',
    caption: 'Pick the Coach or Client experience.',
    alt: 'Screen titled "How will you use Envision?" with two photo cards: Coach and Client.',
    role: 'all',
  },
  {
    src: 'screenshots/client-join.png',
    title: 'Join your trainer',
    caption: 'Enter the invite code from your coach or gym.',
    alt: 'Screen titled "Join your trainer" with an invite code field and buttons "Find training space" and "Maybe later".',
    role: 'client',
  },
  {
    src: 'screenshots/client-dashboard.png',
    title: 'Client dashboard',
    caption: 'Daily calories, macros and meal logs at a glance.',
    alt: 'Client dashboard greeting "Athlete" with Nutrition, Training and Progress tabs, a calorie ring, protein, carb and fat bars, and an empty meal log.',
    role: 'client',
  },
  {
    src: 'screenshots/coach-space.png',
    title: 'Create a training space',
    caption: 'Name your gym, add a photo and pick how you coach.',
    alt: 'Screen titled "Create your training space" with a gym name field, a photo area and options In-person, Online and Hybrid.',
    role: 'coach',
  },
  {
    src: 'screenshots/coach-specialties.png',
    title: 'Coaching specialties',
    caption: 'Tell clients what you coach.',
    alt: 'Screen titled "What do you coach?" with selectable chips such as Strength, Bodybuilding, Weight loss, Sports performance, Group fitness and Mobility.',
    role: 'coach',
  },
  {
    src: 'screenshots/splash.png',
    title: 'Launch screen',
    caption: 'Envision checks your session and routes you automatically.',
    alt: 'Envision launch screen showing the orange three-stripe logo above the word Envision.',
    role: 'all',
  },
];

export const shot = (name: string) => {
  const s = screenshots.find((x) => x.src.includes(name));
  if (!s) throw new Error(`Unknown screenshot: ${name}`);
  return s;
};
