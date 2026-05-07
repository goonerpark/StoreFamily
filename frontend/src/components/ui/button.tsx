import Link from "next/link";
import type { ReactNode } from "react";

const buttonVariant = {
  primary: "bg-primary text-on-primary hover:opacity-90",
  secondary: "border border-outline-variant bg-surface-container-low text-secondary hover:bg-surface-container",
  ghost: "text-primary hover:bg-primary/5",
} as const;

type ButtonProps = {
  children: ReactNode;
  className?: string;
  href?: string;
  type?: "button" | "submit";
  variant?: keyof typeof buttonVariant;
};

export function Button({ children, className = "", href, type = "button", variant = "primary" }: ButtonProps) {
  const classes = `inline-flex items-center justify-center gap-2 rounded-lg px-4 py-2 text-sm font-bold transition active:scale-95 ${buttonVariant[variant]} ${className}`;

  if (href) {
    return (
      <Link className={classes} href={href}>
        {children}
      </Link>
    );
  }

  return (
    <button className={classes} type={type}>
      {children}
    </button>
  );
}
