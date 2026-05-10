import { PlaceholderPage } from "@/components/placeholder-page";

export default async function EmployeeDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;

  return (
    <PlaceholderPage
      description={`직원 #${id} 상세 정보, 보건증, 입사일, 시급 수정 기능을 기존 직원 관리 API와 연결할 예정입니다.`}
      icon="badge"
      title="직원 상세"
    />
  );
}
