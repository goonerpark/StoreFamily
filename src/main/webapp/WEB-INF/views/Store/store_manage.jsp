<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 관리</title>
<style>
	.wrap { max-width: 720px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.menu { margin-top: 18px; }
	.menu a { display: inline-block; margin-right: 8px; margin-bottom: 8px; padding: 10px 14px; border: 1px solid #222; text-decoration: none; color: #222; }
	.info { margin-top: 14px; padding: 12px; border: 1px solid #ddd; background: #fafafa; }
</style>
</head>
<body>
<div class="wrap">
	<h2>매장 관리</h2>
	<p>매장명: ${myStore.store_name}</p>
	<p>매장 코드: ${myStore.store_code}</p>

	<div class="info">
		<p>주소: ${myStore.store_address}</p>
		<p>전화번호: ${myStore.store_phone}</p>
	</div>

	<div class="menu">
		<a href="${pageContext.request.contextPath}/store/approval?storeId=${myStore.store_id}">가입 승인 관리</a>
		<a href="${pageContext.request.contextPath}/store/employees?storeId=${myStore.store_id}">직원 리스트</a>
		<a href="${pageContext.request.contextPath}/store/my">내 매장 목록</a>
	</div>
</div>
</body>
</html>
