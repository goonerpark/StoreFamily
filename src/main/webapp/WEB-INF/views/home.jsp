<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StoreFamily 홈</title>
<style>
:root {
	--bg: #fff9f4;
	--paper: #ffffff;
	--line: #e9dfd4;
	--text: #2d241d;
	--muted: #7a6859;
	--brand: #d97745;
	--brand-dark: #b85f33;
	--chip: #f6ede5;
}
* { box-sizing: border-box; }
body {
	margin: 0;
	background: var(--bg);
	color: var(--text);
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
}
a { color: inherit; text-decoration: none; }
.container { width: min(1180px, 92vw); margin: 0 auto; }

.btn {
	border: 1px solid var(--line);
	background: #fff;
	color: var(--text);
	padding: 9px 14px;
	border-radius: 10px;
	font-weight: 700;
	cursor: pointer;
}
.btn-primary {
	background: var(--brand);
	border-color: var(--brand);
	color: #fff;
}
.btn-primary:hover { background: var(--brand-dark); }
.layout {
	display: grid;
	grid-template-columns: 1fr 320px;
	gap: 20px;
	margin: 26px auto 32px;
}
.banner {
	background: linear-gradient(130deg, #ffe0cc 0%, #ffd2b2 45%, #ffc39b 100%);
	border: 1px solid #f2c8aa;
	border-radius: 20px;
	padding: 28px;
}
.banner h1 { margin: 0 0 10px; font-size: 1.9rem; }
.banner p { margin: 0; color: #5f4435; line-height: 1.6; }
.banner .cta { margin-top: 18px; display: flex; gap: 10px; flex-wrap: wrap; }

.section {
	background: var(--paper);
	border: 1px solid var(--line);
	border-radius: 16px;
	padding: 16px;
	margin-top: 16px;
}
.section h3 { margin: 0 0 12px; font-size: 1.05rem; }
.cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }
.card {
	border: 1px solid var(--line);
	border-radius: 12px;
	padding: 12px;
	background: #fff;
}
.card .tag {
	display: inline-block;
	padding: 4px 8px;
	border-radius: 999px;
	background: var(--chip);
	color: #7a5c48;
	font-size: .75rem;
	font-weight: 700;
	margin-bottom: 8px;
}
.card h4 { margin: 0 0 8px; font-size: .96rem; line-height: 1.35; }
.card p { margin: 0; color: var(--muted); font-size: .88rem; }

.sidebar .box {
	background: var(--paper);
	border: 1px solid var(--line);
	border-radius: 16px;
	padding: 14px;
	margin-bottom: 14px;
}
.sidebar h4 { margin: 0 0 10px; font-size: .98rem; }
.list { margin: 0; padding: 0; list-style: none; }
.list li {
	padding: 8px 0;
	border-bottom: 1px dashed #eaddcf;
	font-size: .9rem;
	color: var(--muted);
}
.list li:last-child { border-bottom: none; }

footer {
	border-top: 1px solid var(--line);
	padding: 18px 0 26px;
	color: var(--muted);
	font-size: .88rem;
}

@media (max-width: 1024px) {
	.layout { grid-template-columns: 1fr; }
	.cards { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 760px) {
	.cards { grid-template-columns: 1fr; }
	.banner h1 { font-size: 1.45rem; }
}
</style>
<script>
function go(path) { location.href = "${pageContext.request.contextPath}" + path; }
</script>
</head>
<body>
	<main class="container layout">
		<section>
			<div class="banner">
				<h1>매장 운영과 대타 구인을 한 곳에서</h1>
				<p>StoreFamily는 스케줄 관리, 직원 커뮤니티, 대타 구인/지원을 연결해 매장 운영을 더 빠르고 안정적으로 만듭니다.</p>
				<div class="cta">
					<button class="btn btn-primary" onclick="go('/store/register')">내 매장 등록하기</button>
					<button class="btn" onclick="go('/fill_all_list')">대타 공고 보러가기</button>
				</div>
			</div>

			<div class="section">
				<h3>대타 구인 추천</h3>
				<div class="cards">
					<article class="card"><span class="tag">카페</span><h4>주말 오픈 대타 구합니다</h4><p>서울 강남 · 시급 11,000원</p></article>
					<article class="card"><span class="tag">편의점</span><h4>야간 근무 대타 모집</h4><p>인천 부평 · 시급 12,000원</p></article>
					<article class="card"><span class="tag">레스토랑</span><h4>평일 저녁 홀서빙 대타</h4><p>부산 해운대 · 시급 10,500원</p></article>
				</div>
			</div>
		</section>

		<aside class="sidebar">
			<div class="box">
				<c:choose>
					<c:when test="${empty sessionScope.id}">
						<button class="btn btn-primary" style="width:100%; margin-bottom:8px;" onclick="go('/login')">로그인</button>
						<button class="btn" style="width:100%;" onclick="go('/signup')">회원가입</button>
					</c:when>
					<c:otherwise>
						<p style="margin:0 0 10px;">${sessionScope.name}님, 환영합니다.</p>
						<button class="btn" style="width:100%;" onclick="go('/home')">홈 새로고침</button>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="box">
				<h4>공지사항</h4>
				<ul class="list">
					<li>매장 가입 승인 기능 개선 안내</li>
					<li>모바일 화면 최적화 업데이트</li>
					<li>보안 점검 일정 공지</li>
				</ul>
			</div>
		</aside>
	</main>

	<footer>
		<div class="container">
			StoreFamily · 매장 운영 및 대타 구인구직 플랫폼<br>
			고객센터 02-0000-0000 · 평일 09:00~18:00
		</div>
	</footer>
</body>
</html>
