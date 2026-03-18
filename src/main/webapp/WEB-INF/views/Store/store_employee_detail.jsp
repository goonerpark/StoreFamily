<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 상세 정보</title>
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
	.wrap { max-width: 980px; margin: 0 auto; padding: 28px 20px 40px; }
	.page-header { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 16px; }
	.page-title { margin: 0; font-size: 30px; }
	.page-sub { margin-top: 8px; color: var(--muted); }
	.card { background: var(--card); border: 1px solid var(--line); border-radius: 14px; padding: 18px; margin-bottom: 14px; }
	.card-title { margin: 0 0 12px; font-size: 20px; }
	.info-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; }
	.item { border: 1px solid var(--line); border-radius: 10px; padding: 12px; background: #fcfdff; }
	.item strong { display: block; margin-bottom: 6px; font-size: 13px; color: var(--muted); }
	.badge { display: inline-flex; align-items: center; justify-content: center; padding: 4px 8px; border-radius: 999px; font-size: 12px; font-weight: 700; }
	.badge.on { background: #e8f7ec; color: #136a2f; }
	.badge.off { background: #fff3cd; color: #8a6d1a; }
	.actions { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 8px; }
	.actions a { display: inline-flex; align-items: center; justify-content: center; min-height: 38px; padding: 8px 12px; border: 1px solid var(--line); border-radius: 10px; text-decoration: none; color: var(--text); font-weight: 700; background: #fff; }
	.actions a:hover { border-color: var(--point); color: var(--point); }
	@media (max-width: 760px) {
		.wrap { padding: 18px 14px 26px; }
		.page-header { flex-direction: column; align-items: stretch; }
		.page-title { font-size: 26px; }
		.info-grid { grid-template-columns: 1fr; }
		.actions a { flex: 1; }
	}
</style>
</head>
<body>
<div class="wrap">
	<div class="page-header">
		<div>
			<h1 class="page-title">직원 상세 정보</h1>
			<div class="page-sub">
				<c:out value="${employee.name}"/> · <c:out value="${employee.member_id}"/>
			</div>
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="card" style="border-color:#d7e5ff; background:#eef4ff; color:#23407c;">
			${message}
		</div>
	</c:if>

	<div class="card">
		<h2 class="card-title">기본 정보</h2>
		<div class="info-grid">
			<div class="item"><strong>이름</strong><c:out value="${employee.name}"/></div>
			<div class="item"><strong>아이디</strong><c:out value="${employee.member_id}"/></div>
			<div class="item"><strong>이메일</strong><c:out value="${employee.email}"/></div>
			<div class="item"><strong>전화번호</strong><c:out value="${employee.phone}"/></div>
			<div class="item"><strong>성별</strong><c:out value="${empty employee.gender ? '-' : employee.gender}"/></div>
			<div class="item"><strong>생년월일</strong><c:out value="${empty employee.bth ? '-' : employee.bth}"/></div>
			<div class="item">
				<strong>주소</strong>
				<c:choose>
					<c:when test="${not empty employee.address}">
						<c:out value="${employee.address}"/>
						<c:if test="${not empty employee.address_etc}">
							<c:out value=" ${employee.address_etc}"/>
						</c:if>
					</c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<div class="card">
		<h2 class="card-title">매장 소속 정보</h2>
		<div class="info-grid">
			<div class="item"><strong>소속 매장명</strong><c:out value="${employee.store_name}"/></div>
			<div class="item"><strong>매장 코드</strong><c:out value="${employee.store_code}"/></div>
			<div class="item"><strong>직책/역할</strong><c:out value="${employee.position}"/></div>
			<div class="item"><strong>소속 등록일</strong><c:out value="${employee.created_at}"/></div>
		</div>
	</div>

	<div class="card">
		<h2 class="card-title">상태 정보</h2>
		<form method="post" action="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees/${employee.member_bno}">
			<div class="info-grid">
				<div class="item">
					<strong>승인 상태</strong>
					<c:choose>
						<c:when test="${employee.chk == 1}"><span class="badge on">승인 완료</span></c:when>
						<c:otherwise><span class="badge off">승인 대기</span></c:otherwise>
					</c:choose>
				</div>
				<div class="item">
					<strong>시급</strong>
					<input type="text" name="rate" value="${employee.rate}" style="width:100%; height:36px; border:1px solid #d8deea; border-radius:8px; padding:0 10px;">
				</div>
				<div class="item">
					<strong>입사일</strong>
					<input type="date" name="employment" value="${employee.employment}" style="width:100%; height:36px; border:1px solid #d8deea; border-radius:8px; padding:0 10px;">
				</div>
				<div class="item">
					<strong>보건증 등록일</strong>
					<input type="date" name="health" value="${employee.health}" style="width:100%; height:36px; border:1px solid #d8deea; border-radius:8px; padding:0 10px;">
				</div>
				<div class="item">
					<strong>보건증 만료일 (등록일 + 1년)</strong>
					<c:out value="${empty healthExpiryDate ? '-' : healthExpiryDate}"/>
				</div>
				<div class="item">
					<strong>보건증 만료까지</strong>
					<c:out value="${healthDDayText}"/>
				</div>
			</div>
			<div class="actions">
				<button type="submit" style="display:inline-flex;align-items:center;justify-content:center;min-height:38px;padding:8px 12px;border:1px solid #d8deea;border-radius:10px;background:#fff;font-weight:700;cursor:pointer;">상태 정보 저장</button>
			</div>
		</form>
	</div>

	<div class="actions">
		<a href="${pageContext.request.contextPath}/stores/${myStore.store_id}/employees">직원 리스트로 돌아가기</a>
		<a href="${pageContext.request.contextPath}/stores/${myStore.store_id}">매장 관리로 돌아가기</a>
	</div>
</div>
</body>
</html>
