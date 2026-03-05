<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<style>
body { font-family: Arial, sans-serif; max-width: 560px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
a { display: inline-block; margin-right: 12px; margin-top: 12px; color: #0b57d0; text-decoration: none; }
</style>
</head>
<body>
	<div class="card">
		<h2>Sign Up</h2>
		<p>Select account type.</p>
		<a href="${pageContext.request.contextPath}/employee_join">Employee Sign Up</a>
		<a href="${pageContext.request.contextPath}/ceo_join">CEO Sign Up</a>
		<div style="margin-top:16px;">
			<a href="${pageContext.request.contextPath}/login">Back to Login</a>
		</div>
	</div>
</body>
</html>
