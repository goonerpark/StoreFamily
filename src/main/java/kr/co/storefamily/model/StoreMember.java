package kr.co.storefamily.model;

public class StoreMember {
	private Integer store_member_id;
	private String store_id;
	private Integer member_bno;
	private String position;
	private Integer chk;
	private String employment;
	private String health;
	private String rate;
	private String color;

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

	public String getEmployment() {
		return employment;
	}

	public void setEmployment(String employment) {
		this.employment = employment;
	}

	public String getHealth() {
		return health;
	}

	public void setHealth(String health) {
		this.health = health;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
}
