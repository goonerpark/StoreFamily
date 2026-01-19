<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.0.js"></script>
<script type="text/javascript">
	/* function insu_write_ok()
	{
		document.insu_write.action='insu_write_ok';
		document.insu_write.submit();
	} */
	
	function check(all)
	{
		var member = document.getElementsByName("checkBox");
		
		if(all.checked)
		{
			for(var i=1; i<member.length; i++)
				member[i].disabled = true;
		}
		else
		{
			for(var i=1; i<member.length; i++)
				member[i].disabled = false;
		}
	}
		
	$(document).ready(function(){
		var ch_member_id=[];
		$("input[name=checkBox]").change(function(){
			if($(this).is(":checked")){
				var th = $(this).val();
				ch_member_id.push(th);
				$("#ch_member_id").val(ch_member_id);
			}
			else{
				for(var i=0; i<ch_member_id.length; i++)
				{
					if(ch_member_id[i] == $(this).val())
					{
						ch_member_id.splice(i,1);
					}
					$("#ch_member_id").val(ch_member_id);
				}
			}
		});
	});
</script>
</head>
<body>
<form:form modelAttribute="insu" method="post" enctype="multipart/form-data" action="insu_write_ok">
<input type="hidden" name="code" value="${code}">
<input type="hidden" name="id" value="${id}">
<input type="hidden" name="ch_member_id" id="ch_member_id">
<table border="1">
	<tr>
		<td> 제목 </td>
		<td> <input type="text" name="title" id="title"> </td>
	</tr>
	
	<tr>
		<td> 내용 </td>
		<td>
			<textarea rows="4" cols="60" name="content"></textarea>
			<input type="file" name="insu_img" multiple="multiple">
		</td>
	</tr>
	
	<tr>
		<td> 작성자 </td>
		<td> <input type="hidden" name="name" value="${name}"> ${name} </td>
	</tr>
	
	<!-- <tr>
		<td> 근무타임 </td>
		<td>
		<select name="time">
			<option value="all"> 전근무자 </option>
			<option value="open"> 오픈 </option>
			<option value="middle"> 미들 </option>
			<option value="end"> 마감 </option>
		</select>
		</td>
	</tr> -->
	
	<tr>
		<td> 확인직원 </td>
		<td>
		<input type="checkbox" name="checkBox" value="all" onclick="check(this)"> 전근무자
		<c:forEach items="${member_list}" var="member_list" varStatus="status">
			<input type="checkbox" name="checkBox" value="${member_list.id}"> ${member_list.name}
		</c:forEach>
		</td>
	</tr>
	
	<tr>
		<td colspan="2"> <button type="submit"> 작성하기 </button> </td>
	</tr>
</table>
</form:form>
</body>
</html>