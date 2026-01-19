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
	
	.img_main {
		position: relative;
	}
	
	button {
		border: none;
		background: none;
	}
		
	.img_text_update {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -65%, -40% );
		font-family: esamanru Light;
		font-size: 15px;
  	}
  	
  	.img_text_delete {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -40% );
		font-family: esamanru Light;
		font-size: 15px;
  	}
  	
  	.img_main_update {
  		margin-left: 130px;
  		margin-right: -10px;
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
	
	.imfo {
		padding-left: 10px;
	}
	
	.imfo_suv {
		padding: 10px;
	}
	
	.imfo_text {
		font-family: MBC M2;
		font-size: 18px;
		border-right: 1px solid #F3F1EA;
		display: inline-block;
		width: 100px;
		vertical-align: top;
	}
	
	.imfo_data {
		display: inline-block;
		width: 300px;
		vertical-align: top;
		font-family: GmarketSansTTFMedium;
		text-align: center;
	}
	
	.imfo_data input {
		border: none;
		outline: none;
	}
	
</style>
<script>
	window.onload = function() {
		var now = new Date();		
		now = now.toDateString();
		now = new Date(now);
		
		var health_end = new Date('${employee_member_imformation.health}');
		health_end.setDate(health_end.getDate() + 365);
		health_end  = health_end.toDateString();
		health_end = new Date(health_end);
		
		var health_gap = health_end.getTime() - now.getTime();
		health_gap = Math.ceil(health_gap / (1000 * 60 * 60 * 24));
		//alert(health_gap+1);
		document.getElementById("health_dday").innerHTML = health_gap;
		
		
		var employment_start = new Date('${employee_member_imformation.employment}');
		employment_start = employment_start.toDateString();
		employment_start = new Date(employment_start);

		var employment_gap = now.getTime() - employment_start.getTime();
		employment_gap = Math.ceil(employment_gap / (1000 * 60 * 60 * 24));
		
		document.getElementById("employment_dday").innerHTML = employment_gap + 1;
		
	}
	function employee_member_imformation2(bno)
	{
		document.employee_member_list.bno.value = bno;
		document.employee_member_list.action='employee_member_imformation';
		document.employee_member_list.submit();
	}
	
	function employee_member_update(bno)
	{
		alert("수정되었습니다.");
		document.employee_member_imformation.bno.value=bno;
		document.employee_member_imformation.action='employee_member_update';
		document.employee_member_imformaiton.submit();
	}
	
	function employee_member_delete(bno)
	{
		alert("삭제되었습니다.");
		document.employee_member_imformation.bno.value=bno;
		document.employee_member_imformation.action='employee_member_delete';
		document.employee_member_imformaiton.submit();
	}
	
</script>
</head>
<body>
	<div id="list">
		<form:form modelAttribute="employee_member_imformation" name="employee_member_imformation" method="post">
		<input type="hidden" name="bno">
		<div class="list_text"> 
			<img src="resources/img/employee.png" width="30"> 
			<span> 직원 정보 </span>
			<span class="img_main img_main_update"> 
			<button onclick="employee_member_update(${employee_member_imformation.bno})">
				<img src="resources/img/employ_update.png" width="60">
				<span class="img_text_update"> 수정 </span>
			</button>
			</span>
			
			<span class="img_main"> 
			<button onclick="employee_member_delete(${employee_member_imformation.bno})">
				<img src="resources/img/employ_delete.png" width="60">
				<span class="img_text_delete"> 삭제 </span>
			</button>
			</span>
		</div>
		<hr>
		
		<div class="imfo">
			<div class="imfo_suv">
				<div class="imfo_text"> 이름(성별) </div>
				<div class="imfo_data">
					${employee_member_imformation.name} 
					<c:if test="${employee_member_imformation.gender == 'female'}">
						( 여 ) 
					</c:if>
					<c:if test="${employee_member_imformation.gender == 'male'}">
						( 남 )
					</c:if>
				</div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 생년월일 </div>
				<div class="imfo_data"> ${employee_member_imformation.bth} </div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 주소 </div>
				<div class="imfo_data">${employee_member_imformation.address} ${employee_member_imformation.address_etc} </div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 전화번호 </div>
				<div class="imfo_data">${employee_member_imformation.phone} </div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 보건증 </div>
				<div class="imfo_data">
					<input type="date" name="health" value="${employee_member_imformation.health}"> 
					<c:if test="${employee_member_imformation.health != '0000-00-00'}">
					( D - <span id="health_dday"> </span> )
					</c:if>
				</div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 입사일 </div>
				<div class="imfo_data">
					<input type="date" name="employment" value="${employee_member_imformation.employment}"> 
					<c:if test="${employee_member_imformation.employment != '0000-00-00'}">
					( <span id="employment_dday"> </span>일째) 
					</c:if>
				</div>
			</div>
			
			<div class="imfo_suv">
				<div class="imfo_text"> 근태율 </div>
				<div class="imfo_data">${employee_member_imformation.rate} %</div>
			</div>
		</div>
		</form:form>
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
		
		<div class="con_text"> 직원 리스트 </div>
		<hr class="con_hr">
		
		
		<form:form modelAttribute="employee_member_list" name="employee_member_list" method="post">
		<input type="hidden" name="bno">
			<c:forEach var="employee_member_list" items="${employee_member_list}" varStatus="status">
				<div class="member_list" onclick="employee_member_imformation2(${employee_member_list.bno})">
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