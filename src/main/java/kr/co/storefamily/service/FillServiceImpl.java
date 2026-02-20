package kr.co.storefamily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.storefamily.model.Fill;
import kr.co.storefamily.model.Resume;
import kr.co.storefamily.model.Schedule;
import mapper.FillMapper;

@Service
public class FillServiceImpl implements FillService {

	@Autowired
	private FillMapper FillMapper;
	
	@Override
	public List<Fill> my_fill_list(String code, String id) {
		return this.FillMapper.my_fill_list(code,id);
	}

	@Override
	public List<Schedule> my_schedule(String code, String id) {
		return this.FillMapper.my_schedule(code,id);
	}

	@Override
	public Schedule this_schedule(int schedule_bno) {
		return this.FillMapper.this_schedule(schedule_bno);
	}

	@Override
	public int fill_write_ok(Fill fill) {
		return this.FillMapper.fill_write_ok(fill);
	}

	@Override
	public List<Fill> my_store_fill_list(String code) {
		return this.FillMapper.my_store_fill_list(code);
	}

	@Override
	public List<Fill> fill_all_list() {
		return this.FillMapper.fill_all_list();
	}

	@Override
	public Fill fill_apply_content(int bno) {
		return this.FillMapper.fill_apply_content(bno);
	}

	@Override
	public int fill_apply_count(int bno,String id) {
		return this.FillMapper.fill_apply_count(bno,id);
	}

	@Override
	public String fill_local_do(String local_do) {
		return this.FillMapper.fill_local_do(local_do);
	}
	
	@Override
	public String fill_local_si(String local_si, String local_do) {
		return this.FillMapper.fill_local_si(local_si, local_do);
	}
	
	@Override
	public List<Fill> this_apply_list(int bno) {
		return this.FillMapper.this_apply_list(bno);
	}

	@Override
	public int fill_registrar_ok(int bno) {
		return this.FillMapper.fill_registrar_ok(bno);
	}

	@Override
	public void fill_apply_add(Fill fill) {
		this.FillMapper.fill_apply_add(fill);
	}

	@Override
	public int fill_registrar_cancle(int bno) {
		return this.FillMapper.fill_registrar_cancle(bno);
	}

	@Override
	public String resume_title(int resume_bno) {
		return this.FillMapper.resume_title(resume_bno);
	}
	
	@Override
	public int fill_apply(Fill fill) {
		return this.FillMapper.fill_apply(fill);
	}

	@Override
	public void fill_apply_su_up(int fill_bno) {
		this.FillMapper.fill_apply_su_up(fill_bno);
	}

	@Override
	public int fill_apply_cancle(int bno,String id) {
		return this.FillMapper.fill_apply_cancle(bno,id);
	}

	@Override
	public int fill_apply_resume_change(Fill fill) {
		return this.FillMapper.fill_apply_resume_change(fill);
	}

	@Override
	public void fill_apply_su_down(int fill_bno) {
		this.FillMapper.fill_apply_su_down(fill_bno);
	}

	@Override
	public Fill apply_content(int bno) {
		return this.FillMapper.apply_content(bno);
	}

	@Override
	public int fill_apply_chk_ok(int bno) {
		return this.FillMapper.fill_apply_chk_ok(bno);
	}

	@Override
	public void fill_apply_chk_no(int fill_bno, int bno) {
		this.FillMapper.fill_apply_chk_no(fill_bno,bno);
	}

	@Override
	public void fill_apply_ok(Fill fill) {
		this.FillMapper.fill_apply_ok(fill);
	}

	@Override
	public int fill_apply_no(int bno) {
		return this.FillMapper.fill_apply_no(bno);
	}

	@Override
	public void fill_apply_reset(Fill fill) {
		this.FillMapper.fill_apply_reset(fill);
	}

	@Override
	public List<Resume> resume_list(String id) {
		return this.FillMapper.resume_list(id);
	}

	@Override
	public int resume_bno(int fill_bno, String id) {
		return this.FillMapper.resume_bno(fill_bno,id);
	}

	@Override
	public int resume_count(int fill_bno, String id) {
		return this.FillMapper.resume_count(fill_bno,id);
	}

	@Override
	public Resume apply_resume_content(int resume_bno) {
		return this.FillMapper.apply_resume_content(resume_bno);
	}


}
