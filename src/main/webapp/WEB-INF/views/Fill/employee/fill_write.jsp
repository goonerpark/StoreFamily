<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		border: 2px solid #F1EFE7;
		border-radius: 10px;
	}
	
	.list_text {
		font-size: 25px;
		margin: 0px 0px 15px 0px;
		font-family: esamanru Medium;
	}
	
	.my_list {
		border: 2px solid #F1EFE7;
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
		background: #F1EFE7;
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
		border: 2px solid #F1EFE7;
		border-radius: 10px;
	}
	
	.nav {
		margin: 0px 0px 15px 5px;
	}
	.nav-item {
		font-family: esamanru Medium;
		font-size: 14px;
		color: gray;
	}
	
	.nav-item a{
		color: #000000;
	}
	
	input, select, textarea {
		border: none;
		outline: none;
		color: gray;
	}
	
	.con_hr {
		border: none;
		height: 2px;
		background: #F1EFE7;
	}
	
	.con_title {
		font-family: MBC M2;
		font-size: 25px;
		padding-left: 20px;
	}
	
	.clock_img, .con_text {
		padding-left: 20px;
		font-family: MBC M2;
	}
	
	.con_day {
		color: gray; 
		font-family: esamanru Light;
		padding: 5px 0px 3px 0px;
	}
	
	.con_content {
		border: 2px solid #F1EFE7;
		margin: 0px 10px 0px 10px;
		padding-left: 10px;
		padding-top: 10px;
		font-family: MBC M2;
		
	}
	
	.con_time {
		padding-left: 20px;
		padding-top: 5px;
		font-family: esamanru Light;		
	}
	
	.btn_write {
		margin: 0px 0px 40px 12px;
		position: fixed;
		bottom: 0;
		border: none;
	}
		
	.img_main {
		position: relative;
	}
		
	.img_text {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -50% );
		color: white;
		font-family: MBC M2;
  	}
  	
  	button {
  		border: none;
  		background: none;
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

	function fill_apply_content2(bno)
	{
		document.fill_apply_list.bno.value = bno;
		document.fill_apply_list.action = 'my_fill_apply_content';
		document.fill_apply_list.submit();
	}
	
	function apply_date()
	{
		var apply_start_day = document.getElementById("apply_start_day");
		var apply_end_day = document.getElementById("apply_end_day");
		
		apply_end_day.min = apply_start_day.value;
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
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="fill_write"> 대타 공고글 작성</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="fill_resume_write"> 이력서 작성 </a>
		  </li>
		</ul>
		<form:form modelAttribute="fill_write" name="fill_write" method="post" action="fill_write_ok">
		<c:set var="now" value="<%=new java.util.Date() %>"/>
		<c:set var="now_date"> <fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/> </c:set>
		
		<span class="con_title"> <input type="text" name="title" placeholder="제목 입력"> </span>
		<hr class="con_hr">
		
		<span class="clock_img"> <img src="resources/img/clock.png"> </span>
		<span class="con_day"> 
			<select id="schedule_bno" name="schedule_bno" class="con_day">
				<option> 날짜 선택 </option>
				<c:forEach items="${my_schedule}" var="my_schedule" varStatus="status">
				<option value="${my_schedule.bno}"> ${my_schedule.day} ( ${my_schedule.start_time} ~ ${my_schedule.end_time} ) </option>
				</c:forEach>
			</select>
		</span>
		<hr class="con_hr">
		
		<div class="con_content"> <textarea rows="4" cols="42" name="content" placeholder="대타 사유 입력(500자 이내)"></textarea> </div>
		<hr class="con_hr">
		
		<div class="con_text"> 대타 신청 기간 </div>
		<span class="con_time">
			<input type="date" name="apply_start_day" id="apply_start_day" min="${now_date}"> ~ 
			<input type="date" name="apply_end_day" id="apply_end_day" min="${now_date}" onclick="apply_date()">
		</span>
		
		<div class="btn_write"> 
				<div class="img_main">
					<button type="submit" class="btn_submit">
						<img src="resources/img/btn_write2.png" width="443" height="40" alt="대타 등록하기">
						<span class="img_text"> 대타 등록하기</span>
					</button>
				</div>
		</div>
		</form:form>
	</div>
</section>
</body>
</html>