package kr.co.storefamily.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Schedule;
import kr.co.storefamily.service.ScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService ScheduleService;
	
	@RequestMapping(value="schedule2")
	public String schedule2() {
		return "Schedule/common/schedule2";
	}

	@RequestMapping(value="/schedule")
	public String employee_schedule(@RequestParam(value = "day", required = false) String day, Model model, HttpSession session)
			throws Exception {
		if (day == null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			day = format.format(now);
		}

		String year = day.substring(0, 4);
		String month = day.substring(5, 7);

		String session_code = (String) session.getAttribute("code");
		String position = (String)session.getAttribute("position");
		List<Schedule> full_schedule = this.ScheduleService.full_schedule(session_code);
		List<Schedule> schedule = this.ScheduleService.schedule(day, session_code);

		for (Schedule element : full_schedule) {
			if(element.getApply_name() == null)
			{
				element.setName(element.getName());
			}
			else
				element.setName(element.getApply_name());
		}

		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", day);
		model.addAttribute("schedule", schedule);
		model.addAttribute("full_schedule", full_schedule);
		model.addAttribute("position", position);
		return "/Schedule/common/schedule";
	}
	
	@RequestMapping(value = "schedule_request")
	public String schedule_request(@RequestParam(value = "year", required = false) String year,@RequestParam(value = "month", required = false) String month) throws Exception {
		return "Schedule/employee/schedule_request";
	}

	@RequestMapping(value="/schedule_write")
	public String schedule_write(@RequestParam(value = "day", required = false) String day, Model model, HttpSession session) throws Exception {

		//달력 띄우기
		if (day == null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			day = format.format(now);
		}

		String year = day.substring(0, 4);
		String month = day.substring(5, 7);

		String session_code = (String) session.getAttribute("code");
		List<Schedule> full_schedule = this.ScheduleService.full_schedule(session_code);


		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", day);
		model.addAttribute("full_schedule", full_schedule);

		String session_id = (String) session.getAttribute("id");
		List<Member> employee_list = this.ScheduleService.employee_list(session_code, session_id);
		model.addAttribute("employee_list", employee_list);

		return "Schedule/ceo/schedule_write";
	}

	@RequestMapping(value="schedule_write_ok")
	public String schedule_write_ok(@ModelAttribute("schedule_write") Schedule schedule, BindingResult result, RedirectAttributes rea) throws Exception {
		String date = schedule.getImsi();
		Member find_employee = this.ScheduleService.find_employee(schedule.getId());
		schedule.setName(find_employee.getName());
		schedule.setCode(find_employee.getCode());

		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		String nstart_time = schedule.getStart_time();
		String nend_time = schedule.getEnd_time();

		Date nnstart_time = format.parse(nstart_time);
		Date nnend_time = format.parse(nend_time);

		long diff = nnend_time.getTime() - nnstart_time.getTime();
		long diffMin = diff / (1000 * 60) % 60;
		long diffHour = diff / (1000 * 60 * 60);

		String di_time;

		if (diffHour == 0) {
			di_time = diffMin + "m";
			schedule.setDi_time(di_time);
		} else {
			di_time = diffHour + "h" + diffMin + "m";
			schedule.setDi_time(di_time);
		}

		if (result.hasErrors()) {
			rea.addFlashAttribute("schedule", result.getModel());
			return "redirect:/schedule_write?day="+date;
		}
		if (this.ScheduleService.schedule_write_ok(schedule) == 1) {
				return "redirect:/schedule?day="+date;
		} else
			return "redirect:/schedule_write?day="+date;
	}

	@RequestMapping(value="/schedule_update")
	public String schedule_update(@RequestParam(value="bno", required = false) int bno, @RequestParam(value="day", required = false) String day, Model model, HttpSession session) throws Exception {

		//달력띄우기
		if (day == null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			day = format.format(now);
		}

		String year = day.substring(0, 4);
		String month = day.substring(5, 7);

		String session_code = (String) session.getAttribute("code");
		List<Schedule> full_schedule = this.ScheduleService.full_schedule(session_code);


		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", day);
		model.addAttribute("full_schedule", full_schedule);

		String session_id = (String) session.getAttribute("id");
		List<Member> employee_list = this.ScheduleService.employee_list(session_code, session_id);
		model.addAttribute("employee_list", employee_list);

		Schedule this_schedule = this.ScheduleService.this_schedule(bno);
		model.addAttribute("this_schedule", this_schedule);
		return "Schedule/ceo/schedule_update";
	}

	@RequestMapping(value="schedule_update_ok")
	public String schedule_update_ok(@ModelAttribute("schedule_update") @Valid Schedule schedule,
			BindingResult result, RedirectAttributes rea) throws Exception {
		String this_day = schedule.getDay();
		System.out.println(this_day);

		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		String nstart_time = schedule.getStart_time();
		String nend_time = schedule.getEnd_time();

		Date nnstart_time = format.parse(nstart_time);
		Date nnend_time = format.parse(nend_time);

		long diff = nnend_time.getTime() - nnstart_time.getTime();
		long diffMin = diff / (1000 * 60) % 60;
		long diffHour = diff / (1000 * 60 * 60);

		String di_time;

		if (diffHour == 0) {
			di_time = diffMin + "m";
			schedule.setDi_time(di_time);
		} else {
			di_time = diffHour + "h" + diffMin + "m";
			schedule.setDi_time(di_time);
		}
		
		String get_name = this.ScheduleService.update_get_name(schedule.getId());
		System.out.println(get_name);
		schedule.setName(get_name);
		
		if (result.hasErrors()) {
			rea.addFlashAttribute("schedule", result.getModel());
			return "redirect:/schedule_update?bno="+schedule.getBno();
		}
		if (this.ScheduleService.schedule_update_ok(schedule) == 1) {
			return "redirect:/schedule?day=" + this_day;
		} else
			return "redirect:/schedule_update?bno=" + schedule.getBno();
	}

	@RequestMapping(value="schedule_delete")
	public String schedule_delete(@RequestParam(value="bno", required = false) int bno, @RequestParam(value="day", required = false) String day) {
		if(this.ScheduleService.schedule_delete(bno) == 1)
		{
			return "redirect:/ceo_schedule?day="+day;
		}
		else
		{
			return "redirect:/ceo_schedule?day="+day;
		}
	}

	@RequestMapping(value="ceo_schedule_request_list")
	public String ceo_schedule_request_list(Model model, HttpSession session) throws Exception {
		String session_code = (String) session.getAttribute("code");
		List<Schedule> ceo_schedule_request_list = this.ScheduleService.ceo_schedule_request_list(session_code);
		model.addAttribute("ceo_schedule_request_list", ceo_schedule_request_list);
		return "ceo/schedule/ceo_schedule_request_list";
	}

	@RequestMapping(value="ceo_schedule_request_attendance_no")
	public String ceo_schedule_request_attendance_no(@RequestParam(value="bno", required = false) int bno) throws Exception {
		if(this.ScheduleService.ceo_schedule_request_attendance_no(bno) == 1)
		{
			return "redirect:/ceo_schedule_request_list";
		}
		else
		{
			return "redirect:/schedule_request_content?bno="+bno;
		}

	}

	@RequestMapping(value="ceo_schedule_request_attendance_yes")
	public String ceo_schedule_request_attendance_yes(@ModelAttribute("schedule_request_content") @Valid Schedule schedule,
			BindingResult result, RedirectAttributes rea) throws Exception {
		int bno = schedule.getBno();
		/*
		schedule.setDay(schedule.getRe_day());
		schedule.setStart_time(schedule.getRe_start_time());
		schedule.setEnd_time(schedule.getRe_end_time());
		schedule.setDi_time(schedule.getRe_di_time());
		*/

		if (result.hasErrors()) {
			rea.addFlashAttribute("schedule", result.getModel());
			return "redirect:/schedule_request_content?bno="+bno;
		}
		if (this.ScheduleService.ceo_schedule_request_attendance_yes(bno) == 1) {
			return "redirect:/ceo_schedule_request_list";
		} else
			return "redirect:/schedule_request_content?bno="+bno;

	}
}


