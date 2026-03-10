package kr.co.storefamily.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping(value = "store_main")
	public String storeMain(HttpSession session) {
		String position = (String) session.getAttribute("position");
		if ("직원".equals(position)) {
			return "/store_main/employee_store_main";
		}
		if ("사장".equals(position)) {
			return "/store_main/ceo_store_main";
		}
		return "redirect:/home";
	}

	@RequestMapping(value = "/main")
	public String main() {
		return "redirect:/home";
	}
}
