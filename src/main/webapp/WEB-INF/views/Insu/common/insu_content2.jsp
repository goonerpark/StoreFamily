<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	
	function insu_list(ch_member_id)
	{
		document.insu_content.ch_member_id.value = ch_member_id;
		document.insu_content.action = 'insu_list';
		document.insu_content.submit();
	}
	function insu_delete(bno)
	{
		document.insu_content.bno.value = bno;
		document.insu_content.action = 'insu_delete';
		document.insu_content.submit();
	}
	
	function insu_ok(bno)
	{
		document.insu_reply.bno.value = bno;
		document.insu_reply.action = 'insu_ok';
		document.insu_reply.submit();
	}
	
	function insu_no(bno)
	{
		document.insu_reply.bno.value = bno;
		document.insu_reply.action = 'insu_no';
		document.insu_reply.submit();
	}
</script>
<body>
<form:form modelAttribute="insu_content" name="insu_content" method="post">
<input type="hidden" name="bno">
<input type="hidden" name="ch_member_id">
<table border="1">
	<tr>
		<td> 제목 </td>
		<td colspan="3"> ${insu_content.title} </td>
	</tr>
	
	<tr>
		<td> 작성자 </td>
		<td colspan="3"> ${insu_content.name} </td>
	</tr>
	
	<tr>
		<td> 승인/총 </td>
		<td> ${insu_content.chk} / ${insu_content.reply_chong} </td> 
		<td> 조회수 </td>
		<td> ${insu_content.viewcnt} </td>
	</tr>
	
	<tr> 
		<td> 인수인계 내용 </td>
		<td colspan="3"> ${insu_content.content} </td>
	</tr>
	
	
	<tr>
		<td>
			<button onclick="insu_list('${insu_content.ch_member_id}')"> ← </button>
			<c:if test="${insu_content.id == id}">
			<button onclick="insu_update(${insu_content.bno})"> 수정하기 </button>
			<button onclick="insu_delete(${insu_content.bno})"> 삭제하기 </button>
			</c:if>
		</td>
	</tr>
	
</table>
</form:form>

<form name="insu_reply" method="post">
<input type="hidden" name="bno">
<input type="hidden" name="insu_bno" value="${insu_content.bno}">
<table border="1">
	<tr>
		<th> 작성자 </th>
		<th> 댓글 </th>
		<th> 승인/반려/미확인 </th>
	</tr>
	
	<c:if test="${insu_reply != null}">
	<c:forEach items="${insu_reply}" var="insu_reply" varStatus="status">
	<tr>
		<td> ${insu_reply.name} </td>
		<td> ${insu_reply.content} </td>
		<c:if test="${position == '사장'}">
		<td>
			<button onclick="insu_ok(${insu_reply.bno})"> 승인 </button>
			<button onclick="insu_no(${insu_reply.bno})"> 반려 </button>
			<c:if test="${insu_reply.chk == 0}"> 미확인 </c:if>
			<c:if test="${insu_reply.chk == 1}"> 승인 </c:if>
			<c:if test="${insu_reply.chk == 2}"> 반려 </c:if>
		</td>
		</c:if>
		
		<c:if test="${position == '직원'}">
		<td>
			<c:if test="${insu_reply.chk == 0}"> 미확인 </c:if>
			<c:if test="${insu_reply.chk == 1}"> 승인 </c:if>
			<c:if test="${insu_reply.chk == 2}"> 반려 </c:if>
		</td>
		</c:if>
	</tr>
	</c:forEach>
	</c:if>
</table>
</form>

<form name="insu_content_reply" method="post" action="insu_content_reply">
<input type="hidden" name="insu_bno" value="${insu_content.bno}">
<table>
	<tr>
		<td>
			<textarea rows="3" cols="40" name="content"></textarea>
			<button type="submit"> 답글등록 </button>
		</td>
	</tr>
</table>
</form>

</body>
</html>