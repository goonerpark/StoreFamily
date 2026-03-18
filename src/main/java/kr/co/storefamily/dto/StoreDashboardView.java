package kr.co.storefamily.dto;

public class StoreDashboardView {
	private String storeId;
	private String storeName;
	private String storeCode;
	private String address;
	private String phone;
	private String createdAt;
	private int employeeCount;
	private int pendingApprovalCount;

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public int getEmployeeCount() {
		return employeeCount;
	}

	public void setEmployeeCount(int employeeCount) {
		this.employeeCount = employeeCount;
	}

	public int getPendingApprovalCount() {
		return pendingApprovalCount;
	}

	public void setPendingApprovalCount(int pendingApprovalCount) {
		this.pendingApprovalCount = pendingApprovalCount;
	}
}
