<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어패밀리 메인</title>
<style>
	.main-wrap {
		max-width: 720px;
		margin: 30px auto;
		padding: 24px;
		border: 1px solid #ddd;
		border-radius: 8px;
	}
	.main-wrap h2 {
		margin-top: 0;
	}
	.btn {
		display: inline-block;
		margin-right: 8px;
		padding: 10px 14px;
		border: 1px solid #222;
		text-decoration: none;
		color: #222;
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
<div class="main-wrap">
	<h2>스토어패밀리</h2>
	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>
	<p>매장 운영과 직원 관리를 한 곳에서 진행하세요.</p>
	<p>
		<a class="btn" href="fill_all_list">채용 페이지</a>
		<a class="btn" href="${pageContext.request.contextPath}/store/register">매장 등록</a>
		<a class="btn" href="${pageContext.request.contextPath}/store/join">매장 가입</a>
		<c:if test="${sessionScope.position eq '사장'}">
			<a class="btn" href="${pageContext.request.contextPath}/store/my">내 매장</a>
		</c:if>
	</p>
</div>
</body>
</html>
