<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 등록</title>
<style>
	.store-wrap { max-width: 900px; margin: 30px auto; padding: 24px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
	.store-wrap h2 { margin: 0 0 18px; }
	.form-row { margin-bottom: 14px; }
	.form-row label { display: block; margin-bottom: 6px; font-weight: 700; }
	.form-row input { width: 100%; height: 38px; padding: 0 10px; box-sizing: border-box; }
	.msg { margin-bottom: 14px; padding: 10px; border-radius: 6px; background: #f6f6f6; }
	.info-box { margin-top: 18px; padding: 12px; border: 1px solid #ddd; background: #fafafa; }
	.btn-row { margin-top: 20px; }
	.btn-row button { height: 40px; padding: 0 18px; cursor: pointer; }
	table { width: 100%; border-collapse: collapse; margin-top: 10px; }
	th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
	th { background: #f2f2f2; }
	.link-btn { display: inline-block; padding: 6px 10px; border: 1px solid #222; text-decoration: none; color: #222; }
</style>
</head>
<body>
<div class="store-wrap">
	<h2>매장 등록</h2>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<form action="${pageContext.request.contextPath}/store/register" method="post">
		<div class="form-row">
			<label for="store_name">매장명</label>
			<input type="text" id="store_name" name="store_name" value="${storeForm.store_name}" required>
		</div>
		<div class="form-row">
			<label for="store_address">매장 주소</label>
			<input type="text" id="store_address" name="store_address" value="${storeForm.store_address}" required>
		</div>
		<div class="form-row">
			<label for="store_phone">매장 전화번호</label>
			<input type="text" id="store_phone" name="store_phone" value="${storeForm.store_phone}" required>
		</div>
		<div class="btn-row">
			<button type="submit">매장 등록하기</button>
		</div>
	</form>

	<c:if test="${not empty myStores}">
		<div class="info-box">
			<h3>내가 등록한 매장</h3>
			<table>
				<thead>
				<tr>
					<th>매장명</th>
					<th>매장 코드</th>
					<th>주소</th>
					<th>관리</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="store" items="${myStores}">
					<tr>
						<td>${store.store_name}</td>
						<td>${store.store_code}</td>
						<td>${store.store_address}</td>
						<td>
							<a class="link-btn" href="${pageContext.request.contextPath}/store/manage?storeId=${store.store_id}">관리하기</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
</div>
</body>
</html>
