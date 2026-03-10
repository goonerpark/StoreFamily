<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입승인관리</title>
<style>
	.wrap { max-width: 1080px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	table { width: 100%; border-collapse: collapse; margin-top: 16px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background: #f2f2f2; }
	.link-btn { display: inline-block; padding: 6px 10px; border: 1px solid #222; text-decoration: none; color: #222; }
</style>
</head>
<body>
<div class="wrap">
	<h2>가입승인관리</h2>
	<p>승인 관리를 진행할 매장을 선택해 주세요.</p>

	<table>
		<thead>
		<tr>
			<th>매장명</th>
			<th>매장 코드</th>
			<th>주소</th>
			<th>이동</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="store" items="${myStores}">
			<tr>
				<td>${store.store_name}</td>
				<td>${store.store_code}</td>
				<td>${store.store_address}</td>
				<td>
					<a class="link-btn" href="${pageContext.request.contextPath}/store/approval?storeId=${store.store_id}">가입 승인 관리</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>
