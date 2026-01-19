package kr.co.storefamily.service;

import kr.co.storefamily.model.Member;

public interface LoginService {

	public Member getLogin(String id, String pwd);
	public Member getStore(String code, String id);
}
