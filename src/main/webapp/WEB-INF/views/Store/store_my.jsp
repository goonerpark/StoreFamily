<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 매장</title>
<style>
	.wrap { max-width: 1080px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.msg { margin-bottom: 14px; padding: 10px; border-radius: 6px; background: #f6f6f6; }
	table { width: 100%; border-collapse: collapse; margin-top: 16px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background: #f2f2f2; }
	.link-btn { display: inline-block; padding: 6px 10px; border: 1px solid #222; text-decoration: none; color: #222; }
	.filter { display: flex; gap: 8px; align-items: center; margin-top: 12px; }
	.filter input, .filter select { height: 36px; padding: 0 10px; box-sizing: border-box; }
	.filter button { height: 36px; padding: 0 12px; cursor: pointer; }
</style>
</head>
<body>
<div class="wrap">
	<h2>내 매장</h2>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<form class="filter" action="${pageContext.request.contextPath}/store/my" method="get">
		<input type="text" name="q" value="${q}" placeholder="매장명, 코드, 주소 검색">
		<select name="sort">
			<option value="latest" ${sort eq 'latest' ? 'selected' : ''}>최신 등록순</option>
			<option value="name_asc" ${sort eq 'name_asc' ? 'selected' : ''}>매장명 오름차순</option>
			<option value="name_desc" ${sort eq 'name_desc' ? 'selected' : ''}>매장명 내림차순</option>
		</select>
		<button type="submit">적용</button>
	</form>

	<c:choose>
		<c:when test="${empty myStores}">
			<p>조건에 맞는 매장이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table>
				<thead>
				<tr>
					<th>매장명</th>
					<th>매장 코드</th>
					<th>주소</th>
					<th>전화번호</th>
					<th>관리</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="store" items="${myStores}">
					<tr>
						<td>${store.store_name}</td>
						<td>${store.store_code}</td>
						<td>${store.store_address}</td>
						<td>${store.store_phone}</td>
						<td>
							<a class="link-btn" href="${pageContext.request.contextPath}/store/manage?storeId=${store.store_id}">매장 관리</a>
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
