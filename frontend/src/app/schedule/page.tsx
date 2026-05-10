import { AppShell } from "@/components/layout/app-shell";
import { StoreSchedulePage } from "@/components/schedule/store-schedule-page";
import { getStoreScheduleDashboard } from "@/lib/api";

export default async function SchedulePage() {
  const dashboard = await getStoreScheduleDashboard();

  return (
    <AppShell showSearch title="스케줄 관리">
      <StoreSchedulePage {...dashboard} />
    </AppShell>
  );
}
