package kr.co.storefamily.model;

public class StoreSchedule {
	private Integer bno;
	private Integer store_employee_bno;
	private String work_date;
	private String start_time;
	private String end_time;
	private Integer work_minutes;
	private String status;
	private String memo;
	private Integer part_bno;
	private String created_at;
	private String updated_at;
	private Integer member_bno;
	private String employee_name;
	private String employee_id;
	private String part_name;
	private String color_code;
	private Integer sort_order;

	public Integer getBno() {
		return bno;
	}

	public void setBno(Integer bno) {
		this.bno = bno;
	}

	public Integer getStore_employee_bno() {
		return store_employee_bno;
	}

	public void setStore_employee_bno(Integer store_employee_bno) {
		this.store_employee_bno = store_employee_bno;
	}

	public String getWork_date() {
		return work_date;
	}

	public void setWork_date(String work_date) {
		this.work_date = work_date;
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

	public Integer getWork_minutes() {
		return work_minutes;
	}

	public void setWork_minutes(Integer work_minutes) {
		this.work_minutes = work_minutes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Integer getPart_bno() {
		return part_bno;
	}

	public void setPart_bno(Integer part_bno) {
		this.part_bno = part_bno;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public Integer getMember_bno() {
		return member_bno;
	}

	public void setMember_bno(Integer member_bno) {
		this.member_bno = member_bno;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public String getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}

	public String getPart_name() {
		return part_name;
	}

	public void setPart_name(String part_name) {
		this.part_name = part_name;
	}

	public String getColor_code() {
		return color_code;
	}

	public void setColor_code(String color_code) {
		this.color_code = color_code;
	}

	public Integer getSort_order() {
		return sort_order;
	}

	public void setSort_order(Integer sort_order) {
		this.sort_order = sort_order;
	}
}
