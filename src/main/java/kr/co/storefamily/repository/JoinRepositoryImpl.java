package kr.co.storefamily.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.storefamily.mapper.JoinMapper;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;

@Repository
public class JoinRepositoryImpl implements JoinRepository {

	@Autowired
	private JoinMapper joinMapper;

	@Override
	public List<Local_Do> findAllLocalDo() {
		return joinMapper.local_do_list();
	}

	@Override
	public List<Local_Si> findLocalSiByDoCode(String localDoCode) {
		return joinMapper.local_si_list(localDoCode);
	}

	@Override
	public List<Field> findAllField() {
		return joinMapper.field_list();
	}

	@Override
	public int findLastStoreCodeSuffix(String codePrefix) {
		return joinMapper.getcode(codePrefix);
	}

	@Override
	public int insertMember(Member member) {
		return joinMapper.member_join_ok(member);
	}

	@Override
	public void insertStore(Member member) {
		joinMapper.store_join_ok(member);
	}

	@Override
	public int countById(String id) {
		return joinMapper.check_userid(id);
	}
}
