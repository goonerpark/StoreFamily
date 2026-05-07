import type { ReactNode } from "react";

const badgeTone = {
  primary: "bg-primary-container text-on-primary-container",
  success: "bg-[#d1fae5] text-[#059669]",
  info: "bg-[#e0f2fe] text-[#0369a1]",
  neutral: "bg-surface-container text-secondary",
  danger: "bg-error-container text-on-error-container",
  warning: "bg-tertiary-fixed-dim text-tertiary",
} as const;

type BadgeProps = {
  children: ReactNode;
  tone?: keyof typeof badgeTone;
  className?: string;
};

export function Badge({ children, tone = "neutral", className = "" }: BadgeProps) {
  return (
    <span className={`inline-flex items-center gap-1 rounded-lg px-3 py-1 text-xs font-bold ${badgeTone[tone]} ${className}`}>
      {children}
    </span>
  );
}
