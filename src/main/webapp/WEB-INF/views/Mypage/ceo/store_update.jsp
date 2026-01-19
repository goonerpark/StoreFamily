<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function start(store_local_do,store_local_si,store_field)
	{
		var local_do = document.getElementById("local_do");
		for(var i=0; i<local_do.options.length; i++)
		{
			if(local_do.options[i].value == store_local_do)
				local_do.options[i].selected = true;
		}
		
		var local_si_select = document.getElementById("local_si");
		
		var chk = new XMLHttpRequest();
		chk.open("get","getlocal_si?local_do_code="+store_local_do);
		chk.send();
		chk.onreadystatechange = function() {
			if(chk.readyState == 4)
			{
				//alert(chk.responseText.trim());
				var local_si = decodeURI(chk.responseText.trim());
				document.store_update.local_si.innerHTML = local_si;
				
				for(var j=0; j<local_si_select.options.length; j++)
				{
					if(local_si_select.options[j].value == store_local_si)
						local_si_select.options[j].selected = true;
				}
			}
		}
		
		var field_select = document.getElementById("field");
		
		var chk2 = new XMLHttpRequest();
		chk2.open("get","getfield");
		chk2.send();
		chk2.onreadystatechange = function() {
			if(chk2.readyState == 4)
			{
				//alert(chk.responseText.trim());
				var field = decodeURIComponent(chk2.responseText.trim());
				document.store_update.field.innerHTML = field;
				
				for(var z=0; z<field_select.options.length; z++)
				{
					if(field_select.options[z].value == store_field)
						field_select.options[z].selected = true;
				}
			}
		}
		
	}//onload
	
	//주소찾기
	function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
	  {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        
	          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	              addr = data.roadAddress;
	          } else { // 사용자가 지번 주소를 선택했을 경우(J)
	              addr = data.jibunAddress;
	          }
	
	          // 우편번호와 주소 정보를 해당 필드에 넣는다.
	         // document.join.zip.value = data.zonecode; // 우편번호
	          //document.pkc.juso.value = addr;  // 주소
	          
	          document.store_update.bussinessaddress.value = "(" + data.zonecode + ")" + addr;
	          // 커서를 상세주소 필드로 이동한다.
	          document.store_update.bussinessaddress_etc.focus();
	      }
	    }).open();
	  }
	
	function getlocal_si(local_do_code)
	{
		document.store_update.code.value = null;
		
		var chk = new XMLHttpRequest();
		chk.open("get","getlocal_si?local_do_code="+local_do_code);
		chk.send();
		chk.onreadystatechange = function() {
			if(chk.readyState == 4)
			{
				//alert(chk.responseText.trim());
				var local_si = decodeURI(chk.responseText.trim());
				document.store_update.local_si.innerHTML = local_si;
			}
		}
	}
	
	function getfield()
	{
		var chk = new XMLHttpRequest();
		chk.open("get","getfield");
		chk.send();
		chk.onreadystatechange = function() {
			if(chk.readyState == 4)
			{
				//alert(chk.responseText.trim());
				var field = decodeURIComponent(chk.responseText.trim());
				document.store_update.field.innerHTML = field;
			}
		}
	}
	
	function getcode()
	{
		var local_do = document.store_update.local_do.value;
		var local_si = document.store_update.local_si.value;
		var field = document.store_update.field.value;
		var code_hap = local_do + local_si + field;
		
		var chk = new XMLHttpRequest();
		chk.open("get","getcode?code="+code_hap);
		chk.send();
		chk.onreadystatechange = function()
		{
			if(chk.readyState == 4)
			{
				var code = parseInt(chk.responseText) + 1;
				code = code + "";
				
				if(code.length == 1)
					code = "00" + code;
				else if(code.length == 2)
					code = "0" + code;
				
				document.store_update.code.value = code_hap + code;
				
			}
		}
	}
	
	function store_update_ok(bno)
	{
		document.store_update.bno.value = bno;
		document.store_update.action='store_update_ok';
		document.store_update.submit();
	}
	
</script>
</head>
<body onload="start('${store_imformation.local_do}','${store_imformation.local_si}','${store_imformation.field}')">
<select>
<c:forEach var="store_list" items="${getStore_list}" varStatus="status">
<option> ${store_list.bussiness} </option>
</c:forEach>
</select>

<form:form modelAttribute="store_update" name="store_update" method="post">
<input type="hidden" name="bno">
<input type="hidden" name="ex_code" value="${store_imformation.code}">
<table border="1">
	<tr>
		<td> 사업자명 </td>
		<td> <input type="text" name="bussiness" value="${store_imformation.bussiness}"> </td>
	</tr>
	
	<tr>
		<td> 사업자번호 </td>
		<td> ${store_imformation.bussinessnum} </td>
	</tr>
	
	<tr>
		<td> 사업자주소 </td>
		<td> 
			<input type="text" name="bussinessaddress" value="${store_imformation.bussinessaddress}" readonly> 
			<input type="button" id="btn1" onclick="juso_search()" value="주소검색">
		</td>
	</tr>
	
	<tr>
		<td> 상세주소 </td>
		<td> <input type="text" name="bussinessaddress_etc" value="${store_imformation.bussinessaddress_etc}"> </td>
	</tr>
	
	<tr>
		<td> 매장코드 </td>
		<td> ${store_imformation.code} </td>
	</tr>
	
	<tr>
		<td colspan="2"> <button onclick="store_update_ok(${store_imformation.bno})"> 수정하기 </button> </td>
	</tr>
</table>
</form:form>
</body>
</html>