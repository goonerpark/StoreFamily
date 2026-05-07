import type { Employee, FillApplication, FillPost, RecommendedFill, WeeklyScheduleDay } from "./types";

export const currentUser = {
  name: "이진혁",
  role: "점주",
  storeName: "강남역 1호점",
  storeCode: "SF-8829",
};

export const fillPosts: FillPost[] = [
  {
    id: 1,
    title: "목요일 오픈 대타 구합니다",
    requesterName: "김철수",
    workerLabel: "김철수 → 지원자 2명",
    applicants: 2,
    date: "2026-05-14",
    monthLabel: "5월",
    dayLabel: "14",
    timeRange: "08:00 - 15:00",
    partName: "오픈",
    status: "pending",
  },
  {
    id: 2,
    title: "금요일 미들 근무 가능하신 분",
    requesterName: "이영희",
    workerLabel: "이영희",
    applicants: 0,
    date: "2026-05-15",
    monthLabel: "5월",
    dayLabel: "15",
    timeRange: "15:00 - 22:00",
    partName: "미들",
    status: "recruiting",
    bonus: "+ 추가수당 1만원",
  },
  {
    id: 3,
    title: "화요일 오픈 교체 완료",
    requesterName: "박민수",
    workerLabel: "박민수 → 정지훈",
    applicants: 1,
    date: "2026-05-12",
    monthLabel: "5월",
    dayLabel: "12",
    timeRange: "08:00 - 15:00",
    partName: "마감",
    status: "done",
  },
];

export const myApplications: FillApplication[] = [
  {
    id: 1,
    title: "5월 17일 야간",
    appliedAt: "05.07",
    payLabel: "82,000원",
    status: "reviewing",
  },
  {
    id: 2,
    title: "5월 20일 미들",
    appliedAt: "05.06",
    payLabel: "54,000원",
    status: "canceled",
  },
];

export const employees: Employee[] = [
  {
    id: 1,
    name: "김민수",
    email: "minsu.k@storefamily.com",
    position: "매니저",
    joinedAt: "2025.05.12",
    hourlyWage: "12,500원",
    healthStatus: "valid",
    healthLabel: "정상 (2026.12)",
  },
  {
    id: 2,
    name: "이지은",
    email: "jieun.l@storefamily.com",
    position: "직원",
    joinedAt: "2025.11.02",
    hourlyWage: "10,030원",
    healthStatus: "expiring",
    healthLabel: "D-7",
  },
  {
    id: 3,
    name: "박준호",
    email: "junho.p@storefamily.com",
    position: "직원",
    joinedAt: "2026.01.15",
    hourlyWage: "10,030원",
    healthStatus: "valid",
    healthLabel: "정상 (2027.01)",
  },
  {
    id: 4,
    name: "최서연",
    email: "seoyeon.c@storefamily.com",
    position: "매니저",
    joinedAt: "2024.09.20",
    hourlyWage: "13,000원",
    healthStatus: "missing",
    healthLabel: "등록 필요",
  },
];

export const weeklySchedule: WeeklyScheduleDay[] = [
  { dayName: "월", dayNumber: 4, hasShift: true },
  { dayName: "화", dayNumber: 5, isToday: true },
  { dayName: "수", dayNumber: 6, hasShift: true },
  { dayName: "목", dayNumber: 7 },
  { dayName: "금", dayNumber: 8, hasShift: true, tone: "tertiary" },
  { dayName: "토", dayNumber: 9, hasShift: true },
  { dayName: "일", dayNumber: 10 },
];

export const recommendedFills: RecommendedFill[] = [
  { id: 1, requesterName: "박민수", dateLabel: "금요일, 5월 8일", timeRange: "10:00 - 14:00", badge: "긴급" },
  { id: 2, requesterName: "이지원", dateLabel: "토요일, 5월 9일", timeRange: "16:00 - 22:00", badge: "신규" },
  { id: 3, requesterName: "김현우", dateLabel: "일요일, 5월 10일", timeRange: "09:00 - 15:00" },
];
