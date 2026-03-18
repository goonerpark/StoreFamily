<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><decorator:title default="StoreFamily" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<decorator:head />
<style>
:root {
	--header-line: #e9dfd4;
	--header-text: #2d241d;
	--header-muted: #7a6859;
	--header-brand: #d97745;
	--header-brand-dark: #b85f33;
	--header-chip: #f6ede5;
}
body { margin: 0; font-family: "Pretendard", "Noto Sans KR", sans-serif; }
a { color: inherit; text-decoration: none; }
.topbar {
	position: sticky;
	top: 0;
	z-index: 20;
	background: rgba(255, 255, 255, 0.9);
	backdrop-filter: blur(8px);
	border-bottom: 1px solid var(--header-line);
}
.topbar .topbar-container { width: min(1180px, 92vw); margin: 0 auto; }
.topbar .topbar-inner {
	display: flex;
	align-items: center;
	justify-content: space-between;
	height: 72px;
}
.topbar .brand { cursor: pointer; }
.topbar .brand img { width: 220px; display: block; }
.topbar .menu { display: flex; gap: 22px; font-weight: 600; align-items: center; }
.topbar .menu > a, .topbar .menu > .menu-group > .menu-trigger { color: var(--header-muted); }
.topbar .menu > a:hover, .topbar .menu > .menu-group > .menu-trigger:hover { color: var(--header-text); }
.topbar .menu-group { position: relative; }
.topbar .menu-trigger {
	background: transparent;
	border: none;
	padding: 0;
	margin: 0;
	font: inherit;
	font-weight: 600;
	cursor: pointer;
}
.topbar .submenu {
	display: none;
	position: absolute;
	top: 28px;
	left: 0;
	min-width: 170px;
	background: #fff;
	border: 1px solid var(--header-line);
	border-radius: 10px;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
	padding: 6px;
}
.topbar .submenu a {
	display: block;
	padding: 8px 10px;
	border-radius: 8px;
	font-size: .92rem;
}
.topbar .submenu a:hover { background: #f7f1ea; }
.topbar .menu-group.open .submenu { display: block; }
.topbar .auth { display: flex; align-items: center; gap: 10px; }
.topbar .name-chip {
	padding: 8px 12px;
	border-radius: 999px;
	background: var(--header-chip);
	font-weight: 700;
}
.topbar .btn {
	border: 1px solid var(--header-line);
	background: #fff;
	color: var(--header-text);
	padding: 9px 14px;
	border-radius: 10px;
	font-weight: 700;
	cursor: pointer;
}
.topbar .btn-primary {
	background: var(--header-brand);
	border-color: var(--header-brand);
	color: #fff;
}
.topbar .btn-primary:hover { background: var(--header-brand-dark); }
.topbar .hamburger {
	display: none;
	border: 1px solid var(--header-line);
	background: #fff;
	border-radius: 8px;
	padding: 7px 10px;
	cursor: pointer;
}
.topbar .mobile-nav {
	display: none;
	padding: 12px 0 16px;
	border-top: 1px solid var(--header-line);
}
.topbar .mobile-nav.open { display: block; }
.topbar .mobile-nav a {
	display: block;
	padding: 10px 6px;
	color: var(--header-muted);
	font-weight: 600;
}
.page-wrap { padding: 18px; }
@media (max-width: 760px) {
	.topbar .menu, .topbar .auth.desktop { display: none; }
	.topbar .hamburger { display: inline-block; }
}
</style>
<script>
function go(path) { location.href = "${pageContext.request.contextPath}" + path; }
function toggleMobileMenu() {
	const nav = document.getElementById("mobileNav");
	if (!nav) return;
	nav.classList.toggle("open");
}
function toggleStoreMenu(event) {
	event.stopPropagation();
	const group = document.getElementById("storeManageGroup");
	if (!group) return;
	group.classList.toggle("open");
}
document.addEventListener("click", function(event) {
	const group = document.getElementById("storeManageGroup");
	if (!group) return;
	if (!group.contains(event.target)) {
		group.classList.remove("open");
	}
});
</script>
</head>
<body>
	<header class="topbar">
		<div class="container topbar-container topbar-inner">
			<div class="brand" onclick="go('/home')">
				<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="storefamily 로고">
			</div>

			<nav class="menu">
				<a href="${pageContext.request.contextPath}/home">홈</a>
				<a href="${pageContext.request.contextPath}/fill_all_list">대타 구인</a>
				<a href="${pageContext.request.contextPath}/store/register">매장 등록</a>
				<a href="${pageContext.request.contextPath}/store/join">매장 가입</a>
				<c:if test="${not empty sessionScope.id}">
					<div class="menu-group" id="storeManageGroup">
						<button type="button" class="menu-trigger" onclick="toggleStoreMenu(event)">내 매장관리</button>
						<div class="submenu">
							<a href="${pageContext.request.contextPath}/store/my">내 매장목록</a>
							<a href="${pageContext.request.contextPath}/store/approval/select">가입승인관리</a>
						</div>
					</div>
				</c:if>
			</nav>

			<div class="auth desktop">
				<c:choose>
					<c:when test="${empty sessionScope.id}">
						<button class="btn" onclick="go('/login')">로그인</button>
						<button class="btn btn-primary" onclick="go('/signup')">회원가입</button>
					</c:when>
					<c:otherwise>
						<span class="name-chip">${sessionScope.name}님</span>
						<button class="btn" onclick="go('/logout')">로그아웃</button>
					</c:otherwise>
				</c:choose>
			</div>
			<button class="hamburger" onclick="toggleMobileMenu()">메뉴</button>
		</div>

		<div class="container topbar-container mobile-nav" id="mobileNav">
			<a href="${pageContext.request.contextPath}/home">홈</a>
			<a href="${pageContext.request.contextPath}/fill_all_list">대타 구인</a>
			<a href="${pageContext.request.contextPath}/store/register">매장 등록</a>
			<a href="${pageContext.request.contextPath}/store/join">매장 가입</a>
			<c:if test="${not empty sessionScope.id}">
				<a href="${pageContext.request.contextPath}/store/my">내 매장목록</a>
				<a href="${pageContext.request.contextPath}/store/approval/select">가입승인관리</a>
			</c:if>
			<c:choose>
				<c:when test="${empty sessionScope.id}">
					<a href="${pageContext.request.contextPath}/login">로그인</a>
					<a href="${pageContext.request.contextPath}/signup">회원가입</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

	<div class="page-wrap">
		<decorator:body />
	</div>
</body>
</html>
