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
		var cal_data = "<table width='800' border='1'>";
		
		//caption 태그에 
		cal_data = cal_data + "<caption>";
		
		cal_data = cal_data + year + "년" + (month+1) + "월";
			
		cal_data = cal_data + "</caption>";
		
		cal_data = cal_data + "<tr>";
		cal_data = cal_data + "<td> 일 </td>";
		cal_data = cal_data + "<td> 월 </td>";
		cal_data = cal_data + "<td> 화 </td>";
		cal_data = cal_data + "<td> 수 </td>";
		cal_data = cal_data + "<td> 목 </td>";
		cal_data = cal_data + "<td> 금 </td>";
		cal_data = cal_data + "<td> 토 </td>";
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
		
		var date_list_getTime = new Array(); // 날짜로 변경해서 저장할 리스트
		
		
		for(i=1;i<=ju;i++) // 행
		{
			cal_data = cal_data + "<tr>";
			for(j=0;j<7;j++)
			{
				 if( (j<yoil && i==1) || (chong < day))
				 {	 
				   cal_data=cal_data+"<td> </td>";
				 }
				else 
				{
					var final_list = new Array(); //해당 날짜의 이름 리스트
					var nmonth = month + 1;
					if(nmonth < 10)
						nmonth = "0" + nmonth;
					if(day < 10)
						day = "0" + day;
					
					cal_data = cal_data +"<td onclick='schedule(" + year + "," + (month+1) + "," + day +")'>" + day + "<br>" + ${final_list} + "</td>";
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
</script>
</head>
<body onload="init(${year},${month-1})">  
<form:form id="ceo_schedule" name="ceo_schedule" method="post">
	<input type="hidden" name="bno">
	<input type="hidden" name="day">
	
	<div style="display:inline-block;">
		<div id="cal" style="display: inline-block;">	</div>
			
				<div style="display: inline-block;">
					<h1>${date } </h1>
					<c:if test="${position == '직원' }">
						<tr>
							<td> <button onclick="${month+1}"> ${month+1}월 휴무신청 </button> </td>
						</tr>
					</c:if>				
						<table border="1">
							<tbody>
							<c:forEach var="result" items="${schedule}" varStatus="status">			
								<tr >
									<td width="500">
										<c:if test="${result.apply_name == null }">
											${result.name} &nbsp;&nbsp; ${result.start_time} ~ ${result.end_time} ( ${result.di_time} ) 
										</c:if>
										
										<c:if test="${result.apply_name != null }">
											${result.apply_name} &nbsp;&nbsp; ${result.start_time} ~ ${result.end_time} ( ${result.di_time} ) 
										</c:if>
									</td>
									
									<c:if test="${position == '사장' }">
									<td> <button onclick="schedule_update(${result.bno},'${result.day}')"> 수정 </button> </td>
									<td> <button onclick="schedule_delete(${result.bno},'${result.day}')"> 삭제 </button> </td>
									</c:if>
								</tr>
							</c:forEach>
							</tbody>
							
							<c:if test="${position == '사장' }">
							<tr>
								<td> <button onclick="schedule_write('${date}')"> 스케줄 등록 </button> </td>
							</tr>							
							
							<tr>
								<td> <button onclick="ceo_schedule_request_list()"> 스케줄 요청 목록 </button> </td>
							</tr>
							</c:if>
							
							
						</table>				
				</div>
	</div>
	</form:form>
</body>

</html>