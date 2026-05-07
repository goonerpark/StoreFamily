import { currentUser, employees, fillPosts, myApplications, recommendedFills, weeklySchedule } from "./mock-data";

// TODO: Spring MVC를 REST API로 분리하면 이 파일의 mock 반환을 fetch 호출로 교체합니다.
// 예: fetch(`${process.env.NEXT_PUBLIC_API_BASE_URL}/api/stores/${storeId}/fills`)

export async function getCurrentUser() {
  return currentUser;
}

export async function getFillDashboard() {
  return {
    fills: fillPosts,
    myApplications,
    storeName: currentUser.storeName,
  };
}

export async function getEmployees() {
  return {
    employees,
    storeCode: currentUser.storeCode,
    storeName: currentUser.storeName,
  };
}

export async function getEmployeeDashboard() {
  return {
    currentUser,
    weeklySchedule,
    recommendedFills,
  };
}
