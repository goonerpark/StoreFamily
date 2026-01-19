package kr.co.storefamily.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.mapper.LoginMapper;
import kr.co.storefamily.model.Member;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper LoginMapper;

	@Override
	public Member getLogin(String id, String pwd) {
		return this.LoginMapper.getLogin(id,pwd);
	}

	@Override
	public Member getStore(String code, String id) {
		return this.LoginMapper.getStore(code, id);
	}
}
