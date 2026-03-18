package kr.co.storefamily.dto;

import javax.validation.constraints.NotBlank;

public class LoginRequestDto {

	@NotBlank(message = "아이디는 필수 입력입니다.")
	private String id;

	@NotBlank(message = "비밀번호는 필수 입력입니다.")
	private String pwd;

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
}
