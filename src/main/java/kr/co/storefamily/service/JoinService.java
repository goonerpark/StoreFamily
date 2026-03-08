package kr.co.storefamily.service;

import java.util.List;

import kr.co.storefamily.dto.EmployeeSignUpRequestDto;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;

public interface JoinService {
	List<Local_Do> local_do_list();

	List<Local_Si> local_si_list(String local_do_code);

	List<Field> field_list();

	int check_userid(String id);

	void registerMember(EmployeeSignUpRequestDto requestDto);
}
