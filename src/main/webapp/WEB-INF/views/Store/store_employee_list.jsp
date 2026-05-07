<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StoreFamily - 직원 관리</title>
</head>
<body>
<c:set var="healthMissingCount" value="0"/>
<c:forEach var="empCountItem" items="${employees}">
	<c:if test="${empty empCountItem.health}">
		<c:set var="healthMissingCount" value="${healthMissingCount + 1}"/>
	</c:if>
</c:forEach>

<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-7xl px-lg pb-xl pt-xl">
		<section class="mb-xl grid grid-cols-1 gap-lg md:grid-cols-4">
			<div class="rounded-xl border border-surface-variant bg-white p-lg md:col-span-3">
				<div class="mb-lg flex flex-col gap-sm md:flex-row md:items-end md:justify-between">
					<div>
						<h1 class="font-h1 text-h1 font-bold text-on-surface">직원 관리</h1>
						<p class="mb-0 mt-xs text-secondary">
							<strong><c:out value="${myStore.store_name}"/></strong>
							<span class="text-on-surface-variant">(<c:out value="${myStore.store_code}"/>)</span>
							소속 직원을 검색하고 근무 정보를 관리하세요.
						</p>
					</div>
					<div class="inline-flex w-fit items-center gap-xs rounded-lg bg-secondary-container px-sm py-xs text-on-secondary-container">
						<span class="text-label-sm font-bold">매장 코드</span>
						<span class="font-mono font-bold tracking-widest"><c:out value="${myStore.store_code}"/></span>
						<button type="button" class="material-symbols-outlined text-[18px] hover:text-primary" onclick="navigator.clipboard && navigator.clipboard.writeText('${myStore.store_code}')">content_copy</button>
					</div>
				</div>

				<div class="flex flex-col gap-md md:flex-row md:items-end">
					<div class="w-full flex-1">
						<label class="mb-xs block text-label-sm text-on-surface-variant">직원명</label>
						<div class="relative">
							<span class="material-symbols-outlined absolute left-sm top-1/2 -translate-y-1/2 text-outline">search</span>
							<input class="w-full rounded-lg border border-outline-variant py-sm pl-xl pr-md focus:border-primary focus:ring-1 focus:ring-primary" placeholder="이름으로 검색..." type="text"/>
						</div>
					</div>
					<div class="w-full md:w-48">
						<label class="mb-xs block text-label-sm text-on-surface-variant">직책</label>
						<select class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-1 focus:ring-primary">
							<option>전체 직원</option>
							<option>직원</option>
							<option>관리자</option>
						</select>
					</div>
					<div class="w-full md:w-48">
						<label class="mb-xs block text-label-sm text-on-surface-variant">보건증 상태</label>
						<select class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-1 focus:ring-primary">
							<option>전체 상태</option>
							<option>등록됨</option>
							<option>등록 필요</option>
						</select>
					</div>
					<!-- TODO: 직원 직접 등록 기능이 생기면 신규 등록 버튼을 실제 라우팅에 연결 -->
					<button type="button" class="inline-flex items-center justify-center gap-xs rounded-lg bg-primary px-lg py-sm font-bold text-white hover:bg-primary-container">
						<span class="material-symbols-outlined text-[20px]">person_add</span>
						신규 등록
					</button>
				</div>
			</div>

			<div class="flex flex-col justify-between rounded-xl border border-primary bg-primary-container p-lg text-on-primary-container">
				<div>
					<p class="mb-xs text-label-sm font-bold uppercase tracking-tight opacity-80">활성 직원</p>
					<h2 class="font-h1 text-h1 font-bold">${fn:length(employees)}</h2>
				</div>
				<div class="flex items-center gap-xs text-label-sm">
					<span class="material-symbols-outlined text-[16px]">warning</span>
					<span class="font-bold">보건증 등록 필요 ${healthMissingCount}건</span>
				</div>
			</div>
		</section>

		<c:if test="${not empty message}">
			<div class="mb-md rounded-xl border border-primary/20 bg-primary-fixed/40 px-md py-sm text-on-primary-fixed-variant">
				<c:out value="${message}"/>
			</div>
		</c:if>

		<section class="overflow-hidden rounded-xl border border-surface-variant bg-white">
			<c:choose>
				<c:when test="${empty employees}">
					<div class="p-xl text-center text-secondary">
						<span class="material-symbols-outlined mb-sm text-[40px] text-primary">group</span>
						<p class="mb-xs font-h3 text-h3 text-on-surface">승인된 직원이 없습니다</p>
						<p class="mb-0">직원이 매장 코드로 가입 요청을 보내면 가입 승인 화면에서 승인할 수 있습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="overflow-x-auto">
						<table class="w-full min-w-[900px] border-collapse">
							<thead class="bg-surface-container-low">
								<tr>
									<th class="px-lg py-md text-left text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">직원명</th>
									<th class="px-lg py-md text-left text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">직책</th>
									<th class="px-lg py-md text-left text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">입사일</th>
									<th class="px-lg py-md text-left text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">시급</th>
									<th class="px-lg py-md text-left text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">보건증</th>
									<th class="px-lg py-md text-right text-label-sm font-bold uppercase tracking-wide text-on-surface-variant">관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="emp" items="${employees}">
									<tr class="transition hover:bg-surface-container-low">
										<td class="border-b border-surface-variant px-lg py-md">
											<div class="flex items-center gap-md">
												<div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-surface-variant bg-primary-fixed font-bold text-on-primary-fixed">
													<c:out value="${fn:substring(emp.name,0,1)}"/>
												</div>
												<div>
													<a class="font-bold text-on-surface hover:text-primary" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees/${emp.member_bno}">
														<c:out value="${emp.name}"/>
													</a>
													<p class="mb-0 text-label-sm text-secondary"><c:out value="${emp.email}"/></p>
												</div>
											</div>
										</td>
										<td class="border-b border-surface-variant px-lg py-md">
											<span class="rounded bg-secondary-container px-sm py-xs text-label-sm font-bold text-on-secondary-container">
												<c:choose>
													<c:when test="${empty emp.position}">직원</c:when>
													<c:otherwise><c:out value="${emp.position}"/></c:otherwise>
												</c:choose>
											</span>
										</td>
										<td class="border-b border-surface-variant px-lg py-md text-body-md text-on-surface">
											<c:choose>
												<c:when test="${empty emp.employment}">-</c:when>
												<c:otherwise><c:out value="${emp.employment}"/></c:otherwise>
											</c:choose>
										</td>
										<td class="border-b border-surface-variant px-lg py-md font-bold">
											<c:choose>
												<c:when test="${empty emp.rate}">-</c:when>
												<c:otherwise><c:out value="${emp.rate}"/></c:otherwise>
											</c:choose>
										</td>
										<td class="border-b border-surface-variant px-lg py-md">
											<c:choose>
												<c:when test="${empty emp.health}">
													<span class="inline-flex items-center gap-xs rounded-lg bg-error-container px-sm py-xs text-label-sm font-bold text-on-error-container">
														<span class="material-symbols-outlined text-[14px]">error</span>
														등록 필요
													</span>
												</c:when>
												<c:otherwise>
													<span class="inline-flex items-center gap-xs font-bold text-on-primary-fixed-variant">
														<span class="h-2 w-2 rounded-full bg-primary"></span>
														등록됨 (<c:out value="${emp.health}"/>)
													</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td class="border-b border-surface-variant px-lg py-md text-right">
											<a class="inline-flex items-center justify-center rounded-lg border border-outline-variant px-md py-sm font-bold text-on-surface hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees/${emp.member_bno}">
												관리
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="flex items-center justify-between border-t border-surface-variant px-lg py-md">
						<p class="mb-0 text-label-sm text-secondary">${fn:length(employees)}명의 직원 표시 중</p>
						<div class="flex gap-xs">
							<button class="rounded border border-outline-variant p-xs hover:bg-surface-container"><span class="material-symbols-outlined text-[18px]">chevron_left</span></button>
							<button class="rounded bg-primary px-sm py-xs text-label-sm font-bold text-white">1</button>
							<button class="rounded border border-outline-variant p-xs hover:bg-surface-container"><span class="material-symbols-outlined text-[18px]">chevron_right</span></button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</section>
	</div>
</main>
</body>
</html>
