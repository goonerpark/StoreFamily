import { AppShell } from "@/components/layout/app-shell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { MaterialSymbol } from "@/components/ui/material-symbol";
import { getEmployees } from "@/lib/api";
import type { Employee } from "@/lib/types";

export default async function EmployeesPage() {
  const { employees, storeCode, storeName } = await getEmployees();
  const alertCount = employees.filter((employee) => employee.healthStatus !== "valid").length;

  return (
    <AppShell title="직원 관리">
      <div className="mx-auto max-w-7xl px-6 py-8 pb-24 md:pb-8">
        <section className="mb-8 grid grid-cols-1 gap-6 md:grid-cols-4">
          <Card className="p-6 md:col-span-3">
            <div className="mb-6 flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
              <div>
                <h1 className="font-h1 text-4xl font-bold text-on-surface">직원 관리</h1>
                <p className="mt-1 text-secondary">{storeName} 소속 직원을 검색하고 근무 정보를 관리하세요.</p>
              </div>
              <div className="inline-flex w-fit items-center gap-1 rounded-lg bg-secondary-container px-2 py-1 text-on-secondary-container">
                <span className="text-xs font-bold">매장 코드</span>
                <span className="font-mono font-bold tracking-widest">{storeCode}</span>
                <MaterialSymbol className="text-[18px]" name="content_copy" />
              </div>
            </div>

            <div className="flex flex-col gap-4 md:flex-row md:items-end">
              <div className="w-full flex-1">
                <label className="mb-1 block text-xs font-bold text-on-surface-variant">직원명</label>
                <div className="relative">
                  <MaterialSymbol className="absolute left-2 top-1/2 -translate-y-1/2 text-outline" name="search" />
                  <input
                    className="w-full rounded-lg border border-outline-variant py-2 pl-8 pr-4 focus:border-primary focus:ring-1 focus:ring-primary"
                    placeholder="이름으로 검색..."
                    type="search"
                  />
                </div>
              </div>
              <SelectFilter label="직책 / 교대" options={["전체 직원", "매니저", "직원"]} />
              <SelectFilter label="보건증 상태" options={["전체 상태", "정상", "만료 예정", "등록 필요"]} />
              <Button>
                <MaterialSymbol className="text-[20px]" name="person_add" />
                신규 등록
              </Button>
            </div>
          </Card>

          <Card className="flex flex-col justify-between border-primary bg-primary-container p-6 text-on-primary-container">
            <div>
              <p className="text-xs font-bold uppercase tracking-tight opacity-80">활성 직원</p>
              <h2 className="font-h1 text-4xl font-bold">{employees.length}</h2>
            </div>
            <div className="flex items-center gap-1 text-xs font-bold">
              <MaterialSymbol className="text-[16px]" name="warning" />
              {alertCount}건 만료/등록 알림
            </div>
          </Card>
        </section>

        <Card className="overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full min-w-[900px] border-collapse">
              <thead className="bg-surface-container-low">
                <tr>
                  {["직원명", "직책", "입사일", "시급", "보건증", "관리"].map((header) => (
                    <th className={`px-6 py-4 text-left text-xs font-bold uppercase tracking-wide text-on-surface-variant ${header === "관리" ? "text-right" : ""}`} key={header}>
                      {header}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {employees.map((employee) => (
                  <EmployeeRow employee={employee} key={employee.id} />
                ))}
              </tbody>
            </table>
          </div>
          <div className="flex items-center justify-between border-t border-surface-variant px-6 py-4">
            <p className="text-xs font-bold text-secondary">{employees.length}명의 직원 표시 중</p>
            <div className="flex gap-1">
              <button className="rounded border border-outline-variant p-1 hover:bg-surface-container" type="button">
                <MaterialSymbol className="text-[18px]" name="chevron_left" />
              </button>
              <button className="rounded bg-primary px-2 py-1 text-xs font-bold text-white" type="button">
                1
              </button>
              <button className="rounded border border-outline-variant p-1 hover:bg-surface-container" type="button">
                <MaterialSymbol className="text-[18px]" name="chevron_right" />
              </button>
            </div>
          </div>
        </Card>
      </div>
    </AppShell>
  );
}

function SelectFilter({ label, options }: { label: string; options: string[] }) {
  return (
    <div className="w-full md:w-48">
      <label className="mb-1 block text-xs font-bold text-on-surface-variant">{label}</label>
      <select className="w-full rounded-lg border border-outline-variant px-4 py-2 focus:border-primary focus:ring-1 focus:ring-primary">
        {options.map((option) => (
          <option key={option}>{option}</option>
        ))}
      </select>
    </div>
  );
}

function EmployeeRow({ employee }: { employee: Employee }) {
  const badge =
    employee.healthStatus === "valid" ? (
      <span className="inline-flex items-center gap-1 font-bold text-on-primary-fixed-variant">
        <span className="h-2 w-2 rounded-full bg-primary" />
        {employee.healthLabel}
      </span>
    ) : employee.healthStatus === "expiring" ? (
      <Badge tone="danger">
        <MaterialSymbol className="text-[14px]" name="error" />
        {employee.healthLabel}
      </Badge>
    ) : (
      <Badge tone="warning">{employee.healthLabel}</Badge>
    );

  return (
    <tr className="transition hover:bg-surface-container-low">
      <td className="border-b border-surface-variant px-6 py-4">
        <div className="flex items-center gap-4">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-surface-variant bg-primary-fixed font-bold text-on-primary-fixed">
            {employee.name.slice(0, 1)}
          </div>
          <div>
            <p className="font-bold text-on-surface">{employee.name}</p>
            <p className="text-xs text-secondary">{employee.email}</p>
          </div>
        </div>
      </td>
      <td className="border-b border-surface-variant px-6 py-4">
        <span className="rounded bg-secondary-container px-2 py-1 text-xs font-bold text-on-secondary-container">{employee.position}</span>
      </td>
      <td className="border-b border-surface-variant px-6 py-4">{employee.joinedAt}</td>
      <td className="border-b border-surface-variant px-6 py-4 font-bold">{employee.hourlyWage}</td>
      <td className="border-b border-surface-variant px-6 py-4">{badge}</td>
      <td className="border-b border-surface-variant px-6 py-4 text-right">
        <Button href={`/employees/${employee.id}`} variant="secondary">
          관리
        </Button>
      </td>
    </tr>
  );
}
