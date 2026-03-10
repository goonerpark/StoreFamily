package kr.co.storefamily.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.storefamily.dto.LoginRequestDto;
import kr.co.storefamily.exception.AuthenticationException;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.service.LoginService;

@Controller
public class LoginController {

	private static final String POSITION_CEO = "\uC0AC\uC7A5";

	@Autowired
	private LoginService loginService;

	@GetMapping("/login")
	public String login(@ModelAttribute("loginRequest") LoginRequestDto loginRequest) {
		return "/login/login";
	}

	@PostMapping({ "/login", "/login_ok" })
	public String loginOk(@ModelAttribute("loginRequest") @Valid LoginRequestDto loginRequest, BindingResult bindingResult,
			HttpSession session) {
		if (bindingResult.hasErrors()) {
			return "/login/login";
		}

		try {
			Member login = loginService.login(loginRequest);
			session.setMaxInactiveInterval(60 * 60 * 2);
			session.setAttribute("name", login.getName());
			session.setAttribute("position", login.getPosition());
			session.setAttribute("code", login.getCode());
			session.setAttribute("id", login.getId());

			if (POSITION_CEO.equals(login.getPosition())) {
				Member store = loginService.getStore(login.getBno());
				if (store != null) {
					session.setAttribute("bussiness", store.getBussiness());
					session.setAttribute("store_code", store.getCode());
					session.setAttribute("store_id", store.getTable_name());
				}
			}
			return "redirect:/main";
		} catch (AuthenticationException ex) {
			bindingResult.reject("login.failed", ex.getMessage());
			return "/login/login";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
