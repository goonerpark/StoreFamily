<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 승인 관리</title>
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
	.wrap { max-width: 1080px; margin: 0 auto; padding: 28px 20px 40px; }
	.card { background: var(--card); border: 1px solid var(--line); border-radius: 14px; padding: 16px; overflow-x: auto; }
	.page-header { margin-bottom: 14px; }
	.page-title { margin: 0; font-size: 30px; }
	.page-sub { margin-top: 8px; color: var(--muted); }
	.msg { margin-bottom: 12px; padding: 10px 12px; border-radius: 10px; background: #eef4ff; color: #1f3f7f; }
	table { width: 100%; border-collapse: collapse; min-width: 760px; }
	th, td { border-bottom: 1px solid var(--line); padding: 12px 10px; text-align: left; font-size: 14px; }
	th { color: var(--muted); font-size: 13px; background: #fafbfe; }
	.actions { display: flex; gap: 8px; }
	.actions button { min-height: 34px; padding: 6px 10px; border: 1px solid var(--line); border-radius: 8px; background: #fff; cursor: pointer; font-weight: 700; }
	.actions button:hover { border-color: var(--point); color: var(--point); }
	.empty { padding: 24px 6px; color: var(--muted); }
	@media (max-width: 760px) {
		.wrap { padding: 18px 14px 26px; }
		.page-title { font-size: 26px; }
	}
</style>
</head>
<body>
<div class="wrap">
	<div class="page-header">
		<h1 class="page-title">가입 승인 관리</h1>
		<div class="page-sub">
			<strong><c:out value="${myStore.store_name}"/></strong>
			(<c:out value="${myStore.store_code}"/>)
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<div class="card">
		<c:choose>
			<c:when test="${empty pendingRequests}">
				<div class="empty">현재 승인 대기 중인 요청이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<table>
					<thead>
					<tr>
						<th>이름</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>요청일</th>
						<th>처리</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="req" items="${pendingRequests}">
						<tr>
							<td><c:out value="${req.name}"/></td>
							<td><c:out value="${req.email}"/></td>
							<td><c:out value="${req.phone}"/></td>
							<td><c:out value="${req.created_at}"/></td>
							<td>
								<div class="actions">
									<form action="${pageContext.request.contextPath}/store/approval/approve" method="post">
										<input type="hidden" name="storeId" value="${myStore.store_id}">
										<input type="hidden" name="storeMemberId" value="${req.store_member_id}">
										<button type="submit">승인</button>
									</form>
									<form action="${pageContext.request.contextPath}/store/approval/reject" method="post">
										<input type="hidden" name="storeId" value="${myStore.store_id}">
										<input type="hidden" name="storeMemberId" value="${req.store_member_id}">
										<button type="submit" onclick="return confirm('해당 가입 요청을 거절하시겠습니까?');">거절</button>
									</form>
								</div>
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
