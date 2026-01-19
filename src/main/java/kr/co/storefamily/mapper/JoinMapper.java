package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;

@Mapper
public interface JoinMapper {
	public List<Local_Do> local_do_list();
	public List<Local_Si> local_si_list(String local_do_code);
	public List<Field> field_list();
	public int getcode(String code);
	public int member_join_ok(Member member);
	public void store_join_ok(Member member);
	public int check_userid(String id);
}
