<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<style>
body { font-family: Arial, sans-serif; max-width: 680px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
.error { color: #b00020; }
a { color: #0b57d0; text-decoration: none; }
</style>
</head>
<body>
	<div class="card">
		<h2>Request Failed</h2>
		<p class="error">${errorMessage}</p>
		<p><a href="${pageContext.request.contextPath}/login">Go to login</a></p>
	</div>
</body>
</html>
