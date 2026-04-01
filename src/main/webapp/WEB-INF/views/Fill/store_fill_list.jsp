<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대타 요청 목록</title>
<style>
	:root { --bg:#f6f7fb; --card:#fff; --line:#e5e7eb; --text:#1f2937; --muted:#6b7280; --point:#1f6feb; }
	body { margin:0; background:var(--bg); color:var(--text); font-family:"GmarketSansTTFMedium","Malgun Gothic",sans-serif; }
	.wrap { max-width:1100px; margin:0 auto; padding:24px 16px 36px; }
	.top { display:flex; justify-content:space-between; align-items:center; gap:10px; margin-bottom:12px; }
	.title { margin:0; font-size:28px; }
	.sub { margin:6px 0 0; color:var(--muted); }
	.btn { display:inline-flex; align-items:center; justify-content:center; min-height:36px; border:1px solid var(--line); border-radius:10px; padding:8px 12px; text-decoration:none; color:var(--text); background:#fff; font-weight:700; font-size:13px; }
	.btn:hover { border-color:var(--point); color:var(--point); }
	.msg { margin:0 0 12px; padding:10px 12px; border-radius:10px; background:#eef4ff; color:#1f3f7f; }
	.list { display:grid; gap:10px; }
	.item { display:block; text-decoration:none; color:inherit; background:var(--card); border:1px solid var(--line); border-radius:12px; padding:12px; }
	.item:hover { border-color:var(--point); }
	.row { display:flex; justify-content:space-between; gap:10px; align-items:center; flex-wrap:wrap; }
	.name { font-size:18px; font-weight:700; }
	.meta { color:var(--muted); font-size:13px; margin-top:6px; display:flex; gap:14px; flex-wrap:wrap; }
	.badge { font-size:12px; font-weight:700; border-radius:999px; padding:4px 8px; }
	.s0 { background:#e8f7ee; color:#166534; }
	.s1 { background:#e7f0ff; color:#1d4ed8; }
	.s2 { background:#f3f4f6; color:#4b5563; }
	.s3 { background:#fff1f2; color:#9f1239; }
	.empty { background:var(--card); border:1px solid var(--line); border-radius:12px; padding:24px; color:var(--muted); }
	@media (max-width:720px){ .wrap{padding:16px 12px 24px;} .title{font-size:24px;} }
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<div>
			<h1 class="title">대타 요청 목록</h1>
			<p class="sub"><strong><c:out value="${myStore.store_name}"/></strong> (<c:out value="${myStore.store_code}"/>)</p>
		</div>
		<div>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}">매장 관리</a>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">스케줄 캘린더</a>
		</div>
	</div>

	<c:if test="${not empty message}"><div class="msg"><c:out value="${message}"/></div></c:if>

	<c:choose>
		<c:when test="${empty fills}">
			<div class="empty">등록된 대타 요청이 없습니다. 스케줄 상세에서 대타 요청을 생성해 주세요.</div>
		</c:when>
		<c:otherwise>
			<div class="list">
				<c:forEach var="fill" items="${fills}">
					<a class="item" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}">
						<div class="row">
							<div class="name"><c:out value="${fill.title}"/></div>
							<c:choose>
								<c:when test="${fill.chk == 0}"><span class="badge s0">모집중</span></c:when>
								<c:when test="${fill.chk == 1}"><span class="badge s1">승인완료</span></c:when>
								<c:when test="${fill.chk == 2}"><span class="badge s2">마감</span></c:when>
								<c:otherwise><span class="badge s3">취소</span></c:otherwise>
							</c:choose>
						</div>
						<div class="meta">
							<span>요청자: <c:out value="${fill.name}"/></span>
							<span>근무일: <c:out value="${fill.fill_day}"/></span>
							<span>근무시간: <c:out value="${fn:substring(fill.fill_start_time,0,5)}"/> ~ <c:out value="${fn:substring(fill.fill_end_time,0,5)}"/></span>
							<span>모집기간: <c:out value="${fill.apply_start_day}"/> ~ <c:out value="${fill.apply_end_day}"/></span>
							<span>지원자수: <c:out value="${fill.apply_su}"/>명</span>
						</div>
					</a>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>
