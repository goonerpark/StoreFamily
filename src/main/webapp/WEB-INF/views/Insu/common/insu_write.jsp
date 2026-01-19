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
		border: 2px solid #F1EFE7;
		border-radius: 10px;
	}
	
	.list_text {
		font-size: 25px;
		margin: 0px 0px 15px 0px;
		font-family: esamanru Medium;
	}
	
	.nav{
		margin-left: 10px;
		display: inline-block;
	}
	
	li {
		display: inline-block;
		font-size: 15px;
		font-family: esamanru Medium;
	}
	
	.insu_list {
		font-family: esamanru Light;
		border: 1.5px solid #F2F2F2;
		margin: 0px 0px 15px 0px;
		padding: 20px;
	}
	
	.day {
		margin-top: 10px;
	}
	
	.name_chk {
		margin-top: 10px;
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
		
	#content {
		float: right;
		width: 480px;
		height: 455px;
		margin-top: 25px;
		margin-right: 40px;
		padding: 20px 0px 0px 0px;
		border: 2px solid #F1EFE7;
		border-radius: 10px;
	}
	
	input, textarea {
		border: none;
		outline: none;
	}
	
	.con_title {
		font-family: MBC M2;
		font-size: 20px;
		padding-left: 20px;
	}
	
	.con_con {
		border: 2px solid #F1EFE7;
		margin: 0px 10px 0px 10px;
		padding-left: 10px;
		padding-top: 10px;
		font-family: MBC M2;
	}
	
	.con_text {
		padding-left: 20px;
		font-family: MBC M2;
	}
	
	input[type="file"] {
		margin-left: 10px;
	}
	
	.con_member {
		margin-left: 20px;
		margin-top: 10px;
	}
	
	.sub {
		margin-left: 10px;
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
	
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.0.js"></script>
<script>

	function check(all)
	{
		var member = document.getElementsByName("checkBox");
		
		if(all.checked)
		{
			for(var i=1; i<member.length; i++)
				member[i].disabled = true;
		}
		else
		{
			for(var i=1; i<member.length; i++)
				member[i].disabled = false;
		}
	}
		
	$(document).ready(function(){
		var ch_member_id=[];
		$("input[name=checkBox]").change(function(){
			if($(this).is(":checked")){
				var th = $(this).val();
				ch_member_id.push(th);
				$("#ch_member_id").val(ch_member_id);
			}
			else{
				for(var i=0; i<ch_member_id.length; i++)
				{
					if(ch_member_id[i] == $(this).val())
					{
						ch_member_id.splice(i,1);
					}
					$("#ch_member_id").val(ch_member_id);
				}
			}
		});
	});

	function insu_list(ch_member_id)
	{
		document.insu_list.ch_member_id.value = ch_member_id;
		document.insu_list.action = 'insu_list';
		document.insu_list.submit();
	}
	
	function insu_write(ch_member_id)
	{
		document.insu_list.ch_member_id.value = ch_member_id;
		document.insu_list.action = 'insu_write';
		document.insu_list.submit();
	}
	
	function insu_content(bno,ch_member_id)
	{
		document.insu_list.bno.value = bno;
		document.insu_list.ch_member_id.value = ch_member_id;
		document.insu_list.action = 'insu_content';
		document.insu_list.submit();
	}
</script>
</head>
<body>

<section>
	<div id="list">
	<form:form modelAttribute="insu_list" name="insu_list" method="post">
	<input type="hidden" name="ch_member_id">
	<input type="hidden" name="bno">
		<div>
			<!-- <span class="list_text"> 인수인계 </span> -->
			<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link" aria-current="page" href="javascript:insu_list('all');"> 전근무자 </a>
			  </li>
			  <c:if test="${position=='사장'}">
			  <c:forEach items="${member_list}" var="member_list" varStatus="status">
			  <li class="nav-item">
			    <a class="nav-link" href="javascript:insu_list('${member_list.id}');"> ${member_list.name} </a>
			  </li>
			  </c:forEach>
			  </c:if>
			  
			  <c:if test="${position=='직원' }">
			  <li class="nav-item">
			  	<a class="nav-link" href="javascript:insu_list('${my_member.id}');"> ${my_member.name} </a>
			  </li>
			  </c:if>
			</ul>
		</div>
		
		<c:forEach items="${insu_list}" var="insu_list" varStatus="status">
		<div class="insu_list" onclick="insu_content(${insu_list.bno},'${ch_member_id}')">
			<div class="title"> ${insu_list.title} </div>
			<div class="day"> <img src="resources/img/clock.png"> ${insu_list.day} </div>
			<div class="name_chk">
				<span class="name"> <img src="resources/img/name.png"> ${insu_list.name} </span>
				<span class="chk"> <img src="resources/img/insu_paper.png"> ${insu_list.chk} </span>
			</div>
		</div>
		</c:forEach>
	
	
		<span onclick="insu_write('${ch_member_id}')"> <img src="resources/img/plus2.png" class="plus_img"> </span>
		</form:form>
	</div>
	
<div id="content">
	<form:form modelAttribute="insu" method="post" enctype="multipart/form-data" action="insu_write_ok">
	<input type="hidden" name="code" value="${code}">
	<input type="hidden" name="id" value="${id}">
	<input type="hidden" name="name" value="${name}">
	<input type="hidden" name="ch_member_id" id="ch_member_id">
	
	<div class="con_title"> <input type="text" name="title" id="titl" placeholder="제목 입력"> </div>
	<hr class="con_hr">
	<div class="con_con"> <textarea rows="4" cols="42" name="content" placeholder="내용 입력(500자 이내)"></textarea> </div>
	<hr class="con_hr">
	<div class="con_file">
		<span class="con_text"> 파일 선택 </span>
		<span class="file"> <input type="file" name="insu_img" multiple="multiple"> </span>
	</div>
	<hr class="con_hr">
	<div class="con_text"> 확인 직원 </div>
	<div class="con_member">
		<input type="checkbox" name="checkBox" value="all" onclick="check(this)"> 전근무자
		<c:forEach items="${member_list}" var="member_list" varStatus="status">
			<span class="sub"> <input type="checkbox" name="checkBox" value="${member_list.id}"> ${member_list.name} </span>
		</c:forEach>
	</div>
	
	<div class="btn_write"> 
		<div class="img_main">
			<button type="submit" class="btn_submit">
				<img src="resources/img/btn_write2.png" width="443" height="40" alt="대타 등록하기">
				<span class="img_text"> 인수인계 등록하기</span>
			</button>
		</div>
	</div>
	</form:form>
</div>
</section>


</body>
</html>