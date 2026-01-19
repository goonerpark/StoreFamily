package kr.co.storefamily.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.storefamily.model.Member;
import kr.co.storefamily.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	private LoginService LoginService;

	@RequestMapping(value="/login")
	public String login(Model model) throws Exception {
		model.addAttribute("member", new Member());
		return "/login/login";
	}

	@RequestMapping(value = "/login_ok", method = RequestMethod.POST)
	public String login_ok(@Valid Member member, BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			model.addAllAttributes(result.getModel());
			return "/login/login";
		}
		try {
			Member login = this.LoginService.getLogin(member.getId(), member.getPwd());
			if (login != null) {
				model.addAttribute("login", login);
				String name = login.getName();
				String position = login.getPosition();
				String code = login.getCode();
				String id = login.getId();

				session.setAttribute("name", name);
				session.setAttribute("position", position);
				session.setAttribute("code", code);
				session.setAttribute("id", id);
				
				if(login.getPosition().equals("사장")) {
					Member store = this.LoginService.getStore(login.getCode(),login.getId());
					String bussiness = store.getBussiness();
					String local_do =store.getLocal_do();
					String local_si = store.getLocal_si();
				
					session.setAttribute("bussiness", bussiness);
					session.setAttribute("local_si", local_si);
					session.setAttribute("local_do", local_do);
				}

				 System.out.println(session.getAttribute("bussiness"));
				return "redirect:/main";
			} else {
				result.rejectValue("id", "error.id.member", "정보없음");
				return "/login/login";

			}
		} catch (Exception e) {
			result.rejectValue("id", "error.id.member", "예외처리");
			model.addAllAttributes(result.getModel());
			return "/login/login";
		}
	}

}
