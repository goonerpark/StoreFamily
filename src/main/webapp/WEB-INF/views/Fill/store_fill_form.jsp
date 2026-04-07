<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대타 요청 작성</title>
<style>
	:root { --bg:#f6f7fb; --card:#fff; --line:#e5e7eb; --text:#1f2937; --muted:#6b7280; --point:#1f6feb; }
	body { margin:0; background:var(--bg); color:var(--text); font-family:"Malgun Gothic",sans-serif; }
	.wrap { max-width:900px; margin:0 auto; padding:24px 16px 36px; }
	.top { display:flex; justify-content:space-between; align-items:center; gap:10px; flex-wrap:wrap; margin-bottom:12px; }
	.title { margin:0; font-size:27px; }
	.btn { display:inline-flex; align-items:center; justify-content:center; min-height:36px; border:1px solid var(--line); border-radius:10px; padding:8px 12px; text-decoration:none; color:var(--text); background:#fff; font-weight:700; font-size:13px; }
	.btn:hover { border-color:var(--point); color:var(--point); }
	.msg { margin:0 0 12px; padding:10px 12px; border-radius:10px; background:#eef4ff; color:#1f3f7f; }
	.card { background:var(--card); border:1px solid var(--line); border-radius:14px; padding:14px; }
	.grid { display:grid; grid-template-columns:1fr 1fr; gap:10px; }
	.group { display:grid; gap:6px; }
	.group.full { grid-column:1 / -1; }
	label { color:var(--muted); font-size:13px; }
	input, textarea, select { width:100%; border:1px solid var(--line); border-radius:8px; padding:8px 10px; font-family:inherit; font-size:14px; box-sizing:border-box; }
	textarea { min-height:120px; resize:vertical; }
	.meta { margin-bottom:10px; padding:10px; border-radius:10px; background:#f8fafc; border:1px solid var(--line); }
	.help { color:var(--muted); font-size:12px; }
	.action { margin-top:10px; display:flex; gap:8px; flex-wrap:wrap; }
	.hidden { display:none; }
	@media (max-width:720px){ .grid{grid-template-columns:1fr;} .wrap{padding:16px 12px 24px;} }
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<h1 class="title">
			<c:choose>
				<c:when test="${isDirect}">사장 직접 모집글 작성</c:when>
				<c:otherwise>스케줄 기반 대타 요청 작성</c:otherwise>
			</c:choose>
		</h1>
		<div>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">대타 목록</a>
			<c:choose>
				<c:when test="${isDirect}">
					<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">스케줄로</a>
				</c:when>
				<c:otherwise>
					<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">내 스케줄로</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<c:if test="${not empty message}"><div class="msg"><c:out value="${message}"/></div></c:if>

	<div class="card">
		<c:if test="${not isDirect}">
			<div class="meta">
				<div><strong>원본 스케줄</strong></div>
				<div>근무일: <c:out value="${schedule.work_date}"/></div>
				<div>근무시간: <c:out value="${fn:substring(schedule.start_time,0,5)}"/> ~ <c:out value="${fn:substring(schedule.end_time,0,5)}"/>
					<c:if test="${not empty schedule.part_name}">(<c:out value="${schedule.part_name}"/>)</c:if>
				</div>
			</div>
		</c:if>

		<c:choose>
			<c:when test="${isDirect}">
				<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/new" id="directFillForm">
					<div class="grid">
						<div class="group full">
							<label>제목</label>
							<input type="text" name="title" maxlength="120" required>
						</div>
						<div class="group full">
							<label>내용</label>
							<textarea name="content" maxlength="1000" required></textarea>
						</div>
						<div class="group">
							<label>근무 날짜</label>
							<input type="date" name="fillDay" value="${defaultFillDay}" required>
						</div>
						<div class="group">
							<label>근무 파트</label>
							<select name="partBno" id="partBno">
								<option value="">직접 입력</option>
								<c:forEach var="part" items="${scheduleParts}">
									<option value="${part.bno}" data-start="${part.start_time}" data-end="${part.end_time}">
										<c:out value="${part.part_name}"/> (<c:out value="${part.start_time}"/>~<c:out value="${part.end_time}"/>)
									</option>
								</c:forEach>
							</select>
						</div>
						<div class="group">
							<label>시작 시간</label>
							<input type="time" name="startTime" id="startTime" required>
						</div>
						<div class="group">
							<label>종료 시간</label>
							<input type="time" name="endTime" id="endTime" required>
						</div>
						<div class="group">
							<label>모집 시작일</label>
							<input type="date" name="applyStartDay" value="${defaultApplyStart}" required>
						</div>
						<div class="group">
							<label>모집 종료일</label>
							<input type="date" name="applyEndDay" value="${defaultApplyEnd}" required>
						</div>
					</div>
					<div class="help">근무 파트를 선택하면 시작/종료 시간이 자동 입력됩니다. 직접 입력일 경우 시간만 저장되고 타임 이름은 표시되지 않습니다.</div>
					<div class="action">
						<button class="btn" type="submit">요청 등록</button>
						<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">취소</a>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/${schedule.bno}/fill/new">
					<div class="grid">
						<div class="group full">
							<label>제목</label>
							<input type="text" name="title" maxlength="120" required>
						</div>
						<div class="group full">
							<label>내용</label>
							<textarea name="content" maxlength="1000" required></textarea>
						</div>
						<div class="group">
							<label>모집 시작일</label>
							<input type="date" name="applyStartDay" value="${defaultApplyStart}" required>
						</div>
						<div class="group">
							<label>모집 종료일</label>
							<input type="date" name="applyEndDay" value="${defaultApplyEnd}" required>
						</div>
					</div>
					<div class="action">
						<button class="btn" type="submit">요청 등록</button>
						<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">취소</a>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</div>

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
</body>
</html>
