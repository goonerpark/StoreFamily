<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 캘린더</title>
<style>
	:root {
		--bg: #f6f7fb;
		--card: #ffffff;
		--line: #e4e7ec;
		--text: #1f2937;
		--muted: #6b7280;
		--point: #1f6feb;
		--danger: #d1242f;
	}
	* { box-sizing: border-box; }
	body { margin: 0; background: var(--bg); color: var(--text); font-family: "GmarketSansTTFMedium", "Malgun Gothic", sans-serif; }
	.wrap { max-width: 1200px; margin: 0 auto; padding: 24px 18px 36px; }
	.top { display: flex; gap: 10px; justify-content: space-between; align-items: center; margin-bottom: 14px; }
	.title { margin: 0; font-size: 28px; }
	.sub { margin: 8px 0 0; color: var(--muted); }
	.nav-btns { display: flex; gap: 8px; flex-wrap: wrap; }
	.btn { display: inline-flex; align-items: center; justify-content: center; min-height: 36px; border: 1px solid var(--line); border-radius: 9px; padding: 8px 12px; text-decoration: none; color: var(--text); background: #fff; font-weight: 700; font-size: 13px; cursor: pointer; }
	.btn:hover { border-color: var(--point); color: var(--point); }
	.btn-danger { border-color: #f4c4c8; color: var(--danger); }
	.btn-danger:hover { border-color: var(--danger); color: var(--danger); }
	.msg { margin-bottom: 12px; padding: 10px 12px; border-radius: 10px; background: #eef4ff; color: #1f3f7f; }
	.layout { display: grid; grid-template-columns: 2fr 1fr; gap: 14px; }
	.card { background: var(--card); border: 1px solid var(--line); border-radius: 14px; }
	.calendar-head { display: flex; justify-content: space-between; align-items: center; padding: 14px 14px 0; }
	.month-label { margin: 0; font-size: 21px; }
	.week { display: grid; grid-template-columns: repeat(7, 1fr); gap: 8px; padding: 12px 14px 0; color: var(--muted); font-size: 13px; }
	.calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); gap: 8px; padding: 10px 14px 14px; }
	.day-cell { min-height: 92px; border: 1px solid var(--line); border-radius: 10px; background: #fff; text-decoration: none; color: var(--text); padding: 8px; display: flex; flex-direction: column; justify-content: space-between; }
	.day-cell:hover { border-color: var(--point); }
	.day-cell.out { opacity: 0.45; }
	.day-cell.selected { border-color: var(--point); background: #edf3ff; }
	.day-top { display: flex; justify-content: space-between; align-items: center; }
	.day-num { font-weight: 700; }
	.today { font-size: 11px; color: var(--point); font-weight: 700; }
	.preview-list { margin-top: 8px; display: grid; gap: 4px; }
	.preview-item { font-size: 11px; color: #334155; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; border-radius: 999px; padding: 2px 7px; }
	.preview-more { font-size: 11px; font-weight: 700; color: #1f6feb; }
	.panel { padding: 14px; }
	.panel-title { margin: 0 0 10px; font-size: 18px; }
	.list { margin: 0; padding: 0; list-style: none; display: grid; gap: 10px; }
	.item { border: 1px solid var(--line); border-radius: 10px; padding: 10px; }
	.item-head { display: flex; justify-content: space-between; gap: 8px; align-items: center; }
	.item-title { font-weight: 700; }
	.item-sub { margin-top: 6px; color: var(--muted); font-size: 13px; }
	.item-actions { display: flex; gap: 6px; margin-top: 8px; }
	.form-card { margin-top: 14px; padding: 14px; }
	.form-title { margin: 0 0 10px; font-size: 18px; }
	.form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; }
	.form-group { display: grid; gap: 6px; }
	.form-group.full { grid-column: 1 / -1; }
	label { font-size: 13px; color: var(--muted); }
	input, select, textarea { width: 100%; border: 1px solid var(--line); border-radius: 8px; padding: 8px 10px; font-family: inherit; font-size: 14px; }
	textarea { min-height: 84px; resize: vertical; }
	.form-actions { margin-top: 10px; display: flex; gap: 8px; flex-wrap: wrap; }
	@media (max-width: 1000px) {
		.layout { grid-template-columns: 1fr; }
	}
	@media (max-width: 720px) {
		.wrap { padding: 16px 12px 24px; }
		.top { flex-direction: column; align-items: stretch; }
		.form-grid { grid-template-columns: 1fr; }
		.day-cell { min-height: 80px; }
	}
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<div>
			<h1 class="title">스케줄 캘린더</h1>
			<p class="sub"><strong><c:out value="${myStore.store_name}"/></strong> (<c:out value="${myStore.store_code}"/>)</p>
		</div>
		<div class="nav-btns">
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}">매장 관리</a>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees">직원 리스트</a>
			<c:if test="${not readOnly}">
				<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/parts">근무 파트 관리</a>
			</c:if>
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="msg"><c:out value="${message}"/></div>
	</c:if>

	<div class="layout">
		<div>
			<div class="card">
				<div class="calendar-head">
					<h2 class="month-label">${month}</h2>
					<div class="nav-btns">
						<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules?month=${prevMonth}&date=${prevMonth}-01">이전 달</a>
						<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules?month=${nextMonth}&date=${nextMonth}-01">다음 달</a>
					</div>
				</div>
				<div class="week">
					<div>일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div>토</div>
				</div>
				<div class="calendar-grid">
					<c:forEach var="cell" items="${calendarCells}">
						<a class="day-cell ${cell.currentMonth ? '' : 'out'} ${cell.selected ? 'selected' : ''}"
							href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules?month=${month}&date=${cell.date}">
							<div class="day-top">
								<span class="day-num">${cell.day}</span>
								<c:if test="${cell.today}"><span class="today">TODAY</span></c:if>
							</div>
							<div class="preview-list">
								<c:forEach var="item" items="${cell.previews}">
									<div class="preview-item" style="background:${item.color};"><c:out value="${item.label}"/></div>
								</c:forEach>
								<c:if test="${cell.overflow > 0}">
									<div class="preview-more">+${cell.overflow}</div>
								</c:if>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>

			<c:if test="${not readOnly}">
			<div class="card form-card">
				<h3 class="form-title">스케줄 등록</h3>
				<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="selectedDate" value="${selectedDate}">
					<div class="form-grid">
						<div class="form-group">
							<label>직원</label>
							<select name="storeEmployeeBno" required>
								<option value="">직원 선택</option>
								<c:forEach var="emp" items="${employees}">
									<option value="${emp.store_member_id}">${emp.name} (${emp.member_id})</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label>근무일</label>
							<input type="date" name="workDate" value="${selectedDate}" required>
						</div>
						<div class="form-group">
							<label>근무 파트</label>
							<select name="partBno" onchange="applyPart(this)">
								<option value="">직접 입력</option>
								<c:forEach var="part" items="${parts}">
									<option value="${part.bno}" data-start="${fn:substring(part.start_time,0,5)}" data-end="${fn:substring(part.end_time,0,5)}">${part.part_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label>시작 시간</label>
							<input type="time" name="startTime" required>
						</div>
						<div class="form-group">
							<label>종료 시간</label>
							<input type="time" name="endTime" required>
						</div>
						<div class="form-group full">
							<label>메모</label>
							<textarea name="memo" maxlength="255" placeholder="메모를 입력하세요 (선택)"></textarea>
						</div>
					</div>
					<div class="form-actions">
						<button class="btn" type="submit">등록</button>
					</div>
				</form>
			</div>
			</c:if>
		</div>

		<div>
			<div class="card panel">
				<h3 class="panel-title">${selectedDate} 스케줄</h3>
				<c:choose>
					<c:when test="${empty daySchedules}">
						<div class="item-sub">선택한 날짜의 스케줄이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<ul class="list">
							<c:forEach var="sc" items="${daySchedules}">
								<li class="item">
									<div class="item-head">
										<div class="item-title"><c:out value="${sc.employee_name}"/> (<c:out value="${sc.employee_id}"/>)</div>
										<c:if test="${not empty sc.part_name}">
											<div><c:out value="${sc.part_name}"/></div>
										</c:if>
									</div>
									<div class="item-sub">${fn:substring(sc.start_time,0,5)} ~ ${fn:substring(sc.end_time,0,5)} / ${sc.work_minutes}분</div>
									<c:if test="${not empty sc.memo}">
										<div class="item-sub"><c:out value="${sc.memo}"/></div>
									</c:if>
									<c:if test="${sessionScope.id == sc.employee_id}">
									<div class="item-actions">
										<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/${sc.bno}/fill/new">대타 요청</a>
									</div>
									</c:if>
									<c:if test="${not readOnly}">
									<div class="item-actions">
										<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules?month=${month}&date=${selectedDate}&editScheduleId=${sc.bno}">수정</a>
										<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules/${sc.bno}/delete" style="margin:0;">
											<input type="hidden" name="month" value="${month}">
											<input type="hidden" name="selectedDate" value="${selectedDate}">
											<button class="btn btn-danger" type="submit" onclick="return confirm('해당 스케줄을 삭제할까요?');">삭제</button>
										</form>
									</div>
									</c:if>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>

			<c:if test="${not readOnly and not empty editSchedule}">
				<div class="card form-card">
					<h3 class="form-title">스케줄 수정</h3>
					<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules/${editSchedule.bno}">
						<input type="hidden" name="month" value="${month}">
						<input type="hidden" name="selectedDate" value="${selectedDate}">
						<div class="form-grid">
							<div class="form-group">
								<label>직원</label>
								<select name="storeEmployeeBno" required>
									<c:forEach var="emp" items="${employees}">
										<option value="${emp.store_member_id}" ${emp.store_member_id == editSchedule.store_employee_bno ? 'selected' : ''}>${emp.name} (${emp.member_id})</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>근무일</label>
								<input type="date" name="workDate" value="${editSchedule.work_date}" required>
							</div>
							<div class="form-group">
								<label>근무 파트</label>
								<select name="partBno" onchange="applyPart(this)">
									<option value="">직접 입력</option>
									<c:forEach var="part" items="${parts}">
										<option value="${part.bno}" data-start="${fn:substring(part.start_time,0,5)}" data-end="${fn:substring(part.end_time,0,5)}" ${part.bno == editSchedule.part_bno ? 'selected' : ''}>${part.part_name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>시작 시간</label>
								<input type="time" name="startTime" value="${fn:substring(editSchedule.start_time,0,5)}" required>
							</div>
							<div class="form-group">
								<label>종료 시간</label>
								<input type="time" name="endTime" value="${fn:substring(editSchedule.end_time,0,5)}" required>
							</div>
							<div class="form-group full">
								<label>메모</label>
								<textarea name="memo" maxlength="255"><c:out value="${editSchedule.memo}"/></textarea>
							</div>
						</div>
						<div class="form-actions">
							<button class="btn" type="submit">수정 저장</button>
							<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules?month=${month}&date=${selectedDate}">수정 취소</a>
						</div>
					</form>
				</div>
			</c:if>
		</div>
	</div>
</div>
<script>
	function applyPart(selectEl) {
		var form = selectEl.form;
		if (!form) return;
		var opt = selectEl.options[selectEl.selectedIndex];
		if (!opt || !opt.value) return;
		var start = opt.getAttribute('data-start');
		var end = opt.getAttribute('data-end');
		var startInput = form.querySelector('input[name=\"startTime\"]');
		var endInput = form.querySelector('input[name=\"endTime\"]');
		if (startInput && start) startInput.value = start;
		if (endInput && end) endInput.value = end;
	}
</script>
</body>
</html>

