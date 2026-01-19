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
	
	section {
		padding: 220px 50px 100px 180px;
	}
	
	.login {
		display: inline-block;
		vertical-align: top;
	}
	
	.id, .pwd {
		border: 2px solid #BAB088;
		border-radius: 5px;
		outline: none;
		padding: 5px 10px 5px 10px;
		width: 250px;
		height: 45px;
		font-family: GmarketSansTTFMedium;
	}
	
	.pwd {
		margin-top: 10px;
	}
	
	.img_main {
		position: relative;
	}
	
	button {
		border: none;
		background: none;
	}
		
	.img_text {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -50% );
		font-family: PyeongChangPeace-Bold;
		font-size: 20px;
		color: white;
  	}
  	
  	.hr {
  		display: inline-block;
  		vertical-align: top;
  		padding-top: 12px;
  	}
  	
  	hr {
  		border: 2px solid #DFDAC7;
  		background: #DFDAC7;
  		height: 10vh;	
  		margin-right: 70px;
  		margin-left: 100px;
  	}
  	
  	.logo {
  		display: inline-block;
  		vertical-align: top;
  		margin-top: -20px;
  	}
  	
  	.plus span {
  		color: #BAB088;
  		padding-right: 5px;
  		padding-left: 5px;
  		font-family: GmarketSansTTFMedium;
  	}
  	.plus {
  		margin-top: 10px;
  		margin-left: 20px;
  	}
</style>

<script>
	function main()
	{
		location.href="home";
	}
	
</script>
</head>
<body>
	<section>
	<div class="login">
	<form:form modelAttribute="member" mothod="post" action="login_ok">
	<table>
		<tr>
			<td> <form:input path="id" placeholder="아이디" class="id"/>
			<span class="fieldError"> <form:errors path="id"/></span> </td>
			<td rowspan="2" class="img_main">
				<button type="submit" class="btn_login"> 
					<img src="resources/img/btn_login.png" width="107">
					<span class="img_text"> LOGIN </span>
				</button>
			</td>
		</tr>
		
		<tr>
			<td> <form:password path="pwd" placeholder="비밀번호" class="pwd"/>
			<span class="fieldError"> <form:errors path="pwd"/> </span> </td>
		</tr>
	</table>
	</form:form>
	<div class="plus">
		<span> 회원가입 </span> <span>| </span> <span> 아이디 찾기 </span> <span> | </span> <span> 비밀번호 찾기 </span>
	</div>
	</div>
	
	<div class="hr"> <hr> </div>
	
	<div class="logo">
		<img src="resources/img/logo.png" width="400">
	</div>
	</section>
</body>
</html>