import Link from "next/link";
import { Button } from "@/components/ui/button";
import { MaterialSymbol } from "@/components/ui/material-symbol";

export default function LoginPage() {
  return (
    <main className="relative flex min-h-screen items-center justify-center overflow-hidden bg-background p-4">
      <section className="z-10 w-full max-w-md">
        <div className="mb-8 text-center">
          <h1 className="font-h1 text-4xl font-bold text-primary">StoreFamily</h1>
          <p className="mt-1 text-base text-secondary">공감하는 효율성</p>
        </div>

        <div className="rounded-xl border border-surface-variant bg-white p-8 shadow-sm">
          <form className="space-y-6">
            <div className="space-y-1">
              <label className="block text-xs font-bold text-on-surface-variant" htmlFor="id">
                아이디
              </label>
              <input
                className="h-12 w-full rounded-lg border border-outline-variant bg-surface-container-lowest px-4 text-sm text-on-surface outline-none transition focus:border-primary focus:ring-1 focus:ring-primary"
                id="id"
                name="id"
                placeholder="아이디를 입력하세요"
                type="text"
              />
            </div>
            <div className="space-y-1">
              <label className="block text-xs font-bold text-on-surface-variant" htmlFor="password">
                비밀번호
              </label>
              <input
                className="h-12 w-full rounded-lg border border-outline-variant bg-surface-container-lowest px-4 text-sm text-on-surface outline-none transition focus:border-primary focus:ring-1 focus:ring-primary"
                id="password"
                name="password"
                placeholder="••••••••"
                type="password"
              />
              {/* TODO: Spring 로그인 API 연동 후 실제 오류 상태에만 표시 */}
              <div className="mt-1 flex items-center gap-1 text-error">
                <MaterialSymbol className="text-[16px]" name="error" />
                <span className="text-xs font-bold">아이디 또는 비밀번호가 일치하지 않습니다.</span>
              </div>
            </div>
            <Button className="h-12 w-full text-lg" type="submit">
              로그인
            </Button>
          </form>

          <div className="mt-8 flex flex-col items-center gap-4">
            <div className="flex items-center gap-4 text-sm">
              <Link className="font-semibold text-primary hover:underline" href="/account/find">
                아이디/비밀번호 찾기
              </Link>
              <span className="h-4 w-px bg-outline-variant" />
              <Link className="font-semibold text-primary hover:underline" href="/signup">
                회원가입
              </Link>
            </div>
            <div className="w-full border-t border-surface-variant pt-6 text-center">
              <p className="text-xs font-bold text-on-surface-variant">매장 관리, 진심을 담아 효율을 더합니다.</p>
            </div>
          </div>
        </div>
      </section>

      <div className="pointer-events-none fixed inset-0 -z-0 overflow-hidden">
        <div className="absolute -right-24 -top-24 h-96 w-96 rounded-full bg-primary-fixed-dim/20 blur-3xl" />
        <div className="absolute -bottom-24 -left-24 h-96 w-96 rounded-full bg-tertiary-fixed/20 blur-3xl" />
      </div>
    </main>
  );
}
