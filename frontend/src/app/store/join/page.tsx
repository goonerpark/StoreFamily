import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";

export default function StoreJoinPage() {
  return (
    <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden bg-background p-4 text-on-background">
      <Card className="z-10 flex w-full max-w-[480px] flex-col gap-8 p-8">
        <header className="space-y-2 text-center">
          <div className="mb-4 flex justify-center">
            <div className="flex h-16 w-16 items-center justify-center rounded-xl bg-primary-container text-on-primary-container">
              <MaterialSymbol className="text-[40px]" name="storefront" />
            </div>
          </div>
          <h1 className="font-h1 text-4xl font-bold text-primary">매장 팀 합류하기</h1>
          <p className="text-base text-secondary">시작을 위해 점주에게 받은 매장 코드를 입력해주세요.</p>
        </header>

        <section className="space-y-6">
          <div className="space-y-2">
            <label className="px-1 text-xs font-bold text-on-surface-variant">매장 접속 코드</label>
            <input
              className="w-full rounded-lg border-2 border-transparent bg-surface-container py-4 text-center text-[40px] font-bold tracking-[0.25em] text-primary placeholder:text-outline-variant/50 focus:border-primary focus:ring-0"
              maxLength={8}
              placeholder="000000"
              type="text"
            />
          </div>
          <Button className="h-12 w-full text-lg">
            매장 확인
            <MaterialSymbol name="arrow_forward" />
          </Button>
        </section>

        <article className="flex items-start gap-4 rounded-xl border border-primary/20 bg-surface-bright p-4">
          <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-primary-fixed text-on-primary-fixed">
            <MaterialSymbol name="store" />
          </div>
          <div className="flex-1">
            <h2 className="font-h3 text-xl font-bold text-on-surface">스토어패밀리 본점</h2>
            <p className="flex items-center gap-1 text-sm text-secondary">
              <MaterialSymbol className="text-[16px]" name="location_on" />
              서울특별시 강남구 테헤란로 123
            </p>
            <Button className="mt-4 w-full" variant="secondary">
              가입 요청하기
            </Button>
          </div>
        </article>

        <section className="flex gap-4 rounded-xl border-l-4 border-primary bg-surface-container-low p-4">
          <MaterialSymbol className="text-primary" name="info" />
          <div>
            <h3 className="text-xs font-bold text-on-surface">점주 승인 대기</h3>
            <p className="mt-1 text-sm text-on-surface-variant">가입 요청 후 점주가 프로필을 검토합니다. 승인 후 매장 기능을 사용할 수 있습니다.</p>
          </div>
        </section>
      </Card>

      <div className="pointer-events-none fixed inset-0 -z-0 opacity-30">
        <div className="absolute left-[5%] top-[10%] h-[400px] w-[400px] rounded-full bg-primary-fixed blur-[120px]" />
        <div className="absolute bottom-[10%] right-[5%] h-[300px] w-[300px] rounded-full bg-tertiary-fixed blur-[100px]" />
      </div>
    </main>
  );
}
