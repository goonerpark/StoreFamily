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
	function init(y, m) {
		var year = y;
		var month = m;

		var xday = new Date(year, month, 1);
		var yoil = xday.getDay();

		var mon = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var chong = mon[month];

		if (month === 1) {
			if ((year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0)) chong++;
		}

		var ju = Math.ceil((chong + yoil) / 7);

		var cal_data = "<table width='800' border='1'>";
		cal_data += "<caption>";

		if (month === 0)
			cal_data += "<a href='javascript:init(" + (year - 1) + ",11)'> 이전 </a>";
		else
			cal_data += "<a href='javascript:init(" + year + "," + (month - 1) + ")'> 이전 </a>";

		cal_data += year + "년" + (month + 1) + "월";

		if (month === 11)
			cal_data += "<a href='javascript:init(" + (year + 1) + ",0)'> 다음 </a>";
		else
			cal_data += "<a href='javascript:init(" + year + "," + (month + 1) + ")'> 다음 </a>";

		cal_data += "</caption>";

		cal_data += "<tr><td> 일 </td><td> 월 </td><td> 화 </td><td> 수 </td><td> 목 </td><td> 금 </td><td> 토 </td></tr>";

		var day = 1;

		// 서버에서 내려준 full_schedule을 JS 배열로 변환
		var name_list = [];
		var date_list = [];
		<c:forEach items="${full_schedule}" var="fs">
			name_list.push("${fs.name}");
			date_list.push("${fs.day}");
		</c:forEach>

		var date_list_getTime = [];
		for (var i = 0; i < date_list.length; i++) {
			var d = new Date(date_list[i]);
			date_list_getTime.push(d.getTime());
		}

		for (var row = 1; row <= ju; row++) {
			cal_data += "<tr>";
			for (var col = 0; col < 7; col++) {
				if ((col < yoil && row === 1) || (chong < day)) {
					cal_data += "<td></td>";
				} else {
					var final_list = [];

					var nmonth = month + 1;
					var monthStr = (nmonth < 10 ? "0" + nmonth : "" + nmonth);

					var dayNum = day; // 숫자 유지
					var dayStr = (dayNum < 10 ? "0" + dayNum : "" + dayNum);

					var full_date = year + "-" + monthStr + "-" + dayStr;
					var full_date_time = new Date(full_date);

					for (var z = 0; z < date_list_getTime.length; z++) {
						if (full_date_time.getTime() === date_list_getTime[z]) {
							final_list.push(name_list[z]);
						}
					}

					cal_data += "<td onclick='schedule(" + year + "," + (month + 1) + "," + dayNum + ")'>"
						+ dayNum + "<br>" + final_list.join("<br>") + "</td>";

					day++;
				}
			}
			cal_data += "</tr>";
		}

		cal_data += "</table>";

		document.getElementById("cal").innerHTML = cal_data;
	}

	function schedule(year, month, day) {
		var nyear = year.toString();
		var nmonth = month.toString();
		var nday = day.toString();

		if (nmonth.length === 1) nmonth = "0" + nmonth;
		if (nday.length === 1) nday = "0" + nday;

		var date = nyear + "-" + nmonth + "-" + nday;
		location.href = "employee_schedule?day=" + date;
	}

	function schedule_request() {
		document.employee_schedule.action = "schedule_request";
		document.employee_schedule.submit();
	}
</script>
</head>

<body onload="init(${year}, ${month-1})">
<form:form id="employee_schedule" name="employee_schedule" method="post">
	<input type="hidden" name="bno">
	<input type="hidden" name="day">
	<input type="hidden" name="id">

	<div style="display:inline-block;">
		<div id="cal" style="display: inline-block;"></div>

		<div style="display: inline-block;">
			<h1>${date}</h1>
			<table border="1">
				<c:forEach var="result" items="${schedule}" varStatus="status">
					<tr>
						<td width="500">
							<c:if test="${result.apply_name == null}">
								${result.name} &nbsp;&nbsp; ${result.start_time} ~ ${result.end_time} ( ${result.di_time} )
							</c:if>

							<c:if test="${result.apply_name != null}">
								${result.apply_name} &nbsp;&nbsp; ${result.start_time} ~ ${result.end_time} ( ${result.di_time} )
							</c:if>
						</td>
					</tr>
				</c:forEach>

				<tr>
					<td>
						<!-- 버튼 기본 submit 방지 + 인자 제거 -->
						<button type="button" onclick="schedule_request()">휴무신청하기</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form:form>
</body>
</html>
