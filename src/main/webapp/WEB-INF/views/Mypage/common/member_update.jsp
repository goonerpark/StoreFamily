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
<script type="text/javascript"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>Insert title here</title>
<script>
	window.onload = function() {
		
		//년
		var bth1 = document.getElementById("bth1");
		var bth1_len = bth1.options.length;
		var my_bth1 = document.getElementById("my_bth1").value;
		
		for(var i=0; i<bth1_len; i++)
		{
			if(bth1.options[i].value==my_bth1)
			{
				bth1.options[i].selected = true;
			}
		}
		
		//월
		var bth2 = document.getElementById("bth2");
		var bth2_len = bth2.options.length;
		var my_bth2 = document.getElementById("my_bth2").value;
		
		for(var i=0; i<bth2_len; i++)
		{
			if(bth2.options[i].value==my_bth2)
			{
				bth2.options[i].selected = true;
			}
		}
		
		//일
		var bth3 = document.getElementById("bth3");
		var bth3_len = bth3.options.length;
		var my_bth3 = document.getElementById("my_bth3").value;
		
		for(var i=0; i<bth3_len; i++)
		{
			if(bth3.options[i].value==my_bth3)
			{
				bth3.options[i].selected = true;
			}
		}
		
		//성별
		var gender = document.getElementsByName("gender");
        var my_gender = document.getElementById("my_gender").value;

        for (var i = 0; i < gender.length; i++) {
            if (gender[i].value === my_gender) {
                gender[i].checked = true;
            }
        }
	}
	
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
			document.my_imformation.email.value = email;
			
			//생년월일 합치기
			var bth = bth1.value + "/" + bth2.value + "/" + bth3.value;
			document.my_imformation.bth.value = bth;
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
		          
		          document.my_imformation.address.value = "(" + data.zonecode + ")" + addr;
		          // 커서를 상세주소 필드로 이동한다.
		          document.my_imformation.address_etc.focus();
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
		
		function member_update_ok()
		{
			document.my_imformation.action = 'member_update_ok';
			document.my_imformation.submit();
		}
</script>
</head>
<body>
<form:form modelAttribute="my_imformation" name="my_imformation" method="post">
<input type="hidden" name="bno" value="${my_imformation.bno}">
<input type="hidden" name="position" value="${my_imformation.position}">
<input type="hidden" id="my_bth1" value="${my_imformation.bth1}">
<input type="hidden" id="my_bth2" value="${my_imformation.bth2}">
<input type="hidden" id="my_bth3" value="${my_imformation.bth3}">
<input type="hidden" id="my_gender" value="${my_imformation.gender}">
<input type="hidden" name="email" value="${my_imformation.email}">
<input type="hidden" name="bth" value="${my_imformation.bth}">
<table border="1">
	<tr>
		<td> 이름 </td>
		<td> ${my_imformation.name} </td>
	</tr>
	
	<tr>
		<td> 아이디 </td>
		<td> ${my_imformation.id} </td>
	</tr>
	
	<tr>
		<td> 비밀번호 </td>
		<td> <input type="password" name="pwd"> </td>
	</tr>
	
	<tr>
		<td> 이메일 </td>
		<td> 
			<input type="text" id="email1" value="${my_imformation.email1}" onchange="combine()"> @
			<input type="text" id="email2" value="${my_imformation.email2}" oninput="combine()">
		</td>
	</tr>
	
	<c:set var="now" value="<%=new java.util.Date() %>"/>
	<c:set var="now_year"> <fmt:formatDate value="${now}" pattern="yyyy"/> </c:set>
	<tr>
		<td> 생년월일 </td>
		<td>
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
		<td> 성별 </td>
		<td>
			<input type="radio" name="gender" value="male"> 남
			<input type="radio" name="gender" value="female"> 여
		</td>
	</tr>
	
	<tr>
		<td> 주소 </td>
		<td>
			<input type="text" id="address" name="address" value="${my_imformation.address}" readonly>
			<input type="button" id="btn1" onclick="juso_search()" value="주소검색">
		</td>
	</tr>
	
	<tr>
		<td> 상세주소 </td>
		<td>
			<input type="text" name="address_etc" value="${my_imformation.address_etc}">
		</td>
	</tr>
	
	<tr>
		<td> 전화번호 </td>
		<td>
			<input type="text" id="phone" name="phone" value="${my_imformation.phone}">
			<input type="button" id="btn2" value="인증번호전송">
		</td>
	</tr>
	
	<tr>
		<td> 인증번호 </td>
		<td>
			<input type="text" id="phone2" disabled required>
			<input type="button" id="btn3" value="인증하기" style="display: none;">
		</td>
	</tr>
	
	<tr>
		<td> 매장코드 </td>
		<td> ${code} </td>
	</tr>
	
	<tr>
		<td colspan="2"> <button onclick="member_update_ok()"> 회원가입 </button> </td>
	</tr>
</table>
</form:form>
</body>
</html>