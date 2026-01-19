<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<script src="resources/js/jquery-3.7.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<style>
	body {
		margin: 0px;
	}
	
	#head_up {
		width: 100%;
		height: 70px;
		position: relative;
		top: -5px;
	}
	
	#store_change {
		margin-left: 800px;
	}
	
	#logout {
		margin-left: 20px;
	}
	
	.hr_solid {
		border : 0px;
	  	border-top: 2px solid #F1EFE7;
	  	margin-bottom: 0px;
	}
</style>

<script>
	function main()
	{
		location.href="home";
	}
	
	function login()
	{
		location.href="login";
	}
	
	function join_main()
	{
		location.href="join_main"
	}
</script>
</head>
<body>
		
	<form:form modelAttribute="member" mothod="post" action="login_ok">
		<table border="1">
			<tr>
				<td> <form:input path="id" placeholder="아이디"/>
				<span class="fieldError"> <form:errors path="id"/></span> </td>
			</tr>
			
			<tr>
				<td> <form:password path="pwd" placeholder="비밀번호"/>
				<span class="fieldError"> <form:errors path="pwd"/> </span> </td>
			</tr>
			
			<tr>
				<td> <button type="submit"> 로그인 </button> </td>
			</tr>
		</table>
	</form:form>
</body>
</html>