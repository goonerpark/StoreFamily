package kr.co.storefamily.service;

import java.util.List;

import javax.mail.MessagingException;

import kr.co.storefamily.model.Employee_Invite;
import kr.co.storefamily.model.Member;

public interface ManageService {
	public List<Employee_Invite> employee_invite_list(String code);
	public List<Member> employee_ok(String code,String id);
	public void employee_invite_ok(String email,String name,String code) throws MessagingException;
	public int employee_invite_chk(String email);
	public void employee_invite_in(String name,String email,String code);
	public void employee_invite_chk_up(String email);
	public int employee_chk_ok(int bno);
	public int employee_chk_no(int bno);
	public int employee_chk_reset(int bno);
	public List<Member> employee_member_list(String code,String id);
	public Member employee_member_imformation(int bno);
	public int employee_member_update(Member member);
	public int employee_member_delete(int bno);
}
