<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

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
	
	section {
		margin-left: 36px;
		margin-bottom: 100px;
	}
	
	.fill_banner img {
		width: 94%;
		margin-top: -20px;
	}
	
	.fill_banner {
		position: relative;
	}
		
	.fill_banner_text1 {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate( -230%, -30% );
	    color: #000000;
	    font-family: MBC M2;
  	}
  	
  	.fill_banner_text2 {
  		font-family: PyeongChangPeace-Bold;
  		font-weight: bold;
  		font-size: 30px;
  	}
  	
  	.fill_banner_text3 {
  		font-family: PyeongChangPeace-Light;
  		font-size: 13px;
  	}
  	
  	.fill_list1 {
  		width: 95%;
  		margin-left: 30px;
  		margin-top: 10px;
  	}
  	
  	.fill_list1:last-child {
  		border-bottom: 2px solid #F2F2F2;
  	}
  	.fill_list2 {
  		width: 48%;
  		display: inline-block;
  		vertical-align: top;
  		padding: 10px 10px 10px 20px;
  	}
  	
  	.fill_list2:nth-child(odd) {
  	  	border-right: 2px solid #F2F2F2;
  	  	border-top: 2px solid #F2F2F2;
  	}
  	
  	.fill_list2:nth-child(even) {
  		border-top: 2px solid #F2F2F2;
  		border-bottom: 2px solid #F2F2F2;
  	}
  	
  	.bussiness {
  		font-family: GmarketSansTTFMedium;
  		font-size: 13px;
  		margin-bottom: 5px;
  		color: gray;
  	}
  	
  	.title {
  		font-family: PyeongChang-Bold;
  		font-size: 20px;
  		margin-bottom: 5px
  	}
  	
  	.time {
  		font-family: esamanru Light;
  		margin-bottom: 5px;
  		color: gray;
  	}
  	
  	.name {
  		font-family: esamanru Light;
  		color: gray;
  	}
  	
  	.apply {
  		margin-left: 100px;
  	}
  	
  	.pay_text {
  		color: #C00000;
  		font-size: 13px;
  		font-family:esamanru Bold;
  	}
  	
  	.pay_data {
  		font-size: 13px;
  		font-family: PyeongChang-Bold;
  		margin-left: 5px;
  	}
  	
  	.img_main {
		position: relative;
		margin-left: 330px;
	}
		
	.img_text {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate( -17%, -30% );
	    color: #000000;
	    font-family: MBC M2;
	    font-size: 13px;
  	}
  	
  	.hr {
  		border: 0px;
		height: 2px;
		background: #F2F2F2;
  	}
  	
  	.bottom {
  		width: 100%;
  		height: 250px;
  		background: #F1EFE7;
  		padding: 10px 10px 10px 20px;
  	}
  	
  	.bottom_text {
  		padding-left: 30px;
  		font-family: esamanru Light;
  	}
  	
  	.bottom_store {
  		font-size: 15px;
  	}
  	
  	.addr {
  		color: #767171;
  		font-size: 13px;
  		padding-bottom: 2px;
  		margin-left: 10px;
  	}
  	
  	.bottom_copy {
  		padding-left: 30px;
  		color: #767171;
  		font-family: PyeongChang-Bold;
  		font-size: 13px;
  	}
  	
  	.jangan {
  		margin-top: 15px;
  		margin-left: 30px;
  		
  	}
</style>
<script>
	
	function fill_apply_content(bno)
	{
		document.fill_all_list.bno.value = bno;
		document.fill_all_list.action = 'fill_apply_content';
		document.fill_all_list.submit();
	}
	
	function fill_write()
	{
		document.fill_all_list.action='fill_write';
		document.fill_all_list.submit();
	}
	
	function resume_write()
	{
		document.fill_all_list.action='resume_write';
		document.fill_all_list.submit();
	}
	
	function main()
	{
		location.href="main";
	}
	
	function fill_content(bno)
	{
		location.href="fill_content?bno="+bno;
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
	
	<section>
	<div class="fill_banner">
		<img src="resources/img/fill_banner3.png">
		<span class="fill_banner_text1">
			<span class="fill_banner_text2"> 전체 대타 채용 공고 </span> <br>
			<span class="fill_banner_text3"> STORE FAMILY의 전체 대타 채용 정보 </span>
		</span>
	</div>
	
	
	<div class="fill_list1">
		<c:forEach items="${fill_all_list}" var="fill_all_list" varStatus="status">
		<div class="fill_list2">
			<div class="bussiness"> ${fill_all_list.local_do} ${fill_all_list.local_si} ${fill_all_list.bussiness} </div>
			<div class="title"> ${fill_all_list.title} </div>
			<div class="time">
				<img src="resources/img/clock.png"> ${fill_all_list.fill_start_time} ~ ${fill_all_list.fill_end_time} |
				${fill_all_list.fill_day}
			</div>
			
			<div class="name">
				<img src="resources/img/name.png"> ${fill_all_list.name}
				<span class="apply"> <img src="resources/img/apply.png"> + ${fill_all_list.apply_su} </span>
			</div>
			
			<hr class="hr">
			
			<div>
				<span class="pay_text"> 시급 </span> <span class="pay_data"> ${fill_all_list.pay} </span>
				<span class="img_main"  onclick="fill_content(${fill_all_list.bno})"> 
					<img src="resources/img/btn_fill_apply.png" width="100">
					<span class="img_text"> 지원하기 </span>
				</span>
			</div>
		</div>
		</c:forEach>
		
	</div>
	
	</section>
	
	<div class="bottom">
		<div class="bottom_logo"> <img src="resources/img/logo.png"> </div>
		<div class="bottom_text"> <b class="store"> 스토어 패밀리 </b> <span class="addr"> 경기도 화성시 봉담읍 삼천병마로 1182(상리, 장안대학), 경기도 화성시 봉담읍 상리 460(장안대학) | 팀장 : 이륜나</span> </div>
		<div class="bottom_copy"> Copyright ⓒ kimjieun. All Rights Reserved.</div>
		<div class="jangan"> <img src="resources/img/jangan.png"> </div>
	</div>
	
</body>
</html>