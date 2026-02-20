<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>

<link href="/resources/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap.bundle.min.js"></script>

<style>
  body { margin: 0px; }
  #head_up { width: 100%; height: 70px; position: relative; top: -5px; }
  #store_change { margin-left: 800px; }
  #logout { margin-left: 20px; }
  .hr_solid { border: 0px; border-top: 2px solid #F1EFE7; margin-bottom: 0px; }
</style>

<script>
  function main() { location.href = "/home"; }
  function login() { location.href = "/login"; }
  function join_main() { location.href = "/join_main"; }
</script>
</head>

<body>
  <div id="head_up">
    <span id="logo" onclick="main()">
      <img src="/resources/img/logo.png" width="250">
    </span>

    <span id="store_change">
      <button type="button" class="btn btn-outline-dark btn-sm" onclick="login()">로그인</button>
    </span>

    <span id="logout">
      <button type="button" class="btn btn-outline-dark btn-sm" onclick="join_main()">회원가입</button>
    </span>
  </div>

  <hr class="hr_solid">
</body>
</html>
