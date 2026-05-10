"use client";

import { useMemo, useState } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";
import type { ScheduleEmployee, ScheduleStore, ScheduleSummary, ScheduleViewMode, ShiftStatus, ShiftType, StoreShift } from "@/lib/types";

type StoreSchedulePageProps = {
  stores: ScheduleStore[];
  selectedStoreId: string;
  employees: ScheduleEmployee[];
  shifts: StoreShift[];
  summary: ScheduleSummary;
  baseMonth: string;
  today: string;
};

type CalendarDay = {
  date: string;
  day: number;
  currentMonth: boolean;
  today: boolean;
  weekday: number;
};

const weekdays = ["일", "월", "화", "수", "목", "금", "토"];

const shiftTone: Record<ShiftType, { label: string; dot: string; card: string; text: string }> = {
  open: {
    label: "오픈",
    dot: "bg-primary",
    card: "border-primary bg-primary-container/10 hover:bg-primary-container/15",
    text: "text-primary",
  },
  middle: {
    label: "미들",
    dot: "bg-secondary",
    card: "border-secondary bg-secondary-container/60 hover:bg-secondary-container",
    text: "text-on-secondary-container",
  },
  close: {
    label: "마감",
    dot: "bg-tertiary",
    card: "border-tertiary bg-tertiary-container/15 hover:bg-tertiary-container/20",
    text: "text-tertiary",
  },
};

const statusTone: Record<ShiftStatus, { label: string; tone: "primary" | "success" | "neutral" | "danger" | "warning"; icon: string }> = {
  scheduled: { label: "예정", tone: "neutral", icon: "event_available" },
  confirmed: { label: "확정", tone: "success", icon: "check_circle" },
  conflict: { label: "충돌", tone: "danger", icon: "warning" },
  shortage: { label: "부족", tone: "warning", icon: "priority_high" },
};

export function StoreSchedulePage({ stores, selectedStoreId, employees, shifts, summary, baseMonth, today }: StoreSchedulePageProps) {
  const [viewMode, setViewMode] = useState<ScheduleViewMode>("month");
  const [employeeFilter, setEmployeeFilter] = useState("all");
  const [storeId, setStoreId] = useState(selectedStoreId);
  const [selectedDate, setSelectedDate] = useState(today);

  const visibleShifts = useMemo(() => {
    return shifts.filter((shift) => employeeFilter === "all" || shift.employeeId === Number(employeeFilter));
  }, [employeeFilter, shifts]);

  const calendarDays = useMemo(() => buildMonthCells(baseMonth, today), [baseMonth, today]);
  const weekDays = useMemo(() => {
    const selected = parseDate(selectedDate);
    const start = new Date(selected);
    start.setDate(selected.getDate() - selected.getDay());
    return Array.from({ length: 7 }, (_, index) => {
      const current = new Date(start);
      current.setDate(start.getDate() + index);
      return toCalendarDay(current, current.getMonth() === parseDate(`${baseMonth}-01`).getMonth(), today);
    });
  }, [baseMonth, selectedDate, today]);

  const days = viewMode === "week" ? weekDays : calendarDays;
  const selectedStore = stores.find((store) => store.id === storeId) ?? stores[0];

  return (
    <div className="mx-auto flex max-w-[1500px] flex-col gap-6 p-4 pb-24 md:p-6 lg:flex-row lg:pb-8">
      <section className="min-w-0 flex-1">
        <Card className="overflow-hidden">
          <ScheduleHeader
            baseMonth={baseMonth}
            employeeFilter={employeeFilter}
            employees={employees}
            onEmployeeFilterChange={setEmployeeFilter}
            onStoreChange={setStoreId}
            onViewModeChange={setViewMode}
            selectedStoreId={storeId}
            stores={stores}
            viewMode={viewMode}
          />
          <div className="border-b border-surface-variant bg-surface-container-low/50">
            <div className="grid min-w-[760px] grid-cols-7">
              {weekdays.map((day, index) => (
                <div className={`py-3 text-center text-xs font-bold ${index === 0 ? "text-error" : index === 6 ? "text-secondary" : "text-on-surface"}`} key={day}>
                  {day}
                </div>
              ))}
            </div>
          </div>
          <div className="overflow-x-auto">
            <div className="grid min-w-[760px] grid-cols-7">
              {days.map((day) => (
                <CalendarCell
                  day={day}
                  key={day.date}
                  onSelect={setSelectedDate}
                  selected={day.date === selectedDate}
                  shifts={visibleShifts.filter((shift) => shift.date === day.date)}
                />
              ))}
            </div>
          </div>
        </Card>

        <section className="mt-6 grid grid-cols-1 gap-4 xl:grid-cols-3">
          <Card className="p-5 xl:col-span-2">
            <div className="mb-4 flex flex-wrap items-center justify-between gap-3">
              <div>
                <h2 className="font-h3 text-xl font-bold text-on-surface">{formatKoreanDate(selectedDate)} 배치 현황</h2>
                <p className="mt-1 text-sm text-secondary">{selectedStore?.name} 기준 직원별 근무와 충돌 상태를 확인합니다.</p>
              </div>
              <Button variant="secondary">
                <MaterialSymbol className="text-[18px]" name="edit_calendar" />
                선택일 수정
              </Button>
            </div>
            <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
              {visibleShifts.filter((shift) => shift.date === selectedDate).length > 0 ? (
                visibleShifts
                  .filter((shift) => shift.date === selectedDate)
                  .map((shift) => <ShiftCard key={shift.id} shift={shift} variant="detail" />)
              ) : (
                <div className="rounded-xl border border-dashed border-outline-variant bg-surface-container-low p-6 text-center text-sm text-secondary md:col-span-2">
                  등록된 스케줄이 없습니다.
                </div>
              )}
            </div>
          </Card>

          <Card className="p-5">
            <h2 className="mb-4 flex items-center gap-2 font-h3 text-xl font-bold text-on-surface">
              <MaterialSymbol className="text-primary" name="report" />
              운영 알림
            </h2>
            <div className="space-y-3">
              <AlertItem icon="warning" label="중복 근무" value={`${summary.conflictCount}건`} tone="danger" />
              <AlertItem icon="person_alert" label="부족 인원" value={`${summary.shortageCount}건`} tone="warning" />
              <AlertItem icon="groups" label="오늘 배치" value={`${visibleShifts.filter((shift) => shift.date === today).length}명`} tone="primary" />
            </div>
          </Card>
        </section>
      </section>

      <ScheduleSummarySidebar employees={employees} summary={summary} />

      <button className="fixed bottom-20 right-5 z-50 flex h-14 w-14 items-center justify-center rounded-full bg-primary text-on-primary shadow-lg transition active:scale-95 md:hidden" type="button">
        <MaterialSymbol name="add" />
      </button>
    </div>
  );
}

function ScheduleHeader({
  baseMonth,
  employeeFilter,
  employees,
  onEmployeeFilterChange,
  onStoreChange,
  onViewModeChange,
  selectedStoreId,
  stores,
  viewMode,
}: {
  baseMonth: string;
  employeeFilter: string;
  employees: ScheduleEmployee[];
  onEmployeeFilterChange: (value: string) => void;
  onStoreChange: (value: string) => void;
  onViewModeChange: (value: ScheduleViewMode) => void;
  selectedStoreId: string;
  stores: ScheduleStore[];
  viewMode: ScheduleViewMode;
}) {
  return (
    <div className="flex flex-col gap-4 border-b border-surface-variant p-4 md:p-5 xl:flex-row xl:items-center xl:justify-between">
      <div className="flex flex-wrap items-center gap-3">
        <div>
          <p className="text-xs font-bold text-secondary">매장 스케줄</p>
          <h1 className="font-h2 text-2xl font-bold text-on-surface">{formatMonthTitle(baseMonth)}</h1>
        </div>
        <div className="flex overflow-hidden rounded-lg border border-outline-variant bg-white">
          <button className="border-r border-outline-variant p-2 hover:bg-surface-container-low" type="button">
            <MaterialSymbol name="chevron_left" />
          </button>
          <button className="px-4 text-sm font-bold hover:bg-surface-container-low" type="button">
            오늘
          </button>
          <button className="border-l border-outline-variant p-2 hover:bg-surface-container-low" type="button">
            <MaterialSymbol name="chevron_right" />
          </button>
        </div>
      </div>

      <div className="flex flex-col gap-2 sm:flex-row sm:flex-wrap sm:items-center sm:justify-end">
        <select className="rounded-lg border border-outline-variant bg-surface-bright px-3 py-2 text-sm focus:border-primary focus:ring-primary" onChange={(event) => onStoreChange(event.target.value)} value={selectedStoreId}>
          {stores.map((store) => (
            <option key={store.id} value={store.id}>
              {store.name}
            </option>
          ))}
        </select>
        <select className="rounded-lg border border-outline-variant bg-surface-bright px-3 py-2 text-sm focus:border-primary focus:ring-primary" onChange={(event) => onEmployeeFilterChange(event.target.value)} value={employeeFilter}>
          <option value="all">전체 직원</option>
          {employees.map((employee) => (
            <option key={employee.id} value={employee.id}>
              {employee.name} ({employee.role})
            </option>
          ))}
        </select>
        <div className="flex rounded-lg border border-outline-variant bg-surface-container-low p-1">
          <button className={`rounded-md px-4 py-1 text-xs font-bold transition ${viewMode === "month" ? "bg-white text-primary shadow-sm" : "text-secondary hover:bg-white/60"}`} onClick={() => onViewModeChange("month")} type="button">
            월간
          </button>
          <button className={`rounded-md px-4 py-1 text-xs font-bold transition ${viewMode === "week" ? "bg-white text-primary shadow-sm" : "text-secondary hover:bg-white/60"}`} onClick={() => onViewModeChange("week")} type="button">
            주간
          </button>
        </div>
        <Button>
          <MaterialSymbol className="text-[18px]" name="add" />
          스케줄 추가
        </Button>
      </div>
    </div>
  );
}

function CalendarCell({ day, onSelect, selected, shifts }: { day: CalendarDay; onSelect: (date: string) => void; selected: boolean; shifts: StoreShift[] }) {
  const overflowCount = Math.max(0, shifts.length - 3);

  return (
    <button
      className={`min-h-[128px] border-b border-r border-surface-variant p-2 text-left transition hover:bg-surface-container-low md:min-h-[150px] ${
        day.currentMonth ? "bg-white" : "bg-surface-container-lowest opacity-50"
      } ${day.today ? "bg-primary/5" : ""} ${selected ? "ring-2 ring-inset ring-primary" : ""}`}
      onClick={() => onSelect(day.date)}
      type="button"
    >
      <div className="mb-2 flex items-center justify-between">
        <span
          className={`flex h-7 w-7 items-center justify-center rounded-full text-xs font-bold ${
            day.today ? "bg-primary text-on-primary" : day.weekday === 0 ? "text-error" : day.weekday === 6 ? "text-secondary" : "text-on-surface"
          }`}
        >
          {day.day}
        </span>
        {shifts.some((shift) => shift.status === "conflict" || shift.status === "shortage") ? <MaterialSymbol className="text-[18px] text-error" name="error" /> : null}
      </div>
      <div className="space-y-1.5">
        {shifts.slice(0, 3).map((shift) => (
          <ShiftCard key={shift.id} shift={shift} />
        ))}
        {overflowCount > 0 ? <div className="rounded-md bg-surface-container px-2 py-1 text-[11px] font-bold text-secondary">+{overflowCount}명 더 있음</div> : null}
      </div>
    </button>
  );
}

function ShiftCard({ shift, variant = "compact" }: { shift: StoreShift; variant?: "compact" | "detail" }) {
  const tone = shiftTone[shift.type];
  const status = statusTone[shift.status];

  if (variant === "detail") {
    return (
      <div className={`rounded-xl border-l-4 ${tone.card} border-y border-r p-4 transition hover:shadow-sm`}>
        <div className="flex items-start justify-between gap-3">
          <div>
            <p className="font-bold text-on-surface">{shift.employeeName}</p>
            <p className="mt-1 text-sm text-secondary">
              {shift.startTime} - {shift.endTime} · {shift.role}
            </p>
          </div>
          <Badge tone={status.tone}>
            <MaterialSymbol className="text-[16px]" name={status.icon} />
            {status.label}
          </Badge>
        </div>
        <div className="mt-4 flex items-center justify-between gap-3">
          <span className={`inline-flex items-center gap-1 text-xs font-bold ${tone.text}`}>
            <span className={`h-2 w-2 rounded-full ${tone.dot}`} />
            {tone.label} 쉬프트
          </span>
          <Button className="px-3 py-1 text-xs" variant="ghost">
            수정
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className={`rounded-md border-l-4 px-2 py-1.5 text-[11px] font-bold ${tone.card} ${tone.text}`}>
      <div className="truncate">{shift.employeeName} ({tone.label})</div>
      <div className="mt-0.5 flex items-center justify-between gap-1 text-[10px] opacity-80">
        <span>{shift.startTime}-{shift.endTime}</span>
        {shift.status === "conflict" || shift.status === "shortage" ? <MaterialSymbol className="text-[14px]" name={status.icon} /> : null}
      </div>
    </div>
  );
}

function ScheduleSummarySidebar({ employees, summary }: { employees: ScheduleEmployee[]; summary: ScheduleSummary }) {
  return (
    <aside className="flex w-full flex-col gap-6 lg:w-80 lg:shrink-0">
      <Card className="p-5">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="flex items-center gap-2 font-h3 text-lg font-bold text-on-surface">
            <MaterialSymbol className="text-primary" name="analytics" />
            주간 요약
          </h2>
          <MaterialSymbol className="text-secondary" name="more_horiz" />
        </div>
        <div className="space-y-3">
          <SummaryRow label="총 근무 시간" value={`${summary.totalHours}시간`} />
          <SummaryRow label="예상 인건비" primary value={formatCurrency(summary.estimatedLaborCost)} />
        </div>
        <div className="mt-5 border-t border-surface-variant pt-4">
          <p className="mb-2 text-xs font-bold text-secondary">근무 유형별 분포</p>
          <div className="flex h-2 overflow-hidden rounded-full">
            <div className="bg-primary" style={{ width: `${summary.openRate}%` }} />
            <div className="bg-secondary" style={{ width: `${summary.middleRate}%` }} />
            <div className="bg-tertiary" style={{ width: `${summary.closeRate}%` }} />
          </div>
          <div className="mt-2 flex justify-between text-[10px] font-bold text-secondary">
            <span>오픈 {summary.openRate}%</span>
            <span>미들 {summary.middleRate}%</span>
            <span>마감 {summary.closeRate}%</span>
          </div>
        </div>
      </Card>

      <Card className="p-5">
        <h2 className="mb-4 flex items-center gap-2 font-h3 text-lg font-bold text-on-surface">
          <MaterialSymbol className="text-primary" name="person_search" />
          직원별 가동 현황
        </h2>
        <div className="space-y-4">
          {employees.map((employee) => {
            const rate = Math.min(100, Math.round((employee.weeklyHours / employee.maxWeeklyHours) * 100));
            const overLimit = employee.weeklyHours > employee.maxWeeklyHours;
            return (
              <div className="flex items-center gap-3" key={employee.id}>
                <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary-fixed font-bold text-on-primary-fixed">{employee.initials}</div>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-2">
                    <p className="truncate text-sm font-bold text-on-surface">{employee.name}</p>
                    <span className={`text-xs font-bold ${overLimit ? "text-error" : "text-primary"}`}>
                      {employee.weeklyHours}h / {employee.maxWeeklyHours}h
                    </span>
                  </div>
                  <div className="mt-1 h-1.5 overflow-hidden rounded-full bg-surface-container-highest">
                    <div className={`h-full rounded-full ${overLimit ? "bg-error" : "bg-primary"}`} style={{ width: `${rate}%` }} />
                  </div>
                </div>
              </div>
            );
          })}
        </div>
        <Button className="mt-5 w-full" variant="secondary">
          모든 직원 보기
        </Button>
      </Card>

      <Card className="bg-surface-container-low p-5">
        <h2 className="mb-3 text-sm font-bold text-on-surface">쉬프트 범례</h2>
        <div className="space-y-2">
          <LegendItem color="bg-primary" label="오픈 근무 (09:00 - 14:00)" />
          <LegendItem color="bg-secondary" label="미들 근무 (12:00 - 18:00)" />
          <LegendItem color="bg-tertiary" label="마감 근무 (17:00 - 23:00)" />
        </div>
      </Card>
    </aside>
  );
}

function SummaryRow({ label, primary = false, value }: { label: string; primary?: boolean; value: string }) {
  return (
    <div className="flex items-center justify-between rounded-lg bg-surface-container-low p-3">
      <span className="text-sm text-secondary">{label}</span>
      <span className={`font-bold ${primary ? "text-primary" : "text-on-surface"}`}>{value}</span>
    </div>
  );
}

function AlertItem({ icon, label, tone, value }: { icon: string; label: string; tone: "primary" | "danger" | "warning"; value: string }) {
  const color = tone === "danger" ? "text-error bg-error-container" : tone === "warning" ? "text-tertiary bg-tertiary-fixed" : "text-primary bg-primary-fixed";
  return (
    <div className="flex items-center justify-between rounded-xl border border-surface-variant bg-surface-container-low p-3">
      <div className="flex items-center gap-3">
        <div className={`flex h-9 w-9 items-center justify-center rounded-full ${color}`}>
          <MaterialSymbol className="text-[18px]" name={icon} />
        </div>
        <span className="text-sm font-bold text-on-surface">{label}</span>
      </div>
      <span className="text-sm font-bold text-secondary">{value}</span>
    </div>
  );
}

function LegendItem({ color, label }: { color: string; label: string }) {
  return (
    <div className="flex items-center gap-2">
      <span className={`h-3 w-3 rounded-sm ${color}`} />
      <span className="text-xs font-bold text-secondary">{label}</span>
    </div>
  );
}

function buildMonthCells(baseMonth: string, today: string) {
  const monthStart = parseDate(`${baseMonth}-01`);
  const start = new Date(monthStart);
  start.setDate(monthStart.getDate() - monthStart.getDay());
  return Array.from({ length: 42 }, (_, index) => {
    const current = new Date(start);
    current.setDate(start.getDate() + index);
    return toCalendarDay(current, current.getMonth() === monthStart.getMonth(), today);
  });
}

function toCalendarDay(date: Date, currentMonth: boolean, today: string): CalendarDay {
  return {
    date: toDateKey(date),
    day: date.getDate(),
    currentMonth,
    today: toDateKey(date) === today,
    weekday: date.getDay(),
  };
}

function parseDate(date: string) {
  const [year, month, day] = date.split("-").map(Number);
  return new Date(year, month - 1, day);
}

function toDateKey(date: Date) {
  const year = date.getFullYear();
  const month = `${date.getMonth() + 1}`.padStart(2, "0");
  const day = `${date.getDate()}`.padStart(2, "0");
  return `${year}-${month}-${day}`;
}

function formatMonthTitle(baseMonth: string) {
  const [year, month] = baseMonth.split("-");
  return `${year}년 ${Number(month)}월`;
}

function formatKoreanDate(date: string) {
  const parsed = parseDate(date);
  return `${parsed.getMonth() + 1}월 ${parsed.getDate()}일 (${weekdays[parsed.getDay()]})`;
}

function formatCurrency(value: number) {
  return new Intl.NumberFormat("ko-KR", { currency: "KRW", style: "currency", maximumFractionDigits: 0 }).format(value);
}
