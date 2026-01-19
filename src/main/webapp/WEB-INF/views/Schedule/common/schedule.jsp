<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<script src="resources/js/jquery-3.7.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<link href="resources/css/style.css" rel="stylesheet">
<script>
function init(y,m)
{
	//달력을 완성한 후 출력하고자 하는 요소에 전달
	//1일의 요일
	
	var year = y;
	var month = m;
	
	
	//이번달의 1일 날짜의 객체를 생성
	var xday = new Date(year,month,1);
	var yoil = xday.getDay(); 
	
	//총일수
	var mon = [31,28,31,30,31,30,31,31,30,31,30,31];
	var chong = mon[month];
	
	//윤년일 경우 2월이 29일로 변경
	if(month == 1)
	{
		if( (year%4 == 0) && (year%100 != 0) || (year%400 == 0)) //년도를 4로 나눈 나머지가 0이면 윤년 100으로 나눈 나머지가 0이면 윤년X
			chong++;
	}
	
	//몇주
	var ju = Math.ceil((chong+yoil)/7);
	
	//테이블 태그를 이용하여 달력을 만들기
	var cal_data = "<table width='650' height='450'>";
	
	//caption 태그에 이전/다음 넣기
	cal_data = cal_data + "<tr> <td colspan='7' style='text-align:center;'>";
	if(month == 0) //1월이면
		cal_data = cal_data + "<a href = 'javascript:init(" + (year-1) + ",11)'> ◀ </a>";
	else
		cal_data = cal_data + "<a href = 'javascript:init(" + year + "," + (month-1) + ")'> ◀ </a>";
		
	cal_data = cal_data + year + "년" + (month+1) + "월";
	
	if(month == 11) //12월이면
		cal_data = cal_data + "<a href='javascript:init(" + (year+1) + ",0)'> ▶ </a>";
	else
		cal_data = cal_data + "<a href='javascript:init(" + year + "," + (month+1) + ")'> ▶ </a>";
	cal_data = cal_data + "</td> </td>";
	
	cal_data = cal_data + "<tr>";
	cal_data = cal_data + "<td class='cal_border yol'> 일 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 월 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 화 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 수 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 목 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 금 </td>";
	cal_data = cal_data + "<td class='cal_border yol'> 토 </td>";
	cal_data = cal_data + "</tr>";
	
	var day=1;
	
	/* var nyear = year.toString();
	var nmonth = (month+1).toString();
	var nday = date.toString();
	if(nmonth.length == 1)
		nmonth = "0" + nmonth;
	if(nday.length == 1)
		nday = "0" + nday;
	var day = nyear + "/" + nmonth + "/" + nday; */
	
	var name_list = new Array(); //전체 스케줄 이름 저장할 리스트
	var date_list = new Array(); // 전체 스케줄 날짜 저장할 리스트
	<c:forEach items="${full_schedule}" var="full_schedule"> // 전체 스케줄을 리스트에 넣어줌
		name_list.push("${full_schedule.name}")
		date_list.push("${full_schedule.day}")
	</c:forEach>
	
	var date_list_getTime = new Array(); // 날짜로 변경해서 저장할 리스트
	for(i=0; i<date_list.length; i++) // 날짜로 변경해서 리스트에 저장
	{
		var date1 = new Date(date_list[i]);
		date_list_getTime.push(date1.getTime());
		
	}
	
	
	for(i=1;i<=ju;i++) // 행
	{
		cal_data = cal_data + "<tr>";
		for(j=0;j<7;j++)
		{
			 if( (j<yoil && i==1) || (chong < day))
			 {	 
			   cal_data=cal_data+"<td class='cal_border'> </td>";
			 }
			else 
			{
				var final_list = new Array(); //해당 날짜의 이름 리스트
				var nmonth = month + 1;
				if(nmonth < 10)
					nmonth = "0" + nmonth;
				if(day < 10)
					day = "0" + day;
				var full_date = year + "-" + nmonth + "-" + day;
				var full_date_time = new Date(full_date);
				
				for(z=0; z<date_list_getTime.length; z++)
				{
					if(full_date_time.getTime() == date_list_getTime[z]) //달력 날짜와 스케줄 날짜가 같다면 이름 저장
					{
						final_list.push(name_list[z]);
					}
				}
				
				if(final_list.length == 1 || final_list.length == 0)
					var final_list_size = "";
				else
					var final_list_size = "(" + final_list.length + ")";
				var final_list2 = final_list[0];
				
				if(final_list2 == null)
					final_list2 = "";
				//<c:set var="final_list" value="final_list[0]"/> //화면에 띄우기 위해 변수로 변경
				
				
				cal_data = cal_data +"<td class='cal_border'> <div class='day' onclick='schedule(" + year + "," + (month+1) + "," + day +")'>"  + "<span id='dday'>" + day  + "</span> <br> <div>" + final_list2 +  final_list_size + " </div> </div> </td>";
				day++;
			}
		}
		cal_data = cal_data + "</tr>";
	} 
	cal_data = cal_data + "</table>";

	
	document.getElementById("cal").innerHTML=cal_data;
}
	
	function schedule(year,month,day)
	{
		
		var nyear = year.toString();
		var nmonth = month.toString();
		var nday = day.toString();
		
		if(nmonth.length == 1)
			nmonth = "0" + nmonth;
		if(nday.length == 1)
			nday = "0" + nday;
		
		var date = nyear + "-" + nmonth + "-" + nday;
		
		location.href="schedule?day="+date;
	}
	
	function schedule_write(day)
	{
		document.ceo_schedule.day.value = day;
		document.ceo_schedule.action = 'schedule_write';
		document.ceo_schedule.submit();
	}
	
	function schedule_update(bno,day)
	{
		document.ceo_schedule.bno.value = bno;
		document.ceo_schedule.day.value = day;
		document.ceo_schedule.action = 'schedule_update';
		document.ceo_schedule.submit();
	}
	
	function schedule_delete(bno,day)
	{
		document.ceo_schedule.bno.value = bno;
		document.ceo_schedule.day.value = day;
		document.ceo_schedule.action = 'schedule_delete';
		document.ceo_schedule.submit();
	}
	
	function main()
	{
		location.href="main";
	}

</script>

<style>
		body {
			margin: 0px;
		}
	
		#head_up {
			width: 100%;
			height: 70px;
			position: relative;
			top: -5px;
		}
		
		#store_change {
			margin-left: 800px;
		}
		
		#logout {
			margin-left: 20px;
		}
		
		#head_side{
			float: left;
			width: 230px;
			height: 100%;
		}
		
		#head_side a {
			text-align: center;
			height: 51px;
		}
		
		.hr_solid {
			border : 0px;
	  		border-top: 2px solid #F1EFE7;
	  		margin-bottom: 0px;
		}
		
		.card {
			float: left;
			width: 230px;
			padding: 0px;
		}
		
		.card .text-center {
			height: 147px;
			background: #F1EFE7;
			padding-top: 35px;
			padding-bottom: 35px;
			border: none;
			font-family: Cafe24Supermagic-Bold;
		}
		
		.list-group-item {
			background: #F1EFE7;
			border: none;
			font-family: Cafe24Supermagic-Bold;
		}
		
		.container {
			margin: 0px;
		}
		
		#default {
			margin-right: 0px;
		}
		
		.col-sm-9 {
			padding: 0px;
			position: fixed;
			margin-left: 230px;
		}
		
		.container-fluid {
			margin: 0px;
			padding: 0px;
			width: 2000px;
		}
		#cal {
			float: left;
			margin: 15px 8px 15px 15px;
			display: inline-block;
		}
		
		#list {
			float: right;
			width: 360px;
			height: 445px;
			margin-top: 35px;
			padding: 10px 0px 0px 0px;
			border: 3px solid #e9ecef;
			border-radius: 20px;
		}
		
		.cal_border {
			border: 3px solid #e9ecef;
			width: 90px;
		}
		
		.yol {
			text-align: center;
			height: 30px;
		}
		
		.day {
			padding: 0px;
			height: 76px;
		}
		
		h2 {
			margin-left: 15px;
			font-family: esamanru Medium;
			margin-top: 5px;
		}
		
		#list_hr {
			border: 0px;
			height: 2px;
			background: #e9ecef;
		}
		
		.schedule_list {
			border: 1px solid #e9ecef;
			border-radius: 10px;
			padding: 15px 0px 15px 10px;
			margin-left: 5px;
			margin-bottom: 7px;
			width: 345px;
		}
		
		.schedule_name, .text {
			font-family: esamanru Light;
			font-weight: bold;
		}
		
		.schedule_time {
			font-family: esamanru Light;
			font-size: 13px;
		}
		
		.up_btn {
			float: right;
			font-size:13px;
			margin: -35px 8px 0px 0px;
			height: 35px;
			border: 1px solid black;
			border-radius: 5px;
			background: none;
		}
		
		.del_btn {
			float: right;
			font-size: 13px;
			margin: 3px 8px 0px 0px;
			border: 1px solid black;
			border-radius: 5px;
			background: none;
			
		}
		
		.plus_img {
			width: 50px;
			height: 60px;
			margin-right: 8px;
			margin-left: 300px;
			margin-bottom: 25px;
			position: fixed;
			bottom:0;
		}
		
	</style>
</head>
<body onload="init(${year},${month-1})">  
<div id="head_up">
	<span id="logo" onclick="main()"> <img src="resources/img/logo.png" width="250"> </span>
	<span id="store_change"> <button type="button" class="btn btn-outline-dark btn-sm"> 사업장 변경 </button> </span>
	<span id="logout"> <button type="button" class="btn btn-outline-danger btn-sm"> 로그아웃 </button> </span>
</div>

<hr class="hr_solid">
<div class="container">
<div class="row">
<div class="card border-light col-sm-3" id="default">
	<div class="card text-center">
	<p> 이륜나 님, </p>
	<p> 반갑습니다. </p>
	</div>
	<div id="head_side" class="list-group list-group-flush">
    	<a class="list-group-item list-group-item-action" href="schedule"> 스케줄 </a>
    	<a class="list-group-item list-group-item-action" href="fill"> 대타관리 </a>
    	<a class="list-group-item list-group-item-action" href="insu_list"> 인수인계 </a>
    	<a class="list-group-item list-group-item-action" href="manage_main"> 직원관리 </a>
    	<a class="list-group-item list-group-item-action" href="mypage_main"> 마이페이지 </a>
    	<a class="list-group-item list-group-item-action" href="#"> 공지사항 </a>
    	<a class="list-group-item list-group-item-action" href="#"> 설정 </a>
    </div>
</div>
    
    

<div class="col-sm-9" id="section">
<div class="container-fluid">
<form:form id="ceo_schedule" name="ceo_schedule" method="post">
	<input type="hidden" name="bno">
	<input type="hidden" name="day">
	
	<div style="display:inline-block;">
		<div id="cal">	</div>
			
				<div id="list">
					<h2>${date } </h2>
					<hr id="list_hr">
					<c:if test="${position == '직원' }">
						<tr>
							<td> <button onclick="schedule_request('${year}','${month+1}')"> ${month+1}월 휴무신청 </button> </td>
						</tr>
					</c:if>			
					
					<c:forEach var="result" items="${schedule}" varStatus="status">	
					<div class="schedule_list">
						<c:if test="${result.apply_name == null }">
							<span class="schedule_name"> ${result.name} </span> <br>
							<!-- <span class="text"> ⊙ 근무시간 ⊙ </span> --> <span class="schedule_time"> ${result.start_time} ~ 	${result.end_time} ( ${result.di_time} )</span>
						</c:if>
						
						<c:if test="${result.apply_name != null }">
							<span class="schedule_name"> ${result.apply_name} </span> <br>
							<!-- <span class="text"> ⊙ 근무시간 ⊙ </span> --> <span class="schedule_time"> ${result.start_time} ~ 	${result.end_time} ( ${result.di_time} )</span>
						</c:if>
						
						<c:if test="${position == '사장' }">
							<span> <button class="up_btn" onclick="schedule_update(${result.bno},'${result.day}')"> 수정 </button></span>
							<span> <button class="del_btn" onclick="schedule_delete(${result.bno},'${result.day}')"> 삭제  </button></span>
						</c:if>
					</div>	
					</c:forEach>
					
					<c:if test="${position == '사장' }">
						<span onclick="schedule_write('${date}')"> <img src="resources/img/plus2.png" class="plus_img"> </span>
					</c:if>
						
				</div>
	</div>
	</form:form>
	
	</div>
	</div>
	</div>
	</div>
</body>

</html>