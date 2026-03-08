<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body { font-family: Arial, sans-serif; max-width: 560px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
a { display: inline-block; margin-right: 12px; margin-top: 12px; color: #0b57d0; text-decoration: none; }
</style>
</head>
<body>
	<div class="card">
		<h2>회원가입</h2>
		<p>회원가입은 공통으로 진행되며, 로그인 후 매장 등록 또는 매장 가입으로 역할이 결정됩니다.</p>
		<a href="${pageContext.request.contextPath}/join">회원가입 하러가기</a>
		<div style="margin-top:16px;">
			<a href="${pageContext.request.contextPath}/login">로그인으로 돌아가기</a>
		</div>
	</div>
</body>
</html>
