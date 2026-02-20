package kr.co.storefamily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;
import mapper.JoinMapper;

@Service
public class JoinServiceImpl implements JoinService{
	@Autowired
	private JoinMapper JoinMapper;

	@Override
	public List<Local_Do> local_do_list() {
		return this.JoinMapper.local_do_list();
	}

	@Override
	public List<Local_Si> local_si_list(String local_do_code) {
		return this.JoinMapper.local_si_list(local_do_code);
	}

	@Override
	public List<Field> field_list() {
		return this.JoinMapper.field_list();
	}

	@Override
	public int getcode(String code) {
		return this.JoinMapper.getcode(code);
	}
	
	@Override
	public int member_join_ok(Member member) {
		return this.JoinMapper.member_join_ok(member);
	}

	@Override
	public void store_join_ok(Member member) {
		this.JoinMapper.store_join_ok(member);
	}

	@Override
	public int check_userid(String id) {
		return this.JoinMapper.check_userid(id);
	}

}
