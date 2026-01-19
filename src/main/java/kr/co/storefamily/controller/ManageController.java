package kr.co.storefamily.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.storefamily.model.Employee_Invite;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.service.ManageService;

@Controller
public class ManageController {

	@Autowired
	private ManageService ManageService;
	
	@RequestMapping(value="manage_main")
	public String manage_main(HttpSession session,Model model) throws Exception {
		String code = (String)session.getAttribute("code");
		String id = (String)session.getAttribute("id");
		List<Employee_Invite> employee_invite = this.ManageService.employee_invite_list(code);
		List<Member> employee_ok = this.ManageService.employee_ok(code,id);
		model.addAttribute("employee_ok", employee_ok);
		model.addAttribute("employee_invite", employee_invite);
		model.addAttribute("code", code);
		return "Manage/manage_main";
	}
	
	@RequestMapping(value="employee_invite")
	public String employee_invite(Model model,HttpSession session) throws Exception {
		String code = (String) session.getAttribute("code");
		model.addAttribute("code", code);
		return "Manage/employee_invite";
	}

	@RequestMapping(value="employee_invite_ok")
	public ResponseEntity<Void> employee_invite_ok(@RequestParam("email")String email,@RequestParam("name")String name, 
			@RequestParam("code")String code, HttpSession session) throws MessagingException, UnsupportedEncodingException {
		String decodeEmail = URLDecoder.decode(email,"UTF-8");
		String decodeName = URLDecoder.decode(name,"UTF-8");
		String decodeCode = URLDecoder.decode(code,"UTF-8");
		System.out.println(decodeCode);
		this.ManageService.employee_invite_ok(decodeEmail,decodeName,decodeCode);
		if(this.ManageService.employee_invite_chk(decodeEmail) == 0)
			this.ManageService.employee_invite_in(name,email,code);
		else
			this.ManageService.employee_invite_chk_up(decodeEmail);
		return ResponseEntity.status(200).build();
	}
	
	@RequestMapping(value="employee_chk_ok")
	public String employee_chk_ok(@RequestParam("bno") int bno,@RequestParam("chk")int chk) throws Exception {
		if(this.ManageService.employee_chk_ok(bno) == 1) {
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
		else{
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
	}
	
	@RequestMapping(value="employee_chk_no")
	public String employee_chk_no(@RequestParam("bno") int bno,@RequestParam("chk")int chk) throws Exception {
		if(this.ManageService.employee_chk_no(bno) == 1){
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
		else{
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
	}
	
	@RequestMapping(value="employee_chk_reset")
	public String employee_chk_reset(@RequestParam("bno") int bno,@RequestParam("chk")int chk) throws Exception {
		if(this.ManageService.employee_chk_reset(bno) == 1){
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
		else{
			if(chk == 1)
				return "redirect:/employee_member_list";
			else
				return "redirect:/manage_main";
		}
	}
	
	@RequestMapping(value="employee_member_list")
	public String employee_invite_list(HttpSession session, Model model) throws Exception {
		String code = (String) session.getAttribute("code");
		String id = (String)session.getAttribute("id");
		List<Member> employee_member_list = this.ManageService.employee_member_list(code,id);
		List<Member> employee_ok = this.ManageService.employee_ok(code,id);
		model.addAttribute("employee_ok", employee_ok);
		model.addAttribute("employee_member_list", employee_member_list);
		return "Manage/employee_member_list";
	}
	
	@RequestMapping(value="employee_member_imformation")
	public String employee_member_imformation(@RequestParam("bno")int bno,Model model,HttpSession session) throws Exception {
		Member employee_member_imformation = this.ManageService.employee_member_imformation(bno);
		model.addAttribute("employee_member_imformation", employee_member_imformation);
		
		String code = (String) session.getAttribute("code");
		String id = (String)session.getAttribute("id");
		List<Member> employee_member_list = this.ManageService.employee_member_list(code,id);
		model.addAttribute("employee_member_list", employee_member_list);
		return "Manage/employee_member_imformation";
		
	}
	
	@RequestMapping(value="employee_member_update")
	public String employee_member_update(@ModelAttribute("employee_member_imformation")Member employee_member, HttpServletResponse response) throws Exception {
		if(this.ManageService.employee_member_update(employee_member) == 1) 
		{
			response.setContentType("text/html; charset=UTF-8");
			 
			PrintWriter out = response.getWriter();
			 
			out.println("<script>alert('수정되었습니다');location.href='employee_member_imformation?bno="+employee_member.getBno()+"';</script>");
			 
			out.flush();
			return "redirect:/employee_member_imformation?bno="+employee_member.getBno();
		}
		else
			return "redirect:/employee_member_imformation?bno="+employee_member.getBno();
	}
	
	@RequestMapping(value="employee_member_delete")
	public String employee_member_delete(@RequestParam("bno") int bno, HttpSession session , HttpServletResponse response) throws Exception {
		String code = (String)session.getAttribute("code");
		
		if(this.ManageService.employee_member_delete(bno) == 1)
		{
			response.setContentType("text/html; charset=UTF-8");
			 
			PrintWriter out = response.getWriter();
			 
			out.println("<script>alert('삭제되었습니다');location.href='employee_member_list?code="+code+"';</script>");
			 
			out.flush();
			return "redirect:/employee_member_list?code="+code;
		}
		else
			return  "redirect:/employee_member_list?code="+code;
	}
}
