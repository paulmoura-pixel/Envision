type Props = { className?: string; withWordmark?: boolean; tone?: 'dark' | 'light' };

// Envision launch screen

export function LogoMark({ className = 'h-7 w-7' }: { className?: string }) {
  return (
    <svg viewBox="28 18 72 72" className={className} aria-hidden="true">
      <g stroke="#FF6B00" strokeWidth="12" strokeLinecap="round" fill="none">
        <line x1="52" y1="38" x2="94" y2="27" />
        <line x1="40" y1="61" x2="88" y2="49" />
        <line x1="33" y1="84" x2="72" y2="74" />
      </g>
    </svg>
  );
}

export default function Logo({ className = '', withWordmark = true, tone = 'dark' }: Props) {
  return (
    <span className={`inline-flex items-center gap-2 ${className}`}>
      <LogoMark />
      {withWordmark && (
        <span className={`font-display text-xl font-extrabold tracking-tight ${tone === 'light' ? 'text-white' : 'text-ink'}`}>
          Envision
        </span>
      )}
    </span>
  );
}
