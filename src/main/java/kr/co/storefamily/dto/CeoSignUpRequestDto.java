package kr.co.storefamily.dto;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class CeoSignUpRequestDto {

	@NotBlank(message = "이름은 필수 입력입니다.")
	private String name;

	@NotBlank(message = "아이디는 필수 입력입니다.")
	@Size(min = 4, max = 20, message = "아이디는 4자 이상 20자 이하로 입력해 주세요.")
	private String id;

	@NotBlank(message = "비밀번호는 필수 입력입니다.")
	@Size(min = 4, max = 50, message = "비밀번호는 4자 이상 입력해 주세요.")
	private String pwd;

	@NotBlank(message = "비밀번호 확인은 필수 입력입니다.")
	private String confirmPwd;

	@NotBlank(message = "이메일은 필수 입력입니다.")
	@Email(message = "이메일 형식이 올바르지 않습니다.")
	private String email;

	@NotBlank(message = "생년월일은 필수 입력입니다.")
	private String birthDate;

	@NotBlank(message = "성별은 필수 입력입니다.")
	private String gender;

	@NotBlank(message = "주소는 필수 입력입니다.")
	private String address;

	private String addressEtc;

	@NotBlank(message = "휴대폰 번호는 필수 입력입니다.")
	@Pattern(regexp = "^[0-9\\-]{8,20}$", message = "휴대폰 번호 형식이 올바르지 않습니다.")
	private String phone;

	@NotBlank(message = "매장명은 필수 입력입니다.")
	private String bussiness;

	@NotBlank(message = "매장 전화번호는 필수 입력입니다.")
	private String bussinessnum;

	@NotBlank(message = "매장 주소는 필수 입력입니다.")
	private String bussinessaddress;

	private String bussinessaddressEtc;

	private String field;

	private String localDo;

	private String localSi;

	private String code;

	private String position;

	@AssertTrue(message = "비밀번호와 비밀번호 확인이 일치하지 않습니다.")
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

	public String getBussiness() {
		return bussiness;
	}

	public void setBussiness(String bussiness) {
		this.bussiness = bussiness;
	}

	public String getBussinessnum() {
		return bussinessnum;
	}

	public void setBussinessnum(String bussinessnum) {
		this.bussinessnum = bussinessnum;
	}

	public String getBussinessaddress() {
		return bussinessaddress;
	}

	public void setBussinessaddress(String bussinessaddress) {
		this.bussinessaddress = bussinessaddress;
	}

	public String getBussinessaddressEtc() {
		return bussinessaddressEtc;
	}

	public void setBussinessaddressEtc(String bussinessaddressEtc) {
		this.bussinessaddressEtc = bussinessaddressEtc;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getLocalDo() {
		return localDo;
	}

	public void setLocalDo(String localDo) {
		this.localDo = localDo;
	}

	public String getLocalSi() {
		return localSi;
	}

	public void setLocalSi(String localSi) {
		this.localSi = localSi;
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
