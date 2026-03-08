package kr.co.storefamily.model;

public class StoreJoinRequest {
	private Integer store_member_id;
	private String store_id;
	private Integer member_bno;
	private String name;
	private String email;
	private String phone;
	private String position;
	private Integer chk;
	private String created_at;

	public Integer getStore_member_id() {
		return store_member_id;
	}

	public void setStore_member_id(Integer store_member_id) {
		this.store_member_id = store_member_id;
	}

	public String getStore_id() {
		return store_id;
	}

	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}

	public Integer getMember_bno() {
		return member_bno;
	}

	public void setMember_bno(Integer member_bno) {
		this.member_bno = member_bno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getChk() {
		return chk;
	}

	public void setChk(Integer chk) {
		this.chk = chk;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
}
