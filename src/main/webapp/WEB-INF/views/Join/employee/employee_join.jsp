<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		
	var email1 = document.getElementById('email1');
	var email2 = document.getElementById("email2");
	var bth1 = document.getElementById("bth1");
	var bth2 = document.getElementById("bth2");
	var bth3 = document.getElementById("bth3");
	var btn1 = document.getElementById("btn1");
	
	//sms문자전송
	var code = "";
	$("#btn2").click(function(){
		alert("인증번호 발송이 완료되었습니다. \n휴대폰에서 인증번호 확인을 해주십시오.");
		var phone = $("#phone").val();
		$.ajax({
			type:"GET",
			url:"phoneCheck?phone="+phone,
			cache:false,
			success:function(data){
				if(data == "error") {
					alert("휴대폰 번호가 올바르지 않습니다.");
					$("#phone").attr("autofocus",true);
				}
				else {
					$("#phone2").attr("disabled",false);
					$("#btn3").css("display","inline-block");
					$("#phone").attr("readonly",true);
					code = data;
					alert(code);
				}
			}
		});
	});
	
	//인증번호 확인
	$("#btn3").click(function(){
		if($("#phone2").val() == code) {
			alert("인증번호가 일치합니다.");
			$("#phone2").attr("disabled",true);
		}
		else {
			alert("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.")
			$(this).attr("autofocus",true);
		}
		
	});
	
	function combine()
	{
		//이메일 합치기
		var email = email1.value + "@" + email2.value;
		document.join.email.value = email;
		
		//생년월일 합치기
		var bth = bth1.value + "/" + bth2.value + "/" + bth3.value;
		document.join.bth.value = bth;
	}
	
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
	          
	          document.join.address.value = "(" + data.zonecode + ")" + addr;
	          // 커서를 상세주소 필드로 이동한다.
	          document.join.address_etc.focus();
	      }
	    }).open();
	  }
	
	 // combine 함수를 호출하는 이벤트 핸들러를 등록합니다.
	  email1.addEventListener('change', combine);
	  email2.addEventListener('input', combine);
	  bth1.addEventListener('change', combine);
	  bth2.addEventListener('change', combine);
	  bth3.addEventListener('change', combine);
	  btn1.addEventListener('click', juso_search);
	});
	
	function join_ok()
	{
		document.join.action = 'join_ok';
		document.join.submit();
	}
</script>
</head>
<body>
<form:form modelAttribute="join" name="join" method="post">
<input type="hidden" name="position" value="직원">
<input type="hidden" name="email">
<input type="hidden" name="bth">
<table border="1">
	<tr>
		<td> <input type="text" name="name" placeholder="이름"> </td>
	</tr>
	
	<tr>
		<td>
			<input type="text" id="id" name="id" placeholder="아이디">
			<input type="button" id="check_userid" value="중복체크" onclick="check_userid()">
		</td>
	</tr>
	
	<tr>
		<td> <input type="password" name="pwd" placeholder="비밀번호"> </td>
	</tr>
	
	<tr>
		<td> <input type="password" placeholder="비밀번호 확인"> </td>
	</tr>
	
	<tr>
		<td> 
			<input type="text" id="email1" placeholder="이메일" onchange="combine()"> @
			<input type="text" id="email2" oninput="combine()">
			<select id="email3">
				<option> 직접입력하기 </option>
				<option value="naver.com"> naver.com </option>
				<option value="gmail.com"> gmail.com </option>
				<option value="daum.net"> daum.net </option>
				<option value="hanmail.net"> hanmail.net </option>
				<option value="yahoo.co.kr"> yagoo.co.kr </option>
			</select>
		</td>
	</tr>
	
	<c:set var="now" value="<%=new java.util.Date() %>"/>
	<c:set var="now_year"> <fmt:formatDate value="${now}" pattern="yyyy"/> </c:set>
	<tr>
		<td>
			생년월일
			<select id="bth1" onchange="combine()">
			<option> 년도 </option>
			<c:forEach var="y" begin="0" end="${now_year - 1900}">
				<option value="${now_year - y}"> ${now_year - y} </option>
			</c:forEach>
			</select> 년
			
			<select id="bth2" onchange="combine()">
			<option> 월 </option>
			<c:forEach var="m" begin="1" end="12">
				<option value="${m}"> ${m} </option>
			</c:forEach>
			</select>월
			
			<select id="bth3" onchange="combine()">
			<option> 일 </option>
			<c:forEach var="d" begin="1" end="31">
				<option value="${d}"> ${d} </option>
			</c:forEach>
			</select>일
		</td>
	</tr>
	
	<tr>
		<td>
			성별
			<input type="radio" name="gender" value="male"> 남
			<input type="radio" name="gender" value="female"> 여
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" id="address" name="address" placeholder="주소" readonly>
			<input type="button" id="btn1" onclick="juso_search()" value="주소검색">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" name="address_etc" placeholder="상세주소">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" id="phone" name="phone" placeholder="전화번호">
			<input type="button" id="btn2" value="인증번호전송">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" id="phone2" placeholder="인증번호" disabled required>
			<input type="button" id="btn3" value="인증하기" style="display: none;">
		</td>
	</tr>
	
	<tr>
		<td> <input type="text" name="code" placeholder="매장코드" value="${code}"> </td>
	</tr>
	
	<tr>
		<td>
			<button onclick="join_ok()"> 회원가입 </button>
		</td>
	</tr>
</table>
</form:form>
</body>
</html>