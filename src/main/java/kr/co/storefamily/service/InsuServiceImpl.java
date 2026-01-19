package kr.co.storefamily.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.storefamily.mapper.InsuMapper;
import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;

@Service
public class InsuServiceImpl implements InsuService{

	@Autowired
	private InsuMapper InsuMapper;
	
	@Override
	public Member my_member(String id) {
		return this.InsuMapper.my_member(id);
	}

	@Override
	public List<Member> member_list(String code) {
		return this.InsuMapper.member_list(code);
	}
	
	@Override
	public void insu_write_ok(HttpServletRequest request) {
		String path = "C:\\Users\\dlfbs\\Documents\\workspace-sts-3.9.18.RELEASE\\StoreFamily\\src\\main\\webapp\\resources\\file_img";
		int size=1024*1024*20;
		Insu insu = new Insu();
		try {
			MultipartRequest multi = new MultipartRequest(request, path,size,"utf-8",new DefaultFileRenamePolicy());
			
			insu.setTitle(multi.getParameter("title"));
			insu.setName(multi.getParameter("name"));
			insu.setContent(multi.getParameter("content"));
			insu.setCode(multi.getParameter("code"));
			insu.setId(multi.getParameter("id"));
			insu.setCh_member_id(multi.getParameter("ch_member_id"));
			insu.setInsu_img(multi.getFilesystemName("insu_img"));
			
			System.out.println(insu.getCh_member_id());
			String[] ch_member_id = insu.getCh_member_id().split(",");
			for(int i=0; i<ch_member_id.length; i++) {
				insu.setCh_member_id(ch_member_id[i]);
				this.InsuMapper.insu_write_ok(insu);
			}
		}
		catch(Exception e) {
			
		}
		
	}

	/*
	 * @Override public void insu_write_ok(Insu insu) {
	 * this.InsuMapper.insu_write_ok(insu); }
	 */

	@Override
	public List<Insu> insu_list(String ch_member_id, String code) {
		return this.InsuMapper.insu_list(ch_member_id,code);
	}

	@Override
	public Insu insu_content(int bno) {
		return this.InsuMapper.insu_content(bno);
	}

	@Override
	public int insu_content_reply(Insu insu) {
		return this.InsuMapper.insu_content_reply(insu);
	}

	@Override
	public void insu_reply_chong(int insu_bno) {
		this.InsuMapper.insu_reply_chong(insu_bno);
	}

	@Override
	public int insu_delete(int bno) {
		return this.InsuMapper.insu_delete(bno);
	}

	@Override
	public List<Insu> insu_reply(int bno) {
		return this.InsuMapper.insu_reply(bno);
	}

	@Override
	public int insu_ok(int bno) {
		return this.InsuMapper.insu_ok(bno);
	}

	@Override
	public void insu_chk(int insu_bno) {
		this.InsuMapper.insu_chk(insu_bno);
	}

	@Override
	public int insu_no(int bno) {
		return this.InsuMapper.insu_no(bno);
	}

}
