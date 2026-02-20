package kr.co.storefamily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Schedule;
import mapper.ScheduleMapper;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleMapper ScheduleMapper;

	@Override
	public List<Schedule> schedule(String day, String code) {
		return this.ScheduleMapper.schedule(day,code);
	}

	@Override
	public List<Schedule> full_schedule(String code) {
		return this.ScheduleMapper.full_schedule(code);
	}

	@Override
	public List<Member> employee_list(String code, String id) {
		return this.ScheduleMapper.employee_list(code,id);
	}

	@Override
	public Schedule this_schedule(int bno) {
		return this.ScheduleMapper.this_schedule(bno);
	}

	@Override
	public Member find_employee(String id) {
		return this.ScheduleMapper.find_employee(id);
	}

	@Override
	public int schedule_write_ok(Schedule schedule) {
		return this.ScheduleMapper.schedule_write_ok(schedule);
	}
	
	@Override
	public String update_get_name(String id) {
		return this.ScheduleMapper.update_get_name(id);
	}

	@Override
	public int schedule_update_ok(Schedule schedule) {
		return this.ScheduleMapper.schedule_update_ok(schedule);
	}

	@Override
	public int schedule_delete(int bno) {
		return this.ScheduleMapper.schedule_delete(bno);
	}

	@Override
	public List<Schedule> ceo_schedule_request_list(String code) {
		return this.ScheduleMapper.ceo_schedule_request_list(code);
	}

	@Override
	public int ceo_schedule_request_attendance_no(int bno) {
		return this.ScheduleMapper.ceo_schedule_request_attendance_no(bno);
	}

	@Override
	public int ceo_schedule_request_attendance_yes(int bno) {
		return this.ScheduleMapper.ceo_schedule_request_attendance_yes(bno);
	}

}
