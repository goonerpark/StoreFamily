package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Resume;

@Mapper
public interface MypageMapper {

	//이력서 작성하기
	public int resume_write_ok(Resume resume);
	//내 이력서 리스트
	public List<Resume> resume_list(String id);
	//이력서 상세보기
	public Resume resume_content(@Param("bno")int bno,@Param("id")String id);
	//사장 회원정보
	public Member my_imformation(String id);
	//직원 회원정보 수정
	public int member_update_ok(Member member);
	//사장 매장코드로 매장 리스트
	public List<Member> getStore_list(String id);
	//매장코드로 매장 정보 찾기
	public Member store_imformation(String code);
	//매장정보 수정
	public int store_update_ok(Member member);
}
