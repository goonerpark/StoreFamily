<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대타 요청 상세</title>
<style>
	:root { --bg:#f6f7fb; --card:#fff; --line:#e5e7eb; --text:#1f2937; --muted:#6b7280; --point:#1f6feb; --danger:#be123c; }
	body { margin:0; background:var(--bg); color:var(--text); font-family:"Malgun Gothic",sans-serif; }
	.wrap { max-width:1100px; margin:0 auto; padding:24px 16px 36px; }
	.top { display:flex; justify-content:space-between; align-items:center; gap:10px; flex-wrap:wrap; margin-bottom:12px; }
	.title { margin:0; font-size:27px; }
	sub { color:var(--muted); }
	.btn { display:inline-flex; align-items:center; justify-content:center; min-height:36px; border:1px solid var(--line); border-radius:10px; padding:8px 12px; text-decoration:none; color:var(--text); background:#fff; font-weight:700; font-size:13px; cursor:pointer; }
	.btn:hover { border-color:var(--point); color:var(--point); }
	.btn-danger { border-color:#f8c9d5; color:var(--danger); }
	.btn-danger:hover { border-color:var(--danger); color:var(--danger); }
	.msg { margin:0 0 12px; padding:10px 12px; border-radius:10px; background:#eef4ff; color:#1f3f7f; }
	.card { background:var(--card); border:1px solid var(--line); border-radius:14px; padding:14px; margin-bottom:12px; }
	.grid { display:grid; grid-template-columns: 1fr 1fr; gap:10px; }
	.row { display:flex; gap:8px; }
	.label { width:100px; color:var(--muted); flex-shrink:0; }
	.value { flex:1; }
	.content { white-space:pre-wrap; line-height:1.5; }
	.actions { display:flex; gap:8px; flex-wrap:wrap; margin-top:10px; }
	.badge { font-size:12px; font-weight:700; border-radius:999px; padding:4px 8px; }
	.s0 { background:#e8f7ee; color:#166534; }
	.s1 { background:#e7f0ff; color:#1d4ed8; }
	.s2 { background:#f3f4f6; color:#4b5563; }
	.s3 { background:#fff1f2; color:#9f1239; }
	.table { width:100%; border-collapse:collapse; }
	.table th,.table td { border-bottom:1px solid var(--line); padding:10px 8px; text-align:left; font-size:14px; }
	.table th { color:var(--muted); font-weight:700; }
	.inline { display:inline; margin:0; }
	@media (max-width:820px){ .grid{grid-template-columns:1fr;} .wrap{padding:16px 12px 24px;} }
</style>
</head>
<body>
<div class="wrap">
	<div class="top">
		<div>
			<h1 class="title">대타 요청 상세</h1>
			<div><strong><c:out value="${myStore.store_name}"/></strong></div>
		</div>
		<div>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills">목록으로</a>
			<a class="btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/schedules">스케줄로</a>
		</div>
	</div>

	<c:if test="${not empty message}"><div class="msg"><c:out value="${message}"/></div></c:if>

	<div class="card">
		<div class="top" style="margin-bottom:8px;">
			<h2 style="margin:0;"><c:out value="${fill.title}"/></h2>
			<c:choose>
				<c:when test="${fill.chk == 0}"><span class="badge s0">모집중</span></c:when>
				<c:when test="${fill.chk == 1}"><span class="badge s1">승인완료</span></c:when>
				<c:when test="${fill.chk == 2}"><span class="badge s2">마감</span></c:when>
				<c:otherwise><span class="badge s3">취소</span></c:otherwise>
			</c:choose>
		</div>
		<div class="grid">
			<div class="row"><div class="label">요청자</div><div class="value"><c:out value="${fill.name}"/> (<c:out value="${fill.id}"/>)</div></div>
			<div class="row"><div class="label">근무일</div><div class="value"><c:out value="${fill.fill_day}"/></div></div>
			<div class="row"><div class="label">근무시간</div><div class="value"><c:out value="${fn:substring(fill.fill_start_time,0,5)}"/> ~ <c:out value="${fn:substring(fill.fill_end_time,0,5)}"/>
				<c:if test="${not empty fill.fill_di_time}">(<c:out value="${fill.fill_di_time}"/>)</c:if>
			</div></div>
			<div class="row"><div class="label">모집기간</div><div class="value"><c:out value="${fill.apply_start_day}"/> ~ <c:out value="${fill.apply_end_day}"/></div></div>
			<div class="row"><div class="label">지원자 수</div><div class="value"><c:out value="${fill.apply_su}"/>명</div></div>
			<div class="row"><div class="label">원본 스케줄</div><div class="value">
				<c:choose>
					<c:when test="${fill.schedule_bno != null and fill.schedule_bno > 0}">
						#<c:out value="${fill.schedule_bno}"/>
						<c:if test="${not empty fill.schedule_member_name}">
							/ <c:out value="${fill.schedule_member_name}"/> (<c:out value="${fill.schedule_member_id}"/>)
						</c:if>
					</c:when>
					<c:otherwise>사장 직접 모집글</c:otherwise>
				</c:choose>
			</div></div>
		</div>
		<div class="card" style="margin:10px 0 0; padding:10px;">
			<div class="content"><c:out value="${fill.content}"/></div>
		</div>

		<div class="actions">
			<c:if test="${canApply}">
				<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/apply">
					<button class="btn" type="submit">지원하기</button>
				</form>
			</c:if>
			<c:if test="${hasPendingMyApply}">
				<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/apply/cancel">
					<button class="btn btn-danger" type="submit" onclick="return confirm('지원을 취소할까요?');">지원 취소</button>
				</form>
			</c:if>
			<c:if test="${canManage and fill.chk == 0}">
				<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/close">
					<button class="btn btn-danger" type="submit" onclick="return confirm('이 요청을 마감할까요?');">요청 마감</button>
				</form>
			</c:if>
			<c:if test="${canCancelFill}">
				<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/cancel">
					<button class="btn btn-danger" type="submit" onclick="return confirm('요청을 취소할까요?');">요청 취소</button>
				</form>
			</c:if>
		</div>
	</div>

	<c:if test="${showApplyList}">
		<div class="card">
			<h3 style="margin-top:0;">지원자 목록</h3>
			<c:choose>
				<c:when test="${empty applies}">
					<div style="color:var(--muted);">아직 지원자가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<table class="table">
						<thead>
							<tr>
								<th>지원자</th>
								<th>연락처</th>
								<th>상태</th>
								<c:if test="${canManage and fill.chk == 0}"><th>처리</th></c:if>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="ap" items="${applies}">
							<tr>
								<td><c:out value="${ap.m_name}"/> (<c:out value="${ap.id}"/>)</td>
								<td><c:out value="${ap.applicant_phone}"/></td>
								<td>
									<c:choose>
										<c:when test="${ap.chk == 0}"><span class="badge s0">지원대기</span></c:when>
										<c:when test="${ap.chk == 1}"><span class="badge s1">승인</span></c:when>
										<c:when test="${ap.chk == 2}"><span class="badge s2">거절</span></c:when>
										<c:otherwise><span class="badge s3">지원취소</span></c:otherwise>
									</c:choose>
								</td>
								<c:if test="${canManage and fill.chk == 0}">
								<td>
									<c:if test="${ap.chk == 0}">
										<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/applications/${ap.bno}/approve">
											<button class="btn" type="submit">승인</button>
										</form>
										<form class="inline" method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/fills/${fill.bno}/applications/${ap.bno}/reject">
											<button class="btn btn-danger" type="submit">거절</button>
										</form>
									</c:if>
								</td>
								</c:if>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</c:if>
</div>
</body>
</html>
