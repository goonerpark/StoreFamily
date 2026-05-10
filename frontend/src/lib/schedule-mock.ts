import type { StoreScheduleDashboard } from "./types";

export const storeScheduleDashboard: StoreScheduleDashboard = {
  baseMonth: "2026-05",
  today: "2026-05-09",
  selectedStoreId: "gangnam-1",
  stores: [
    { id: "gangnam-1", name: "강남점 1호" },
    { id: "seongsu-2", name: "성수점" },
  ],
  employees: [
    { id: 1, name: "김철수", role: "오픈 담당", initials: "김", weeklyHours: 38, maxWeeklyHours: 40 },
    { id: 2, name: "이영희", role: "플로어", initials: "이", weeklyHours: 24, maxWeeklyHours: 40 },
    { id: 3, name: "송지아", role: "마감 담당", initials: "송", weeklyHours: 42, maxWeeklyHours: 40 },
    { id: 4, name: "최민수", role: "파트 리더", initials: "최", weeklyHours: 18, maxWeeklyHours: 32 },
  ],
  shifts: [
    { id: 101, employeeId: 1, employeeName: "김철수", role: "오픈", date: "2026-05-01", startTime: "09:00", endTime: "14:00", type: "open", status: "confirmed" },
    { id: 102, employeeId: 2, employeeName: "이영희", role: "미들", date: "2026-05-01", startTime: "12:00", endTime: "18:00", type: "middle", status: "scheduled" },
    { id: 103, employeeId: 3, employeeName: "송지아", role: "마감", date: "2026-05-02", startTime: "17:00", endTime: "23:00", type: "close", status: "confirmed" },
    { id: 104, employeeId: 1, employeeName: "김철수", role: "오픈", date: "2026-05-04", startTime: "09:00", endTime: "14:00", type: "open", status: "confirmed" },
    { id: 105, employeeId: 4, employeeName: "최민수", role: "마감", date: "2026-05-04", startTime: "17:00", endTime: "23:00", type: "close", status: "shortage" },
    { id: 106, employeeId: 1, employeeName: "김철수", role: "오픈", date: "2026-05-09", startTime: "09:00", endTime: "14:00", type: "open", status: "confirmed" },
    { id: 107, employeeId: 4, employeeName: "최민수", role: "미들", date: "2026-05-09", startTime: "12:00", endTime: "18:00", type: "middle", status: "scheduled" },
    { id: 108, employeeId: 3, employeeName: "송지아", role: "마감", date: "2026-05-09", startTime: "17:00", endTime: "23:00", type: "close", status: "conflict" },
    { id: 109, employeeId: 1, employeeName: "김철수", role: "오픈", date: "2026-05-10", startTime: "09:00", endTime: "14:00", type: "open", status: "scheduled" },
    { id: 110, employeeId: 2, employeeName: "이영희", role: "미들", date: "2026-05-12", startTime: "12:00", endTime: "18:00", type: "middle", status: "confirmed" },
    { id: 111, employeeId: 3, employeeName: "송지아", role: "마감", date: "2026-05-15", startTime: "17:00", endTime: "23:00", type: "close", status: "scheduled" },
    { id: 112, employeeId: 4, employeeName: "최민수", role: "미들", date: "2026-05-17", startTime: "13:00", endTime: "19:00", type: "middle", status: "scheduled" },
    { id: 113, employeeId: 1, employeeName: "김철수", role: "오픈", date: "2026-05-21", startTime: "09:00", endTime: "14:00", type: "open", status: "confirmed" },
    { id: 114, employeeId: 2, employeeName: "이영희", role: "미들", date: "2026-05-23", startTime: "12:00", endTime: "18:00", type: "middle", status: "scheduled" },
    { id: 115, employeeId: 3, employeeName: "송지아", role: "마감", date: "2026-05-24", startTime: "17:00", endTime: "23:00", type: "close", status: "confirmed" },
  ],
  summary: {
    totalHours: 148,
    estimatedLaborCost: 1850000,
    openRate: 35,
    middleRate: 45,
    closeRate: 20,
    shortageCount: 1,
    conflictCount: 1,
  },
};
