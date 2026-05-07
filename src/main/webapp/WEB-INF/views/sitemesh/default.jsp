<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><decorator:title default="StoreFamily" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Manrope:wght@600;700;800&family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script>
tailwind.config = {
	important: true,
	darkMode: "class",
	theme: {
		extend: {
			colors: {
				background: "#f5faf8",
				surface: "#f5faf8",
				"surface-container-lowest": "#ffffff",
				"surface-container-low": "#f0f5f2",
				"surface-container": "#eaefed",
				"surface-container-high": "#e4e9e7",
				"surface-container-highest": "#dee4e1",
				"surface-variant": "#dee4e1",
				outline: "#6d7a77",
				"outline-variant": "#bcc9c6",
				primary: "#00685f",
				"primary-container": "#008378",
				"primary-fixed": "#89f5e7",
				"primary-fixed-dim": "#6bd8cb",
				"on-primary": "#ffffff",
				"on-primary-container": "#f4fffc",
				"on-primary-fixed": "#00201d",
				"on-primary-fixed-variant": "#005049",
				secondary: "#5c5f61",
				"secondary-container": "#e0e3e5",
				"on-secondary-container": "#626567",
				tertiary: "#924628",
				"tertiary-container": "#b05e3d",
				"tertiary-fixed": "#ffdbce",
				"tertiary-fixed-dim": "#ffb59a",
				"on-tertiary-fixed": "#370e00",
				error: "#ba1a1a",
				"error-container": "#ffdad6",
				"on-error-container": "#93000a",
				"on-surface": "#171d1c",
				"on-surface-variant": "#3d4947",
				"on-background": "#171d1c"
			},
			borderRadius: { xl: "0.75rem" },
			spacing: {
				xs: "0.25rem",
				sm: "0.5rem",
				md: "1rem",
				lg: "1.5rem",
				xl: "2rem",
				"container-padding": "1.5rem"
			},
			fontFamily: {
				h1: ["Manrope"],
				h2: ["Manrope"],
				h3: ["Manrope"],
				"body-md": ["Inter"],
				"body-lg": ["Inter"],
				"label-sm": ["Inter"]
			},
			fontSize: {
				h1: ["32px", { lineHeight: "40px", fontWeight: "700" }],
				h2: ["24px", { lineHeight: "32px", fontWeight: "600" }],
				h3: ["20px", { lineHeight: "28px", fontWeight: "600" }],
				"body-md": ["14px", { lineHeight: "20px", fontWeight: "400" }],
				"body-lg": ["16px", { lineHeight: "24px", fontWeight: "400" }],
				"label-sm": ["12px", { lineHeight: "16px", fontWeight: "600" }]
			}
		}
	}
};
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<decorator:head />
<style>
body { margin: 0; background: #f5faf8; color: #171d1c; font-family: "Inter", "Noto Sans KR", sans-serif; }
a { color: inherit; text-decoration: none; }
a:hover { text-decoration: none; }
.material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; line-height: 1; }
.sf-sidebar-link { display:flex; align-items:center; gap:1rem; border-radius:.5rem; padding:.5rem 1rem; color:#5c5f61; transition:background-color .2s,color .2s; }
.sf-sidebar-link:hover { background:#f0f5f2; color:#171d1c; }
.sf-sidebar-link.active { background:#008378; color:#f4fffc; font-weight:700; }
.page-wrap { min-height:100vh; padding-top:64px; padding-bottom:88px; }
@media (min-width:768px) { .page-wrap { padding-left:256px; padding-bottom:0; } }
</style>
<script>
function go(path) {
	location.href = "${pageContext.request.contextPath}" + path;
}
</script>
</head>
<body>
	<aside class="hidden md:flex fixed left-0 top-0 z-50 h-screen w-64 flex-col border-r border-surface-variant bg-white p-md">
		<div class="mb-xl flex items-center gap-sm px-sm">
			<div class="flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-on-primary">
				<span class="material-symbols-outlined">storefront</span>
			</div>
			<div>
				<div class="font-h3 text-h3 font-bold text-primary">StoreFamily</div>
				<div class="text-[10px] text-secondary">Empathetic Efficiency</div>
			</div>
		</div>
		<nav class="flex-1 space-y-xs">
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/home"><span class="material-symbols-outlined">dashboard</span><span>홈</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/store/my"><span class="material-symbols-outlined">store</span><span>매장 관리</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/store/approval/select"><span class="material-symbols-outlined">person_add</span><span>가입 승인</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/fill_all_list"><span class="material-symbols-outlined">swap_horiz</span><span>대타 모집</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/store/join"><span class="material-symbols-outlined">group_add</span><span>매장 가입</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/insu_list"><span class="material-symbols-outlined">forum</span><span>게시판</span></a>
			<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/mypage_main"><span class="material-symbols-outlined">person</span><span>마이페이지</span></a>
		</nav>
		<div class="mt-auto space-y-xs border-t border-surface-variant pt-md">
			<a class="flex w-full items-center justify-center gap-sm rounded-lg bg-primary px-md py-sm font-bold text-on-primary" href="${pageContext.request.contextPath}/fill_all_list">
				<span class="material-symbols-outlined text-[20px]">add</span>
				<span>대타 보기</span>
			</a>
			<c:if test="${not empty sessionScope.id}">
				<a class="sf-sidebar-link" href="${pageContext.request.contextPath}/logout"><span class="material-symbols-outlined">logout</span><span>로그아웃</span></a>
			</c:if>
		</div>
	</aside>

	<header class="fixed left-0 top-0 z-40 flex h-16 w-full items-center justify-between bg-surface px-lg shadow-sm md:pl-[280px]">
		<div class="flex items-center gap-md">
			<span class="material-symbols-outlined text-primary md:hidden">menu</span>
			<strong class="font-h2 text-h2 text-primary">StoreFamily</strong>
		</div>
		<div class="flex items-center gap-md">
			<a class="hidden rounded-full bg-surface-container-low px-md py-sm text-body-md text-secondary sm:block" href="${pageContext.request.contextPath}/fill_all_list">대타 검색</a>
			<span class="material-symbols-outlined text-secondary">notifications</span>
			<c:choose>
				<c:when test="${empty sessionScope.id}">
					<a class="rounded-lg border border-outline-variant px-md py-sm font-bold text-secondary" href="${pageContext.request.contextPath}/login">로그인</a>
				</c:when>
				<c:otherwise>
					<div class="flex items-center gap-sm rounded-lg p-xs hover:bg-surface-container">
						<div class="flex h-9 w-9 items-center justify-center rounded-full bg-primary-container font-bold text-on-primary-container">
							<c:out value="${fn:substring(sessionScope.name,0,1)}"/>
						</div>
						<div class="hidden text-left lg:block">
							<p class="mb-0 text-label-sm font-bold leading-none"><c:out value="${sessionScope.name}"/>님</p>
							<p class="mb-0 text-[10px] text-secondary"><c:out value="${sessionScope.position}"/></p>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

	<div class="page-wrap">
		<decorator:body />
	</div>

	<nav class="fixed bottom-0 left-0 z-50 flex h-16 w-full items-center justify-around border-t border-surface-variant bg-white px-md shadow-[0_-2px_10px_rgba(0,0,0,0.05)] md:hidden">
		<a class="flex flex-col items-center gap-xs text-primary" href="${pageContext.request.contextPath}/home"><span class="material-symbols-outlined">home</span><span class="text-[10px] font-bold">홈</span></a>
		<a class="flex flex-col items-center gap-xs text-secondary" href="${pageContext.request.contextPath}/schedule"><span class="material-symbols-outlined">calendar_today</span><span class="text-[10px]">근무표</span></a>
		<a class="-mt-8 flex h-12 w-12 items-center justify-center rounded-full bg-primary text-on-primary shadow-lg" href="${pageContext.request.contextPath}/fill_all_list"><span class="material-symbols-outlined">add</span></a>
		<a class="flex flex-col items-center gap-xs text-secondary" href="${pageContext.request.contextPath}/fill_all_list"><span class="material-symbols-outlined">swap_horiz</span><span class="text-[10px]">대타</span></a>
		<a class="flex flex-col items-center gap-xs text-secondary" href="${pageContext.request.contextPath}/mypage_main"><span class="material-symbols-outlined">person</span><span class="text-[10px]">마이</span></a>
	</nav>
</body>
</html>
