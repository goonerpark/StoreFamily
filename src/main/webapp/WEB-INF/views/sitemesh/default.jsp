<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><decorator:title default="StoreFamily" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<decorator:head />
<style>
body { margin: 0; }
.topbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 14px 20px;
	border-bottom: 2px solid #f1efe7;
	background: #fff;
}
.logo-area img { width: 220px; cursor: pointer; }
.actions { display: flex; gap: 8px; align-items: center; }
.actions .name { font-weight: 600; margin-right: 6px; }
.page-wrap { padding: 18px; }
</style>
<script>
function goHome() { location.href = "${pageContext.request.contextPath}/home"; }
function goLogin() { location.href = "${pageContext.request.contextPath}/login"; }
function goJoin() { location.href = "${pageContext.request.contextPath}/join"; }
function doLogout() { location.href = "${pageContext.request.contextPath}/logout"; }
</script>
</head>
<body>
	<div class="topbar">
		<div class="logo-area" onclick="goHome()">
			<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="StoreFamily 로고">
		</div>
		<div class="actions">
			<c:choose>
				<c:when test="${empty sessionScope.id}">
					<button type="button" class="btn btn-outline-dark btn-sm" onclick="goLogin()">로그인</button>
					<button type="button" class="btn btn-outline-dark btn-sm" onclick="goJoin()">회원가입</button>
				</c:when>
				<c:otherwise>
					<span class="name">${sessionScope.name}님</span>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="doLogout()">로그아웃</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="page-wrap">
		<decorator:body />
	</div>
</body>
</html>
