<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
body { font-family: Arial, sans-serif; max-width: 720px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
.row { margin-bottom: 12px; }
label { display: block; font-weight: 600; margin-bottom: 4px; }
input, select { width: 100%; padding: 8px; box-sizing: border-box; }
.inline { display: flex; gap: 8px; align-items: center; }
.inline input { flex: 1; }
.error { color: #b00020; font-size: 13px; display: block; margin-top: 4px; }
.guide { margin-bottom: 12px; padding: 10px; background: #f6f6f6; border-radius: 6px; }
</style>
<script>
function checkUserId() {
	const id = document.getElementById("id").value;
	if (!id) {
		alert("아이디를 먼저 입력해 주세요.");
		return;
	}
	fetch("${pageContext.request.contextPath}/check_userid?id=" + encodeURIComponent(id))
		.then(res => res.text())
		.then(count => {
			if (parseInt(count, 10) > 0) {
				alert("이미 사용 중인 아이디입니다.");
			} else {
				alert("사용 가능한 아이디입니다.");
			}
		})
		.catch(() => alert("아이디 중복 확인에 실패했습니다."));
}

function requestPhoneCode() {
	const phone = document.getElementById("phone").value;
	fetch("${pageContext.request.contextPath}/phoneCheck?phone=" + encodeURIComponent(phone))
		.then(res => res.json())
		.then(data => {
			document.getElementById("expectedCode").value = data.code;
			alert("인증번호를 발송했습니다. (개발용 코드: " + data.code + ")");
		})
		.catch(() => alert("인증번호 발송에 실패했습니다."));
}

function verifyPhoneCode() {
	const expected = document.getElementById("expectedCode").value;
	const input = document.getElementById("phoneCode").value;
	if (expected && expected === input) {
		alert("휴대폰 인증이 완료되었습니다.");
		document.getElementById("phoneVerified").value = "Y";
		return;
	}
	alert("인증번호가 올바르지 않습니다.");
	document.getElementById("phoneVerified").value = "N";
}

function jusoSearch() {
	new daum.Postcode({
		oncomplete: function(data) {
			let addr = "";
			if (data.userSelectedType === "R") {
				addr = data.roadAddress;
			} else {
				addr = data.jibunAddress;
			}
			document.getElementById("address").value = "(" + data.zonecode + ") " + addr;
			document.getElementById("addressEtc").focus();
		}
	}).open();
}
</script>
</head>
<body>
	<div class="card">
		<h2>회원가입</h2>

		<c:if test="${not empty inviteStoreCode}">
			<p class="guide">
				초대받은 매장 코드: <b>${inviteStoreCode}</b><br>
				회원가입 후 로그인하여 <b>매장 가입</b> 메뉴에서 위 코드를 입력해 주세요.
			</p>
		</c:if>

		<form:form modelAttribute="joinRequest" method="post" action="${pageContext.request.contextPath}/join">
			<form:errors cssClass="error" />

			<div class="row">
				<label for="name">이름</label>
				<form:input path="name" id="name" />
				<form:errors path="name" cssClass="error" />
			</div>

			<div class="row">
				<label for="id">아이디</label>
				<div class="inline">
					<form:input path="id" id="id" />
					<button type="button" onclick="checkUserId()">중복 확인</button>
				</div>
				<form:errors path="id" cssClass="error" />
			</div>

			<div class="row">
				<label for="pwd">비밀번호</label>
				<form:password path="pwd" id="pwd" />
				<form:errors path="pwd" cssClass="error" />
			</div>

			<div class="row">
				<label for="confirmPwd">비밀번호 확인</label>
				<form:password path="confirmPwd" id="confirmPwd" />
				<form:errors path="confirmPwd" cssClass="error" />
			</div>

			<div class="row">
				<label for="email">이메일</label>
				<form:input path="email" id="email" />
				<form:errors path="email" cssClass="error" />
			</div>

			<div class="row">
				<label for="birthDate">생년월일</label>
				<form:input path="birthDate" id="birthDate" type="date" />
				<form:errors path="birthDate" cssClass="error" />
			</div>

			<div class="row">
				<label for="gender">성별</label>
				<form:select path="gender" id="gender">
					<form:option value="" label="성별 선택" />
					<form:option value="male" label="남성" />
					<form:option value="female" label="여성" />
				</form:select>
				<form:errors path="gender" cssClass="error" />
			</div>

			<div class="row">
				<label for="address">주소</label>
				<div class="inline">
					<form:input path="address" id="address" readonly="true" />
					<button type="button" onclick="jusoSearch()">주소검색</button>
				</div>
				<form:errors path="address" cssClass="error" />
			</div>

			<div class="row">
				<label for="addressEtc">상세주소</label>
				<form:input path="addressEtc" id="addressEtc" />
			</div>

			<div class="row">
				<label for="phone">전화번호</label>
				<div class="inline">
					<form:input path="phone" id="phone" />
					<button type="button" onclick="requestPhoneCode()">인증번호 발송</button>
				</div>
				<form:errors path="phone" cssClass="error" />
			</div>

			<div class="row">
				<label for="phoneCode">휴대폰 인증번호</label>
				<div class="inline">
					<input id="phoneCode" type="text" />
					<button type="button" onclick="verifyPhoneCode()">인증 확인</button>
				</div>
				<input type="hidden" id="expectedCode" />
				<input type="hidden" id="phoneVerified" value="N" />
			</div>

			<button type="submit">회원가입</button>
		</form:form>
		<p><a href="${pageContext.request.contextPath}/login">로그인으로 돌아가기</a></p>
	</div>
</body>
</html>
