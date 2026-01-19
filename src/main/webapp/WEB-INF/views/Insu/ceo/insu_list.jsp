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
		padding: 10px 0px 0px 0px;
		border: 2px solid #F2F2F2;
		border-radius: 10px;
		color: gray;
		padding: 200px 0px 0px 75px;
		font-family: GmarketSansTTFMedium;
	}
	
	
</style>

<script>
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
		<h2 id="content_text"> 게시글을 선택해주세요 </h2>
	</div>
</section>


</body>
</html>