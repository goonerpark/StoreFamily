package kr.co.storefamily.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Resume;
import mapper.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageMapper MypageMapper;
	

	@Override
	public int resume_write_ok(Resume resume) {
		return this.MypageMapper.resume_write_ok(resume);
	}

	@Override
	public List<Resume> resume_list(String id) {
		return this.MypageMapper.resume_list(id);
	}

	@Override
	public Resume resume_content(int bno,String id) {
		return this.MypageMapper.resume_content(bno,id);
	}

	@Override
	public Member my_imformation(String id) {
		return this.MypageMapper.my_imformation(id);
	}

	@Override
	public int member_update_ok(Member member) {
		return this.MypageMapper.member_update_ok(member);
	}
	
	@Override
	public List<Member> getStore_list(String id) {
		return this.MypageMapper.getStore_list(id);
	}

	@Override
	public Member store_imformation(String code) {
		return this.MypageMapper.store_imformation(code);
	}

	@Override
	public int store_update_ok(Member member) {
		return this.MypageMapper.store_update_ok(member);
	}

}
