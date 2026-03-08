package kr.co.storefamily.model;

public class Store {
	private String store_id;
	private String store_code;
	private String store_name;
	private String store_address;
	private String store_phone;
	private Integer ceo_bno;
	private String created_at;

	public String getStore_id() {
		return store_id;
	}

	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}

	public String getStore_code() {
		return store_code;
	}

	public void setStore_code(String store_code) {
		this.store_code = store_code;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_address() {
		return store_address;
	}

	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}

	public String getStore_phone() {
		return store_phone;
	}

	public void setStore_phone(String store_phone) {
		this.store_phone = store_phone;
	}

	public Integer getCeo_bno() {
		return ceo_bno;
	}

	public void setCeo_bno(Integer ceo_bno) {
		this.ceo_bno = ceo_bno;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
}
