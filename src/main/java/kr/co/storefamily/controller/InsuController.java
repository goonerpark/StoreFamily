package kr.co.storefamily.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.storefamily.model.Insu;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.service.InsuService;

@Controller
public class InsuController {

	@Autowired
	private InsuService InsuService;

	@RequestMapping(value="insu_write")
	public String insu_write(Model model, HttpSession session, @RequestParam(value="ch_member_id", required = false) String ch_member_id) throws Exception {
		String name = (String) session.getAttribute("name");
		String code = (String) session.getAttribute("code");
		String id = (String) session.getAttribute("id");
		String position = (String) session.getAttribute("position");
		
		//리스트
		List<Insu> insu_list = this.InsuService.insu_list(ch_member_id,code);

		model.addAttribute("insu_list", insu_list);
		model.addAttribute("ch_member_id", ch_member_id);
		model.addAttribute("position", position);
	

		//작성
		List<Member> member_list = this.InsuService.member_list(code);

		model.addAttribute("member_list", member_list);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		model.addAttribute("id", id);
		model.addAttribute("insu_write", new Insu());
		
		if(position.equals("직원")) {
			Member my_member = this.InsuService.my_member(id);
			model.addAttribute("my_member", my_member);
			return "Insu/common/insu_write";
		}
			
		else
		{
			model.addAttribute("member_list", member_list);
			return "Insu/common/insu_write";
		}
	}
	
	@RequestMapping(value="insu_write_ok")
	public String insu_write_ok(HttpServletRequest request) throws Exception {
		this.InsuService.insu_write_ok(request);
		
		return "redirect:/insu_list";
	}

	/*@RequestMapping(value="insu_write_ok")
	public String insu_write_ok(@ModelAttribute("insu_write")@Valid Insu insu, HttpSession session) throws Exception {
		String code = (String) session.getAttribute("code");
		String id = (String)session.getAttribute("id");
		
		insu.setCode(code);
		insu.setId(id);
		
		String[] ch_member_id = insu.getCh_member_id().split(",");
		for(int i=0; i<ch_member_id.length; i++)
		{
			insu.setCh_member_id(ch_member_id[i]);
			
			this.InsuService.insu_write_ok(insu);
		}
		
			return "redirect:/insu_list";
	}*/
	
	@RequestMapping(value="insu_list")
	public String insu_list(Model model,HttpSession session,@RequestParam(value="ch_member_id", required = false, defaultValue = "all") String ch_member_id) throws Exception {
		String code = (String)session.getAttribute("code");
		String id = (String)session.getAttribute("id");
		String position = (String) session.getAttribute("position");

		List<Insu> insu_list = this.InsuService.insu_list(ch_member_id,code);

		model.addAttribute("insu_list", insu_list);
		model.addAttribute("ch_member_id", ch_member_id);
		model.addAttribute("position", position);

		if(position.equals("직원")) {
			Member my_member = this.InsuService.my_member(id);
			model.addAttribute("my_member", my_member);
			return "Insu/ceo/insu_list";
		}
			
		else
		{
			List<Member> member_list = this.InsuService.member_list(code);
			model.addAttribute("member_list", member_list);
			return "Insu/ceo/insu_list";
		}

	}

	@RequestMapping(value="insu_content")
	public String insu_content(@RequestParam(value="bno", required = false)int bno, @RequestParam(value="ch_member_id", required = false) String ch_member_id, Model model, HttpSession session) throws Exception {
		Insu insu_content = this.InsuService.insu_content(bno);
		String id = (String)session.getAttribute("id");
		String position = (String) session.getAttribute("position");
		String code = (String)session.getAttribute("code");
		
		//리스트
		List<Insu> insu_list = this.InsuService.insu_list(ch_member_id,code);

		model.addAttribute("insu_list", insu_list);
		model.addAttribute("ch_member_id", ch_member_id);

		//content
		List<Insu> insu_reply = this.InsuService.insu_reply(bno);

		model.addAttribute("id",id);
		model.addAttribute("position", position);
		model.addAttribute("insu_content", insu_content);
		model.addAttribute("insu_reply", insu_reply);
		
		if(position.equals("직원")) {
			Member my_member = this.InsuService.my_member(id);
			model.addAttribute("my_member", my_member);
			return "Insu/common/insu_content";
		}
			
		else
		{
			List<Member> member_list = this.InsuService.member_list(code);
			model.addAttribute("member_list", member_list);
			return "Insu/common/insu_content";
		}
	}

	@RequestMapping(value="insu_content_reply")
	public String insu_content_reply(Insu insu, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("id");
		String code = (String) session.getAttribute("code");
		String name = (String) session.getAttribute("name");

		insu.setId(id);
		insu.setCode(code);
		insu.setName(name);
		if(this.InsuService.insu_content_reply(insu) == 1)
		{
			this.InsuService.insu_reply_chong(insu.getInsu_bno());
			return "redirect:/insu_content?bno="+insu.getInsu_bno();
		}
		else
			return "redirect:/insu_content?bno="+insu.getInsu_bno();
	}

	@RequestMapping(value="insu_delete")
	public String insu_delete(@RequestParam(value="bno", required = false) int bno) throws Exception {
		if(this.InsuService.insu_delete(bno) == 1)
			return "redirect:/insu_list";
		else
			return "redirect:/insu_content?bno=" + bno;
	}

	@RequestMapping(value="insu_ok")
	public String insu_ok(@RequestParam(value="bno", required = false)int bno, @RequestParam(value="insu_bno",required = false) int insu_bno) throws Exception {
		if(this.InsuService.insu_ok(bno) == 1)
		{
			this.InsuService.insu_chk(insu_bno);
			return "redirect:/insu_content?bno=" + insu_bno;
		}
		else
			return "redirect:/insu_content?bno=" + insu_bno;
	}

	@RequestMapping(value="insu_no")
	public String insu_no(@RequestParam(value="bno", required = false)int bno, @RequestParam(value="insu_bno",required = false) int insu_bno) throws Exception {
		if(this.InsuService.insu_no(bno) == 1)
		{
			this.InsuService.insu_chk(insu_bno);
			return "redirect:/insu_content?bno=" + insu_bno;
		}
		else
			return "redirect:/insu_content?bno=" + insu_bno;
	}


}
