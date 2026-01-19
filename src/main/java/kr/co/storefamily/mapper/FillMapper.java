package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Fill;
import kr.co.storefamily.model.Resume;
import kr.co.storefamily.model.Schedule;

@Mapper
public interface FillMapper {
	
	public List<Fill> my_fill_list(@Param("code")String code, @Param("id")String id);
	//fill_write에서 select 할 수 있는 스케줄 리스트 가져오기
	public List<Schedule> my_schedule(@Param("code")String code, @Param("id")String id);
	//fill_wrtie_ok에서 요청한 스케줄에서 날짜,시간 가져오기
	public Schedule this_schedule(int schedule_bno);
	//fill_write_ok 등록하기
	public int fill_write_ok(Fill fill);
	//fill_apply_list에서 등록 승인 리스트
	public List<Fill> my_store_fill_list(String code);
	//전체 대타 리스트
	public List<Fill> fill_all_list();
	//fill 상세정보
	public Fill fill_apply_content(int bno);
	//지역뽑아오기
	public String fill_local_do(String local_do);
	public String fill_local_si(@Param("local_si")String local_si, @Param("local_do")String local_do);
	//지원하기 or 지원취소 버튼
	public int fill_apply_count(@Param("bno")int bno,@Param("id")String id);
	//지원자 리스트
	public List<Fill> this_apply_list(int bno);
	//등록대기 -> 등록완료
	public int fill_registrar_ok(int bno);
	//사장이 등록완료하면 사업자명,분야,지역 추가
	public void fill_apply_add(Fill fill);
	//등록완료 -> 등록대기
	public int fill_registrar_cancle(int bno);
	//지원 이력서 제목 가져오기
	public String resume_title(int resume_bno);
	//대타 지원하기
	public int fill_apply(Fill fill);
	//fill테이블 apply_su +1
	public void fill_apply_su_up(int fill_bno);
	//대타 지원취소
	public int fill_apply_cancle(@Param("bno")int bno, @Param("id")String id);
	//지원 이력서 변경하기
	public int fill_apply_resume_change(Fill fill);
	//fill 테이블 apply_su -1
	public void fill_apply_su_down(int fill_bno);
	//지원자 정보
	public Fill apply_content(int bno);
	//fill_apply 테이블 chk 1 변경
	public int fill_apply_chk_ok(int bno);
	//fill_apply 테이블 chk 2 변경
	public void fill_apply_chk_no(@Param("fill_bno") int fill_bno,@Param("bno")int bno);
	//지원자 승인하기
	public void fill_apply_ok(Fill fill);
	//지원자 반려
	public int fill_apply_no(int bno);
	//반려 시 스케줄 원래 직원으로 돌리기
	public void fill_apply_reset(Fill fill);
	//이력서 리스트
	public List<Resume> resume_list(String id);
	//지원했다면 이력서 보일 때 checkbox check를 위함
	public int resume_bno(@Param("fill_bno")int fill_bno, @Param("id")String id);
	//위 함수 오류잡기위해....
	public int resume_count(@Param("fill_bno")int fill_bno, @Param("id")String id);
	//사장이 지원자 이력서보기
	public Resume apply_resume_content(int resume_bno);

}
