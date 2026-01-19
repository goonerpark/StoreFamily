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
	function employee_member_imformation(bno)
	{
		document.employee_member_list.bno.value = bno;
		document.employee_member_list.action='employee_member_imformation';
		document.employee_member_list.submit();
	}
	
</script>
</head>
<body>
<form:form modelAttribute="employee_member_list" name="employee_member_list" method="post">
<input type="hidden" name="bno">
<table border="1">
	<tr>
		<td> 이름 </td>
		<td> 입사일 </td>
		<td> 근태율 </td>
	</tr>
	
	<c:forEach var="employee_member_list" items="${employee_member_list}" varStatus="status">
	<tr>
		<td onclick="employee_member_imformation(${employee_member_list.bno})"> ${employee_member_list.name} </td>
		<c:if test="${employee_member_list.employment == '0000-00-00'}">
		<td> 미등록 </td>
		</c:if>
		<c:if test="${employee_member_list.employment != '0000-00-00'}">
		<td> ${employee_member_list.employment} </td>
		</c:if>
	</tr>
	</c:forEach>
</table>
</form:form>
</body>
</html>