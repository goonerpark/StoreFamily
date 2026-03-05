<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Sign Up</title>
<style>
body { font-family: Arial, sans-serif; max-width: 720px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
.row { margin-bottom: 12px; }
label { display: block; font-weight: 600; margin-bottom: 4px; }
input, select { width: 100%; padding: 8px; box-sizing: border-box; }
.inline { display: flex; gap: 8px; align-items: center; }
.inline input { flex: 1; }
.error { color: #b00020; font-size: 13px; display: block; margin-top: 4px; }
</style>
<script>
function checkUserId() {
	const id = document.getElementById("id").value;
	if (!id) {
		alert("Enter ID first.");
		return;
	}
	fetch("check_userid?id=" + encodeURIComponent(id))
		.then(res => res.text())
		.then(count => {
			if (parseInt(count, 10) > 0) {
				alert("ID is already used.");
			} else {
				alert("ID is available.");
			}
		})
		.catch(() => alert("Failed to check ID."));
}

function requestPhoneCode() {
	const phone = document.getElementById("phone").value;
	fetch("phoneCheck?phone=" + encodeURIComponent(phone))
		.then(res => res.json())
		.then(data => {
			document.getElementById("expectedCode").value = data.code;
			alert("Verification code sent. (dev code: " + data.code + ")");
		})
		.catch(() => alert("Failed to send verification code."));
}

function verifyPhoneCode() {
	const expected = document.getElementById("expectedCode").value;
	const input = document.getElementById("phoneCode").value;
	if (expected && expected === input) {
		alert("Phone verification success.");
		document.getElementById("phoneVerified").value = "Y";
		return;
	}
	alert("Phone verification failed.");
	document.getElementById("phoneVerified").value = "N";
}
</script>
</head>
<body>
	<div class="card">
		<h2>Employee Sign Up</h2>
		<form:form modelAttribute="employeeJoinRequest" method="post" action="${pageContext.request.contextPath}/employee_join">
			<form:errors cssClass="error" />

			<div class="row">
				<label for="name">Name</label>
				<form:input path="name" id="name" />
				<form:errors path="name" cssClass="error" />
			</div>

			<div class="row">
				<label for="id">ID</label>
				<div class="inline">
					<form:input path="id" id="id" />
					<button type="button" onclick="checkUserId()">Check ID</button>
				</div>
				<form:errors path="id" cssClass="error" />
			</div>

			<div class="row">
				<label for="pwd">Password</label>
				<form:password path="pwd" id="pwd" />
				<form:errors path="pwd" cssClass="error" />
			</div>

			<div class="row">
				<label for="confirmPwd">Confirm Password</label>
				<form:password path="confirmPwd" id="confirmPwd" />
				<form:errors path="confirmPwd" cssClass="error" />
			</div>

			<div class="row">
				<label for="email">Email</label>
				<form:input path="email" id="email" />
				<form:errors path="email" cssClass="error" />
			</div>

			<div class="row">
				<label for="birthDate">Birth Date</label>
				<form:input path="birthDate" id="birthDate" type="date" />
				<form:errors path="birthDate" cssClass="error" />
			</div>

			<div class="row">
				<label for="gender">Gender</label>
				<form:select path="gender" id="gender">
					<form:option value="" label="Select gender" />
					<form:option value="male" label="Male" />
					<form:option value="female" label="Female" />
				</form:select>
				<form:errors path="gender" cssClass="error" />
			</div>

			<div class="row">
				<label for="address">Address</label>
				<form:input path="address" id="address" />
				<form:errors path="address" cssClass="error" />
			</div>

			<div class="row">
				<label for="addressEtc">Address Detail</label>
				<form:input path="addressEtc" id="addressEtc" />
			</div>

			<div class="row">
				<label for="phone">Phone</label>
				<div class="inline">
					<form:input path="phone" id="phone" />
					<button type="button" onclick="requestPhoneCode()">Send Code</button>
				</div>
				<form:errors path="phone" cssClass="error" />
			</div>

			<div class="row">
				<label for="phoneCode">Phone Verification Code</label>
				<div class="inline">
					<input id="phoneCode" type="text" />
					<button type="button" onclick="verifyPhoneCode()">Verify</button>
				</div>
				<input type="hidden" id="expectedCode" />
				<input type="hidden" id="phoneVerified" value="N" />
			</div>

			<div class="row">
				<label for="code">Store Code</label>
				<form:input path="code" id="code" />
				<form:errors path="code" cssClass="error" />
			</div>

			<button type="submit">Sign Up</button>
		</form:form>
		<p><a href="${pageContext.request.contextPath}/join_main">Back</a></p>
	</div>
</body>
</html>
