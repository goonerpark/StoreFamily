package kr.co.storefamily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.storefamily.dto.CeoSignUpRequestDto;
import kr.co.storefamily.dto.EmployeeSignUpRequestDto;
import kr.co.storefamily.exception.DuplicateUserIdException;
import kr.co.storefamily.exception.RegistrationException;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.repository.JoinRepository;

@Service
public class JoinServiceImpl implements JoinService{

	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";
	private static final String POSITION_CEO = "\uC0AC\uC7A5";

	@Autowired
	private JoinRepository joinRepository;

	@Override
	public List<Local_Do> local_do_list() {
		return joinRepository.findAllLocalDo();
	}

	@Override
	public List<Local_Si> local_si_list(String local_do_code) {
		return joinRepository.findLocalSiByDoCode(local_do_code);
	}

	@Override
	public List<Field> field_list() {
		return joinRepository.findAllField();
	}

	@Override
	public int getcode(String code) {
		return joinRepository.findLastStoreCodeSuffix(code);
	}

	@Override
	public int check_userid(String id) {
		return joinRepository.countById(id);
	}

	@Override
	public int member_join_ok(Member member) {
		return joinRepository.insertMember(member);
	}

	@Override
	public void store_join_ok(Member member) {
		joinRepository.insertStore(member);
	}

	@Override
	@Transactional
	public void registerEmployee(EmployeeSignUpRequestDto requestDto) {
		validateUniqueId(requestDto.getId());
		Member member = toEmployeeMember(requestDto);
		int inserted = joinRepository.insertMember(member);
		if (inserted != 1) {
			throw new RegistrationException("Employee registration failed.");
		}
	}

	@Override
	@Transactional
	public void registerCeo(CeoSignUpRequestDto requestDto) {
		validateUniqueId(requestDto.getId());
		Member member = toCeoMember(requestDto);
		int inserted = joinRepository.insertMember(member);
		if (inserted != 1) {
			throw new RegistrationException("CEO registration failed.");
		}

		joinRepository.insertStore(member);
	}

	private void validateUniqueId(String id) {
		if (joinRepository.countById(id) > 0) {
			throw new DuplicateUserIdException("Already used ID.");
		}
	}

	private Member toEmployeeMember(EmployeeSignUpRequestDto requestDto) {
		Member member = new Member();
		member.setName(requestDto.getName());
		member.setId(requestDto.getId());
		member.setPwd(requestDto.getPwd());
		member.setEmail(requestDto.getEmail());
		member.setBth(formatBirthDate(requestDto.getBirthDate()));
		member.setGender(requestDto.getGender());
		member.setAddress(requestDto.getAddress());
		member.setAddress_etc(requestDto.getAddressEtc());
		member.setPhone(requestDto.getPhone());
		member.setCode(requestDto.getCode());
		member.setChk(0);
		member.setPosition(POSITION_EMPLOYEE);
		return member;
	}

	private Member toCeoMember(CeoSignUpRequestDto requestDto) {
		Member member = new Member();
		member.setName(requestDto.getName());
		member.setId(requestDto.getId());
		member.setPwd(requestDto.getPwd());
		member.setEmail(requestDto.getEmail());
		member.setBth(formatBirthDate(requestDto.getBirthDate()));
		member.setGender(requestDto.getGender());
		member.setAddress(requestDto.getAddress());
		member.setAddress_etc(requestDto.getAddressEtc());
		member.setPhone(requestDto.getPhone());
		member.setCode(requestDto.getCode());
		member.setChk(1);
		member.setPosition(POSITION_CEO);

		member.setBussiness(requestDto.getBussiness());
		member.setBussinessnum(requestDto.getBussinessnum());
		member.setBussinessaddress(requestDto.getBussinessaddress());
		member.setBussinessaddress_etc(requestDto.getBussinessaddressEtc());
		member.setField(requestDto.getField());
		member.setLocal_do(requestDto.getLocalDo());
		member.setLocal_si(requestDto.getLocalSi());
		return member;
	}

	private String formatBirthDate(String birthDate) {
		return birthDate == null ? null : birthDate.replace("-", "/");
	}

}
