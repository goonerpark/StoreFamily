package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Employee_Invite;
import kr.co.storefamily.model.Member;

@Mapper
public interface ManageMapper {
	public List<Employee_Invite> employee_invite_list(String code);
	public List<Member> employee_ok(@Param("code") String code,@Param("id") String id);
	public void employee_invite_in(@Param("name")String name, @Param("email")String email, @Param("code")String code);
	public int employee_invite_chk(String email);
	public void employee_invite_chk_up(String email);
	public int employee_chk_ok(int bno);
	public int employee_chk_no(int bno);
	public int employee_chk_reset(int bno);
	public List<Member> employee_member_list(@Param("code") String code,@Param("id") String id);
	public Member employee_member_imformation(int bno);
	public int employee_member_update(Member member);
	public int employee_member_delete(int bno);
}
