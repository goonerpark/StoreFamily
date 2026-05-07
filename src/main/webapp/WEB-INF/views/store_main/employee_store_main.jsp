<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StoreFamily - 직원 대시보드</title>
</head>
<body>
<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-6xl space-y-lg px-container-padding py-xl">
		<section class="grid grid-cols-1 gap-lg lg:grid-cols-3">
			<div class="rounded-xl border border-surface-variant bg-white p-xl transition hover:shadow-md lg:col-span-2">
				<div class="grid grid-cols-1 items-center gap-xl md:grid-cols-2">
					<div class="space-y-md">
						<div class="inline-flex items-center gap-xs rounded-full bg-primary-container px-sm py-1 text-on-primary-container">
							<span class="material-symbols-outlined text-[16px]" style="font-variation-settings:'FILL' 1;">timer</span>
							<span class="font-label-sm text-label-sm">오늘의 근무</span>
						</div>
						<div>
							<h1 class="font-h1 text-h1 font-bold text-on-surface">
								<c:out value="${sessionScope.name}"/>님, 좋은 근무 되세요
							</h1>
							<p class="mb-0 mt-sm text-secondary">오늘 일정과 대타 추천을 빠르게 확인할 수 있습니다.</p>
						</div>
						<!-- TODO: /stores/{storeId}/my-schedules 모델과 연결되면 오늘 실제 근무 시간으로 교체 -->
						<div class="space-y-sm">
							<div class="flex items-center gap-md">
								<span class="material-symbols-outlined text-primary">schedule</span>
								<span class="font-body-lg text-body-lg text-on-surface">09:00 - 17:00</span>
							</div>
							<div class="flex items-center gap-md">
								<span class="material-symbols-outlined text-primary">assignment_ind</span>
								<span class="font-body-lg text-body-lg text-on-surface">메인 카운터 및 재고 관리</span>
							</div>
						</div>
						<div class="flex flex-wrap gap-sm pt-md">
							<a class="rounded-lg bg-primary px-lg py-sm font-bold text-white transition active:scale-95" href="${pageContext.request.contextPath}/schedule">근무표 보기</a>
							<a class="rounded-lg border border-primary px-lg py-sm font-bold text-primary hover:bg-surface-container" href="${pageContext.request.contextPath}/fill_all_list">대타 찾기</a>
						</div>
					</div>
					<div class="relative h-48 overflow-hidden rounded-xl bg-primary-fixed md:h-64">
						<div class="absolute inset-0 bg-gradient-to-br from-primary/90 to-primary-container/80"></div>
						<div class="absolute inset-0 flex flex-col justify-end p-lg text-white">
							<span class="material-symbols-outlined mb-md text-[56px] opacity-80">storefront</span>
							<p class="mb-xs text-label-sm opacity-80">현재 매장</p>
							<p class="mb-0 font-h3 text-h3">
								<c:choose>
									<c:when test="${empty sessionScope.bussiness}">소속 매장</c:when>
									<c:otherwise><c:out value="${sessionScope.bussiness}"/></c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
			</div>

			<aside class="flex flex-col justify-between rounded-xl border border-surface-variant bg-surface-container-low p-lg">
				<div>
					<div class="mb-md flex items-start justify-between">
						<h2 class="flex items-center gap-sm font-h3 text-h3 text-primary">
							<span class="material-symbols-outlined">campaign</span>
							매장 공지
						</h2>
						<span class="material-symbols-outlined text-secondary">more_horiz</span>
					</div>
					<div class="space-y-md">
						<!-- TODO: 게시판/공지 모델 연동 시 실제 최신 게시글로 교체 -->
						<div class="rounded-lg border-l-4 border-primary bg-white p-sm">
							<p class="mb-1 text-label-sm font-bold text-primary">공지</p>
							<p class="mb-1 font-semibold text-on-surface">보건증 등록 상태를 확인해주세요</p>
							<p class="mb-0 text-[12px] text-secondary">점주 • 2시간 전</p>
						</div>
						<div class="rounded-lg border-l-4 border-tertiary-container bg-white p-sm">
							<p class="mb-1 text-label-sm font-bold text-tertiary">운영</p>
							<p class="mb-1 font-semibold text-on-surface">주말 대타 모집이 열려 있습니다</p>
							<p class="mb-0 text-[12px] text-secondary">관리자 • 5시간 전</p>
						</div>
					</div>
				</div>
				<a class="mt-lg flex w-full items-center justify-center gap-xs font-label-sm text-label-sm font-bold text-primary hover:underline" href="${pageContext.request.contextPath}/insu_list">
					게시판 보기 <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
				</a>
			</aside>
		</section>

		<section class="grid grid-cols-1 gap-lg lg:grid-cols-3">
			<div class="rounded-xl border border-surface-variant bg-white p-lg lg:col-span-2">
				<div class="mb-lg flex items-center justify-between">
					<h2 class="flex items-center gap-sm font-h3 text-h3 text-on-surface">
						<span class="material-symbols-outlined text-primary">calendar_month</span>
						나의 주간 스케줄
					</h2>
					<div class="flex gap-xs">
						<button class="rounded p-1 hover:bg-surface-container"><span class="material-symbols-outlined">chevron_left</span></button>
						<button class="rounded p-1 hover:bg-surface-container"><span class="material-symbols-outlined">chevron_right</span></button>
					</div>
				</div>
				<!-- TODO: 실제 주간 스케줄 데이터가 컨트롤러에서 전달되면 아래 mock 셀을 반복 렌더링으로 교체 -->
				<div class="grid grid-cols-7 gap-sm">
					<c:forTokens var="day" items="월,화,수,목,금,토,일" delims="," varStatus="status">
						<c:set var="dayCardClass" value="bg-surface-container-low text-on-surface"/>
						<c:if test="${status.index == 1}">
							<c:set var="dayCardClass" value="bg-primary-container text-white shadow-lg"/>
						</c:if>
						<div class="space-y-sm text-center">
							<p class="mb-0 text-[10px] font-bold text-secondary">${day}</p>
							<div class="${dayCardClass} flex h-24 flex-col items-center justify-center rounded-lg p-xs">
								<span class="font-label-sm">${12 + status.index}</span>
								<c:choose>
									<c:when test="${status.index == 1}">
										<div class="mt-1 text-[10px] font-bold">오늘</div>
									</c:when>
									<c:when test="${status.index == 0 || status.index == 2 || status.index == 4 || status.index == 5}">
										<div class="mt-1 flex h-8 w-full items-center justify-center rounded-md border border-primary/30 bg-primary-container/20">
											<div class="h-1.5 w-1.5 rounded-full bg-primary"></div>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>
					</c:forTokens>
				</div>
			</div>

			<div class="rounded-xl border border-surface-variant bg-white p-lg">
				<h2 class="mb-md font-h3 text-h3 text-on-surface">주간 요약</h2>
				<div class="space-y-lg">
					<div class="flex items-center gap-lg">
						<div class="flex h-12 w-12 items-center justify-center rounded-full bg-surface-container text-primary">
							<span class="material-symbols-outlined">work</span>
						</div>
						<div>
							<p class="mb-0 font-h2 text-h2 font-bold text-on-surface">32h</p>
							<p class="mb-0 font-label-sm text-label-sm text-secondary">예정 근무 시간</p>
						</div>
					</div>
					<div class="flex items-center gap-lg">
						<div class="flex h-12 w-12 items-center justify-center rounded-full bg-surface-container text-tertiary">
							<span class="material-symbols-outlined">payments</span>
						</div>
						<div>
							<p class="mb-0 font-h2 text-h2 font-bold text-on-surface">계산 예정</p>
							<p class="mb-0 font-label-sm text-label-sm text-secondary">예상 급여</p>
						</div>
					</div>
					<div class="border-t border-surface-variant pt-sm">
						<p class="mb-0 text-on-surface-variant">다음 주: <span class="font-bold text-primary">4개 근무</span> 확정됨.</p>
					</div>
				</div>
			</div>
		</section>

		<section class="space-y-md">
			<div class="flex items-center justify-between">
				<h2 class="flex items-center gap-sm font-h3 text-h3 text-on-surface">
					<span class="material-symbols-outlined text-primary">sync_alt</span>
					대타 추천
				</h2>
				<a class="font-label-sm text-label-sm font-bold text-primary hover:underline" href="${pageContext.request.contextPath}/fill_all_list">전체 모집 보기</a>
			</div>
			<div class="grid grid-cols-1 gap-md md:grid-cols-2 lg:grid-cols-3">
				<c:forEach var="idx" begin="1" end="3">
					<article class="group flex gap-md rounded-xl border border-surface-variant bg-white p-md transition hover:border-primary">
						<div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-surface-container text-primary transition group-hover:bg-primary-container group-hover:text-white">
							<span class="material-symbols-outlined">person_search</span>
						</div>
						<div class="flex-1">
							<div class="flex justify-between gap-sm">
								<p class="mb-0 font-bold text-on-surface">추천 대타 ${idx}</p>
								<c:if test="${idx == 1}">
									<span class="rounded-full bg-tertiary-fixed-dim px-sm text-[10px] font-bold text-tertiary">긴급</span>
								</c:if>
							</div>
							<p class="mb-0 text-[12px] text-secondary">이번 주말</p>
							<p class="mt-1 font-label-sm text-label-sm text-on-surface-variant">10:00 - 14:00</p>
							<div class="mt-md flex gap-sm">
								<a class="flex-1 rounded-md bg-surface-container py-1 text-center font-label-sm text-label-sm font-bold text-primary hover:bg-primary-container hover:text-white" href="${pageContext.request.contextPath}/fill_all_list">지원하기</a>
								<a class="flex-1 rounded-md border border-outline-variant py-1 text-center font-label-sm text-label-sm font-bold text-secondary" href="${pageContext.request.contextPath}/fill_all_list">상세보기</a>
							</div>
						</div>
					</article>
				</c:forEach>
			</div>
		</section>
	</div>
</main>

<a class="fixed bottom-lg right-lg z-40 hidden items-center gap-md rounded-full bg-primary-container px-lg py-md font-h3 text-on-primary-container shadow-xl transition hover:scale-105 md:flex" href="${pageContext.request.contextPath}/fill_all_list">
	<span class="material-symbols-outlined">swap_calls</span>
	대타 요청하기
</a>
</body>
</html>
