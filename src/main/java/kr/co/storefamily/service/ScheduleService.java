package kr.co.storefamily.service;

import java.util.List;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Schedule;


public interface ScheduleService {
	public List<Schedule> schedule(String day,String code);
	public List<Schedule> full_schedule(String code);


	public List<Member> employee_list(String code, String id);
	public Schedule this_schedule(int bno);
	public Member find_employee(String id);
	public int schedule_write_ok(Schedule schedule);
	public String update_get_name(String id);
	public int schedule_update_ok(Schedule schedule);
	public int schedule_delete(int bno);
	public List<Schedule> ceo_schedule_request_list(String code);
	public int ceo_schedule_request_attendance_no(int bno);
	public int ceo_schedule_request_attendance_yes(int bno);
}
