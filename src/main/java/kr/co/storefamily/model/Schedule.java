package kr.co.storefamily.model;

public class Schedule {
	private int bno;
	private String name;
	private String start_time;
	private String end_time;
	private String day;
	private String di_time;
	private String code;
	private String attendance;
	private String id;
	private int schedule_bno;
	private String content;
	private int request;
	//@NotEmpty(message="제목을 입력하세요")
	private String title;
	private String re_day;
	private String re_start_time;
	private String re_end_time;
	private String re_di_time;
	private int request_attendance;
	private String imsi;

	private String apply_name;
	private String apply_id;
	private String apply_code;



	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getDi_time() {
		return di_time;
	}
	public void setDi_time(String di_time) {
		this.di_time = di_time;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSchedule_bno() {
		return schedule_bno;
	}
	public void setSchedule_bno(int schedule_bno) {
		this.schedule_bno = schedule_bno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRequest() {
		return request;
	}
	public void setRequest(int request) {
		this.request = request;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRe_day() {
		return re_day;
	}
	public void setRe_day(String re_day) {
		this.re_day = re_day;
	}
	public String getRe_start_time() {
		return re_start_time;
	}
	public void setRe_start_time(String re_start_time) {
		this.re_start_time = re_start_time;
	}
	public String getRe_end_time() {
		return re_end_time;
	}
	public void setRe_end_time(String re_end_time) {
		this.re_end_time = re_end_time;
	}
	public String getRe_di_time() {
		return re_di_time;
	}
	public void setRe_di_time(String re_di_time) {
		this.re_di_time = re_di_time;
	}
	public int getRequest_attendance() {
		return request_attendance;
	}
	public void setRequest_attendance(int request_attendance) {
		this.request_attendance = request_attendance;
	}
	public String getApply_name() {
		return apply_name;
	}
	public void setApply_name(String apply_name) {
		this.apply_name = apply_name;
	}
	public String getApply_id() {
		return apply_id;
	}
	public void setApply_id(String apply_id) {
		this.apply_id = apply_id;
	}
	public String getApply_code() {
		return apply_code;
	}
	public void setApply_code(String apply_code) {
		this.apply_code = apply_code;
	}





}
