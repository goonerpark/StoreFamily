<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 가입 요청</title>
<style>
	.join-wrap {
		max-width: 640px;
		margin: 30px auto;
		padding: 24px;
		border: 1px solid #ddd;
		border-radius: 8px;
		background: #fff;
	}
	.join-wrap h2 {
		margin: 0 0 18px;
	}
	.row {
		margin-bottom: 14px;
	}
	label {
		display: block;
		margin-bottom: 6px;
		font-weight: 700;
	}
	input {
		width: 100%;
		height: 40px;
		padding: 0 10px;
		box-sizing: border-box;
	}
	.btn-row {
		margin-top: 18px;
	}
	button {
		height: 40px;
		padding: 0 16px;
		cursor: pointer;
	}
	.msg {
		margin-bottom: 14px;
		padding: 10px;
		border-radius: 6px;
		background: #f6f6f6;
	}
</style>
</head>
<body>
<div class="join-wrap">
	<h2>매장 가입 요청</h2>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<form action="${pageContext.request.contextPath}/store/join" method="post">
		<div class="row">
			<label for="storeCode">매장 코드</label>
			<input type="text" id="storeCode" name="storeCode" value="${storeCode}" placeholder="매장 코드를 입력해 주세요." required>
		</div>
		<div class="btn-row">
			<button type="submit">가입 요청하기</button>
		</div>
	</form>
</div>
</body>
</html>
