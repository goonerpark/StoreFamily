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
</head>
<body>
<table border="1">
	<tr>
		<td> 제목 </td>
		<td> ${resume_content.title} </td>
		<td> 작성일 </td>
		<td> ${resume_content.sign_day} </td>
	</tr>
	<c:forEach var ="work_place" items="${work_place}" varStatus="statusNm">
	<c:forEach var ="period" items="${period[statusNm.index]}" varStatus="status">
		<tr>
			<td> 근무지 </td>
			<td> ${work_place} </td>
			<td> 근무기간 </td>
			<td> ${period} </td>
		</tr>
	</c:forEach>
    <c:forEach var ="work_activity" items="${work_activity[statusNm.index]}" varStatus="status">
	    <tr>
	    	<td> 활동내용 </td>
			<td colspan="3"> ${work_activity} </td>
		</tr>
    </c:forEach>
</c:forEach>
	<tr>
		<td colspan="4"> <button onclick="javascript:history.back()"> ← </button> </td>
	</tr>
</table>
</body>
</html>