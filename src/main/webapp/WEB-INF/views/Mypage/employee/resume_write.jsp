<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	function resume_write_ok()
	{
		document.resume_write.action='resume_write_ok';
		document.resume_write.submit();
	}
	
	$(function () {
        $("input[name=AddCol]").click(function () {
            var newRow = $(".1rows").eq(0).clone(true);

            newRow.find('input[type="text"]').val('');
            newRow.find('textarea').val('');

            $("#box tbody").append(newRow);
            $("#box tr:last").attr('class', ($(".optionName").length + 'rows'));
            $("#box tr:last").find("td:first").removeAttr("rowspan");
        });
    });
	
	$(function(){
		$("input[name=AddCol]").click(function(){
			var newRow = $(".2rows").eq(0).clone(true);
			 newRow.find('input[type="text"]').val('');
	         newRow.find('textarea').val('');
			$("#box tbody").append(newRow);
			$("#box tr:last").attr('class',($(".optionName").length+'rows'));
			$("#box tr:last").find("td:first").removeAttr("rowspan");
		});
	});
	
</script>
</head>
<body>
<form:form modelAttribute="resume_write" name="resume_write" method="post">
<table border="1" id="box">
<tbody>
	<tr>
		<td> 제목 </td>
		<td colspan="3"> <input type="text" name="title"> </td>
	</tr>
	
	<tr class="1rows">
		<td class="optionName"> 근무지 </td>
		<td> <input type="text" name="work_place"> </td>
		<td> 근무기간 </td>
		<td> <input type="text" name="period" placeholder="년/개월"> </td>
	</tr>
		
	<tr class="2rows">
		<td  class="optionName"> 활동내용 </td>
		<td colspan="3"> <textarea rows="4" cols="60" name="work_activity"></textarea> </td>
	</tr>
</tbody>
</table>

		<tr>
		<td colspan="4"> <input type="button" name="AddCol" value="+"> </td>
	</tr>
	
	<tr>
		<td colspan="4"> 
			<button onclick="resume_write_ok()"> 이력서 작성하기 </button> 
		</td> 
	</tr>
	
</form:form>
</body>
</html>