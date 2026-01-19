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
});
	
	function employee_chk_ok(bno)
	{
		document.employee_ok.bno.value = bno;
		document.employee_ok.action = 'employee_chk_ok';
		document.employee_ok.submit();
	}
	
	function employee_chk_no(bno)
	{
		document.employee_ok.bno.value = bno;
		document.employee_ok.action = 'employee_chk_no';
		document.employee_ok.submit();
	}
	
	function employee_chk_reset(bno)
	{
		document.employee_ok.bno.value = bno;
		document.employee_ok.action = 'employee_chk_reset';
		document.employee_ok.submit();
	}
</script>
</head>
<body>
<a href="employee_invite"> 직원초대 </a>
<a href="employee_member_list"> 직원목록 </a>
<p> 초대장 보낸 직원 </p>
<form name="employee_invite" method="post">
<table border="1">
	<tr>
		<td> 이름 </td>
		<td> 이메일 </td>
		<td> 다시보내기 </td>
	</tr>
	
	<c:forEach var="employee_invite" items="${employee_invite}" varStatus="status">
	<input type="hidden" name="email" id="email" value="${employee_invite.email}">
	<input type="hidden" name="name" id="name" value="${employee_invite.name}">
	<input type="hidden" name="code" id="code" value="${employee_invite.code}">
	<tr>
		<td> ${employee_invite.name} </td>
		<td> ${employee_invite.email} </td>
		<td> <input type="button" id="employee_invite_ok" value="댜시보내기"> </td>
	</tr>
	</c:forEach>
</table>
</form>

<p> 승인대기 직원 </p>
<form name="employee_ok" method="post">
<input type="hidden" name="bno">
<table border="1">
	<tr>
		<td> 이름 </td>
		<td> 승인 </td>
		<td> 반려 </td>
		<td> 상태(취소) </td>
	</tr>
	
	<c:forEach var="employee_ok" items="${employee_ok}" varStatus="status">
	<c:if test="${employee_ok.position ==  '사장'}">
	<tr>
		<td colspan="4"> ${employee_ok.name} ( ${employee_ok.position} ) </td>
	</tr>
	</c:if>
	
	<c:if test="${employee_ok.position == '직원' }">
	<tr>
		<td> ${employee_ok.name} </td>
		<td> <button onclick="employee_chk_ok(${employee_ok.bno})"> 승인 </button> </td>
		<td> <button onclick="employee_chk_no(${employee_ok.bno})"> 반려 </button> </td>
		<c:if test="${employee_ok.chk == 0}">
		<td> 대기 </td>
		</c:if>
		<c:if test="${employee_ok.chk == 1}">
		<td> 승인 <button onclick="employee_chk_reset(${employee_ok.bno})"> 취소 </button> </td>
		</c:if>
		<c:if test="${employee_ok.chk == -1}">
		<td> 반려 <button onclick="employee_chk_reset(${employee_ok.bno})"> 취소 </button> </td>
		</c:if>
	</tr>
	</c:if>
	</c:forEach>
</table>
</form>
</body>
</html>