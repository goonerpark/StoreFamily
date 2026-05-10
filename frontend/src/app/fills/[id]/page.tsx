import { PlaceholderPage } from "@/components/placeholder-page";

export default async function FillDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;

  return (
    <PlaceholderPage
      description={`대타 모집글 #${id} 상세, 지원자 목록, 승인/거절 흐름을 기존 Spring fill API와 연결할 예정입니다.`}
      icon="assignment"
      title="대타 상세"
    />
  );
}
