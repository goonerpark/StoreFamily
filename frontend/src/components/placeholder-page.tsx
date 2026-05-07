import { AppShell } from "@/components/layout/app-shell";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";

type PlaceholderPageProps = {
  title: string;
  description: string;
  icon: string;
};

export function PlaceholderPage({ title, description, icon }: PlaceholderPageProps) {
  return (
    <AppShell title={title}>
      <div className="mx-auto flex min-h-[calc(100vh-64px)] max-w-4xl items-center justify-center p-6 pb-24 md:pb-6">
        <Card className="w-full p-8 text-center">
          <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-xl bg-primary-container text-on-primary-container">
            <MaterialSymbol className="text-[40px]" name={icon} />
          </div>
          <h1 className="font-h1 text-4xl font-bold text-on-surface">{title}</h1>
          <p className="mx-auto mt-3 max-w-xl text-secondary">{description}</p>
          <div className="mt-8 flex justify-center">
            <Button href="/employee-dashboard" variant="secondary">
              홈으로 돌아가기
            </Button>
          </div>
        </Card>
      </div>
    </AppShell>
  );
}
