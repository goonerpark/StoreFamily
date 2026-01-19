package kr.co.storefamily.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;

public interface InsuService {
	public Member my_member(String id);
	public List<Member> member_list(String code);
	public void insu_write_ok(HttpServletRequest request);
	//public void insu_write_ok(Insu insu);
	public List<Insu> insu_list(String ch_member_id, String code);
	public Insu insu_content(int bno);
	public int insu_content_reply(Insu insu);
	public int insu_delete(int bno);
	public List<Insu> insu_reply(int bno);
	public void insu_reply_chong(int insu_bno);
	public int insu_ok(int bno);
	public void insu_chk(int insu_bno);
	public int insu_no(int bno);
}
