<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StoreFamily - 대타 관리</title>
</head>
<body>
<c:set var="openCount" value="0"/>
<c:set var="pendingCount" value="0"/>
<c:set var="doneCount" value="0"/>
<c:forEach var="fillCountItem" items="${fills}">
	<c:if test="${fillCountItem.chk == 0}"><c:set var="openCount" value="${openCount + 1}"/></c:if>
	<c:if test="${fillCountItem.chk == 1}"><c:set var="pendingCount" value="${pendingCount + 1}"/></c:if>
	<c:if test="${fillCountItem.chk == 1 || fillCountItem.chk == 2}"><c:set var="doneCount" value="${doneCount + 1}"/></c:if>
</c:forEach>

<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-7xl space-y-xl p-lg md:p-xl">
		<section class="flex flex-col gap-md lg:flex-row lg:items-end lg:justify-between">
			<div>
				<h1 class="font-h1 text-h1 font-bold text-on-surface">대타 모집 및 지원 관리</h1>
				<p class="mt-sm text-secondary">
					<strong><c:out value="${myStore.store_name}"/></strong>
					<span class="text-on-surface-variant">(<c:out value="${myStore.store_code}"/>)</span>
					매장의 교대 요청과 지원 현황을 한눈에 관리하세요.
				</p>
			</div>
			<div class="flex flex-wrap items-center gap-sm">
				<a class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-surface-container-low px-md py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}">
					<span class="material-symbols-outlined text-[20px]">store</span>
					매장 홈
				</a>
				<c:if test="${canManage}">
					<a class="inline-flex items-center gap-xs rounded-lg bg-primary px-lg py-sm font-bold text-on-primary shadow-sm transition hover:opacity-90" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/new">
						<span class="material-symbols-outlined text-[20px]">edit_square</span>
						모집글 올리기
					</a>
				</c:if>
			</div>
		</section>

		<c:if test="${not empty message}">
			<div class="rounded-xl border border-primary/20 bg-primary-fixed/40 px-md py-sm text-on-primary-fixed-variant">
				<c:out value="${message}"/>
			</div>
		</c:if>

		<section class="flex flex-wrap items-center gap-md rounded-xl border border-surface-variant bg-white p-md">
			<div class="flex gap-sm overflow-x-auto pb-sm md:pb-0">
				<button class="whitespace-nowrap rounded-full bg-primary-container px-md py-xs font-bold text-on-primary-container">전체</button>
				<button class="whitespace-nowrap rounded-full bg-surface-container-low px-md py-xs text-secondary hover:bg-surface-container-high">모집중 (${openCount})</button>
				<button class="whitespace-nowrap rounded-full bg-surface-container-low px-md py-xs text-secondary hover:bg-surface-container-high">승인대기 (${pendingCount})</button>
				<button class="whitespace-nowrap rounded-full bg-surface-container-low px-md py-xs text-secondary hover:bg-surface-container-high">완료 (${doneCount})</button>
			</div>
			<div class="hidden h-6 w-px bg-surface-variant md:block"></div>
			<select class="rounded-lg border-0 bg-surface-container-low py-xs pr-lg text-body-md focus:ring-primary">
				<option><c:out value="${myStore.store_name}"/></option>
			</select>
		</section>

		<section class="grid grid-cols-1 gap-lg lg:grid-cols-3">
			<div class="space-y-md lg:col-span-2">
				<div class="flex items-center justify-between">
					<h2 class="flex items-center gap-xs font-h3 text-h3">
						<span class="material-symbols-outlined text-primary">list_alt</span>
						진행 중인 대타 요청
					</h2>
					<span class="text-label-sm text-secondary">총 ${fn:length(fills)}건</span>
				</div>

				<c:choose>
					<c:when test="${empty fills}">
						<div class="rounded-xl border border-dashed border-outline-variant bg-white p-xl text-center text-secondary">
							<span class="material-symbols-outlined mb-sm text-[40px] text-primary">swap_horiz</span>
							<p class="mb-xs font-h3 text-h3 text-on-surface">등록된 대타 요청이 없습니다</p>
							<p class="mb-0">직원은 내 스케줄에서 대타 요청을 만들 수 있고, 사장은 직접 모집글을 올릴 수 있습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="fill" items="${fills}">
							<c:set var="statusLabel" value="모집중"/>
							<c:set var="statusClass" value="bg-[#d1fae5] text-[#059669]"/>
							<c:set var="barClass" value="bg-[#10b981]"/>
							<c:if test="${fill.chk == 1}">
								<c:set var="statusLabel" value="승인완료"/>
								<c:set var="statusClass" value="bg-[#e0f2fe] text-[#0369a1]"/>
								<c:set var="barClass" value="bg-primary"/>
							</c:if>
							<c:if test="${fill.chk == 2}">
								<c:set var="statusLabel" value="완료"/>
								<c:set var="statusClass" value="bg-surface-container text-secondary"/>
								<c:set var="barClass" value="bg-secondary"/>
							</c:if>
							<c:if test="${fill.chk == 3}">
								<c:set var="statusLabel" value="취소"/>
								<c:set var="statusClass" value="bg-error-container text-on-error-container"/>
								<c:set var="barClass" value="bg-error"/>
							</c:if>
							<c:set var="dimClass" value=""/>
							<c:if test="${fill.chk == 2 || fill.chk == 3}">
								<c:set var="dimClass" value="opacity-75"/>
							</c:if>
							<article class="relative overflow-hidden rounded-xl border border-surface-variant bg-white p-lg transition hover:shadow-md ${dimClass}">
								<div class="absolute left-0 top-0 h-full w-1 ${barClass}"></div>
								<div class="flex flex-col gap-md md:flex-row md:items-center md:justify-between">
									<div class="flex items-start gap-md">
										<div class="flex h-12 w-12 shrink-0 flex-col items-center justify-center rounded-lg border border-surface-variant bg-surface-container-low">
											<span class="text-label-sm font-bold text-secondary">${fn:substring(fill.fill_day,5,7)}월</span>
											<span class="font-h3 text-h3 font-bold text-primary">${fn:substring(fill.fill_day,8,10)}</span>
										</div>
										<div>
											<div class="mb-xs flex flex-wrap items-center gap-sm">
												<span class="rounded-full bg-[#e7f5f1] px-sm py-0.5 text-[10px] font-bold text-primary">
													<c:choose>
														<c:when test="${empty fill.fill_di_time}">파트 미지정</c:when>
														<c:otherwise><c:out value="${fill.fill_di_time}"/></c:otherwise>
													</c:choose>
												</span>
												<a class="font-bold text-on-surface hover:text-primary" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">
													<c:out value="${fill.title}"/>
												</a>
											</div>
											<div class="flex flex-wrap items-center gap-sm text-body-md text-secondary">
												<span class="inline-flex items-center gap-xs"><span class="material-symbols-outlined text-[18px]">schedule</span><c:out value="${fill.fill_day}"/> ${fn:substring(fill.fill_start_time,0,5)} - ${fn:substring(fill.fill_end_time,0,5)}</span>
												<span class="inline-flex items-center gap-xs"><span class="material-symbols-outlined text-[18px]">person</span><c:out value="${fill.name}"/></span>
												<span class="font-bold text-primary">지원자 <c:out value="${fill.apply_su}"/>명</span>
											</div>
										</div>
									</div>
									<div class="flex flex-col gap-sm md:items-end">
										<span class="inline-flex items-center gap-xs rounded-lg px-md py-sm text-label-sm font-bold ${statusClass}">
											<span class="material-symbols-outlined text-[16px]">hourglass_empty</span>
											${statusLabel}
										</span>
										<div class="flex w-full gap-xs md:w-auto">
											<a class="flex-1 rounded-lg border border-outline-variant px-md py-sm text-center font-bold text-on-surface hover:bg-surface-container md:flex-none" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">지원자 보기</a>
											<a class="flex-1 rounded-lg bg-primary px-md py-sm text-center font-bold text-on-primary hover:opacity-90 md:flex-none" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">상세보기</a>
										</div>
									</div>
								</div>
							</article>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>

			<aside class="space-y-lg">
				<div class="rounded-xl border border-surface-variant bg-white p-lg shadow-sm">
					<div class="mb-lg flex items-center justify-between">
						<h2 class="flex items-center gap-xs font-h3 text-h3">
							<span class="material-symbols-outlined text-primary">history</span>
							나의 지원 현황
						</h2>
						<a class="text-label-sm font-bold text-primary" href="${pageContext.request.contextPath}/fill_all_list">전체보기</a>
					</div>
					<!-- TODO: fill_apply의 내 지원 목록 API/모델이 생기면 아래 mock을 실제 applies 데이터로 교체 -->
					<div class="space-y-md">
						<div class="rounded-lg border border-surface-variant bg-surface-container-low p-md">
							<div class="mb-sm flex items-start justify-between gap-sm">
								<p class="mb-0 font-bold">최근 지원 내역</p>
								<span class="rounded bg-primary-container px-sm py-0.5 text-[10px] text-on-primary-container">준비중</span>
							</div>
							<div class="flex items-center justify-between text-label-sm">
								<span class="text-secondary">실제 지원 현황 연동 예정</span>
								<span class="font-bold text-primary">TODO</span>
							</div>
						</div>
					</div>
				</div>

				<div class="relative overflow-hidden rounded-xl bg-primary p-lg text-on-primary">
					<div class="relative z-10">
						<h3 class="mb-sm text-label-sm font-bold opacity-80">이번 달 대타 성사율</h3>
						<div class="mb-lg flex items-baseline gap-xs">
							<span class="text-[32px] font-bold">92%</span>
							<span class="text-label-sm opacity-80">mock</span>
						</div>
						<div class="mb-md h-2 w-full overflow-hidden rounded-full bg-white/20">
							<div class="h-full bg-white" style="width: 92%"></div>
						</div>
						<p class="mb-0 text-[11px] leading-relaxed opacity-90">TODO: 승인 완료된 대타 수와 전체 모집 수 기반으로 계산하세요.</p>
					</div>
					<span class="material-symbols-outlined absolute -bottom-4 -right-4 text-[120px] opacity-10">trending_up</span>
				</div>

				<div class="flex gap-md rounded-xl bg-surface-container-high p-md">
					<div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-white text-primary">
						<span class="material-symbols-outlined">info</span>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-on-surface">운영 팁</p>
						<p class="mb-0 text-[12px] text-secondary">모집 기간과 근무 파트를 명확히 적으면 지원자가 더 빠르게 판단할 수 있습니다.</p>
					</div>
				</div>
			</aside>
		</section>
	</div>
</main>
</body>
</html>
