package kr.co.storefamily.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.co.storefamily.model.Employee_Invite;
import kr.co.storefamily.model.Member;
import mapper.ManageMapper;

@Service
public class ManageServiceImpl implements ManageService{

	@Autowired
	private ManageMapper ManageMapper;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private final String AUTHOR_EMAIL="storefamilymail@naver.com";
	
	@Override
	public List<Employee_Invite> employee_invite_list(String code) {
		return this.ManageMapper.employee_invite_list(code);
	}
	
	@Override
	public List<Member> employee_ok(String code,String id) {
		return this.ManageMapper.employee_ok(code,id);
	}
	
	@Override
	public void employee_invite_ok(String email,String name,String code) throws MessagingException{
		MimeMessage message = null;
		StringBuilder sb = new StringBuilder();
		sb.append(" [STOREFAMILY]에 가입해주세요~ <br> "
		        + "<form name='join' method='post' action='http://localhost:8080/storefamily/employee_join'>"
		        + "<input type='hidden' name='code' value='" + code + "'/>"
		        + "<input type='submit' value='회원가입'>"
		        + "</form>");



		message = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(message,"UTF-8");
		mailHelper.setFrom(AUTHOR_EMAIL);
		mailHelper.setTo(email);
		mailHelper.setSubject("[STOREFAMILY]" + name + " 님 초대요~");
		mailHelper.setText(sb.toString(),true);
		mailSender.send(message);
	}
	
	@Override
	public int employee_invite_chk(String email) {
		return this.ManageMapper.employee_invite_chk(email);
	}
	
	@Override
	public void employee_invite_in(String name,String email,String code) {
		this.ManageMapper.employee_invite_in(name,email,code);
	}
	
	@Override
	public void employee_invite_chk_up(String email) {
		this.ManageMapper.employee_invite_chk_up(email);
	}

	@Override
	public int employee_chk_ok(int bno) {
		return this.ManageMapper.employee_chk_ok(bno);
	}

	@Override
	public int employee_chk_no(int bno) {
		return this.ManageMapper.employee_chk_no(bno);
	}

	@Override
	public int employee_chk_reset(int bno) {
		return this.ManageMapper.employee_chk_reset(bno);
	}

	@Override
	public List<Member> employee_member_list(String code, String id) {
		return this.ManageMapper.employee_member_list(code,id);
	}

	@Override
	public Member employee_member_imformation(int bno) {
		return this.ManageMapper.employee_member_imformation(bno);
	}

	@Override
	public int employee_member_update(Member member) {
		return this.ManageMapper.employee_member_update(member);
	}

	@Override
	public int employee_member_delete(int bno) {
		return this.ManageMapper.employee_member_delete(bno);
	}
	
}
