package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;

@Mapper
public interface InsuMapper {
	//내 정보
	public Member my_member(String id);
	//매장 멤버 리스트
	public List<Member> member_list(String code);
	//인수인계 등록
	public void insu_write_ok(Insu insu);
	//public void insu_write_ok(Insu insu);
	//인수인계 리스트
	public List<Insu> insu_list(@Param("ch_member_id") String ch_member_id,@Param("code") String code);
	//인수인계 상세보기
	public Insu insu_content(int bno);
	//댓글 찾기
	public List<Insu> insu_reply(int bno);
	//인수인계 답글달기
	public int insu_content_reply(Insu insu);
	//인수인계 답글 총 갯수 insu 테이블에 update
	public void insu_reply_chong(int insu_bno);
	//인수인계 삭제
	public int insu_delete(int bno);
	//사장 -> 인수인계 승인 -> insu_reply / chk = 1
	public int insu_ok(int bno);
	//insu / chk update
	public void insu_chk(int insu_bno);
	//사장 -> 인수인계 반려 -> insu_reply / chk = 2
	public int insu_no(int bno);
}
