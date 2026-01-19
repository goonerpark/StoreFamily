<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
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
</script>
</head>
<body>
<form:form modelAttribute="employee_invite" name="employee_invite" method="post">
<input type="hidden" id="code" name="code" value="${code}"/>
<table border="1">
	<tr>
		<td> <input type="text" id="name" name="name" placeholder="이름"> </td>
	</tr>
	
	<tr>
		<td> <input type="text" id="email" name="email" placeholder="이메일"> </td>
	</tr>
	
	<tr>
		<td> <input type="button" id="employee_invite_ok" value="초대링크보내기"> </td>
	</tr>
</table>
</form:form>
</body>
</html>