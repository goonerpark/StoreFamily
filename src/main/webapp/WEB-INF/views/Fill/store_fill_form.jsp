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
	body { margin:0; background:var(--bg); color:var(--text); font-family:"GmarketSansTTFMedium","Malgun Gothic",sans-serif; }
	.wrap { max-width:880px; margin:0 auto; padding:24px 16px 36px; }
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
	input, textarea { width:100%; border:1px solid var(--line); border-radius:8px; padding:8px 10px; font-family:inherit; font-size:14px; }
	textarea { min-height:120px; resize:vertical; }
	.meta { margin-bottom:10px; padding:10px; border-radius:10px; background:#f8fafc; border:1px solid var(--line); }
	@media (max-width:720px){ .grid{grid-template-columns:1fr;} .wrap{padding:16px 12px 24px;} }
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<h1 class="title">대타 요청 작성</h1>
		<div>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">내 스케줄로</a>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">대타 목록</a>
		</div>
	</div>

	<c:if test="${not empty message}"><div class="msg"><c:out value="${message}"/></div></c:if>

	<div class="card">
		<div class="meta">
			<div><strong>원본 스케줄</strong></div>
			<div>근무일: <c:out value="${schedule.work_date}"/></div>
			<div>근무시간: <c:out value="${fn:substring(schedule.start_time,0,5)}"/> ~ <c:out value="${fn:substring(schedule.end_time,0,5)}"/> <c:if test="${not empty schedule.part_name}">(<c:out value="${schedule.part_name}"/>)</c:if></div>
		</div>

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
			<div style="margin-top:10px; display:flex; gap:8px; flex-wrap:wrap;">
				<button class="btn" type="submit">요청 등록</button>
				<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/my-schedules">취소</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
