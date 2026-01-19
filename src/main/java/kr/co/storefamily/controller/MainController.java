package kr.co.storefamily.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.storefamily.service.MainService;

@Controller
public class MainController {

	@Autowired
	private MainService MainService;

	@RequestMapping(value="store_main")
	public String store_main(HttpSession session) {
		String position = (String)session.getAttribute("position");
		System.out.println(position);
		if(position.equals("직원")) {
			return "/store_main/employee_store_main";
		}
		else if(position.equals("사장")){
			return "/store_main/ceo_store_main";
		}
		else {
			return "redirect:/sotre_main";
		}
	}
	
	@RequestMapping(value="/main")
	public String main() {
		return "/main";
	}

}
