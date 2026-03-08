<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
body { font-family: Arial, sans-serif; max-width: 560px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
.row { margin-bottom: 12px; }
label { display: block; font-weight: 600; margin-bottom: 4px; }
input { width: 100%; padding: 8px; box-sizing: border-box; }
.error { color: #b00020; font-size: 13px; }
.actions { margin-top: 16px; }
a { color: #0b57d0; text-decoration: none; }
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

			<div class="actions">
				<button type="submit">로그인</button>
			</div>
		</form:form>

		<p>
			회원이 아니신가요? <a href="${pageContext.request.contextPath}/join">회원가입</a>
		</p>
	</div>
</body>
</html>
