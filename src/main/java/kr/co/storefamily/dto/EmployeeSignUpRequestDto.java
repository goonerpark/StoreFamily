package kr.co.storefamily.dto;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class EmployeeSignUpRequestDto {

	@NotBlank(message = "Name is required.")
	private String name;

	@NotBlank(message = "ID is required.")
	@Size(min = 4, max = 20, message = "ID must be between 4 and 20 characters.")
	private String id;

	@NotBlank(message = "Password is required.")
	@Size(min = 4, max = 50, message = "Password must be at least 4 characters.")
	private String pwd;

	@NotBlank(message = "Confirm password is required.")
	private String confirmPwd;

	@NotBlank(message = "Email is required.")
	@Email(message = "Invalid email format.")
	private String email;

	@NotBlank(message = "Birth date is required.")
	private String birthDate;

	@NotBlank(message = "Gender is required.")
	private String gender;

	@NotBlank(message = "Address is required.")
	private String address;

	private String addressEtc;

	@NotBlank(message = "Phone is required.")
	@Pattern(regexp = "^[0-9\\-]{8,20}$", message = "Phone format is invalid.")
	private String phone;

	@NotBlank(message = "Store code is required.")
	private String code;

	private String position;

	@AssertTrue(message = "Password and confirm password do not match.")
	public boolean isPasswordMatched() {
		if (pwd == null || confirmPwd == null) {
			return false;
		}
		return pwd.equals(confirmPwd);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getConfirmPwd() {
		return confirmPwd;
	}

	public void setConfirmPwd(String confirmPwd) {
		this.confirmPwd = confirmPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressEtc() {
		return addressEtc;
	}

	public void setAddressEtc(String addressEtc) {
		this.addressEtc = addressEtc;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
}
