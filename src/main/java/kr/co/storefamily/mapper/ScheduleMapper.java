package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Schedule;

@Mapper
public interface ScheduleMapper {
	List<Schedule> schedule(@Param("day")String day,@Param("code")String code);
	List<Schedule> full_schedule(String code);
	
	List<Member> employee_list(@Param("code") String code, @Param("id") String id);
	Schedule this_schedule(int bno);
	Member find_employee(String id);
	int schedule_write_ok(Schedule schedule);
	String update_get_name(String id);
	int schedule_update_ok(Schedule schedule);
	int schedule_delete(int bno);
	List<Schedule> ceo_schedule_request_list(String code);
	int ceo_schedule_request_attendance_no(int bno);
	int ceo_schedule_request_attendance_yes(int bno);
}
