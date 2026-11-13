import { Link } from 'react-router-dom';
import { LogoMark } from '../components/Logo';

export default function NotFound() {
  return (
    <section className="container-page flex flex-col items-center py-28 text-center">
      <LogoMark className="h-16 w-16" />
      <p className="eyebrow mt-6">404</p>
      <h1 className="mt-2 text-4xl font-extrabold">This page took a rest day</h1>
      <p className="mt-3 max-w-md text-muted">The page you&apos;re looking for doesn&apos;t exist or has moved.</p>
      <div className="mt-8 flex flex-wrap justify-center gap-3">
        <Link to="/" className="btn-primary">Back to Envision</Link>
        <Link to="/guide" className="btn-secondary">User Guide</Link>
      </div>
    </section>
  );
}
