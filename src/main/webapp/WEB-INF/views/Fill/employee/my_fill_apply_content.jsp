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

<style>
	form {
		padding: 0px;
		margin: 0px;
	}
	
	#list {
		float: left;
		width: 480px;
		height: 455px;
		margin-top: 25px;
		margin-left: 30px;
		padding: 20px 20px 20px 20px;
		border: 2px solid #e9ecef;
		border-radius: 10px;
	}
	
	.list_text {
		font-size: 25px;
		margin: 0px 0px 15px 0px;
		font-family: esamanru Medium;
	}
	
	.my_list {
		border: 2px solid #e9ecef;
		margin-bottom: 15px;
		font-family: esamanru Light;
	}
	
	.my_list2 {
		padding: 10px 0px 0px 20px;
	}
	
	.my_list3 {
		padding: 0px 0px 10px 20px;
	}
	
	.title {
		margin-bottom: 5px;
		font-size: 15px;
	}
	
	.time_day {
		margin-bottom: 5px;
		color: gray;
		font-size: 13px;
	}
	
	.name {
		padding-top: 15px;
		color: gray;
		font-size: 13px;
	}
	
	.apply_su_img {
		margin-left: 110px;
	}
	
	.apply_su {
		color: gray;
		font-size: 13px;
	}
	
	.con_hr {
		border: 0px;
		height: 2px;
		background: #e9ecef;
		margin-bottom: 10px;
	}
	
	.pay {
		color: #C00000;
		padding-right: 5px;
	}
	
	.my_list3 span {
		font-size: 13px;
	}
	
	.chk_1 {
		color: #BAB088;
		font-size: 14px;
		float: right;
		margin-right: 20px;
	}
	
	.chk_0 {
		color: #C00000;
		font-size: 14px;
		float: right;
		margin-right: 20px;
	}
	
	img {
		padding-top: 0px;
	}
	
	#content {
		float: right;
		width: 480px;
		height: 455px;
		margin-top: 25px;
		margin-right: 40px;
		padding: 10px 0px 0px 0px;
		border: 2px solid #e9ecef;
		border-radius: 10px;
	}
	
	.con {
		margin: 10px 0px 0px 15px;
	}
	
	.con_title {
		font-family: MBC M2;
		font-size: 25px;
		margin: 0px 0px 7px 0px;
	}
	
	.sign_day_img {
		margin-left: 20px;
	}
	
	#content .name {
		font-family: esamanru Light;
	}
	
	.sign_day {
		color: gray;
		font-size: 13px;
		font-family: esamanru Light;
	}	
	
	.con_hr {
		border: 0px;
		height: 2px;
		background: #e9ecef;
	}
	
	.con_text {
		font-family: MBC M2;
		font-size: 15px;
		margin: 0px 0px 7px 0px;
	}
	
	.con1 {
		margin: 0px 0px 15px 25px;
	}
	
	.con2 {
		margin:0px 7px 15px 7px;
		border: 2px solid #e9ecef;
		padding: 10px 0px 0px 15px;	
	}
	
	.con3 {
		margin: 0px 0px 15px 25px;	
		font-family: esamanru Light;	
	}
	
	.con_con {
		margin: 0px 0px 7px 0px;
		font-size: 14px;
	}
	
	.con_con_text {
		font-family: GmarketSansTTFMedium;
		margin-right: 10px;
		font-size: 13px;
		color: gray;
	}
	
	.con_con_data {
		font-family: MBC M2;
		font-size: 13px;
	}
	
	.pay_text {
		font-family: esamanru Light;
		font-size: 13px;
		color: #C00000;
		margin-right: 10px;
	}
	
	.con_content {
		margin: 0px 0px 0px 0px;
		width: 430px;
		height: 40px;
		font-size: 13px;
		font-family: esamanru Light;
	}
	
	.con3 input {
		border: none;
	}
	
	.resume_title {
		width: 280px;
		display: inline-block;
	}
	
	.apply_border {
		border-bottom: 2px dashed gray;
		margin: 5px 20px 5px 0px;
	}
	
	#content .pay {
		border-bottom: 2px solid #e9ecef;
		width: 220px;
		margin-top: 10px;
	}
	
	.img_main {
		position: relative;
		margin-left: 165px;
	}
		
	.img_text_cancle {
		position: absolute;
		top: 50%;
		left: 30%;
		transform: translate( -15%, -30% );
		color: #000000;
		font-family: esamanru Light;
		font-size: 10px;
  	}
  	
  	.img_text_ok {
		position: absolute;
		top: 50%;
		left: 30%;
		transform: translate( 0%, -30% );
		color: #000000;
		font-family: esamanru Light;
		font-size: 10px;
  	}
  	
  	.img_main2, .img_main3 {
		position: relative;
	}
	
  	.btn_ok, .btn_no {
		position: absolute;
		top: 50%;
		left: 30%;
		transform: translate( -10%, -50% );
		color: #000000;
		font-family: esamanru Light;
		font-size: 10px;
  	}
  	
  	.plus_img {
			width: 50px;
			height: 60px;
			margin-right: 8px;
			margin-left: 390px;
			margin-bottom: 25px;
			position: fixed;
			bottom:0;
		}
	
	
</style>

<script>
	
	function fill_registrar_ok(bno)
	{
		document.fill_apply_content.bno.value=bno;
		document.fill_apply_content.action = 'fill_registrar_ok';
		document.fill_apply_content.submit();
	}
	
	function fill_registrar_cancle(bno)
	{
		document.fill_apply_content.bno.value=bno;
		document.fill_apply_content.action = 'fill_registrar_cancle';
		document.fill_apply_content.submit();
	}
	
	function fill_apply(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_cancle(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply_cancle';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_ok(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply_ok';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_no(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action = 'fill_apply_no';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_resume_change(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action = 'fill_apply_resume_change';
		document.fill_apply_content.submit();
	}
	
	function resume_content(resume_bno)
	{
		document.fill_apply_content.resume_bno.value = resume_bno;
		document.fill_apply_content.action = 'apply_resume_content';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_content2(bno)
	{
		document.fill_apply_list.bno.value = bno;
		document.fill_apply_list.action = 'my_fill_apply_content';
		document.fill_apply_list.submit();
	}
	
	function fill_write()
	{
		location.href="fill_write";
	}
</script>
</head>
<body>
<section>
	<div id="list">
		<div class="list_text"> MY 대타 공고 글 </div>
		<form:form modelAttribute="fill_apply_list" name="fill_apply_list" method="post">
			<input type="hidden" name="bno" id="bno">
			
			<c:forEach items="${my_fill_list}" var="my_fill_list" varStatus="status">
			<div class="my_list" onclick="fill_apply_content2(${my_fill_list.bno})">
				<div class="my_list2">
					<div class="title"> <b> ${my_fill_list.title} </b> </div>
					<div class="time_day"> <img src="resources/img/clock.png"> ${my_fill_list.fill_start_time} ~ ${my_fill_list.fill_end_time} | ${my_fill_list.fill_day} </div>
					<div>
						<span class="name_img"> <img src="resources/img/name.png"> </span> <span class="name"> ${my_fill_list.name} </span>
						<span class="apply_su_img"> <img src="resources/img/apply.png"> </span> <span class="apply_su"> + ${my_fill_list.apply_su} </span>
					</div>
				</div>
			
			
				<hr class="con_hr">
				
				<div class="my_list3">
					<c:if test="${my_fill_list.chk == 1}">
					<div> <span class="pay"> 시급 </span> <span> ${my_fill_list.pay} </span> <span class="chk_1"> 등록완료 </span> </div>
					</c:if>
					
					<c:if test="${my_fill_list.chk == 0}">
					<div> <span class="pay"> 시급 </span> <span> ${my_fill_list.pay} </span> <span class="chk_0"> 등록대기 </span> </div>
					</c:if>
				</div>
			</div>
			</c:forEach>
		</form:form>
		<span onclick="fill_write('${date}')"> <img src="resources/img/plus2.png" class="plus_img"> </span>
	</div>
	
	<div id="content">
		<form:form modelAttribute="fill_apply_content" name="fill_apply_content" method="post">
		<input type="hidden" name="bno">
		<input type="hidden" name="w_name" value="${fill_apply_content.name}">
		<input type="hidden" name="schedule_bno" value="${fill_apply_content.schedule_bno}">
		<input type="hidden" name="fill_bno" value="${fill_apply_content.bno}">
		<input type="hidden" name="w_code" value="${fill_apply_content.code}">
		<input type="hidden" name="w_id" value="${fill_apply_content.id}">
		
		<div class="con">
			<div class="con_title"> ${fill_apply_content.title} </div>
			<div>
				<span class="name_img"> <img src="resources/img/name.png"> </span> <span class="name"> ${fill_apply_content.name} </span>
				<span class="sign_day_img"> <img src="resources/img/clock.png"> </span> <span class="sign_day"> ${fill_apply_content.sign_day} </span>
			</div>
		</div>
		<hr class="con_hr">
		
		<div class="con1">
			<div class="con_text"> 근무조건 </div>
			<div class="con_con"> <span class="con_con_text"> · 근무 시간 · </span> <span class="con_con_data"> ${fill_apply_content.fill_start_time} ~ ${fill_apply_content.fill_end_time} ( ${fill_apply_content.fill_di_time} ) </span></div>
			<div class="con_con"> <span class="con_con_text"> · 근무 날짜 · </span> <span class="con_con_data"> ${fill_apply_content.fill_day} </span></div>
			<div class="con_con"> <span class="con_con_text"> · 급&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;여 · </span> <span class="pay_text"> 시급 </span><span class="con_con_data"> ${fill_apply_content.pay} </span></div>
		</div>
		
		<div class="con2">
			<div class="con_text"> 상세내용 </div>
			<div class="con_content"> <span class="con_content"> ${fill_apply_content.content} </span> </div>
		</div>
		

		</form:form>
	</div>
</section>
</body>
</html>