<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StoreFamily - 대타 요청 작성</title>
</head>
<body>
<main class="min-h-screen bg-background">
	<div class="mx-auto max-w-4xl space-y-lg p-lg md:p-xl">
		<section class="flex flex-col gap-md md:flex-row md:items-end md:justify-between">
			<div>
				<p class="mb-xs text-label-sm font-bold text-primary">New Fill Request</p>
				<h1 class="mb-0 font-h1 text-h1 font-bold text-on-surface">
					<c:choose>
						<c:when test="${isDirect}">직접 대타 모집</c:when>
						<c:otherwise>내 근무 대타 요청</c:otherwise>
					</c:choose>
				</h1>
				<p class="mt-sm text-secondary"><strong><c:out value="${myStore.store_name}"/></strong> 스케줄 기준으로 대타 요청을 등록합니다.</p>
			</div>
			<a class="inline-flex items-center gap-xs rounded-lg border border-outline-variant bg-white px-md py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">
				<span class="material-symbols-outlined text-[20px]">arrow_back</span>
				목록
			</a>
		</section>

		<c:if test="${not empty message}">
			<div class="rounded-xl border border-primary/20 bg-primary-fixed/40 px-md py-sm text-on-primary-fixed-variant">
				<c:out value="${message}"/>
			</div>
		</c:if>

		<section class="rounded-xl border border-surface-variant bg-white p-lg shadow-sm">
			<c:if test="${not isDirect}">
				<div class="mb-lg rounded-xl border border-surface-variant bg-surface-container-low p-md">
					<p class="mb-sm text-label-sm font-bold text-secondary">대상 근무 일정</p>
					<div class="grid grid-cols-1 gap-md md:grid-cols-3">
						<div>
							<p class="mb-xs text-label-sm text-secondary">근무 날짜</p>
							<p class="mb-0 font-bold"><c:out value="${schedule.work_date}"/></p>
						</div>
						<div>
							<p class="mb-xs text-label-sm text-secondary">근무 시간</p>
							<p class="mb-0 font-bold">${fn:substring(schedule.start_time,0,5)} - ${fn:substring(schedule.end_time,0,5)}</p>
						</div>
						<div>
							<p class="mb-xs text-label-sm text-secondary">파트</p>
							<p class="mb-0 font-bold">
								<c:choose>
									<c:when test="${empty schedule.part_name}">파트 미지정</c:when>
									<c:otherwise><c:out value="${schedule.part_name}"/></c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
			</c:if>

			<c:choose>
				<c:when test="${isDirect}">
					<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/new" id="directFillForm" class="space-y-md">
						<div>
							<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">제목</label>
							<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="text" name="title" maxlength="120" placeholder="예: 토요일 마감 대타 모집" required>
						</div>
						<div>
							<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">요청 사유 / 안내</label>
							<textarea class="min-h-[140px] w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" name="content" maxlength="1000" placeholder="필요 인원, 담당 업무, 참고사항을 입력하세요." required></textarea>
						</div>
						<div class="grid grid-cols-1 gap-md md:grid-cols-2">
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">근무 날짜</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="date" name="fillDay" value="${defaultFillDay}" required>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">근무 파트</label>
								<select class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" name="partBno" id="partBno">
									<option value="">직접 입력</option>
									<c:forEach var="part" items="${scheduleParts}">
										<option value="${part.bno}" data-start="${part.start_time}" data-end="${part.end_time}">
											<c:out value="${part.part_name}"/> (<c:out value="${part.start_time}"/>~<c:out value="${part.end_time}"/>)
										</option>
									</c:forEach>
								</select>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">시작 시간</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="time" name="startTime" id="startTime" required>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">종료 시간</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="time" name="endTime" id="endTime" required>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">모집 시작일</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="date" name="applyStartDay" value="${defaultApplyStart}" required>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">모집 종료일</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="date" name="applyEndDay" value="${defaultApplyEnd}" required>
							</div>
						</div>
						<div class="flex flex-wrap gap-sm pt-sm">
							<button class="rounded-lg bg-primary px-lg py-sm font-bold text-on-primary hover:opacity-90" type="submit">요청 등록</button>
							<a class="rounded-lg border border-outline-variant px-lg py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">취소</a>
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form method="post" data-submit-once="true" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/${schedule.bno}/fill/new" class="space-y-md">
						<div>
							<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">제목</label>
							<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="text" name="title" maxlength="120" placeholder="예: 금요일 미들 대타 부탁드립니다" required>
						</div>
						<div>
							<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">요청 사유</label>
							<textarea class="min-h-[160px] w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" name="content" maxlength="1000" placeholder="대타가 필요한 이유를 입력하세요." required></textarea>
						</div>
						<div class="grid grid-cols-1 gap-md md:grid-cols-2">
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">모집 시작일</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="date" name="applyStartDay" value="${defaultApplyStart}" required>
							</div>
							<div>
								<label class="mb-xs block text-label-sm font-bold text-on-surface-variant">모집 종료일</label>
								<input class="w-full rounded-lg border border-outline-variant px-md py-sm focus:border-primary focus:ring-primary" type="date" name="applyEndDay" value="${defaultApplyEnd}" required>
							</div>
						</div>
						<div class="flex flex-wrap gap-sm pt-sm">
							<button class="rounded-lg bg-primary px-lg py-sm font-bold text-on-primary hover:opacity-90" type="submit">요청 등록</button>
							<a class="rounded-lg border border-outline-variant px-lg py-sm font-bold text-secondary hover:bg-surface-container" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">취소</a>
						</div>
					</form>
				</c:otherwise>
			</c:choose>
		</section>
	</div>
</main>

<c:if test="${isDirect}">
<script>
	(function() {
		var partSelect = document.getElementById('partBno');
		var startInput = document.getElementById('startTime');
		var endInput = document.getElementById('endTime');
		if (!partSelect || !startInput || !endInput) {
			return;
		}

		function applyPartTime() {
			var option = partSelect.options[partSelect.selectedIndex];
			if (!option || !option.value) {
				startInput.readOnly = false;
				endInput.readOnly = false;
				return;
			}
			var start = option.getAttribute('data-start');
			var end = option.getAttribute('data-end');
			if (start && end) {
				startInput.value = start.substring(0, 5);
				endInput.value = end.substring(0, 5);
			}
			startInput.readOnly = true;
			endInput.readOnly = true;
		}

		partSelect.addEventListener('change', applyPartTime);
		applyPartTime();
	})();
</script>
</c:if>
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
