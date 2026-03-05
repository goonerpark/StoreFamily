package kr.co.storefamily.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.storefamily.dto.CeoSignUpRequestDto;
import kr.co.storefamily.dto.EmployeeSignUpRequestDto;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Do;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.service.JoinService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class JoinController {

	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";
	private static final String POSITION_CEO = "\uC0AC\uC7A5";

	@Autowired
	private JoinService joinService;

	@Value("${sms.api.key:}")
	private String smsApiKey;

	@Value("${sms.api.secret:}")
	private String smsApiSecret;

	@Value("${sms.from.number:}")
	private String smsFromNumber;

	@GetMapping("join_main")
	public String joinMain() {
		return "Join/join_main";
	}

	@GetMapping("employee_join")
	public String employeeJoin(Model model, @RequestParam(value = "code", required = false) String code) {
		EmployeeSignUpRequestDto form = new EmployeeSignUpRequestDto();
		if (code != null && !code.isEmpty()) {
			form.setCode(code);
		}
		model.addAttribute("employeeJoinRequest", form);
		return "Join/employee/employee_join";
	}

	@PostMapping("employee_join")
	public String employeeJoinSubmit(
			@ModelAttribute("employeeJoinRequest") @Valid EmployeeSignUpRequestDto employeeJoinRequest,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "Join/employee/employee_join";
		}

		employeeJoinRequest.setPosition(POSITION_EMPLOYEE);
		joinService.registerEmployee(employeeJoinRequest);
		return "redirect:/login";
	}

	@GetMapping("ceo_join")
	public String ceoJoin(Model model) {
		model.addAttribute("ceoJoinRequest", new CeoSignUpRequestDto());
		model.addAttribute("localDoList", joinService.local_do_list());
		return "Join/ceo/ceo_join";
	}

	@PostMapping("ceo_join")
	public String ceoJoinSubmit(@ModelAttribute("ceoJoinRequest") @Valid CeoSignUpRequestDto ceoJoinRequest,
			BindingResult bindingResult, Model model) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("localDoList", joinService.local_do_list());
			return "Join/ceo/ceo_join";
		}

		ceoJoinRequest.setPosition(POSITION_CEO);
		joinService.registerCeo(ceoJoinRequest);
		return "redirect:/login";
	}

	@GetMapping("ceo_store_join")
	public String ceoStoreJoinLegacyRedirect() {
		return "redirect:/ceo_join";
	}

	@GetMapping("getlocal_si")
	@ResponseBody
	public List<Local_Si> getLocalSi(@RequestParam("local_do_code") String localDoCode) {
		return joinService.local_si_list(localDoCode);
	}

	@GetMapping("getfield")
	@ResponseBody
	public List<Field> getField() {
		return joinService.field_list();
	}

	@GetMapping("getcode")
	@ResponseBody
	public Integer getCode(@RequestParam("code") String code) {
		return joinService.getcode(code);
	}

	@GetMapping("check_userid")
	@ResponseBody
	public int checkUserId(@RequestParam("id") String id) {
		return joinService.check_userid(id);
	}

	@GetMapping("phoneCheck")
	@ResponseBody
	public Map<String, String> phoneCheck(@RequestParam("phone") String phone) {
		Map<String, String> response = new HashMap<>();
		int randomNumber = (int) (Math.random() * (9999 - 1000 + 1) + 1000);
		response.put("code", String.valueOf(randomNumber));

		if (smsApiKey.isEmpty() || smsApiSecret.isEmpty() || smsFromNumber.isEmpty()) {
			response.put("status", "mocked");
			return response;
		}

		Message coolsms = new Message(smsApiKey, smsApiSecret);
		HashMap<String, String> params = new HashMap<>();
		params.put("to", phone);
		params.put("from", smsFromNumber);
		params.put("type", "SMS");
		params.put("text", "[StoreFamily] Verification code: " + randomNumber);
		params.put("app_version", "storefamily 1.0");

		try {
			JSONObject obj = coolsms.send(params);
			response.put("status", "sent");
			response.put("providerResult", obj.toString());
		} catch (CoolsmsException e) {
			response.put("status", "failed");
			response.put("message", e.getMessage());
		}
		return response;
	}

	@ModelAttribute("employeePosition")
	public String employeePosition() {
		return POSITION_EMPLOYEE;
	}

	@ModelAttribute("ceoPosition")
	public String ceoPosition() {
		return POSITION_CEO;
	}

}
