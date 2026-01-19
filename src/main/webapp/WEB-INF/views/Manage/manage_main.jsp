<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
	
	.invite {
		padding-left: 20px;
	}	
	
	.img_main_invite {
		position: relative;
	}
	
	.img_text_invite {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -50% );
		font-family: PyeongChangPeace-Bold;
		font-size: 15px;
		color: white;
  	}
  	
  	#name, #email {
  		border: 2px solid #BAB088;
		border-radius: 5px;
		outline: none;
		padding: 5px 10px 5px 10px;
		width: 300px;
		height: 45px;
		font-family: GmarketSansTTFMedium;
  	}
  	
  	.re_invite {
  		margin-left: 20px;
  		margin-right: 20px;
  		border-bottom: 1px solid #F2F2F2;
  	}
  	
  	.re_name {
  		font-family: GmarketSansTTFMedium;
  		font-size: 15px;
  		margin-right: 60px;
  	}
  	
  	.re_email {
  		font-family: GmarketSansTTFMedium;
  		font-size: 12px;
  		margin-right: 60px;
  	}
  	
  	.img_main_invite2 {
		position: relative;
	}
	
	.img_text_invite2 {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate( -50%, -30% );
		font-family: GmarketSansTTFBold;
		font-size: 15px;
		color: white;
  	}
</style>
<script>
	$(document).ready(function() {
		$("#employee_invite_ok").click(function(){
			var email = $("#email").val();
			var name = $("#name").val();
			var code = $("#code").val();
			if(!email) {
				alert("이메일을 입력하세요.");
				return;
			}
			$.ajax({
				url:"employee_invite_ok?email="+email+"&name="+name+"&code="+code,
				method: "GET",
				success: function(response) {
					alert("초대링크 보냄");
				},
				error: function(request, status, error) {
					console.log("AJAX 오류 발생");
				    console.log("request:", request);
				    console.log("status:", status);
				    console.log("error:", error);
				    
				    alert("전송 실패");
				}
			
				
			});
		});
		
		
		$("#employee_invite_ok2").click(function(){
			var email = $("#email2").val();
			var name = $("#name2").val();
			var code = $("#code2").val();
			if(!email) {
				alert("이메일을 입력하세요.");
				return;
			}
			$.ajax({
				url:"employee_invite_ok?email="+email+"&name="+name+"&code="+code,
				method: "GET",
				success: function(response) {
					alert("초대링크 보냄");
				},
				error: function(request, status, error) {
					console.log("AJAX 오류 발생");
				    console.log("request:", request);
				    console.log("status:", status);
				    console.log("error:", error);
				    
				    alert("전송 실패");
				}
			
				
			});
		});
	});
	
	function employee_chk_ok1(bno)
	{
		location.href="employee_chk_ok?bno="+bno+"&chk=0";
	}
	
	function employee_chk_no1(bno)
	{
		location.href="employee_chk_no?bno="+bno+"&chk=0";
	}
	
	function employee_chk_reset(bno)
	{
		location.href="employee_chk_reset?bno="+bno+"&chk=0";
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
				<button onclick="employee_chk_ok1(${employee_ok.bno})">
					<img src="resources/img/ok.png" width="50">
					<span class="img_text"> 승인 </span>
				</button>
				</span>
				
				<span class="img_main btn_no">
				<button onclick="employee_chk_no1(${employee_ok.bno})">
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
		    <a class="nav-link active" aria-current="page" href="manage_main"> <img src="resources/img/paper.png"> 직원 초대 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="employee_member_list" style="color:gray;"> 직원 목록 </a>
		  </li>
		</ul>
		
		<div class="con_text"> 직원 초대하기 </div>
		<hr class="con_hr">
		
		<div class="invite">
		<form:form modelAttribute="employee_invite" name="employee_invite" method="post">
		<input type="hidden" id="code" name="code" value="${code}"/>
		<table>
			<tr>
				<td> <input type="text" id="name" name="name" placeholder="이름"> </td>
				<td rowspan="2" class="img_main_invite">
					<button class="btn_login" id="employee_invite_ok"> 
					<img src="resources/img/btn_login.png" width="107">
					<span class="img_text_invite"> 초대링크 <br> 보내기 </span>
				</button>
				</td>
			</tr>
			
			<tr>
				<td> <input type="text" id="email" name="email" placeholder="이메일"> </td>
			</tr>
		</table>
		</form:form>
		</div>
		
		<hr class="con_hr">
		
		<div class="con_text"> 초대장 보낸 직원 리스트 </div>
		<hr class="con_hr">
		
		<div class="re_invite">
		<form name="employee_invite" method="post">
		<c:forEach var="employee_invite" items="${employee_invite}" varStatus="status">
		<input type="hidden" name="email" id="email2" value="${employee_invite.email}">
		<input type="hidden" name="name" id="name2" value="${employee_invite.name}">
		<input type="hidden" name="code" id="code2" value="${employee_invite.code}">
		<span class="re_name"> ${employee_invite.name} </span>
		<span class="re_email"> ${employee_invite.email}</span>
		<span class="img_main_invite2">
			<button id="employee_invite_ok2"> 
				<img src="resources/img/btn_invite.png" width="100">
				<span class="img_text_invite2"> 재발송 </span>
			</button>
		</span>
		</c:forEach>
		</form>		
		</div>
	</div>
</body>
</html>