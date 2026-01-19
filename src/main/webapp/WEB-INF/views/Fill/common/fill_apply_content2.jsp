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
	/* window.onload = function() {
		var resume_bno = ${resume_bno};
		
	} */
	
	function fill_registrar_ok(bno)
	{
		document.fill_apply_content.bno.value=bno;
		document.fill_apply_content.action = 'fill_registrar_ok';
		document.fill_apply_content.submit();
	}
	
	function fill_registrar_cancle(bno)
	{
		document.fill_apply_content.bno.value=bno;
		document.fill_apply_content.action = 'fill_registrar_cancle';
		document.fill_apply_content.submit();
	}
	
	function fill_apply(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_cancle(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply_cancle';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_ok(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action='fill_apply_ok';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_no(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action = 'fill_apply_no';
		document.fill_apply_content.submit();
	}
	
	function fill_apply_resume_change(bno)
	{
		document.fill_apply_content.bno.value = bno;
		document.fill_apply_content.action = 'fill_apply_resume_change';
		document.fill_apply_content.submit();
	}
	
	function resume_content(resume_bno)
	{
		document.fill_apply_content.resume_bno.value = resume_bno;
		document.fill_apply_content.action = 'apply_resume_content';
		document.fill_apply_content.submit();
	}
</script>
</head>
<body>
<form:form modelAttribute="fill_apply_content" name="fill_apply_content" method="post">
<input type="hidden" name="bno">
<input type="hidden" name="w_name" value="${fill_apply_content.name}">
<input type="hidden" name="schedule_bno" value="${fill_apply_content.schedule_bno}">
<input type="hidden" name="fill_bno" value="${fill_apply_content.bno}">
<input type="hidden" name="w_code" value="${fill_apply_content.code}">
<input type="hidden" name="w_id" value="${fill_apply_content.id}">
<!-- <input type="hidden" name="resume_bno"> -->
<table border="1">
	<tr>
		<td> 작성일 </td>
		<td> ${fill_apply_content.sign_day} </td>
		<td> 작성자 </td>
		<td> ${fill_apply_content.name} </td>
	</tr>
	
	<tr>
		<td> 제목 </td>
		<td colspan="3"> ${fill_apply_content.title} </td>
	</tr>
	
	<c:if test="${fill_apply_content.bussiness != null}">
	<tr>
		<td> 사업자명 </td>
		<td> ${fill_apply_content.bussiness} </td>
		<td> 분야 </td>
		<td> ${fill_apply_content.field} </td>
	</tr>
	
	<tr>
		<td> 지역 </td>
		<td colspan="3"> ${local_do} ${local_si} </td>
	</tr>
	</c:if>
	
	<tr>
		<td> 대타 날짜 </td>
		<td> ${fill_apply_content.fill_day} </td>
		<td> 대타 시간 </td>
		<td> ${fill_apply_content.fill_start_time} ~ ${fill_apply_content.fill_end_time} ( ${fill_apply_content.fill_di_time} ) </td>
	</tr>
	
	<tr>
		<td> 대타 사유 </td>
		<td colspan="3"> ${fill_apply_content.content} </td>
	</tr>
	
	<c:forEach items="${this_apply_list}" var="this_apply_list" varStatus="status">
		<c:if test="${position == '직원' || position == '사장' && fill_apply_content.code != code}">	
	<tr>
		<td colspan="4"> 지원자 </td> 
	</tr>
		<tr>
			<td colspan="4"> ${this_apply_list.m_name} </td>
		</tr>
		</c:if>
		
		<c:if test="${position == '사장' && fill_apply_content.code == code}">
		<tr>
			<td colspan="2">
				${this_apply_list.m_name}
				<a href="apply_resume_content?resume_bno=${this_apply_list.resume_bno}"> 이력서 보기 </a>
			</td>
			<td colspan="2">
				<button onclick="fill_apply_ok(${this_apply_list.bno})"> 승인 </button>
				<button onclick="fill_apply_no(${this_apply_list.bno})"> 반려 </button>
				<c:if test="${this_apply_list.chk == 1}">
				승인
				</c:if>
				<c:if test="${this_apply_list.chk == 2}">
				반려
				</c:if>
			</td>
		</tr>
		</c:if>
	</c:forEach>
	
	<c:if test="${position == '사장'}">
		<c:if test="${fill_apply_content.chk == 0}">
		<tr>
			<td colspan="4"> <button onclick="fill_registrar_ok(${fill_apply_content.bno})"> 등록 승인 </button> </td>
		</tr>
		</c:if>
		
		<c:if test="${fill_apply_content.chk == 1}">
		<tr>
			<td colspan="4"> <button onclick="fill_registrar_cancle(${fill_apply_content.bno})"> 등록 승인 취소 </button> </td>
		</tr>
		</c:if>
	</c:if>
	
	<c:if test="${position == '직원'}">
		<c:if test="${count == 0}">
		<c:forEach items="${my_resume_list}" var="my_resume_list" varStatus="status">
			<tr>
				<td> <input type="radio" name="resume_bno" id="resume_bno" value="${my_resume_list.bno}"> </td>
				<td colspan="3"> ${my_resume_list.title} </td>
			</tr>
		</c:forEach>
		<tr>
			<td> <button onclick="fill_apply(${fill_apply_content.bno})"> 지원하기 </button> </td>
		</tr>
		</c:if>
		
		<c:if test="${count == 1}">
		<c:forEach items="${my_resume_list}" var="my_resume_list" varStatus="status">
			<tr>
				<td> <input type="radio" name="resume_bno" id="${my_resume_list.bno}" value="${my_resume_list.bno}"> </td>
				<td colspan="3"> ${my_resume_list.title} </td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4"> 
				<button onclick="fill_apply_resume_change(${fill_apply_content.bno})"> 이력서 변경 </button>
				<button onclick="fill_apply_cancle(${fill_apply_content.bno})"> 지원취소 </button>
			</td>
		</tr>
		</c:if>
	</c:if>
</table>
</form:form>
</body>
</html>