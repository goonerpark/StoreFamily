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
