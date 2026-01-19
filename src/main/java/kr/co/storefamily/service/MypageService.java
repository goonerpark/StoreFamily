package kr.co.storefamily.service;

import java.util.List;

import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Resume;

public interface MypageService {

	public int resume_write_ok(Resume resume);
	public List<Resume> resume_list(String id);
	public Resume resume_content(int bno,String id);
	public Member my_imformation(String id);
	public int member_update_ok(Member member);
	public List<Member> getStore_list(String id);
	public Member store_imformation(String code);
	public int store_update_ok(Member member);
}
