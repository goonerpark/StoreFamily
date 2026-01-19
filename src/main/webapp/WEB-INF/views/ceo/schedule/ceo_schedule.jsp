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
		
		//caption 태그에 이전/다음 넣기
		cal_data = cal_data + "<caption>";
		if(month == 0) //1월이면
			cal_data = cal_data + "<a href = 'javascript:init(" + (year-1) + ",11)'> 이전 </a>";
		else
			cal_data = cal_data + "<a href = 'javascript:init(" + year + "," + (month-1) + ")'> 이전 </a>";
			
		cal_data = cal_data + year + "년" + (month+1) + "월";
		
		if(month == 11) //12월이면
			cal_data = cal_data + "<a href='javascript:init(" + (year+1) + ",0)'> 다음 </a>";
		else
			cal_data = cal_data + "<a href='javascript:init(" + year + "," + (month+1) + ")'> 다음 </a>";
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
					var full_date = year + "-" + nmonth + "-" + day;
					var full_date_time = new Date(full_date);
					
					for(z=0; z<date_list_getTime.length; z++)
					{
						if(full_date_time.getTime() == date_list_getTime[z]) //달력 날짜와 스케줄 날짜가 같다면 이름 저장
						{
							final_list.push(name_list[z]);
						}
					}
					<c:set var="final_list" value="final_list"/> //화면에 띄우기 위해 변수로 변경
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
		
		location.href="ceo_schedule?day="+date;
	}
	
	function schedule_write(day)
	{
		document.ceo_schedule.day.value = day;
		document.ceo_schedule.action = 'schedule_write';
		document.ceo_schedule_submit();
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
	
	function ceo_schedule_request_list()
	{
		document.ceo_schedule.action = 'ceo_schedule_request_list';
		document.ceo_schedule.submit();
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
					<h1>${date }</h1>				
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
									<td> <button onclick="schedule_update(${result.bno},'${result.day}')"> 수정 </button> </td>
									<td> <button onclick="schedule_delete(${result.bno},'${result.day}')"> 삭제 </button> </td>
								</tr>
							</c:forEach>
							</tbody>
							
							<tr>
								<td> <button onclick="schedule_write('${date}')"> 스케줄 등록 </button> </td>
							</tr>							
							
							<tr>
								<td> <button onclick="ceo_schedule_request_list()"> 스케줄 요청 목록 </button> </td>
							</tr>
						</table>				
				</div>
	</div>
	</form:form>
</body>

</html>