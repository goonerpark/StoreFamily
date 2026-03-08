package kr.co.storefamily.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.co.storefamily.mapper.ManageMapper;
import kr.co.storefamily.model.Employee_Invite;
import kr.co.storefamily.model.Member;

@Service
public class ManageServiceImpl implements ManageService {

	@Autowired
	private ManageMapper manageMapper;

	@Autowired
	private JavaMailSender mailSender;

	private static final String AUTHOR_EMAIL = "storefamilymail@naver.com";

	@Override
	public List<Employee_Invite> employee_invite_list(String code) {
		return this.manageMapper.employee_invite_list(code);
	}

	@Override
	public List<Member> employee_ok(String code, String id) {
		return this.manageMapper.employee_ok(code, id);
	}

	@Override
	public void employee_invite_ok(String email, String name, String code) throws MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(message, "UTF-8");

		StringBuilder sb = new StringBuilder();
		sb.append("[STOREFAMILY] 매장 초대 안내<br>");
		sb.append("회원가입 후 로그인하여 아래 매장 코드로 매장 가입을 진행해 주세요.<br><br>");
		sb.append("매장 코드: <b>").append(code).append("</b><br><br>");
		sb.append("<a href='http://localhost:8080/storefamily/join'>회원가입 하러가기</a><br>");
		sb.append("<a href='http://localhost:8080/storefamily/login'>로그인 하러가기</a><br>");
		sb.append("로그인 후 메뉴에서 '매장 가입'을 선택해 코드를 입력하면 됩니다.");

		mailHelper.setFrom(AUTHOR_EMAIL);
		mailHelper.setTo(email);
		mailHelper.setSubject("[STOREFAMILY] " + name + "님의 매장 초대");
		mailHelper.setText(sb.toString(), true);
		mailSender.send(message);
	}

	@Override
	public int employee_invite_chk(String email) {
		return this.manageMapper.employee_invite_chk(email);
	}

	@Override
	public void employee_invite_in(String name, String email, String code) {
		this.manageMapper.employee_invite_in(name, email, code);
	}

	@Override
	public void employee_invite_chk_up(String email) {
		this.manageMapper.employee_invite_chk_up(email);
	}

	@Override
	public int employee_chk_ok(int bno) {
		return this.manageMapper.employee_chk_ok(bno);
	}

	@Override
	public int employee_chk_no(int bno) {
		return this.manageMapper.employee_chk_no(bno);
	}

	@Override
	public int employee_chk_reset(int bno) {
		return this.manageMapper.employee_chk_reset(bno);
	}

	@Override
	public List<Member> employee_member_list(String code, String id) {
		return this.manageMapper.employee_member_list(code, id);
	}

	@Override
	public Member employee_member_imformation(int bno) {
		return this.manageMapper.employee_member_imformation(bno);
	}

	@Override
	public int employee_member_update(Member member) {
		return this.manageMapper.employee_member_update(member);
	}

	@Override
	public int employee_member_delete(int bno) {
		return this.manageMapper.employee_member_delete(bno);
	}
}
