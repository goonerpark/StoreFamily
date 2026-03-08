package kr.co.storefamily.repository;

import java.util.List;

import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;

public interface JoinRepository {

	List<Local_Do> findAllLocalDo();

	List<Local_Si> findLocalSiByDoCode(String localDoCode);

	List<Field> findAllField();

	int insertMember(Member member);

	int countById(String id);
}
