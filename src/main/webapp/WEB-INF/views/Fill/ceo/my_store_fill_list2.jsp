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
		document.fill_apply_list.bno.value = bno;
		document.fill_apply_list.action = 'fill_apply_content';
		document.fill_apply_list.submit();
	}
</script>
</head>
<body>
<a href="fill"> 내 매장 대타 리스트 </a>
<a href="fill_all_list"> 대타 전체 리스트 </a>
<form:form modelAttribute="fill_apply_list" name="fill_apply_list" method="post">
<input type="hidden" name="bno" id="bno">
<table border="1">
	<tr>
		<td> 번호 </td>
		<td> 제목 </td>
		<td> 대타 날짜 </td>
		<td> 대타 시간 </td>
		<td> 작성자 </td>
		<td> 상태 </td>
	</tr>
	
	<c:forEach items="${my_store_fill_list}" var="my_store_fill_list" varStatus="status">
	<tr>
		<td> ${my_store_fill_list.bno} </td>
		<td onclick="fill_apply_content(${my_store_fill_list.bno})"> ${my_store_fill_list.title} </td>
		<td> ${my_store_fill_list.fill_day} </td>
		<td> ${my_store_fill_list.fill_start_time} ~ ${my_store_fill_list.fill_end_time} </td>
		<td> ${my_store_fill_list.name} </td>
		
		<c:choose>
			<c:when test="${my_store_fill_list.chk == 0}">
			<td> 등록 대기 </td>
			</c:when>
			
			<c:when test="${my_store_fill_list.chk ==1}">
			<td> 등록 완료 </td>
			</c:when>
		</c:choose>
	</tr>
	</c:forEach>
	
</table>
</form:form>
</body>
</html>