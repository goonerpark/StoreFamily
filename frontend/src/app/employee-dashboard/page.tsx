import { AppShell } from "@/components/layout/app-shell";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";
import { getEmployeeDashboard } from "@/lib/api";

export default async function EmployeeDashboardPage() {
  const { currentUser, recommendedFills, weeklySchedule } = await getEmployeeDashboard();

  return (
    <AppShell title="홈">
      <div className="mx-auto max-w-6xl space-y-6 px-6 py-8 pb-24 md:pb-8">
        <section className="grid grid-cols-1 gap-6 lg:grid-cols-3">
          <Card className="p-8 lg:col-span-2">
            <div className="grid grid-cols-1 items-center gap-8 md:grid-cols-2">
              <div className="space-y-4">
                <div className="inline-flex items-center gap-1 rounded-full bg-primary-container px-2 py-1 text-on-primary-container">
                  <MaterialSymbol className="text-[16px]" fill name="timer" />
                  <span className="text-xs font-bold">현재 근무 중</span>
                </div>
                <div>
                  <h1 className="font-h1 text-4xl font-bold text-on-surface">오늘의 근무</h1>
                  <p className="mt-2 text-secondary">{currentUser.name}님, 오늘 일정과 대타 추천을 빠르게 확인하세요.</p>
                </div>
                <div className="space-y-2">
                  <div className="flex items-center gap-4">
                    <MaterialSymbol className="text-primary" name="schedule" />
                    <span className="text-base text-on-surface">09:00 - 17:00</span>
                  </div>
                  <div className="flex items-center gap-4">
                    <MaterialSymbol className="text-primary" name="assignment_ind" />
                    <span className="text-base text-on-surface">메인 카운터 및 재고 관리</span>
                  </div>
                </div>
                <div className="flex flex-wrap gap-2 pt-4">
                  <Button href="/schedule">근무표 보기</Button>
                  <Button href="/fills" variant="secondary">
                    대타 찾기
                  </Button>
                </div>
              </div>
              <div className="relative h-48 overflow-hidden rounded-xl bg-primary-fixed md:h-64">
                <div className="absolute inset-0 bg-gradient-to-br from-primary/90 to-primary-container/80" />
                <div className="absolute inset-0 flex flex-col justify-end p-6 text-white">
                  <MaterialSymbol className="mb-4 text-[56px] opacity-80" name="storefront" />
                  <p className="text-xs opacity-80">매장 위치</p>
                  <p className="font-h3 text-xl font-bold">{currentUser.storeName}</p>
                </div>
              </div>
            </div>
          </Card>

          <Card className="flex flex-col justify-between bg-surface-container-low p-6">
            <div>
              <div className="mb-4 flex items-start justify-between">
                <h2 className="flex items-center gap-2 font-h3 text-xl font-bold text-primary">
                  <MaterialSymbol name="campaign" />
                  매장 공지
                </h2>
                <MaterialSymbol className="text-secondary" name="more_horiz" />
              </div>
              <div className="space-y-4">
                <div className="rounded-lg border-l-4 border-primary bg-white p-3">
                  <p className="mb-1 text-xs font-bold text-primary">새로운 정책</p>
                  <p className="font-semibold text-on-surface">보건증 등록 상태를 확인해주세요</p>
                  <p className="text-xs text-secondary">점주 • 2시간 전</p>
                </div>
                <div className="rounded-lg border-l-4 border-tertiary-container bg-white p-3">
                  <p className="mb-1 text-xs font-bold text-tertiary">점검 공지</p>
                  <p className="font-semibold text-on-surface">주말 대타 모집이 열려 있습니다</p>
                  <p className="text-xs text-secondary">관리자 • 5시간 전</p>
                </div>
              </div>
            </div>
            <Button className="mt-6 w-full" href="/board" variant="ghost">
              전체 게시판 보기 <MaterialSymbol className="text-[16px]" name="arrow_forward" />
            </Button>
          </Card>
        </section>

        <section className="grid grid-cols-1 gap-6 lg:grid-cols-3">
          <Card className="p-6 lg:col-span-2">
            <div className="mb-6 flex items-center justify-between">
              <h2 className="flex items-center gap-2 font-h3 text-xl font-bold text-on-surface">
                <MaterialSymbol className="text-primary" name="calendar_month" />
                나의 주간 스케줄
              </h2>
              <div className="flex gap-1">
                <button className="rounded p-1 hover:bg-surface-container" type="button">
                  <MaterialSymbol name="chevron_left" />
                </button>
                <button className="rounded p-1 hover:bg-surface-container" type="button">
                  <MaterialSymbol name="chevron_right" />
                </button>
              </div>
            </div>
            <div className="grid grid-cols-7 gap-2">
              {weeklySchedule.map((day) => (
                <div className="space-y-2 text-center" key={day.dayName}>
                  <p className="text-[10px] font-bold text-secondary">{day.dayName}</p>
                  <div
                    className={`flex h-24 flex-col items-center justify-center rounded-lg p-1 ${
                      day.isToday ? "bg-primary-container text-white shadow-lg" : "bg-surface-container-low text-on-surface"
                    }`}
                  >
                    <span className="text-xs font-bold">{day.dayNumber}</span>
                    {day.isToday ? <span className="mt-1 text-[10px] font-bold">오늘</span> : null}
                    {day.hasShift ? (
                      <div
                        className={`mt-1 flex h-8 w-full items-center justify-center rounded-md border ${
                          day.tone === "tertiary" ? "border-tertiary-container/30 bg-tertiary-container/20" : "border-primary/30 bg-primary-container/20"
                        }`}
                      >
                        <span className={`h-1.5 w-1.5 rounded-full ${day.tone === "tertiary" ? "bg-tertiary" : "bg-primary"}`} />
                      </div>
                    ) : null}
                  </div>
                </div>
              ))}
            </div>
          </Card>

          <Card className="p-6">
            <h2 className="mb-4 font-h3 text-xl font-bold text-on-surface">주간 요약</h2>
            <div className="space-y-6">
              <SummaryItem icon="work" label="예정 근무 시간" value="32h" />
              <SummaryItem icon="payments" label="예상 급여" value="계산 예정" tone="tertiary" />
              <div className="border-t border-surface-variant pt-2">
                <p className="text-on-surface-variant">
                  다음 주: <span className="font-bold text-primary">4개 근무</span> 확정됨.
                </p>
              </div>
            </div>
          </Card>
        </section>

        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="flex items-center gap-2 font-h3 text-xl font-bold text-on-surface">
              <MaterialSymbol className="text-primary" name="sync_alt" />
              대타 추천
            </h2>
            <Button href="/fills" variant="ghost">
              전체 모집 보기
            </Button>
          </div>
          <div className="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
            {recommendedFills.map((fill) => (
              <Card className="group flex gap-4 p-4 transition hover:border-primary" key={fill.id}>
                <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-surface-container text-primary transition group-hover:bg-primary-container group-hover:text-white">
                  <MaterialSymbol name="person_search" />
                </div>
                <div className="flex-1">
                  <div className="flex justify-between gap-2">
                    <p className="font-bold text-on-surface">{fill.requesterName}</p>
                    {fill.badge ? <span className="rounded-full bg-tertiary-fixed-dim px-2 text-[10px] font-bold text-tertiary">{fill.badge}</span> : null}
                  </div>
                  <p className="text-xs text-secondary">{fill.dateLabel}</p>
                  <p className="mt-1 text-xs font-bold text-on-surface-variant">{fill.timeRange}</p>
                  <div className="mt-4 flex gap-2">
                    <Button className="flex-1 py-1 text-xs" href={`/fills/${fill.id}`} variant="secondary">
                      지원하기
                    </Button>
                    <Button className="flex-1 py-1 text-xs" href={`/fills/${fill.id}`} variant="ghost">
                      상세보기
                    </Button>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        </section>
      </div>
    </AppShell>
  );
}

function SummaryItem({ icon, label, value, tone = "primary" }: { icon: string; label: string; value: string; tone?: "primary" | "tertiary" }) {
  return (
    <div className="flex items-center gap-6">
      <div className={`flex h-12 w-12 items-center justify-center rounded-full bg-surface-container ${tone === "primary" ? "text-primary" : "text-tertiary"}`}>
        <MaterialSymbol name={icon} />
      </div>
      <div>
        <p className="font-h2 text-2xl font-bold text-on-surface">{value}</p>
        <p className="text-xs font-bold text-secondary">{label}</p>
      </div>
    </div>
  );
}
