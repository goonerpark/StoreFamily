<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
	          
	          document.join.bussinessaddress.value = "(" + data.zonecode + ")" + addr;
	          // 커서를 상세주소 필드로 이동한다.
	          document.join.bussinessaddress_etc.focus();
	      }
	    }).open();
	  }
	
	function getlocal_si(local_do_code)
	{
		var chk = new XMLHttpRequest();
		chk.open("get","getlocal_si?local_do_code="+local_do_code);
		chk.send();
		chk.onreadystatechange = function() {
			if(chk.readyState == 4)
			{
				//alert(chk.responseText.trim());
				var local_si = decodeURI(chk.responseText.trim());
				document.join.local_si.innerHTML = local_si;
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
				document.join.field.innerHTML = field;
			}
		}
	}
	
	function getcode()
	{
		var local_do = document.join.local_do.value;
		var local_si = document.join.local_si.value;
		var field = document.join.field.value;
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
				
				document.join.code.value = code_hap + code;
				
			}
		}
	}
	
	function join_ok()
	{
		document.join.action = 'join_ok';
		document.join.submit();
	}
</script>
</head>
<body>
<form:form modelAttribute="join" name="join" method="post">
<input type="hidden" name="name" value="${member.name}"/>
<input type="hidden" name="id" value="${member.id}"/>
<input type="hidden" name="pwd" value="${member.pwd}"/>
<input type="hidden" name="email" value="${member.email}"/>
<input type="hidden" name="bth" value="${member.bth}"/>
<input type="hidden" name="gender" value="${member.gender}"/>
<input type="hidden" name="address" value="${member.address}"/>
<input type="hidden" name="address_etc" value="${member.address_etc}"/>
<input type="hidden" name="phone" value="${member.phone}"/>
<input type="hidden" name="chk" value="1"/>
<input type="hidden" name="position" value="사장"/>
<table border="1">
	<tr>
		<td> <input type="text" name="bussiness" placeholder="사업자명"> </td>
	</tr>
	
	<tr>
		<td> <input type="text" name="bussinessnum" placeholder="사업자번호"> </td>
	</tr>
	
	<tr>	
		<td>
			<input type="text" id="bussinessaddress" name="bussinessaddress" placeholder="사업자주소" readonly>
			<input type="button" id="btn1" onclick="juso_search()" value="주소검색">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" name="bussinessaddress_etc" placeholder="상세주소">
		</td>
	</tr>
	
	<tr>
		<td>
			<select name="local_do" onchange="getlocal_si(this.value); getfield();">
			<option> 도/특별시/광역시 </option>
			<c:forEach items="${local_do}" var="local_do" varStatus="status">
				<option value="${local_do.code}"> ${local_do.local_do} </option>
			</c:forEach>
			</select>
			
			<select name="local_si">
			<option> 시/군/구 </option>
			</select>
			
			<select name="field">
			<option> 분야 </option>
			</select>
			
			<input type="button" onclick="getcode()" value="매장코드생성">
		</td>
	</tr>
	
	<tr>
		<td> <input type="text" name="code" placeholder="매장코드" readonly> </td>
	</tr>
	
	<tr>
		<td> <button onclick="join_ok()"> 회원가입 </button>
	</tr>
</table>
</form:form>
</body>
</html>