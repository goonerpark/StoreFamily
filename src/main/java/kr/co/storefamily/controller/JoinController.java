package kr.co.storefamily.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.model.Member;
import kr.co.storefamily.service.JoinService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class JoinController {

	@Autowired
	private JoinService JoinService;

	@RequestMapping(value="join_main")
	public String join_main() throws Exception {
		return "Join/join_main";
	}

	@RequestMapping(value="employee_join")
	public String employee_join(Model model, @RequestParam(value="code", required = false)String code) throws Exception {
		if(code != null)
			model.addAttribute("code", code);
		model.addAttribute("join", new Member());
		return "Join/employee/employee_join";
	}

	@RequestMapping(value="ceo_join")
	public String ceo_join(Model model) throws Exception {
		model.addAttribute("join", new Member());
		return "Join/ceo/ceo_join";
	}

	@RequestMapping(value="ceo_store_join")
	public String ceo_store_join(@ModelAttribute("join") @Valid Member member, Model model) throws Exception {
		List<Local_Do> local_do = this.JoinService.local_do_list();
		model.addAttribute("local_do", local_do);
		model.addAttribute("member", member);
		return "Join/ceo/ceo_store_join";
	}

	@RequestMapping(value="getlocal_si")
	public void getlocal_si(@RequestParam("local_do_code")String local_do_code, PrintWriter out) throws Exception {
		List<Local_Si> local_si_list = this.JoinService.local_si_list(local_do_code);
		String str="<option> 시/군/구 </option>";

		for (Local_Si local_si : local_si_list) {
			str = str + "<option value='"+ local_si.getCode() + "'>" + URLEncoder.encode(local_si.getLocal_si()) + "</option>";
		}
		out.print(str);
	}

	@RequestMapping(value="getfield")
	public void getfield(PrintWriter out) throws Exception {
		List<Field> field_list = this.JoinService.field_list();
		String str="<option> 분야 </option>";

		for (Field field : field_list) {
			str = str + "<option value='"+ field.getCode() + "'>" + URLEncoder.encode(field.getField()) + "</option>";
		}
		out.print(str);
	}

	@RequestMapping(value="getcode")
	public void getcode(@RequestParam("code")String code, PrintWriter out) throws Exception {
		Integer code_num = this.JoinService.getcode(code);
		out.print(code_num);
	}

	@RequestMapping(value="join_ok")
	public String join_ok(@ModelAttribute("join") @Valid Member member) throws Exception {
		String position = member.getPosition();

		if(position.equals("직원"))
		{
			if(this.JoinService.member_join_ok(member) == 1)
				return "redirect:/";
			else
				return "redirect:/join";
		}

		else if(position.equals("사장"))
		{
			if(this.JoinService.member_join_ok(member) == 1)
			{
				this.JoinService.store_join_ok(member);
				return "redirect:/";
			}
			else
				return "redirect:/join";
		}
		else
			return "redirect:/join";
	}

	@RequestMapping(value="phoneCheck")
	@ResponseBody
	public String phoneCheck(@RequestParam("phone") String phone) {
		int randomNumber = (int)(Math.random()*(9999-1000+1)+1000); //난수 생성

		String api_key = "NCS5VIKDBHSJEQHF";
		String api_secret = "D5LGQF6Q6CRO8BKZD2XDPLT1BHS0VJYI";
		Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);
	    params.put("from", "010-9495-2649"); //무조건 자기번호 (인증)
	    params.put("type", "SMS");
	    params.put("text", "[StoreFamily] 인증번호는 " + randomNumber + " 입니다.");
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	    	//send() 는 메시지를 보내는 함수
	      JSONObject obj = coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }

	    return Integer.toString(randomNumber);

	}

	@RequestMapping(value="check_userid")
	public int check_userid(@RequestParam("id") String id) throws Exception {
		int chk = this.JoinService.check_userid(id);
		return chk;
	}

}
