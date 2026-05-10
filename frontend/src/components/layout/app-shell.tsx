"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { MaterialSymbol } from "@/components/ui/material-symbol";
import { currentUser } from "@/lib/mock-data";

const navItems = [
  { href: "/employee-dashboard", label: "홈", icon: "dashboard" },
  { href: "/store/join", label: "매장 가입", icon: "group_add" },
  { href: "/employees", label: "직원 관리", icon: "group" },
  { href: "/schedule", label: "스케줄", icon: "calendar_today" },
  { href: "/fills", label: "대타 모집", icon: "swap_horiz" },
  { href: "/board", label: "게시판", icon: "forum" },
  { href: "/mypage", label: "마이페이지", icon: "person" },
];

type AppShellProps = {
  children: React.ReactNode;
  title?: string;
  showSearch?: boolean;
};

export function AppShell({ children, title = "StoreFamily", showSearch = false }: AppShellProps) {
  const pathname = usePathname();

  return (
    <div className="min-h-screen bg-background text-on-background">
      <aside className="fixed left-0 top-0 z-50 hidden h-screen w-64 flex-col border-r border-surface-variant bg-white p-4 md:flex">
        <Link className="mb-8 flex items-center gap-2 px-2" href="/employee-dashboard">
          <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-on-primary">
            <MaterialSymbol name="storefront" />
          </div>
          <div>
            <h1 className="font-h3 text-xl font-bold text-primary">StoreFamily</h1>
            <p className="text-[10px] text-secondary">Empathetic Efficiency</p>
          </div>
        </Link>

        <nav className="flex-1 space-y-1">
          {navItems.map((item) => {
            const active = pathname === item.href || pathname.startsWith(`${item.href}/`);
            return (
              <Link
                className={`flex items-center gap-4 rounded-lg px-4 py-2 transition ${
                  active ? "bg-primary-container font-bold text-on-primary-container" : "text-secondary hover:bg-surface-container-low hover:text-on-surface"
                }`}
                href={item.href}
                key={item.href}
              >
                <MaterialSymbol name={item.icon} />
                <span>{item.label}</span>
              </Link>
            );
          })}
        </nav>

        <div className="mt-auto space-y-1 border-t border-surface-variant pt-4">
          <Link className="flex w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 py-2 font-bold text-on-primary transition hover:opacity-90" href="/schedule">
            <MaterialSymbol className="text-[20px]" name="add" />
            새 스케줄 등록
          </Link>
          <Link className="flex items-center gap-4 rounded-lg px-4 py-2 text-secondary hover:bg-surface-container-low" href="/settings">
            <MaterialSymbol name="settings" />
            설정
          </Link>
        </div>
      </aside>

      <header className="fixed left-0 top-0 z-40 flex h-16 w-full items-center justify-between bg-surface px-4 shadow-sm md:pl-[280px] md:pr-6">
        <div className="flex min-w-0 items-center gap-4">
          <MaterialSymbol className="text-primary md:hidden" name="menu" />
          <h2 className="truncate font-h2 text-xl font-bold text-primary md:text-2xl">{title}</h2>
        </div>
        <div className="flex items-center gap-3 md:gap-4">
          {showSearch ? (
            <div className="relative hidden sm:block">
              <MaterialSymbol className="absolute left-3 top-1/2 -translate-y-1/2 text-[20px] text-secondary" name="search" />
              <input className="w-56 rounded-full border-none bg-surface-container-low py-2 pl-10 pr-4 text-sm transition focus:bg-white focus:ring-2 focus:ring-primary" placeholder="검색" type="search" />
            </div>
          ) : null}
          <button className="relative rounded-full p-2 hover:bg-surface-container" type="button">
            <MaterialSymbol className="text-secondary" name="notifications" />
            <span className="absolute right-2 top-2 h-2 w-2 rounded-full border-2 border-surface bg-error" />
          </button>
          <div className="flex items-center gap-2 rounded-lg p-1 hover:bg-surface-container">
            <div className="flex h-9 w-9 items-center justify-center rounded-full bg-primary-container font-bold text-on-primary-container">
              {currentUser.name.slice(0, 1)}
            </div>
            <div className="hidden text-left lg:block">
              <p className="text-xs font-bold leading-none">{currentUser.name}</p>
              <p className="text-[10px] text-secondary">{currentUser.storeName}</p>
            </div>
            <MaterialSymbol className="hidden text-[18px] text-secondary sm:inline-block" name="keyboard_arrow_down" />
          </div>
        </div>
      </header>

      <main className="min-h-screen pt-16 md:pl-64">{children}</main>

      <nav className="fixed bottom-0 left-0 z-50 flex h-16 w-full items-center justify-around border-t border-surface-variant bg-white px-4 shadow-[0_-2px_10px_rgba(0,0,0,0.05)] md:hidden">
        <BottomNavItem active={pathname.startsWith("/employee-dashboard")} href="/employee-dashboard" icon="home" label="홈" />
        <BottomNavItem active={pathname.startsWith("/schedule")} href="/schedule" icon="calendar_today" label="근무표" />
        <Link className="-mt-8 flex h-12 w-12 items-center justify-center rounded-full bg-primary text-on-primary shadow-lg" href="/schedule">
          <MaterialSymbol name="add" />
        </Link>
        <BottomNavItem active={pathname.startsWith("/fills")} href="/fills" icon="swap_horiz" label="대타" />
        <BottomNavItem active={pathname.startsWith("/mypage")} href="/mypage" icon="person" label="마이" />
      </nav>
    </div>
  );
}

function BottomNavItem({ active, href, icon, label }: { active: boolean; href: string; icon: string; label: string }) {
  return (
    <Link className={`flex flex-col items-center gap-1 ${active ? "text-primary" : "text-secondary"}`} href={href}>
      <MaterialSymbol fill={active} name={icon} />
      <span className="text-[10px] font-bold">{label}</span>
    </Link>
  );
}
