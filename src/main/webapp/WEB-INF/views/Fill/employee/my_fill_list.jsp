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
	
	#content {
		float: right;
		width: 480px;
		height: 455px;
		margin-top: 25px;
		margin-right: 40px;
		padding: 10px 0px 0px 0px;
		border: 2px solid #e9ecef;
		border-radius: 10px;
		color: gray;
		padding: 200px 0px 0px 75px;
		font-family: GmarketSansTTFMedium;
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
	function my_fill_apply_content(bno)
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
			<div class="my_list" onclick="my_fill_apply_content(${my_fill_list.bno})">
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
		<h2 id="content_text"> 게시글을 선택해주세요 </h2>
	</div>
</section>


</body>
</html>