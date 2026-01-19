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
  	
  	.content {
  		margin: 10px 70px 50px 20px;
  		border-top: 2px solid #767171;
  		border-bottom: 2px solid #767171;
  		border-left: 1px solid #767171;
  		border-right: 1px solid #767171;
  		padding: 20px 50px 20px 50px;
  	}
  	
  	.title {
  		border-bottom: 1px solid #D9D9D9;
  	}
  	
  	.bussiness {
  		font-family: GmarketSansTTFMedium;
  		font-size: 15px;
  		margin-bottom: 5px;
  	}
  	
  	.fill_title {
  		font-family: PyeongChang-Bold;
  		font-size: 30px;
  		margin-bottom: 5px;
  	}
  	
  	.name {
  		font-family: esamanru Light;
  		font-size: 10px;
  		margin-bottom: 15px;
  	}
  	
  	.name span {
  		margin-right: 20px;
  	}
  	
  	.second {
  		display: inline-block;
  		border-bottom: 1px solid #D9D9D9;
  	}
  	
  	.work {
  		display: inline-block;
  		width: 510px;
  		vertical-align: top;
  		padding: 20px 0px 20px 0px;
  		border-right: 1px solid #D9D9D9;
  	}
  	
  	.con_btn {
  		display: inline-block;
  		width: 510px;
  		vertical-align: top;
  		padding: 30px 20px 35px 50px;
  	}
  	
  	.con_btn button {
  		width: 420px;
  		height: 50px;
  		background: none;
  		border: 2px solid #BAB088;
  		border-radius: 4px;
  		color: #BAB088;
  		font-family: GmarketSansTTFMedium;
  	}
  	
  	.btn_resume {
  		margin-top: 10px;
  	}
  	
  	
  	.big {
  		font-family: GmarketSansTTFMedium;
  		font-size: 20px;
  		font-weight: bold;
  		margin-bottom: 10px;
  	}
  	
  	.small {
  		font-family: GmarketSansTTFMedium;
  		font-size: 15px;
  		margin-bottom: 10px;
  	}
  	
  	.third {
  		border-bottom: 1px solid #D9D9D9;
  		height: 150px;
  	}
  	
  	.detail {
  		display: inline-block;
  		width: 510px;
  		height: 150px;
  		vertical-align: top;
  		padding: 20px 0px 0px 0px;
  		border-right: 1px solid #D9D9D9;
  	}
  	
  	.day {
  		display: inline-block;
  		width: 510px;
  		height: 150px;
  		vertical-align: top;
  		padding: 30px 20px 0px 50px;
  	}
  	
  	.day_small {
  		font-family: GmarketSansTTFMedium;
  		padding-bottom: 10px;
  	}
  	
  	.day_red_text {
  		color: #C00000;
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
	function main()
	{
		location.href="main";
	}
	
	function apply_go(bno)
	{
		location.href="apply_go?bno="+bno;
	}
	
	function fill_apply_cancle(bno)
	{
		location.href="fill_apply_cancle?bno="+bno;
	}
	
	function resume_write()
	{
		location.href="resume_write";
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
	
	<div class="content">
		<div class="title">
			<div class="bussiness"> ${fill_apply_content.local_do} ${fill_apply_content.local_si} ${fill_apply_content.bussiness} </div>
			<div class="fill_title"> ${fill_apply_content.title} </div>
			<div class="name">
				<span> <img src="resources/img/name.png"> ${fill_apply_content.name} </span>
				<span> <img src="resources/img/apply.png"> + ${fill_apply_content.apply_su} </span>
				<span> <img src="resources/img/clock.png"> ${fill_apply_content.sign_day} </span>
			</div>
		</div>
		
		<div class="second">
		<div class="work">
			<div class="big"> 근무조건 </div>
			<div class="small"> <span class="gray_text"> 근무 시간 </span> <span> ${fill_apply_content.fill_start_time} ~ ${fill_apply_content.fill_end_time} ( ${fill_apply_content.fill_di_time} ) </span> </div>
			<div class="small"> <span> 근무 날짜 </span> <span> ${fill_apply_content.fill_day} </span> </div>
			<div class="small"> <span> 급 &nbsp;&nbsp;&nbsp;&nbsp; 여 </span> <span> ${fill_apply_content.pay} </span> </div>
		</div>
		
		<div class="con_btn">
			<c:if test="${count == 0}">
			<div> <button class="btn_fill_apply" onclick="apply_go(${fill_apply_content.bno})"> 대타 지원하기 </button> </div>
			<div> <button class="btn_resume" onclick="resume_write()"> 이력서 작성하기 </button> </div>
			</c:if>
			
			<c:if test="${count == 1}">
			<div> <button class="btn_fill_apply" onclick="fill_apply_cancle(${fill_apply_content.bno})"> 지원 취소하기 </button> </div>
			<div> <button class="btn_resume"> 이력서 변경하기 </button> </div>
			</c:if>
			
		</div>
		</div>
		
		<div class="third">
		<div class="detail">
			<div class="big"> 상세내용 </div>
			<div class="small"> ${fill_apply_content.content} </div>
		</div>
		
		<div class="day">
			<div class="big"> 모집 마감일 </div>
			<div class="day_small"> ${fill_apply_content.apply_start_day} ~ ${fill_apply_content.apply_end_day} </div>
			<div class="day_small"> <span class="day_red_text"> '마감기한' </span>을 항상 확인해주세요</div>
		</div>
		</div>
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