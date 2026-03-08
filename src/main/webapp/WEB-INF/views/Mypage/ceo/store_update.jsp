<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 정보 수정</title>
<style>
body { font-family: Arial, sans-serif; max-width: 760px; margin: 40px auto; }
.card { border: 1px solid #ddd; border-radius: 8px; padding: 24px; }
.row { margin-bottom: 12px; }
label { display: block; font-weight: 600; margin-bottom: 4px; }
input, select { width: 100%; padding: 8px; box-sizing: border-box; }
button { padding: 8px 14px; }
.msg { margin-bottom: 12px; color: #b00020; }
</style>
<script>
function changeStoreCode(sel) {
	if (sel && sel.value) {
		location.href = 'store_update?code=' + encodeURIComponent(sel.value);
	}
}
</script>
</head>
<body>
<div class="card">
	<h2>매장 정보 수정</h2>

	<c:if test="${not empty message}">
		<div class="msg">${message}</div>
	</c:if>

	<c:if test="${not empty getStore_list}">
		<div class="row">
			<label for="storeSelect">매장 선택</label>
			<select id="storeSelect" onchange="changeStoreCode(this)">
				<c:forEach var="store_list" items="${getStore_list}">
					<option value="${store_list.code}" ${store_list.code eq store_imformation.code ? 'selected' : ''}>
						${store_list.bussiness} (${store_list.code})
					</option>
				</c:forEach>
			</select>
		</div>
	</c:if>

	<c:if test="${not empty store_imformation}">
		<form:form modelAttribute="store_update" name="store_update" method="post" action="store_update_ok">
			<input type="hidden" name="ex_code" value="${store_imformation.code}">

			<div class="row">
				<label for="bussiness">매장명</label>
				<input type="text" id="bussiness" name="bussiness" value="${store_imformation.bussiness}">
			</div>

			<div class="row">
				<label for="bussinessnum">매장 전화번호</label>
				<input type="text" id="bussinessnum" name="bussinessnum" value="${store_imformation.bussinessnum}">
			</div>

			<div class="row">
				<label for="bussinessaddress">매장 주소</label>
				<input type="text" id="bussinessaddress" name="bussinessaddress" value="${store_imformation.bussinessaddress}">
			</div>

			<div class="row">
				<label for="bussinessaddress_etc">매장 상세 주소</label>
				<input type="text" id="bussinessaddress_etc" name="bussinessaddress_etc" value="${store_imformation.bussinessaddress_etc}">
			</div>

			<div class="row">
				<label>매장 코드</label>
				<input type="text" value="${store_imformation.code}" readonly>
			</div>

			<button type="submit">수정하기</button>
		</form:form>
	</c:if>
</div>
</body>
</html>
