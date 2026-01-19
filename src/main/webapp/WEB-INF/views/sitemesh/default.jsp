<%@page import="kr.co.storefamily.mapper.MainMapper"%>
<%@page import="kr.co.storefamily.controller.MainController"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<script src="resources/js/jquery-3.7.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/bootstrap.bundle.min.js"></script>

<html>
<head>
<title><decorator:title default="테크리포트" /></title>
<link href="resources/css/style.css" rel="stylesheet">

<decorator:head />
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
		/* #head_up span button {
			padding: 10px;
			position: relative;
			top: 17px;
			left: 1030px;
		} */
		
		#head_side{
			float: left;
			width: 230px;
			height: 100%;
		}
		
		#head_side a {
			text-align: center;
			height: 51px;
		}
		
		.hr_solid {
			border : 0px;
	  		border-top: 2px solid #F1EFE7;
	  		margin-bottom: 0px;
		}
		
		.card {
			float: left;
			width: 230px;
			padding: 0px;
		}
		
		.card .text-center {
			height: 147px;
			background: #F1EFE7;
			padding-top: 35px;
			border: none;
			font-family: Cafe24Supermagic-Bold;
		}
		
		.list-group-item {
			background: #F1EFE7;
			border: none;
			font-family: Cafe24Supermagic-Bold;
		}
		
	</style>
	
	<script>
		function main() {
			location.href="main";
		}
	</script>

</head>
    
<body>

<div id="head_up">
	<span id="logo" onclick="main()"> <img src="resources/img/logo.png" width="250"> </span>
	<span id="store_change"> <button type="button" class="btn btn-outline-dark btn-sm"> 사업장 변경 </button> </span>
	<span id="logout"> <button type="button" class="btn btn-outline-danger btn-sm"> 로그아웃 </button> </span>
</div>

<hr class="hr_solid">
<div>
<div class="card border-light">
	<div class="card text-center">
	<p> 이륜나 님, </p>
	<p> 반갑습니다. </p>
	</div>
	<div id="head_side" class="list-group list-group-flush">
    	<a class="list-group-item list-group-item-action" href="schedule"> 스케줄 </a>
    	<a class="list-group-item list-group-item-action" href="fill"> 대타관리 </a>
    	<a class="list-group-item list-group-item-action" href="insu_list"> 인수인계 </a>
    	<a class="list-group-item list-group-item-action" href="manage_main"> 직원관리 </a>
    	<a class="list-group-item list-group-item-action" href="mypage_main"> 마이페이지 </a>
    	<a class="list-group-item list-group-item-action" href="#"> 공지사항 </a>
    	<a class="list-group-item list-group-item-action" href="#"> 설정 </a>
    </div>
</div>
    
    
    
<decorator:body />
    
</div>
    </body>
</html>