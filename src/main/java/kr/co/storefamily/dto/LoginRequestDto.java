package kr.co.storefamily.dto;

import javax.validation.constraints.NotBlank;

public class LoginRequestDto {

	@NotBlank(message = "ID is required.")
	private String id;

	@NotBlank(message = "Password is required.")
	private String pwd;

	@NotBlank(message = "Position is required.")
	private String position;

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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
}
