<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function resume_content(bno)
	{
		document.resume_list.bno.value = bno;
		document.resume_list.action = 'resume_content';
		document.resume_list.submit();
	}
	
	function resume_write()
	{
		document.resume_list.action = 'resume_write';
		document.resume_list.submit();
	}
	
</script>
</head>
<body>
<form:form modelAttribute="resume_list" name="resume_list" method="post">
<input type="hidden" name="bno">
<table border="1">
	<tr>
		<td> 번호 </td>
		<td> 제목 </td>
		<td> 작성일 </td>
	</tr>
	
	<c:forEach items="${resume_list}" var="resume_list" varStatus="status">
	<tr>
		<td> ${resume_list.bno} </td>
		<td onclick="resume_content(${resume_list.bno})"> ${resume_list.title} </td>
		<td> ${resume_list.sign_day} </td>
	</tr>
	</c:forEach>
	
	<tr>
		<td> <button onclick="resume_write()"> 이력서 작성하기 </button>
	</tr>
</table>
</form:form>
</body>
</html>