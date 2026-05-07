import type { ReactNode } from "react";

type CardProps = {
  children: ReactNode;
  className?: string;
};

export function Card({ children, className = "" }: CardProps) {
  return <section className={`rounded-xl border border-surface-variant bg-white shadow-sm ${className}`}>{children}</section>;
}
