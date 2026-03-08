package kr.co.storefamily.service;

import kr.co.storefamily.dto.LoginRequestDto;
import kr.co.storefamily.model.Member;

public interface LoginService {

	Member login(LoginRequestDto loginRequestDto);

	Member getStore(int ceoBno);
}
