<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무 파트 관리</title>
<style>
	:root { --bg:#f6f7fb; --card:#fff; --line:#e4e7ec; --text:#1f2937; --muted:#6b7280; --point:#1f6feb; --danger:#d1242f; }
	* { box-sizing: border-box; }
	body { margin:0; background:var(--bg); color:var(--text); font-family:"GmarketSansTTFMedium","Malgun Gothic",sans-serif; }
	.wrap { max-width:1160px; margin:0 auto; padding:24px 18px 32px; }
	.top { display:flex; justify-content:space-between; align-items:center; gap:8px; margin-bottom:12px; }
	.btn { display:inline-flex; align-items:center; justify-content:center; min-height:36px; border:1px solid var(--line); border-radius:9px; padding:8px 12px; text-decoration:none; color:var(--text); background:#fff; font-weight:700; font-size:13px; cursor:pointer; }
	.btn:hover { border-color:var(--point); color:var(--point); }
	.btn-danger { border-color:#f4c4c8; color:var(--danger); }
	.msg { margin-bottom:12px; padding:10px 12px; border-radius:10px; background:#eef4ff; color:#1f3f7f; }
	.card { background:var(--card); border:1px solid var(--line); border-radius:14px; padding:14px; }
	.part-list { display:grid; gap:10px; }
	.part-item { border:1px solid var(--line); border-radius:10px; padding:10px; }
	.part-grid { display:grid; grid-template-columns:2fr 1fr 1fr 1fr 1fr auto; gap:8px; align-items:end; }
	label { display:grid; gap:5px; color:var(--muted); font-size:12px; }
	input { width:100%; border:1px solid var(--line); border-radius:8px; padding:7px 9px; font-family:inherit; font-size:13px; }
	.actions { display:flex; gap:6px; }
	.new-form { margin-top:14px; display:grid; gap:8px; grid-template-columns:2fr 1fr 1fr 1fr 1fr auto; align-items:end; }
	@media (max-width:1000px) { .part-grid, .new-form { grid-template-columns:1fr 1fr; } }
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<h1>근무 파트 관리</h1>
		<div>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">스케줄 캘린더</a>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}">매장 관리</a>
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="msg"><c:out value="${message}"/></div>
	</c:if>

	<div class="card">
		<div class="part-list">
			<c:forEach var="part" items="${parts}">
				<form class="part-item" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/parts/${part.bno}">
					<div class="part-grid">
						<label>파트명<input name="partName" value="${part.part_name}" required></label>
						<label>시작시간<input type="time" name="startTime" value="${part.start_time}" required></label>
						<label>종료시간<input type="time" name="endTime" value="${part.end_time}" required></label>
						<label>색상<input type="color" name="colorCode" value="${empty part.color_code ? '#1f6feb' : part.color_code}"></label>
						<label>정렬<input type="number" name="sortOrder" value="${part.sort_order}" min="1"></label>
						<div class="actions">
							<button class="btn" type="submit">수정</button>
							<button class="btn btn-danger" type="submit" formaction="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/parts/${part.bno}/delete" onclick="return confirm('파트를 삭제할까요? 연결된 스케줄은 직접입력으로 유지됩니다.');">삭제</button>
						</div>
					</div>
				</form>
			</c:forEach>
			<c:if test="${empty parts}">
				<div class="part-item">등록된 근무 파트가 없습니다.</div>
			</c:if>
		</div>

		<form class="new-form" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedule/parts">
			<label>파트명<input name="partName" placeholder="예: 오픈" required></label>
			<label>시작시간<input type="time" name="startTime" required></label>
			<label>종료시간<input type="time" name="endTime" required></label>
			<label>색상<input type="color" name="colorCode" value="#1f6feb"></label>
			<label>정렬<input type="number" name="sortOrder" min="1" placeholder="1"></label>
			<button class="btn" type="submit">새 파트 추가</button>
		</form>
	</div>
</div>
</body>
</html>
