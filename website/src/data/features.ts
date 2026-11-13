import type { LucideIcon } from 'lucide-react';
import {
  UserRoundCheck, KeyRound, Building2, Salad, Dumbbell, LineChart, ShieldCheck, Route, Tags, Users,
} from 'lucide-react';

// available items are usable in the current build
// early items are present in the app but still being implemented
// development items are planned or partially built, not complete

export type FeatureStatus = 'available' | 'early' | 'development';

export type Feature = {
  icon: LucideIcon;
  title: string;
  body: string;
  status: FeatureStatus;
  audience: 'client' | 'coach' | 'everyone';
  screenshot?: string;
};

export const features: Feature[] = [
  {
    icon: ShieldCheck,
    title: 'Simple, secure sign-in',
    body: 'Sign in with Google or Apple. Authentication is handled by Firebase Authentication, so Envision never sees or stores a password.',
    status: 'available',
    audience: 'everyone',
    screenshot: 'sign-in',
  },
  {
    icon: UserRoundCheck,
    title: 'Client and coach accounts',
    body: 'Choose how you will use Envision. Clients and coaches each get their own setup flow and dashboard.',
    status: 'available',
    audience: 'everyone',
    screenshot: 'role-select',
  },
  {
    icon: Route,
    title: 'Pick up where you left off',
    body: 'Envision remembers your role and how far you got through setup, and sends you straight back to the right screen.',
    status: 'available',
    audience: 'everyone',
    screenshot: 'splash',
  },
  {
    icon: KeyRound,
    title: 'Join your coach with a code',
    body: 'Enter the invite code your trainer or gym gave you. Envision checks the code and links you to their training space.',
    status: 'available',
    audience: 'client',
    screenshot: 'client-join',
  },
  {
    icon: Salad,
    title: 'Nutrition tracking',
    body: 'Set a calorie goal, then see calories, protein, carbs and fat for any day, alongside your meal log.',
    status: 'early',
    audience: 'client',
    screenshot: 'client-dashboard',
  },
  {
    icon: Dumbbell,
    title: 'Training',
    body: 'A Training tab on the client dashboard for workout plans and exercises.',
    status: 'development',
    audience: 'client',
  },
  {
    icon: LineChart,
    title: 'Progress',
    body: 'A Progress tab for body measurements and progress over time.',
    status: 'development',
    audience: 'client',
  },
  {
    icon: Building2,
    title: 'Your own training space',
    body: 'Coaches create a space with a gym or coaching name, an optional photo, and whether they coach in person, online or both.',
    status: 'available',
    audience: 'coach',
    screenshot: 'coach-space',
  },
  {
    icon: Tags,
    title: 'Coaching specialties',
    body: 'Show what you coach: strength, bodybuilding, weight loss, sports performance, group fitness, mobility and more.',
    status: 'available',
    audience: 'coach',
    screenshot: 'coach-specialties',
  },
  {
    icon: Users,
    title: 'Coach dashboard and clients',
    body: 'A coach dashboard where clients who joined with your code are connected to your space. Client management tools are being expanded.',
    status: 'early',
    audience: 'coach',
  },
];

export const statusLabel: Record<FeatureStatus, string> = {
  available: 'Available',
  early: 'Early version',
  development: 'In development',
};
