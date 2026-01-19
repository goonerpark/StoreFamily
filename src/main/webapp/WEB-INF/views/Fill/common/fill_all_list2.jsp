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
	
	function fill_apply_content(bno)
	{
		document.fill_all_list.bno.value = bno;
		document.fill_all_list.action = 'fill_apply_content';
		document.fill_all_list.submit();
	}
	
	function fill_write()
	{
		document.fill_all_list.action='fill_write';
		document.fill_all_list.submit();
	}
	
	function resume_write()
	{
		document.fill_all_list.action='resume_write';
		document.fill_all_list.submit();
	}
</script>
</head>
<body>
<c:if test="${position == '사장'}">
<a href="fill"> 내 매장 대타 리스트 </a>
<a href="fill_all_list"> 대타 전체 리스트 </a>
</c:if>
<form:form modelAttribute="fill_all_list" name="fill_all_list" method="post">
<input type="hidden" name="bno">
<table border="1">	
	<tr>
		<td> 번호 </td>
		<td> 제목 </td>
		<td> 대타 날짜 </td>
		<td> 대타 시간 </td>
		<td> 작성자 </td>
		<td> 지원수 </td>
	</tr>
	
	<c:forEach items="${fill_all_list}" var="fill_all_list" varStatus="status">
	<tr>
		<td> ${fill_all_list.bno} </td>
		<td onclick="fill_apply_content(${fill_all_list.bno})"> ${fill_all_list.title} </td>
		<td> ${fill_all_list.fill_day} </td>
		<td> ${fill_all_list.fill_start_time} ~ ${fill_all_list.fill_end_time} </td>
		<td> ${fill_all_list.name} </td>
		<td> ${fill_all_list.apply_su} </td>
	</tr>
	</c:forEach>
		
	<c:if test="${position == '직원'}">
	<tr>
		<td colspan="6">
			<button onclick="fill_write()"> 대타요청 글 작성하기 </button>
			<button onclick="resume_write()"> 이력서 작성하기 </button>
		</td>
	</tr>
	</c:if>
	
	

</table>
</form:form>
</body>
</html>