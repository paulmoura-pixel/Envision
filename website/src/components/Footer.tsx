import { Link } from 'react-router-dom';
import Logo from './Logo';
import { footerNav } from '../data/nav';
import { app } from '../data/app';

export default function Footer() {
  return (
    <footer className="mt-24 bg-ink text-[#c9cdd4]">
      <div className="container-page grid gap-10 py-14 md:grid-cols-[1.4fr_repeat(3,1fr)]">
        <div className="max-w-sm">
          <Logo tone="light" />
          <p className="mt-4 text-sm leading-6">{app.shortDescription}</p>
          <p className="mt-4 text-xs leading-5 text-[#9aa1ab]">{app.notice}</p>
        </div>
        {footerNav.map((group) => (
          <nav key={group.title} aria-label={group.title}>
            <h2 className="font-sans text-sm font-semibold text-white">{group.title}</h2>
            <ul className="mt-4 space-y-2.5 text-sm">
              {group.links.map((l) => (
                <li key={l.to}>
                  <Link to={l.to} className="hover:text-white hover:underline underline-offset-4">
                    {l.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        ))}
      </div>
      <div className="border-t border-white/10">
        <div className="container-page flex flex-col gap-2 py-6 text-xs text-[#9aa1ab] sm:flex-row sm:items-center sm:justify-between">
          <p>© {new Date().getFullYear()} Envision student team. Built for a university software development course.</p>
          <p>Not affiliated with Google, Apple or FlutterFlow.</p>
        </div>
      </div>
    </footer>
  );
}
