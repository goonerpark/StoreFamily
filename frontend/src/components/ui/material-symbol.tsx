type MaterialSymbolProps = {
  name: string;
  className?: string;
  fill?: boolean;
};

export function MaterialSymbol({ name, className = "", fill = false }: MaterialSymbolProps) {
  return (
    <span
      aria-hidden="true"
      className={`material-symbols-outlined ${className}`}
      style={{ fontVariationSettings: `"FILL" ${fill ? 1 : 0}, "wght" 400, "GRAD" 0, "opsz" 24` }}
    >
      {name}
    </span>
  );
}
