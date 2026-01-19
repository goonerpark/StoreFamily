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
  	
  	
  	.con {
  		border-top: 2px solid #767171;
  		border-bottom: 2px solid #767171;
  		border-right: 1px solid #767171;
  		border-left: 1px solid #767171;
  		width: 1135px;
  		margin-left: 20px;
  		padding: 30px 50px 30px 50px;
  	}
  	
  	.text {
  		font-family: PyeongChangPeace-Light;
  		font-size: 13px;
  		font-weight: bold;
  		color: #C00000;
  		margin-bottom: 20px;
  	}
  	
  	.title input{
  		width: 500px;
  		font-size: 35px;
  		font-family: MBC M2;
  		border-bottom: 2px solid #D9D9D9;
  		border-top: none;
  		border-left: none;
  		border-right: none;
  		outline: none;
  		
  	}  	
  	
  	.con_text {
  		font-family: MBC M2;
  		font-weight: bold;
  		font-size: 20px;
  		margin-top: 15px;
  		margin-bottom: 5px;
  	}
  	
  	.in input {
  		font-family: esamanru Light;
  		font-size: 17px;
  		border-bottom: 2px solid #D9D9D9;
  		border-top: none;
  		border-left: none;
  		border-right: none;
  		outline: none;
  	}
  	
  	.day input{
  		border: none;
  		outline: none;
  		font-family: esamanru Light;
  		font-size: 17px;
  	}
  	
  	.con_con {
  		margin-top: 15px;
  	}
  	
  	.con_con textarea {
  		padding: 15px;
  		border:2px solid #D9D9D9;
  		outline: none;
  		width: 500px;
  		font-size: 17px;
  		font-family: MBC M2;
  		
  	}
  	
  	.btn {
  		margin-left: 600px;
  		margin-top: 20px;
  	}
  	
  	.img_main_plus {
		position: relative;
	}
		
	.img_text_plus {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -80%, -45% );
		font-family: MBC M2;
		font-size: 20px;
  	}
  	
  	.img_main_write {
		position: relative;
	}
		
	.img_text_write {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -45% );
		font-family: MBC M2;
		font-size: 20px;
  	}
  	
  	button {
  		border: none;
  		background: none;
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
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	function main()
	{
		location.href="main";
	}
	
	function resume_write_ok()
	{
		document.resume_write.action='resume_write_ok';
		document.resume_write.submit();
	}
	
	$(function () {
        $("#btn_plus").click(function () {
            var newRow = $(".row-template").eq(0).clone(true);

            newRow.find('input[type="text"]').val('');
            newRow.find('textarea').val('');

            $(".content").append(newRow);
        });
    });
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
	
	<div class="con">
	<div class="content">
		<div class="text"> <img src="resources/img/expoint.png" width="15"> 이력서는 한번 작성하면 수정할 수 없습니다. </div>
		<form:form modelAttribute="resume_write" name="resume_write" method="post">		
		<div class="title"> <input type="text" name="title" placeholder="제목 입력"> </div>
		<div class="row-template">
			<div class="con_text"> 근무지 </div>
			<div class="in"> <input type="text" name="work_place" placeholder="근무지 작성"> </div>
		 	<div class="con_text"> 근무기간 </div>
		 	<div class="day"> 
		 		<img src="resources/img/clock.png">
		 		<input type="date" name="start_day"> ~ <input type="date" name="end_day">
		 	</div>
		 	<div class="con_con"> <textarea rows="4" cols="60" name="work_activity" placeholder="활동 내용 입력"></textarea> </div>
		</div>
		</form:form>
	</div>
	
	<div class="btn">
	
       <span class="img_main_plus">
			<button id="btn_plus">
				<img src="resources/img/resume_plus.png" width="70">
				<span class="img_text_plus"> + </span>
			</button>
		</span>
		
		<span class="img_main_write">
			<button onclick="resume_write_ok()">
				<img src="resources/img/resume_write.png" width="300">
				<span class="img_text_write"> 이력서 작성하기 </span>
			</button>
		</span>
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