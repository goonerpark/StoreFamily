package kr.co.storefamily.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.dto.LoginRequestDto;
import kr.co.storefamily.exception.AuthenticationException;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.repository.LoginRepository;

@Service
public class LoginServiceImpl implements LoginService {

	private static final String POSITION_CEO = "\uC0AC\uC7A5";
	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";

	@Autowired
	private LoginRepository loginRepository;

	@Override
	public Member login(LoginRequestDto loginRequestDto) {
		Member loginMember = loginRepository.findLoginMember(loginRequestDto.getId(), loginRequestDto.getPwd());
		if (loginMember == null) {
			throw new AuthenticationException("\uC544\uC774\uB514 \uB610\uB294 \uBE44\uBC00\uBC88\uD638\uAC00 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.");
		}

		Member store = loginRepository.findLatestStoreByCeoBno(loginMember.getBno());
		loginMember.setPosition(store != null ? POSITION_CEO : POSITION_EMPLOYEE);
		return loginMember;
	}

	@Override
	public Member getStore(int ceoBno) {
		return loginRepository.findLatestStoreByCeoBno(ceoBno);
	}
}
