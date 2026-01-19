<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	//대타 신청기간
	function apply_date()
	{
		var apply_start_day = document.getElementById("apply_start_day");
		var apply_end_day = document.getElementById("apply_end_day");
		
		apply_end_day.min = apply_start_day.value;
	}
</script>
</head>
<body>
<form:form modelAttribute="fill_write" name="fill_write" method="post" action="fill_write_ok">
	<c:set var="now" value="<%=new java.util.Date() %>"/>
	<c:set var="now_date"> <fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/> </c:set>
	<table border="1">
		<tr>
			<td> 제목 </td>
			<td> <input type="text" name="title"> </td>
		</tr>
		
		<tr>
			<td> 대타 날짜 </td>
			<td>
			<select id="schedule_bno" name="schedule_bno">
				<c:forEach items="${my_schedule}" var="my_schedule" varStatus="status">
				<option value="${my_schedule.bno}"> ${my_schedule.day} ( ${my_schedule.start_time} ~ ${my_schedule.end_time} ) </option>
				</c:forEach>
			</select>
		</tr>
		
		<tr>
			<td> 대타 사유 </td>
			<td> <textarea rows="6" cols="40" name="content"></textarea> </td>
		</tr>
		
		<tr>
			<td> 대타 신청기간 </td>
			<td> <input type="date" name="apply_start_day" id="apply_start_day" min="${now_date}"> ~ 
				 <input type="date" name="apply_end_day" id="apply_end_day" min="${now_date}" onclick="apply_date()"> </td>
		</tr>
		
		<tr>
			<td colspan="2"> <button type="submit"> 대타 신청하기 </button> </td>
		</tr>
	</table>
</form:form>
</body>
</html>