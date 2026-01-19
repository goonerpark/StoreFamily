package kr.co.storefamily.service;

import java.util.List;

import kr.co.storefamily.model.Fill;
import kr.co.storefamily.model.Resume;
import kr.co.storefamily.model.Schedule;

public interface FillService {
	public List<Fill> my_fill_list(String code, String id);
	public List<Schedule> my_schedule(String code, String id);
	public Schedule this_schedule(int schedule_bno);
	public int fill_write_ok(Fill fill);
	public List<Fill> my_store_fill_list(String code);
	public List<Fill> fill_all_list();
	public Fill fill_apply_content(int bno);
	public List<Fill> this_apply_list(int bno);
	public int fill_apply_count(int bno,String id);
	public String fill_local_do(String local_do);
	public String fill_local_si(String local_si,String local_do);
	public int fill_registrar_ok(int bno);
	public void fill_apply_add(Fill fill);
	public int fill_registrar_cancle(int bno);
	public String resume_title(int resume_bno);
	public int fill_apply(Fill fill);
	public void fill_apply_su_up(int fill_bno);
	public int fill_apply_cancle(int bno,String id);
	public int fill_apply_resume_change(Fill fill);
	public void fill_apply_su_down(int bno);
	public Fill apply_content(int bno);
	public int fill_apply_chk_ok(int bno);
	public void fill_apply_chk_no(int fill_bno, int bno);
	public void fill_apply_ok(Fill fill);
	public int fill_apply_no(int bno);
	public void fill_apply_reset(Fill fill);
	public List<Resume> resume_list(String id);
	public int resume_bno(int fill_bno, String id);
	public int resume_count(int fill_bno, String id);
	public Resume apply_resume_content(int resume_bno);
}
