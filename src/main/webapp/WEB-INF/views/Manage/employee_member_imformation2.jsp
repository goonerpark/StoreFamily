<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function start(health,employment) {
	var now = new Date();		
	now = now.toDateString();
	now = new Date(now);
	
	var health_end = new Date(health);
	health_end.setDate(health_end.getDate() + 365);
	health_end  = health_end.toDateString();
	health_end = new Date(health_end);
	
	var health_gap = health_end.getTime() - now.getTime();
	health_gap = Math.ceil(health_gap / (1000 * 60 * 60 * 24));
	//alert(health_gap+1);
	document.getElementById("health_dday").innerHTML = health_gap;
	
	
	var employment_start = new Date(employment);
	employment_start = employment_start.toDateString();
	employment_start = new Date(employment_start);

	var employment_gap = now.getTime() - employment_start.getTime();
	employment_gap = Math.ceil(employment_gap / (1000 * 60 * 60 * 24));
	
	document.getElementById("employment_dday").innerHTML = employment_gap + 1;
	
}

	function employee_member_update(bno)
	{
		document.employee_member_imformation.bno.value=bno;
		document.employee_member_imformation.action='employee_member_update';
		document.employee_member_imformaiton.submit();
	}
	
	function employee_member_delete(bno)
	{
		document.employee_member_imformation.bno.value=bno;
		document.employee_member_imformation.action='employee_member_delete';
		document.employee_member_imformaiton.submit();
	}
	
	function employee_member_list()
	{
		document.employee_member_imformation.action='employee_member_list';
		document.employee_member_imformaiton.submit();
	}
	
</script>
</head>
<body onload="start('${employee_member_imformation.health}','${employee_member_imformation.employment}')">
<form:form modelAttribute="employee_member_imformation" name="employee_member_imformation" method="post">
<input type="hidden" name="bno">
<table border="1">
	<tr>
		<td> 이름(남/여) </td>
		<td> 
			${employee_member_imformation.name} 
			<c:if test="${employee_member_imformation.gender == 'female'}">
			( 여 ) 
			</c:if>
			<c:if test="${employee_member_imformation.gender == 'male'}">
			( 남 )
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td> 생년월일 </td>
		<td> ${employee_member_imformation.bth} </td>
	</tr>
	
	<tr>
		<td> 주소 </td>
		<td> ${employee_member_imformation.address} ${employee_member_imformation.address_etc} </td>
	</tr>
	
	<tr>
		<td> 핸드폰 번호 </td>
		<td> ${employee_member_imformation.phone} </td>
	</tr>
	
	<tr>
		<td> 보건증 </td>
		<td> 
			<input type="date" name="health" value="${employee_member_imformation.health}"> 
			<c:if test="${employee_member_imformation.health != '0000-00-00'}">
			( D - <span id="health_dday"> </span> )
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td> 입사일 </td>
		<td>
			<input type="date" name="employment" value="${employee_member_imformation.employment}"> 
			<c:if test="${employee_member_imformation.employment != '0000-00-00'}">
			( <span id="employment_dday"> </span>일째) 
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td> 근태율 </td>
		<td> ${employee_member_imformation.rate} % </td>
	</tr>
	
	<tr>
		<td colspan="2">
			<button onclick="employee_member_list()"> ← </button>
			<button onclick="employee_member_update(${employee_member_imformation.bno})"> 수정하기 </button>
			<button onclick="employee_member_delete(${employee_member_imformation.bno})"> 삭제하기 </button>
		</td>
	</tr>
</table>
</form:form>
</body>
</html>