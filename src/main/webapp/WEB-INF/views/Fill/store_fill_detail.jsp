<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StoreFamily - 대타 요청 상세</title>
</head>
<body>
<c:set var="statusLabel" value="대기중"/>
<c:set var="statusClass" value="bg-[#d1fae5] text-[#059669]"/>
<c:if test="${fill.chk == 1}">
	<c:set var="statusLabel" value="수락됨"/>
	<c:set var="statusClass" value="bg-[#e0f2fe] text-[#0369a1]"/>
</c:if>
<c:if test="${fill.chk == 2}">
	<c:set var="statusLabel" value="마감"/>
	<c:set var="statusClass" value="bg-surface-container text-secondary"/>
</c:if>
<c:if test="${fill.chk == 3}">
	<c:set var="statusLabel" value="취소됨"/>
	<c:set var="statusClass" value="bg-error-container text-on-error-container"/>
</c:if>

<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-6xl space-y-lg p-lg md:p-xl">
		<section class="flex flex-col gap-md lg:flex-row lg:items-end lg:justify-between">
			<div>
				<p class="mb-xs text-label-sm font-bold text-primary">Fill Request</p>
				<h1 class="mb-0 font-h1 text-h1 font-bold text-on-surface">대타 요청 상세</h1>
				<p class="mt-sm text-secondary"><strong><c:out value="${myStore.store_name}"/></strong>의 대타 요청 정보입니다.</p>
			</div>
			<div class="flex flex-wrap items-center gap-sm">
				<a class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-white px-md py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">
					<span class="material-symbols-outlined text-[20px]">arrow_back</span>
					목록
				</a>
				<a class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-white px-md py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">
					<span class="material-symbols-outlined text-[20px]">calendar_today</span>
					스케줄
				</a>
			</div>
		</section>

		<c:if test="${not empty message}">
			<div class="rounded-xl border border-primary/20 bg-primary-fixed/40 px-md py-sm text-on-primary-fixed-variant">
				<c:out value="${message}"/>
			</div>
		</c:if>

		<section class="grid grid-cols-1 gap-lg lg:grid-cols-3">
			<article class="rounded-xl border border-surface-variant bg-white p-lg shadow-sm lg:col-span-2">
				<div class="mb-md flex flex-wrap items-start justify-between gap-md">
					<div class="min-w-0">
						<div class="mb-sm flex flex-wrap items-center gap-sm">
							<span class="inline-flex items-center gap-xs rounded-lg px-md py-xs text-label-sm font-bold ${statusClass}">
								<span class="material-symbols-outlined text-[16px]">swap_horiz</span>
								${statusLabel}
							</span>
							<c:if test="${isRequester}">
								<span class="rounded-full bg-primary-fixed px-sm py-0.5 text-[10px] font-bold text-on-primary-fixed">내 요청</span>
							</c:if>
						</div>
						<h2 class="mb-0 font-h2 text-h2 font-bold text-on-surface"><c:out value="${fill.title}"/></h2>
					</div>
				</div>

				<div class="grid grid-cols-1 gap-md rounded-xl bg-surface-container-low p-md md:grid-cols-2">
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">근무 날짜</p>
						<p class="mb-0 font-bold text-on-surface"><c:out value="${fill.fill_day}"/></p>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">근무 시간</p>
						<p class="mb-0 font-bold text-on-surface">${fn:substring(fill.fill_start_time,0,5)} - ${fn:substring(fill.fill_end_time,0,5)}</p>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">요청자</p>
						<p class="mb-0 font-bold text-on-surface"><c:out value="${fill.name}"/> (<c:out value="${fill.id}"/>)</p>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">모집 기간</p>
						<p class="mb-0 font-bold text-on-surface"><c:out value="${fill.apply_start_day}"/> ~ <c:out value="${fill.apply_end_day}"/></p>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">근무 파트</p>
						<p class="mb-0 font-bold text-on-surface">
							<c:choose>
								<c:when test="${empty fill.fill_di_time}">파트 미지정</c:when>
								<c:otherwise><c:out value="${fill.fill_di_time}"/></c:otherwise>
							</c:choose>
						</p>
					</div>
					<div>
						<p class="mb-xs text-label-sm font-bold text-secondary">원본 스케줄</p>
						<p class="mb-0 font-bold text-on-surface">
							<c:choose>
								<c:when test="${fill.schedule_bno != null and fill.schedule_bno > 0}">#<c:out value="${fill.schedule_bno}"/></c:when>
								<c:otherwise>직접 모집</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>

				<div class="mt-lg">
					<p class="mb-sm text-label-sm font-bold text-secondary">요청 사유</p>
					<div class="min-h-[120px] whitespace-pre-wrap rounded-xl border border-surface-variant bg-white p-md text-on-surface">
						<c:out value="${fill.content}"/>
					</div>
				</div>

				<div class="mt-lg flex flex-wrap gap-sm">
					<c:if test="${canAccept}">
						<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/accept">
							<button class="inline-flex items-center gap-xs rounded-lg bg-primary px-lg py-sm font-bold text-on-primary hover:opacity-90" type="submit">
								<span class="material-symbols-outlined text-[20px]">check_circle</span>
								수락하기
							</button>
						</form>
					</c:if>
					<c:if test="${canApply}">
						<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/apply">
							<button class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-white px-lg py-sm font-bold text-on-surface hover:bg-surface-container" type="submit">
								<span class="material-symbols-outlined text-[20px]">how_to_reg</span>
								지원만 하기
							</button>
						</form>
					</c:if>
					<c:if test="${hasPendingMyApply}">
						<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/apply/cancel">
							<button class="inline-flex items-center gap-xs rounded-lg border border-error-container bg-white px-lg py-sm font-bold text-error hover:bg-error-container" type="submit" onclick="return confirm('지원 내역을 취소할까요?');">
								<span class="material-symbols-outlined text-[20px]">cancel</span>
								지원 취소
							</button>
						</form>
					</c:if>
					<c:if test="${canCancelFill}">
						<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/cancel">
							<button class="inline-flex items-center gap-xs rounded-lg border border-error-container bg-white px-lg py-sm font-bold text-error hover:bg-error-container" type="submit" onclick="return confirm('대타 요청을 취소할까요?');">
								<span class="material-symbols-outlined text-[20px]">delete</span>
								요청 취소
							</button>
						</form>
					</c:if>
					<c:if test="${canManage and fill.chk == 0}">
						<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/close">
							<button class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-white px-lg py-sm font-bold text-secondary hover:bg-surface-container" type="submit" onclick="return confirm('대타 요청을 마감할까요?');">
								<span class="material-symbols-outlined text-[20px]">lock</span>
								마감
							</button>
						</form>
					</c:if>
				</div>
			</article>

			<aside class="space-y-lg">
				<div class="rounded-xl border border-surface-variant bg-white p-lg shadow-sm">
					<h3 class="mb-md flex items-center gap-xs font-h3 text-h3">
						<span class="material-symbols-outlined text-primary">group</span>
						지원/수락 현황
					</h3>
					<c:choose>
						<c:when test="${empty applies}">
							<div class="rounded-xl border border-dashed border-outline-variant bg-surface-container-low p-lg text-center text-secondary">
								아직 지원자가 없습니다.
							</div>
						</c:when>
						<c:otherwise>
							<div class="space-y-sm">
								<c:forEach var="ap" items="${applies}">
									<c:set var="applyLabel" value="대기"/>
									<c:set var="applyClass" value="bg-[#d1fae5] text-[#059669]"/>
									<c:if test="${ap.chk == 1}">
										<c:set var="applyLabel" value="수락됨"/>
										<c:set var="applyClass" value="bg-[#e0f2fe] text-[#0369a1]"/>
									</c:if>
									<c:if test="${ap.chk == 2}">
										<c:set var="applyLabel" value="거절"/>
										<c:set var="applyClass" value="bg-surface-container text-secondary"/>
									</c:if>
									<c:if test="${ap.chk == 3}">
										<c:set var="applyLabel" value="취소"/>
										<c:set var="applyClass" value="bg-error-container text-on-error-container"/>
									</c:if>
									<div class="rounded-xl border border-surface-variant bg-surface-container-low p-md">
										<div class="flex items-start justify-between gap-sm">
											<div>
												<p class="mb-xs font-bold text-on-surface"><c:out value="${ap.m_name}"/></p>
												<p class="mb-0 text-label-sm text-secondary"><c:out value="${ap.applicant_phone}"/></p>
											</div>
											<span class="rounded-lg px-sm py-xs text-[10px] font-bold ${applyClass}">${applyLabel}</span>
										</div>
										<c:if test="${canManage and fill.chk == 0 and ap.chk == 0}">
											<div class="mt-sm flex gap-xs">
												<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/applications/${ap.bno}/approve">
													<button class="rounded-lg bg-primary px-md py-xs text-label-sm font-bold text-on-primary" type="submit">승인</button>
												</form>
												<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/applications/${ap.bno}/reject">
													<button class="rounded-lg border border-error-container px-md py-xs text-label-sm font-bold text-error" type="submit">거절</button>
												</form>
											</div>
										</c:if>
									</div>
								</c:forEach>
							</div>
						</c:otherwise>
					</c:choose>
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
