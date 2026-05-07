import { AppShell } from "@/components/layout/app-shell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";
import { getFillDashboard } from "@/lib/api";
import type { FillPost, FillStatus } from "@/lib/types";

const statusMap: Record<FillStatus, { label: string; tone: "success" | "info" | "neutral" | "danger"; icon: string; bar: string; dim?: boolean }> = {
  recruiting: { label: "모집중", tone: "success", icon: "person_search", bar: "bg-[#10b981]" },
  pending: { label: "승인대기", tone: "info", icon: "hourglass_empty", bar: "bg-primary" },
  done: { label: "완료", tone: "neutral", icon: "done_all", bar: "bg-secondary", dim: true },
  canceled: { label: "취소", tone: "danger", icon: "cancel", bar: "bg-error", dim: true },
};

export default async function FillsPage() {
  const { fills, myApplications, storeName } = await getFillDashboard();
  const recruitingCount = fills.filter((fill) => fill.status === "recruiting").length;
  const pendingCount = fills.filter((fill) => fill.status === "pending").length;
  const doneCount = fills.filter((fill) => fill.status === "done").length;

  return (
    <AppShell showSearch title="대타 모집">
      <div className="mx-auto max-w-7xl space-y-8 p-6 pb-24 md:p-8">
        <section className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
          <div>
            <h1 className="font-h1 text-4xl font-bold text-on-surface">대타 모집 및 지원 관리</h1>
            <p className="mt-2 text-secondary">{storeName}의 교대 요청과 지원 현황을 한눈에 관리하세요.</p>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <Button variant="secondary">
              <MaterialSymbol className="text-[20px]" name="filter_list" />
              필터 상세
            </Button>
            <Button href="/fills/new">
              <MaterialSymbol className="text-[20px]" name="edit_square" />
              모집글 올리기
            </Button>
          </div>
        </section>

        <Card className="flex flex-wrap items-center gap-4 p-4">
          <div className="no-scrollbar flex gap-2 overflow-x-auto pb-2 md:pb-0">
            <button className="whitespace-nowrap rounded-full bg-primary-container px-4 py-1 font-bold text-on-primary-container" type="button">
              전체
            </button>
            <button className="whitespace-nowrap rounded-full bg-surface-container-low px-4 py-1 text-secondary hover:bg-surface-container-high" type="button">
              모집중 ({recruitingCount})
            </button>
            <button className="whitespace-nowrap rounded-full bg-surface-container-low px-4 py-1 text-secondary hover:bg-surface-container-high" type="button">
              승인대기 ({pendingCount})
            </button>
            <button className="whitespace-nowrap rounded-full bg-surface-container-low px-4 py-1 text-secondary hover:bg-surface-container-high" type="button">
              완료 ({doneCount})
            </button>
          </div>
          <div className="hidden h-6 w-px bg-surface-variant md:block" />
          <select className="rounded-lg border-none bg-surface-container-low py-1 pr-8 text-sm focus:ring-primary">
            <option>{storeName}</option>
          </select>
        </Card>

        <section className="grid grid-cols-1 gap-6 lg:grid-cols-3">
          <div className="space-y-4 lg:col-span-2">
            <div className="flex items-center justify-between">
              <h2 className="flex items-center gap-1 font-h3 text-xl font-bold">
                <MaterialSymbol className="text-primary" name="list_alt" />
                진행 중인 대타 요청
              </h2>
              <span className="text-xs font-bold text-secondary">총 {fills.length}건</span>
            </div>
            {fills.map((fill) => (
              <FillCard fill={fill} key={fill.id} />
            ))}
          </div>

          <aside className="space-y-6">
            <Card className="p-6">
              <div className="mb-6 flex items-center justify-between">
                <h2 className="flex items-center gap-1 font-h3 text-xl font-bold">
                  <MaterialSymbol className="text-primary" name="history" />
                  나의 지원 현황
                </h2>
                <Button className="px-0 py-0" href="/fills/applications" variant="ghost">
                  전체보기
                </Button>
              </div>
              <div className="space-y-4">
                {myApplications.map((application) => (
                  <div className="rounded-lg border border-surface-variant bg-surface-container-low p-4" key={application.id}>
                    <div className="mb-2 flex items-start justify-between gap-2">
                      <p className="font-bold">{application.title}</p>
                      <span className="rounded bg-primary-container px-2 py-0.5 text-[10px] text-on-primary-container">
                        {application.status === "reviewing" ? "심사중" : application.status === "approved" ? "승인" : "취소됨"}
                      </span>
                    </div>
                    <div className="flex items-center justify-between text-xs font-bold">
                      <span className="text-secondary">신청일: {application.appliedAt}</span>
                      <span className="text-primary">{application.payLabel}</span>
                    </div>
                  </div>
                ))}
              </div>
            </Card>

            <Card className="relative overflow-hidden bg-primary p-6 text-on-primary">
              <div className="relative z-10">
                <h3 className="mb-2 text-xs font-bold opacity-80">이번 달 대타 성사율</h3>
                <div className="mb-6 flex items-baseline gap-1">
                  <span className="text-[32px] font-bold">92%</span>
                  <span className="text-xs opacity-80">mock</span>
                </div>
                <div className="mb-4 h-2 w-full overflow-hidden rounded-full bg-white/20">
                  <div className="h-full bg-white" style={{ width: "92%" }} />
                </div>
                <p className="text-xs leading-relaxed opacity-90">TODO: 승인 완료된 대타 수와 전체 모집 수 기반으로 계산합니다.</p>
              </div>
              <MaterialSymbol className="absolute -bottom-4 -right-4 text-[120px] opacity-10" name="trending_up" />
            </Card>

            <div className="flex gap-4 rounded-xl bg-surface-container-high p-4">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-white text-primary">
                <MaterialSymbol name="info" />
              </div>
              <div>
                <p className="text-xs font-bold text-on-surface">알고 계셨나요?</p>
                <p className="mt-1 text-xs text-secondary">추가 수당을 설정하면 대타가 모집될 확률이 올라갑니다.</p>
              </div>
            </div>
          </aside>
        </section>
      </div>
    </AppShell>
  );
}

function FillCard({ fill }: { fill: FillPost }) {
  const status = statusMap[fill.status];

  return (
    <Card className={`relative overflow-hidden p-6 transition hover:shadow-md ${status.dim ? "opacity-75" : ""}`}>
      <div className={`absolute left-0 top-0 h-full w-1 ${status.bar}`} />
      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
        <div className="flex items-start gap-4">
          <div className="flex h-12 w-12 shrink-0 flex-col items-center justify-center rounded-lg border border-surface-variant bg-surface-container-low">
            <span className="text-xs font-bold text-secondary">{fill.monthLabel}</span>
            <span className="font-h3 text-xl font-bold text-primary">{fill.dayLabel}</span>
          </div>
          <div>
            <div className="mb-1 flex flex-wrap items-center gap-2">
              <span className="rounded-full bg-[#e7f5f1] px-2 py-0.5 text-[10px] font-bold text-primary">{fill.partName}</span>
              <p className={`font-bold ${status.dim ? "text-secondary line-through" : "text-on-surface"}`}>{fill.title}</p>
            </div>
            <div className="flex flex-wrap items-center gap-2 text-sm text-secondary">
              <span className="inline-flex items-center gap-1">
                <MaterialSymbol className="text-[18px]" name="schedule" />
                {fill.date} {fill.timeRange}
              </span>
              <span className="inline-flex items-center gap-1">
                <MaterialSymbol className="text-[18px]" name="person" />
                {fill.workerLabel}
              </span>
              {fill.bonus ? <span className="font-bold text-error">{fill.bonus}</span> : <span className="font-bold text-primary">지원자 {fill.applicants}명</span>}
            </div>
          </div>
        </div>
        <div className="flex flex-col gap-2 md:items-end">
          <Badge tone={status.tone}>
            <MaterialSymbol className="text-[16px]" name={status.icon} />
            {status.label}
          </Badge>
          <div className="flex w-full gap-1 md:w-auto">
            <Button className="flex-1 md:flex-none" href={`/fills/${fill.id}`} variant="secondary">
              지원자 보기
            </Button>
            <Button className="flex-1 md:flex-none" href={`/fills/${fill.id}`}>
              상세보기
            </Button>
          </div>
        </div>
      </div>
    </Card>
  );
}
