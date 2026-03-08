<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 승인 관리</title>
<style>
	.wrap { max-width: 1080px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.msg { margin-bottom: 14px; padding: 10px; border-radius: 6px; background: #f6f6f6; }
	table { width: 100%; border-collapse: collapse; margin-top: 16px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background: #f2f2f2; }
	.actions { display: flex; gap: 8px; justify-content: center; }
	.actions button { padding: 6px 10px; cursor: pointer; }
	.top-actions { margin-top: 12px; }
	.top-actions a { display: inline-block; padding: 8px 12px; border: 1px solid #222; text-decoration: none; color: #222; }
</style>
</head>
<body>
<div class="wrap">
	<h2>가입 승인 관리</h2>
	<p>매장명: ${myStore.store_name}</p>
	<p>매장 코드: ${myStore.store_code}</p>

	<div class="top-actions">
		<a href="${pageContext.request.contextPath}/store/manage?storeId=${myStore.store_id}">매장 관리로 돌아가기</a>
	</div>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<c:choose>
		<c:when test="${empty pendingRequests}">
			<p>현재 승인 대기 중인 요청이 없습니다.</p>
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
						<td>${req.name}</td>
						<td>${req.email}</td>
						<td>${req.phone}</td>
						<td>${req.created_at}</td>
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
</body>
</html>
