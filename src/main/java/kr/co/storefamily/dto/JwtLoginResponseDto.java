package kr.co.storefamily.dto;

public class JwtLoginResponseDto {

	private String accessToken;
	private String tokenType;
	private String id;
	private String name;
	private String role;

	public JwtLoginResponseDto(String accessToken, String id, String name, String role) {
		this.accessToken = accessToken;
		this.tokenType = "Bearer";
		this.id = id;
		this.name = name;
		this.role = role;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public String getTokenType() {
		return tokenType;
	}

	public void setTokenType(String tokenType) {
		this.tokenType = tokenType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}
