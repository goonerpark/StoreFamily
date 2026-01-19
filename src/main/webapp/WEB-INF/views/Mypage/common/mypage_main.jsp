<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${position == '직원'}">
	<a href="resume_write"> 이력서 작성하기 </a>
	<a href="resume_list"> 이력서 보기 </a>
</c:if>
<a href="member_update"> 회원정보 수정 </a>

<c:if test="${position == '사장'}">
	<a href="store_update"> 사업장 정보 수정 </a>
</c:if>

<a href="my_write"> 내가 작성한 글 </a>
</body>
</html>