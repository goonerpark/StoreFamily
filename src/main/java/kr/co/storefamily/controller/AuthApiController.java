package kr.co.storefamily.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.storefamily.dto.ApiErrorResponseDto;
import kr.co.storefamily.dto.JwtLoginResponseDto;
import kr.co.storefamily.dto.LoginRequestDto;
import kr.co.storefamily.exception.AuthenticationException;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.security.JwtTokenProvider;
import kr.co.storefamily.service.LoginService;

@RestController
@RequestMapping("/api/auth")
public class AuthApiController {

	private final LoginService loginService;
	private final JwtTokenProvider jwtTokenProvider;

	public AuthApiController(LoginService loginService, JwtTokenProvider jwtTokenProvider) {
		this.loginService = loginService;
		this.jwtTokenProvider = jwtTokenProvider;
	}

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody @Valid LoginRequestDto loginRequest) {
		try {
			Member member = loginService.login(loginRequest);
			String token = jwtTokenProvider.createAccessToken(member);
			return ResponseEntity.ok(new JwtLoginResponseDto(token, member.getId(), member.getName(), toRole(member)));
		} catch (AuthenticationException ex) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiErrorResponseDto(ex.getMessage()));
		}
	}

	@GetMapping("/me")
	public ResponseEntity<?> me(Authentication authentication) {
		if (authentication == null || !authentication.isAuthenticated()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiErrorResponseDto("Authentication required."));
		}
		return ResponseEntity.ok(authentication);
	}

	private String toRole(Member member) {
		if ("사장".equals(member.getPosition())) {
			return "ROLE_CEO";
		}
		if ("관리자".equals(member.getPosition())) {
			return "ROLE_MANAGER";
		}
		return "ROLE_EMPLOYEE";
	}
}
