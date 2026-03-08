package kr.co.storefamily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.storefamily.dto.EmployeeSignUpRequestDto;
import kr.co.storefamily.exception.DuplicateUserIdException;
import kr.co.storefamily.exception.RegistrationException;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.repository.JoinRepository;

@Service
public class JoinServiceImpl implements JoinService {

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
	public int check_userid(String id) {
		return joinRepository.countById(id);
	}

	@Override
	@Transactional
	public void registerMember(EmployeeSignUpRequestDto requestDto) {
		validateUniqueId(requestDto.getId());
		Member member = toMember(requestDto);
		int inserted = joinRepository.insertMember(member);
		if (inserted != 1) {
			throw new RegistrationException("\uD68C\uC6D0\uAC00\uC785 \uCC98\uB9AC \uC911 \uC624\uB958\uAC00 \uBC1C\uC0DD\uD588\uC2B5\uB2C8\uB2E4.");
		}
	}

	private void validateUniqueId(String id) {
		if (joinRepository.countById(id) > 0) {
			throw new DuplicateUserIdException("\uC774\uBBF8 \uC0AC\uC6A9 \uC911\uC778 \uC544\uC774\uB514\uC785\uB2C8\uB2E4.");
		}
	}

	private Member toMember(EmployeeSignUpRequestDto requestDto) {
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
		return member;
	}

	private String formatBirthDate(String birthDate) {
		return birthDate == null ? null : birthDate.replace("-", "/");
	}
}
