<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 상세 정보</title>
<style>
	.wrap { max-width: 720px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.row { margin-bottom: 10px; }
	.label { display: inline-block; width: 140px; font-weight: 700; }
	.btn { display: inline-block; margin-top: 14px; padding: 8px 12px; border: 1px solid #222; text-decoration: none; color: #222; }
</style>
</head>
<body>
<div class="wrap">
	<h2>직원 상세 정보</h2>
	<p>매장명: ${myStore.store_name}</p>

	<div class="row"><span class="label">이름</span>${employee.name}</div>
	<div class="row"><span class="label">이메일</span>${employee.email}</div>
	<div class="row"><span class="label">전화번호</span>${employee.phone}</div>
	<div class="row"><span class="label">입사일</span>${employee.employment}</div>
	<div class="row"><span class="label">보건증 만료일</span>${employee.health}</div>
	<div class="row"><span class="label">시급</span>${employee.rate}</div>

	<a class="btn" href="${pageContext.request.contextPath}/store/employees?storeId=${myStore.store_id}">직원 리스트로 돌아가기</a>
</div>
</body>
</html>
