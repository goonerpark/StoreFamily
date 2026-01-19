<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function insu_list(ch_member_id)
	{
		document.insu_list.ch_member_id.value = ch_member_id;
		document.insu_list.action = 'insu_list';
		document.insu_list.submit();
	}
	
	function insu_content(bno)
	{
		document.insu_list.bno.value = bno;
		document.insu_list.action = 'insu_content';
		document.insu_list.submit();
	}
	
	function insu_write()
	{
		document.insu_list.action='insu_write';
		document.insu_list.submit();
	}
</script>
</head>
<body>
<form:form modelAttribute="insu_list" name="insu_list" method="post">
<input type="hidden" name="ch_member_id">
<input type="hidden" name="bno">

<a href="javascript:insu_list('all');"> 전체 </a>
<a href="javascript:insu_list('${id}');"> 내 인수인계 </a>

<table border="1">
	<tr>
		<th> 번호 </th>
		<th> 제목 </th>
		<th> 작성자 </th>
		<th> 작성일 </th>
		<th> 승인/총 </th>
		<th> 조회수 </th>
	</tr>
	
	<c:forEach items="${insu_list}" var="insu_list" varStatus="status">
	<tr>
		<td> ${insu_list.bno} </td>
		<td onclick="insu_content(${insu_list.bno})"> ${insu_list.title} </td>
		<td> ${insu_list.name} </td>
		<td> ${insu_list.day} </td>
		<td> ${insu_list.chk} / ${insu_list.reply_chong} </td>
		<td> ${insu_list.viewcnt} </td>
	</tr>
	</c:forEach>
		
	<tr>
		<td colspan="7"> <button onclick="insu_write()"> 인수인계 작성하기 </button>
	</tr>
</table>
</form:form>
</body>
</html>