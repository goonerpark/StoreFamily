<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 리스트</title>
<style>
	.wrap { max-width: 1080px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.msg { margin-bottom: 14px; padding: 10px; border-radius: 6px; background: #f6f6f6; }
	table { width: 100%; border-collapse: collapse; margin-top: 16px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background: #f2f2f2; }
	.link-btn { display: inline-block; padding: 6px 10px; border: 1px solid #222; text-decoration: none; color: #222; }
	.top-actions { margin-top: 12px; }
	.top-actions a { display: inline-block; padding: 8px 12px; border: 1px solid #222; text-decoration: none; color: #222; }
</style>
</head>
<body>
<div class="wrap">
	<h2>직원 리스트</h2>
	<p>매장명: ${myStore.store_name}</p>
	<p>매장 코드: ${myStore.store_code}</p>

	<div class="top-actions">
		<a href="${pageContext.request.contextPath}/store/manage?storeId=${myStore.store_id}">매장 관리로 돌아가기</a>
	</div>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<c:choose>
		<c:when test="${empty employees}">
			<p>승인된 직원이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table>
				<thead>
				<tr>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>입사일</th>
					<th>보건증 만료일</th>
					<th>시급</th>
					<th>상세</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="emp" items="${employees}">
					<tr>
						<td>${emp.name}</td>
						<td>${emp.email}</td>
						<td>${emp.phone}</td>
						<td>
							<c:choose>
								<c:when test="${not empty emp.employment}">${emp.employment}</c:when>
								<c:otherwise>${emp.created_at}</c:otherwise>
							</c:choose>
						</td>
						<td>${emp.health}</td>
						<td>${emp.rate}</td>
						<td>
							<a class="link-btn" href="${pageContext.request.contextPath}/store/employees/detail?storeId=${myStore.store_id}&storeMemberId=${emp.store_member_id}">보기</a>
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
