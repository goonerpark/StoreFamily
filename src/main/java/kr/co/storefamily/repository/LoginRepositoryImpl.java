package kr.co.storefamily.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.storefamily.mapper.LoginMapper;
import kr.co.storefamily.model.Member;

@Repository
public class LoginRepositoryImpl implements LoginRepository {

	@Autowired
	private LoginMapper loginMapper;

	@Override
	public Member findLoginMember(String id, String pwd) {
		return loginMapper.getLogin(id, pwd);
	}

	@Override
	public Member findStore(String code, String id) {
		return loginMapper.getStore(code, id);
	}
}
