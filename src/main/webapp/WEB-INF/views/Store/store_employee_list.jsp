<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 리스트</title>
<style>
	:root {
		--bg: #f6f7fb;
		--card: #ffffff;
		--line: #e4e7ec;
		--text: #1f2937;
		--muted: #6b7280;
		--point: #1f6feb;
	}
	* { box-sizing: border-box; }
	body { margin: 0; background: var(--bg); color: var(--text); font-family: "GmarketSansTTFMedium", "Malgun Gothic", sans-serif; }
	.wrap { max-width: 1160px; margin: 0 auto; padding: 28px 20px 40px; }
	.card { background: var(--card); border: 1px solid var(--line); border-radius: 14px; }
	.page-header { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 16px; }
	.page-title { margin: 0; font-size: 30px; }
	.page-sub { margin-top: 8px; color: var(--muted); }
	.msg { margin-bottom: 12px; padding: 10px 12px; border-radius: 10px; background: #eef4ff; color: #1f3f7f; }
	.table-card { padding: 16px; overflow-x: auto; }
	table { width: 100%; border-collapse: collapse; min-width: 860px; }
	th, td { border-bottom: 1px solid var(--line); padding: 12px 10px; text-align: left; font-size: 14px; }
	th { color: var(--muted); font-size: 13px; background: #fafbfe; }
	.name-link { color: var(--point); text-decoration: none; font-weight: 700; }
	.name-link:hover { text-decoration: underline; }
	.badge { display: inline-flex; align-items: center; justify-content: center; padding: 4px 8px; border-radius: 999px; font-size: 12px; font-weight: 700; }
	.badge.on { background: #e8f7ec; color: #136a2f; }
	.badge.off { background: #fff3cd; color: #8a6d1a; }
	.detail-btn { display: inline-flex; align-items: center; justify-content: center; min-height: 34px; padding: 6px 10px; border: 1px solid var(--line); border-radius: 8px; color: var(--text); text-decoration: none; font-weight: 700; }
	.detail-btn:hover { border-color: var(--point); color: var(--point); }
	.empty { padding: 28px 6px; color: var(--muted); }
	@media (max-width: 760px) {
		.wrap { padding: 18px 14px 26px; }
		.page-header { flex-direction: column; align-items: stretch; }
		.page-title { font-size: 26px; }
	}
</style>
</head>
<body>
<div class="wrap">
	<div class="page-header">
		<div>
			<h1 class="page-title">직원 리스트</h1>
			<div class="page-sub">
				<strong><c:out value="${myStore.store_name}"/></strong>
				(<c:out value="${myStore.store_code}"/>)
			</div>
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<div class="card table-card">
		<c:choose>
			<c:when test="${empty employees}">
				<div class="empty">현재 승인된 직원이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<table>
					<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>직책</th>
						<th>상태</th>
						<th>등록일</th>
						<th>상세</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="emp" items="${employees}">
						<tr>
							<td>
								<a class="name-link" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees/${emp.member_bno}">
									<c:out value="${emp.name}"/>
								</a>
							</td>
							<td><c:out value="${emp.member_id}"/></td>
							<td><c:out value="${emp.email}"/></td>
							<td><c:out value="${emp.phone}"/></td>
							<td><c:out value="${emp.position}"/></td>
							<td>
								<c:choose>
									<c:when test="${emp.chk == 1}">
										<span class="badge on">승인 완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge off">승인 대기</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td><c:out value="${emp.created_at}"/></td>
							<td>
								<a class="detail-btn" href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees/${emp.member_bno}">상세 보기</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</body>
</html>
