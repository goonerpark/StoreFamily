package kr.co.storefamily.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.storefamily.model.Fill;
import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.model.Resume;
import kr.co.storefamily.service.JoinService;
import kr.co.storefamily.service.MypageService;

@Controller
public class MypageController {

	@Autowired
	private MypageService MypageService;
	
	@Autowired
	private JoinService JoinService;

	@RequestMapping(value="mypage_main")
	public String mypage_main(HttpSession session, Model model) throws Exception {
		String position = (String) session.getAttribute("position");
		model.addAttribute("position", position);
		return "Mypage/common/mypage_main";
	}

	@RequestMapping(value="my_resume_write")
	public String resume_write() throws Exception {
		return "Mypage/employee/resume_write";
	}

	@RequestMapping(value="my_resume_write_ok")
	public String resume_write_ok(@ModelAttribute("resume_write")@Valid Resume resume, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		String name = (String)session.getAttribute("name");

		resume.setId(id);
		resume.setCode(code);
		resume.setName(name);

		System.out.println(resume.getTitle());
		System.out.println(resume.getWork_place());
		System.out.println(resume.getWork_activity());

		if(this.MypageService.resume_write_ok(resume) == 1)
			return "redirect:/resume_list";
		else
			return "redirect:/resume_write";
	}

	@RequestMapping(value="resume_list")
	public String resume_list(Model model,HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		List<Resume> resume_list = this.MypageService.resume_list(id);

		model.addAttribute("resume_list", resume_list);
		return "Mypage/common/resume_list";
	}

	@RequestMapping(value="resume_content")
	public String resume_content(HttpSession session, Model model,@RequestParam(value="bno", required = false)int bno) throws Exception {
		String id = (String)session.getAttribute("id");

		Resume resume_content = this.MypageService.resume_content(bno,id);

		String[] work_place = resume_content.getWork_place().split(",");
		String[] work_activity = resume_content.getWork_activity().split(",");
		String[] period = resume_content.getPeriod().split(",");

		model.addAttribute("resume_content", resume_content);
		model.addAttribute("work_place", work_place);
		model.addAttribute("work_activity", work_activity);
		model.addAttribute("period", period);
		return "Mypage/common/resume_content";
	}

	@RequestMapping(value="member_update")
	public String member_update(HttpSession session,Model model) throws Exception {
		String id = (String) session.getAttribute("id");
		Member my_imformation;
		my_imformation = this.MypageService.my_imformation(id);
		
		String email[] = my_imformation.getEmail().split("@");
		my_imformation.setEmail1(email[0]);
		my_imformation.setEmail2(email[1]);
		
		String bth[] = my_imformation.getBth().split("/");
		my_imformation.setBth1(bth[0]);
		my_imformation.setBth2(bth[1]);
		my_imformation.setBth3(bth[2]);
		
		model.addAttribute("my_imformation",my_imformation);
		return "Mypage/common/member_update";
	}
	
	@RequestMapping(value="member_update_ok")
	public String member_update_ok(@ModelAttribute("my_imformation")Member member) throws Exception {
			if(this.MypageService.member_update_ok(member) == 1)
				return "redirect:/member_update";
			else
				return "redirect:/member_update";
					
		
	}
	
	@RequestMapping(value="store_update")
	public String store_update(@RequestParam(value="code", required = false) String code, HttpSession session, Model model) throws Exception {
		String id = (String) session.getAttribute("id");
		List<Member> getStore_list = this.MypageService.getStore_list(id);
		model.addAttribute("getStore_list", getStore_list);
		
		if(code == null)
			code=getStore_list.get(0).getCode();
		Member store_imformation = this.MypageService.store_imformation(code);
		
		List<Local_Do> local_do = this.JoinService.local_do_list();
		model.addAttribute("local_do", local_do);
		model.addAttribute("store_imformation", store_imformation);
		return "Mypage/ceo/store_update";
	}
	
	@RequestMapping(value="store_update_ok")
	public String store_update_ok(@ModelAttribute("store_update")Member member) throws Exception {
		String ex_code = member.getEx_code();
		if(this.MypageService.store_update_ok(member) == 1)
			return "redirect:/store_update?code="+ex_code;
		else
			return "redirect:/store_upate?code="+ex_code;
	}
}
