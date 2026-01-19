<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/style.css" rel="stylesheet">
<style>
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
	
	.img_main {
		position: relative;
	}
	
	button {
		border: none;
		background: none;
	}
		
	.img_text {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -55%, -38% );
		font-family: esamanru Light;
		font-size: 15px;
  	}
  	
  	.empl_list {
  		border: 2px solid #DFDAC7;
  		margin-bottom: 7px;
  		padding: 5px 5px 5px 12px;
  		font-family: esamanru Light;
  	}
  	
	.name {
		font-size: 17px;
	}
	
	.btn {
		margin-left: 80px;
	}
	
	.btn_no {
		margin-left: -10px;
	}
	
	.cancle {
		margin-left: 15px;
	}
	
	.ok {
		color : #70AD47;
	}
	
	.no {
		color: #C00000;
	}
	
	.content {
		float: right;
		width: 480px;
		height: 455px;
		margin-top: 25px;
		margin-right: 40px;
		padding: 10px 0px 0px 0px;
		border: 1px solid #F2F2F2;
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
	
	.con_text {
		font-family: MBC M2;
		font-size: 20px;
		padding-left: 20px;
		padding-top: 10px;
	}
	
	.member_list {
		margin-left: 20px;
		padding: 10px;
		border-bottom: 1px solid #F2F2F2;
	}
	
	.member_list .name {
		font-family: GmarketSansTTFMedium;
		font-size: 18px;
	}
	
	.member_list .employment {
		font-family: GmarketSansTTFMedium;
		font-size: 15px;
		margin-left:100px;
	}
	
	.member_list .rate {
		font-family: GmarketSansTTFMedium;
		font-size: 15px;
		float: right;
		margin-right: 50px;
	}
	
</style>
<script>

	function employee_chk_ok(bno)
	{
		location.href="employee_chk_ok?bno="+bno+"&chk=1";
	}
	
	function employee_chk_no(bno)
	{
		location.href="employee_chk_no?bno="+bno+"&chk=1";
	}
	
	function employee_chk_reset(bno)
	{
		location.href="employee_chk_reset?bno="+bno+"&chk=1";
	}
	function employee_member_imformation(bno)
	{
		document.employee_member_list.bno.value = bno;
		document.employee_member_list.action='employee_member_imformation';
		document.employee_member_list.submit();
	}
</script>
</head>
<body>
	<div id="list">
		<div class="list_text"> <img src="resources/img/paper.png" width="30"> <span> 승인대기 직원 </span> </div>
		<c:forEach var="employee_ok" items="${employee_ok}" varStatus="status">
		<div class="empl_list">
			<span class="name"> <img src="resources/img/name.png" width="20"> ${employee_ok.name} </span>
			<span class="btn">
				<span class="img_main">
				<button onclick="employee_chk_ok(${employee_ok.bno})">
					<img src="resources/img/ok.png" width="50">
					<span class="img_text"> 승인 </span>
				</button>
				</span>
				
				<span class="img_main btn_no">
				<button onclick="employee_chk_no(${employee_ok.bno})">
					<img src="resources/img/no.png" width="50">
					<span class="img_text"> 삭제 </span>
				</button>
				</span>
			</span>
			
		<c:if test="${employee_ok.chk == 0}">
			<span class="wait"> 대기 </span>
		</c:if>
		
		<c:if test="${employee_ok.chk == 1}">
			<span class="ok"> 승인 </span>
		</c:if>
		
		<c:if test="${employee_ok.chk == -1}">
			<span class="no"> 반려 </span>
		</c:if>
		
		<span class="cancle">
		<span class="img_main">
			<button onclick="employee_chk_reset(${employee_ok.bno})">
				<img src="resources/img/no.png" width="50">
				<span class="img_text"> 취소 </span>
			</button>
		</span>
		</span>
		</div>
		</c:forEach>
	</div>
	
	<div class="content">
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link" aria-current="page" href="manage_main" style="color:gray;"> 직원 초대 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link active" href="employee_member_list"> <img src="resources/img/paper.png"> 직원 목록 </a>
		  </li>
		</ul>
		
		<div class="con_text"> 직원 초대하기 </div>
		<hr class="con_hr">
		
		
		<form:form modelAttribute="employee_member_list" name="employee_member_list" method="post">
		<input type="hidden" name="bno">
			<c:forEach var="employee_member_list" items="${employee_member_list}" varStatus="status">
				<div class="member_list" onclick="employee_member_imformation(${employee_member_list.bno})">
				<span class="name"> ${employee_member_list.name} </span>
				
				<c:if test="${employee_member_list.employment == '0000-00-00'}">
					<span class="employment"> 미등록 </span>
				</c:if>			
				
				<c:if test="${employee_member_list.employment != '0000-00-00'}">
					<span class="employment"> ${employee_member_list.employment} </span>
				</c:if>
				
				<span class="rate"> ${employee_member_list.rate}%</span>
				</div>
			</c:forEach>
		</form:form>		
		
	</div>
</body>
</html>