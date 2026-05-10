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
<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-7xl space-y-xl p-lg md:p-xl">
		<section class="flex flex-col gap-md lg:flex-row lg:items-end lg:justify-between">
			<div>
				<p class="mb-xs text-label-sm font-bold text-primary">Shift Swap</p>
				<h1 class="mb-0 font-h1 text-h1 font-bold text-on-surface">대타 요청 관리</h1>
				<p class="mt-sm text-secondary">
					<strong><c:out value="${myStore.store_name}"/></strong>
					<span class="text-on-surface-variant">(<c:out value="${myStore.store_code}"/>)</span>
					매장의 대타 요청을 확인하고 수락 또는 취소할 수 있습니다.
				</p>
			</div>
			<div class="flex flex-wrap items-center gap-sm">
				<a class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-surface-container-low px-md py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">
					<span class="material-symbols-outlined text-[20px]">calendar_today</span>
					내 스케줄
				</a>
				<c:if test="${canManage}">
					<a class="inline-flex items-center gap-xs rounded-lg bg-primary px-lg py-sm font-bold text-on-primary shadow-sm transition hover:opacity-90" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/new">
						<span class="material-symbols-outlined text-[20px]">edit_square</span>
						직접 모집
					</a>
				</c:if>
			</div>
		</section>

		<c:if test="${not empty message}">
			<div class="rounded-xl border border-primary/20 bg-primary-fixed/40 px-md py-sm text-on-primary-fixed-variant">
				<c:out value="${message}"/>
			</div>
		</c:if>

		<section class="rounded-xl border border-surface-variant bg-white p-md shadow-sm">
			<div class="flex flex-col gap-md lg:flex-row lg:items-center lg:justify-between">
				<div class="flex gap-sm overflow-x-auto pb-sm md:pb-0">
					<a class="whitespace-nowrap rounded-full px-md py-xs font-bold ${status == 'all' ? 'bg-primary-container text-on-primary-container' : 'bg-surface-container-low text-secondary hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">전체</a>
					<a class="whitespace-nowrap rounded-full px-md py-xs font-bold ${status == 'open' ? 'bg-primary-container text-on-primary-container' : 'bg-surface-container-low text-secondary hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills?status=open">대기중 (${openCount})</a>
					<a class="whitespace-nowrap rounded-full px-md py-xs font-bold ${status == 'accepted' ? 'bg-primary-container text-on-primary-container' : 'bg-surface-container-low text-secondary hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills?status=accepted">수락됨 (${acceptedCount})</a>
					<a class="whitespace-nowrap rounded-full px-md py-xs font-bold ${status == 'canceled' ? 'bg-primary-container text-on-primary-container' : 'bg-surface-container-low text-secondary hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills?status=canceled">취소됨 (${canceledCount})</a>
					<a class="whitespace-nowrap rounded-full px-md py-xs font-bold ${status == 'mine' ? 'bg-primary-container text-on-primary-container' : 'bg-surface-container-low text-secondary hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills?status=mine">내 요청</a>
				</div>
				<div class="text-label-sm font-bold text-secondary">총 ${fn:length(fills)}건</div>
			</div>
		</section>

		<section class="grid grid-cols-1 gap-lg lg:grid-cols-3">
			<div class="space-y-md lg:col-span-2">
				<div class="flex items-center justify-between">
					<h2 class="mb-0 flex items-center gap-xs font-h3 text-h3">
						<span class="material-symbols-outlined text-primary">list_alt</span>
						요청 목록
					</h2>
				</div>

				<c:choose>
					<c:when test="${empty fills}">
						<div class="rounded-xl border border-dashed border-outline-variant bg-white p-xl text-center text-secondary">
							<span class="material-symbols-outlined mb-sm text-[44px] text-primary">swap_horiz</span>
							<p class="mb-xs font-h3 text-h3 text-on-surface">표시할 대타 요청이 없습니다</p>
							<p class="mb-0">내 스케줄에서 대타 요청을 등록하면 이곳에 표시됩니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="fill" items="${fills}">
							<c:set var="statusLabel" value="대기중"/>
							<c:set var="statusClass" value="bg-[#d1fae5] text-[#059669]"/>
							<c:set var="barClass" value="bg-[#10b981]"/>
							<c:if test="${fill.chk == 1}">
								<c:set var="statusLabel" value="수락됨"/>
								<c:set var="statusClass" value="bg-[#e0f2fe] text-[#0369a1]"/>
								<c:set var="barClass" value="bg-primary"/>
							</c:if>
							<c:if test="${fill.chk == 2}">
								<c:set var="statusLabel" value="마감"/>
								<c:set var="statusClass" value="bg-surface-container text-secondary"/>
								<c:set var="barClass" value="bg-secondary"/>
							</c:if>
							<c:if test="${fill.chk == 3}">
								<c:set var="statusLabel" value="취소됨"/>
								<c:set var="statusClass" value="bg-error-container text-on-error-container"/>
								<c:set var="barClass" value="bg-error"/>
							</c:if>
							<c:set var="isMine" value="${loginId == fill.id}"/>
							<article class="relative overflow-hidden rounded-xl border border-surface-variant bg-white p-lg shadow-sm transition hover:shadow-md">
								<div class="absolute left-0 top-0 h-full w-1 ${barClass}"></div>
								<div class="flex flex-col gap-md md:flex-row md:items-start md:justify-between">
									<div class="min-w-0 flex-1">
										<div class="mb-sm flex flex-wrap items-center gap-sm">
											<span class="rounded-full bg-[#e7f5f1] px-sm py-0.5 text-[10px] font-bold text-primary">
												<c:choose>
													<c:when test="${empty fill.fill_di_time}">파트 미지정</c:when>
													<c:otherwise><c:out value="${fill.fill_di_time}"/></c:otherwise>
												</c:choose>
											</span>
											<c:if test="${isMine}">
												<span class="rounded-full bg-primary-fixed px-sm py-0.5 text-[10px] font-bold text-on-primary-fixed">내 요청</span>
											</c:if>
											<span class="inline-flex items-center gap-xs rounded-lg px-md py-xs text-label-sm font-bold ${statusClass}">
												<span class="material-symbols-outlined text-[16px]">hourglass_empty</span>
												${statusLabel}
											</span>
										</div>
										<a class="block truncate font-h3 text-h3 font-bold text-on-surface hover:text-primary" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">
											<c:out value="${fill.title}"/>
										</a>
										<div class="mt-sm flex flex-wrap items-center gap-md text-body-md text-secondary">
											<span class="inline-flex items-center gap-xs"><span class="material-symbols-outlined text-[18px]">event</span><c:out value="${fill.fill_day}"/></span>
											<span class="inline-flex items-center gap-xs"><span class="material-symbols-outlined text-[18px]">schedule</span>${fn:substring(fill.fill_start_time,0,5)} - ${fn:substring(fill.fill_end_time,0,5)}</span>
											<span class="inline-flex items-center gap-xs"><span class="material-symbols-outlined text-[18px]">person</span><c:out value="${fill.name}"/></span>
											<span class="font-bold text-primary">지원 ${fill.apply_su}명</span>
										</div>
										<p class="mt-md mb-0 line-clamp-2 text-body-md text-on-surface-variant"><c:out value="${fill.content}"/></p>
									</div>
									<div class="flex w-full flex-col gap-sm md:w-auto md:min-w-[180px]">
										<a class="rounded-lg border border-outline-variant px-md py-sm text-center font-bold text-on-surface hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">상세보기</a>
										<c:if test="${storeMember.position == '직원' and not isMine and fill.chk == 0}">
											<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/accept">
												<button class="w-full rounded-lg bg-primary px-md py-sm font-bold text-on-primary hover:opacity-90" type="submit">수락하기</button>
											</form>
										</c:if>
										<c:if test="${isMine and fill.chk == 0}">
											<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/cancel">
												<button class="w-full rounded-lg border border-error-container px-md py-sm font-bold text-error hover:bg-error-container" type="submit" onclick="return confirm('대타 요청을 취소할까요?');">요청 취소</button>
											</form>
										</c:if>
									</div>
								</div>
							</article>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>

			<aside class="space-y-lg">
				<div class="rounded-xl border border-surface-variant bg-white p-lg shadow-sm">
					<h2 class="mb-md flex items-center gap-xs font-h3 text-h3">
						<span class="material-symbols-outlined text-primary">analytics</span>
						상태 요약
					</h2>
					<div class="space-y-sm">
						<div class="flex items-center justify-between rounded-lg bg-surface-container-low p-sm"><span class="text-secondary">대기중</span><strong>${openCount}건</strong></div>
						<div class="flex items-center justify-between rounded-lg bg-surface-container-low p-sm"><span class="text-secondary">수락됨</span><strong class="text-primary">${acceptedCount}건</strong></div>
						<div class="flex items-center justify-between rounded-lg bg-surface-container-low p-sm"><span class="text-secondary">취소됨</span><strong class="text-error">${canceledCount}건</strong></div>
					</div>
				</div>

				<div class="flex gap-md rounded-xl bg-surface-container-high p-md">
					<div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-white text-primary">
						<span class="material-symbols-outlined">info</span>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-on-surface">운영 안내</p>
						<p class="mb-0 text-[12px] text-secondary">수락 전 요청만 요청자가 직접 취소할 수 있습니다. 이미 수락된 요청은 스케줄 담당자가 변경됩니다.</p>
					</div>
				</div>
			</aside>
		</section>
	</div>
</main>
<script>
	(function() {
		document.querySelectorAll('form[data-submit-once="true"]').forEach(function(form) {
			form.addEventListener('submit', function() {
				form.querySelectorAll('button[type="submit"]').forEach(function(button) {
					button.disabled = true;
					button.classList.add('opacity-60', 'cursor-not-allowed');
				});
			});
		});
	})();
</script>
</body>
</html>
