<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#first #logo, #first #store_name {
		display: inline-block;
	}
	
	#menu {
		width: 200px;
	}
	
	#menu #plus:hover{
		color: red;
	}
	
	#second #menu, #second #section{
		display: inline-block;
	}
	div {
		border: 1px solid black;
	}
</style>
</head>
<body>
<div id="first">
	<div id="logo"> LOGO </div>
	<div id="store_name"> STORE_NAME </div>
</div>

<div id="second">
	<div id="menu">
		<div id="menu_1"> <a href="fill_list"> 대타 </a> <span id="plus" onclick="#"> ▼ </span> </div>
		<div id="menu_2"> <a href="schedule"> 스케줄 </a> <span id="plus" onclick="#"> ▼ </span> </div>
		<div id="menu_3"> <a href="insu_list"> 인수인계 </a> <span id="plus" onclick="#"> ▼ </span> </div>
		<div id="menu_4"> <a href="mypage_main"> 마이페이지 </a> <span id="plus" onclick="#"> ▼ </span> </div>
		<a href="#"> 공지사항 </a>
	</div>
</div>

</body>
</html>