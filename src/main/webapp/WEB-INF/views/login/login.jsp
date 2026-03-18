<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
body { margin: 0; font-family: "Pretendard", "Noto Sans KR", sans-serif; background: #fff9f4; }
.card { border: 1px solid #ddd; border-radius: 12px; padding: 24px; max-width: 560px; margin: 32px auto; background: #fff; }
.row { margin-bottom: 12px; }
label { display: block; font-weight: 600; margin-bottom: 4px; }
input { width: 100%; padding: 8px; box-sizing: border-box; }
.error { color: #b00020; font-size: 13px; }
.actions-row { margin-top: 16px; }
</style>
</head>
<body>
	<div class="card">
		<h2>스토어패밀리 로그인</h2>

		<form:form modelAttribute="loginRequest" method="post" action="${pageContext.request.contextPath}/login">
			<form:errors cssClass="error" />

			<div class="row">
				<label for="id">아이디</label>
				<form:input path="id" id="id" />
				<form:errors path="id" cssClass="error" />
			</div>

			<div class="row">
				<label for="pwd">비밀번호</label>
				<form:password path="pwd" id="pwd" />
				<form:errors path="pwd" cssClass="error" />
			</div>

			<div class="actions-row">
				<button type="submit" class="btn btn-dark">로그인</button>
			</div>
		</form:form>

		<p>회원이 아니신가요? <a href="${pageContext.request.contextPath}/signup">회원가입</a></p>
	</div>
</body>
</html>
