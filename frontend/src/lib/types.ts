export type FillStatus = "recruiting" | "pending" | "done" | "canceled";

export type FillPost = {
  id: number;
  title: string;
  requesterName: string;
  workerLabel: string;
  applicants: number;
  date: string;
  monthLabel: string;
  dayLabel: string;
  timeRange: string;
  partName: string;
  status: FillStatus;
  bonus?: string;
};

export type ScheduleViewMode = "month" | "week";

export type ShiftType = "open" | "middle" | "close";

export type ShiftStatus = "scheduled" | "confirmed" | "conflict" | "shortage";

export type ScheduleStore = {
  id: string;
  name: string;
};

export type ScheduleEmployee = {
  id: number;
  name: string;
  role: string;
  initials: string;
  weeklyHours: number;
  maxWeeklyHours: number;
};

export type StoreShift = {
  id: number;
  employeeId: number;
  employeeName: string;
  role: string;
  date: string;
  startTime: string;
  endTime: string;
  type: ShiftType;
  status: ShiftStatus;
};

export type ScheduleSummary = {
  totalHours: number;
  estimatedLaborCost: number;
  openRate: number;
  middleRate: number;
  closeRate: number;
  shortageCount: number;
  conflictCount: number;
};

export type StoreScheduleDashboard = {
  stores: ScheduleStore[];
  selectedStoreId: string;
  employees: ScheduleEmployee[];
  shifts: StoreShift[];
  summary: ScheduleSummary;
  baseMonth: string;
  today: string;
};

export type FillApplication = {
  id: number;
  title: string;
  appliedAt: string;
  payLabel: string;
  status: "reviewing" | "canceled" | "approved";
};

export type Employee = {
  id: number;
  name: string;
  email: string;
  position: string;
  joinedAt: string;
  hourlyWage: string;
  healthStatus: "valid" | "expiring" | "missing";
  healthLabel: string;
};

export type WeeklyScheduleDay = {
  dayName: string;
  dayNumber: number;
  isToday?: boolean;
  hasShift?: boolean;
  tone?: "primary" | "tertiary";
};

export type RecommendedFill = {
  id: number;
  requesterName: string;
  dateLabel: string;
  timeRange: string;
  badge?: "긴급" | "신규";
};
