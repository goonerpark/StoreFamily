package kr.co.storefamily.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.dto.LoginRequestDto;
import kr.co.storefamily.exception.AuthenticationException;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.repository.LoginRepository;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginRepository loginRepository;

	@Override
	public Member login(LoginRequestDto loginRequestDto) {
		Member loginMember = loginRepository.findLoginMember(loginRequestDto.getId(), loginRequestDto.getPwd());
		if (loginMember == null) {
			throw new AuthenticationException("ID or password is incorrect.");
		}

		if (!loginRequestDto.getPosition().equals(loginMember.getPosition())) {
			throw new AuthenticationException("Selected position does not match account.");
		}

		return loginMember;
	}

	@Override
	public Member getStore(String code, String id) {
		return loginRepository.findStore(code, id);
	}
}
