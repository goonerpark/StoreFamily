<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 대시보드</title>
<style>
	:root {
		--bg: #f6f7fb;
		--card: #ffffff;
		--line: #e4e7ec;
		--text: #1f2937;
		--muted: #6b7280;
		--point: #1f6feb;
	}
	* { box-sizing: border-box; }
	body { margin: 0; background: var(--bg); color: var(--text); font-family: "GmarketSansTTFMedium", "Malgun Gothic", sans-serif; }
	.dashboard-wrap { max-width: 1160px; margin: 0 auto; padding: 28px 20px 40px; }
	.card { background: var(--card); border: 1px solid var(--line); border-radius: 14px; }
	.page-header { display: flex; justify-content: space-between; gap: 12px; align-items: flex-start; margin-bottom: 18px; }
	.page-title { margin: 0; font-size: 30px; }
	.page-subtitle { margin: 8px 0 0; color: var(--muted); }
	.back-link { display: inline-flex; align-items: center; justify-content: center; padding: 10px 14px; border: 1px solid var(--line); border-radius: 10px; background: #fff; text-decoration: none; color: var(--text); font-weight: 700; }
	.back-link:hover, .menu-link:hover { border-color: var(--point); color: var(--point); }
	.info-card { padding: 20px; margin-bottom: 18px; }
	.info-title { margin: 0 0 14px; font-size: 20px; }
	.info-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
	.info-item { padding: 12px; border: 1px solid var(--line); border-radius: 10px; background: #fbfcff; }
	.info-item strong { display: block; margin-bottom: 6px; color: var(--muted); font-size: 13px; }
	.sections { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; }
	.menu-card, .summary-card { padding: 20px; }
	.section-title { margin: 0 0 14px; font-size: 20px; }
	.menu-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; }
	.menu-link { display: block; padding: 14px; border: 1px solid var(--line); border-radius: 10px; text-decoration: none; color: var(--text); background: #fff; }
	.menu-name { font-weight: 700; }
	.menu-desc { margin-top: 6px; font-size: 13px; color: var(--muted); }
	.summary-grid { display: grid; grid-template-columns: 1fr; gap: 10px; }
	.summary-item { padding: 14px; border: 1px solid var(--line); border-radius: 10px; background: #fff; }
	.summary-label { color: var(--muted); font-size: 13px; }
	.summary-value { margin-top: 8px; font-size: 28px; font-weight: 700; color: var(--point); }
	.summary-link { margin-top: 10px; }
	.summary-link .mini-btn { display: inline-flex; align-items: center; justify-content: center; min-height: 36px; padding: 8px 12px; border-radius: 9px; border: 1px solid var(--line); color: var(--text); text-decoration: none; font-weight: 700; font-size: 13px; background: #fff; }
	.summary-link .mini-btn:hover { border-color: var(--point); color: var(--point); }
	@media (max-width: 900px) {
		.sections { grid-template-columns: 1fr; }
		.menu-grid { grid-template-columns: 1fr; }
	}
	@media (max-width: 700px) {
		.dashboard-wrap { padding: 18px 14px 26px; }
		.page-header { flex-direction: column; }
		.page-title { font-size: 26px; }
		.info-grid { grid-template-columns: 1fr; }
		.back-link { width: 100%; }
	}
</style>
</head>
<body>
<div class="dashboard-wrap">
	<div class="page-header">
		<div>
			<h1 class="page-title">매장 관리</h1>
			<p class="page-subtitle"><c:out value="${dashboard.storeName}"/> 관리 페이지</p>
		</div>
		<a class="back-link" href="${pageContext.request.contextPath}/my-stores">내 매장 목록</a>
	</div>

	<div class="card info-card">
		<h2 class="info-title">매장 기본 정보</h2>
		<div class="info-grid">
			<div class="info-item">
				<strong>매장명</strong>
				<c:out value="${dashboard.storeName}"/>
			</div>
			<div class="info-item">
				<strong>매장 코드</strong>
				<c:out value="${dashboard.storeCode}"/>
			</div>
			<div class="info-item">
				<strong>주소</strong>
				<c:out value="${dashboard.address}"/>
			</div>
			<div class="info-item">
				<strong>전화번호</strong>
				<c:out value="${dashboard.phone}"/>
			</div>
		</div>
	</div>

	<div class="sections">
		<div class="card menu-card">
			<h2 class="section-title">빠른 메뉴</h2>
			<div class="menu-grid">
				<a class="menu-link" href="${pageContext.request.contextPath}/stores/${dashboard.storeId}/employees">
					<div class="menu-name">직원 리스트</div>
					<div class="menu-desc">현재 매장 직원 조회 및 관리</div>
				</a>
				<a class="menu-link" href="${pageContext.request.contextPath}/stores/${dashboard.storeId}/approvals">
					<div class="menu-name">가입 승인 관리</div>
					<div class="menu-desc">가입 요청 확인 및 승인/거절 처리</div>
				</a>
				<a class="menu-link" href="${pageContext.request.contextPath}/stores/${dashboard.storeId}/schedules">
					<div class="menu-name">스케줄 캘린더</div>
					<div class="menu-desc">월별 근무 스케줄 등록/수정/삭제</div>
				</a>
				<a class="menu-link" href="${pageContext.request.contextPath}/stores/${dashboard.storeId}/schedule/parts">
					<div class="menu-name">근무 파트 관리</div>
					<div class="menu-desc">근무 파트 생성/수정/삭제</div>
				</a>
				<a class="menu-link" href="${pageContext.request.contextPath}/my-stores">
					<div class="menu-name">내 매장 목록</div>
					<div class="menu-desc">보유한 전체 매장 목록으로 이동</div>
				</a>
			</div>
		</div>

		<div class="card summary-card">
			<h2 class="section-title">요약 정보</h2>
			<div class="summary-grid">
				<div class="summary-item">
					<div class="summary-label">직원 수</div>
					<div class="summary-value">${dashboard.employeeCount}</div>
					<div class="summary-link">
						<a class="mini-btn" href="${pageContext.request.contextPath}/stores/${dashboard.storeId}/employees">전체 보기</a>
					</div>
				</div>
				<div class="summary-item">
					<div class="summary-label">가입 승인 대기</div>
					<div class="summary-value">${dashboard.pendingApprovalCount}</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
