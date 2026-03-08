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

import kr.co.storefamily.dto.EmployeeSignUpRequestDto;
import kr.co.storefamily.model.Field;
import kr.co.storefamily.model.Local_Si;
import kr.co.storefamily.service.JoinService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class JoinController {

	@Autowired
	private JoinService joinService;

	@Value("${sms.api.key:}")
	private String smsApiKey;

	@Value("${sms.api.secret:}")
	private String smsApiSecret;

	@Value("${sms.from.number:}")
	private String smsFromNumber;

	@GetMapping({ "join", "join_main" })
	public String join(@ModelAttribute("joinRequest") EmployeeSignUpRequestDto joinRequest,
			@RequestParam(value = "code", required = false) String code,
			Model model) {
		if (code != null && !code.trim().isEmpty()) {
			model.addAttribute("inviteStoreCode", code.trim());
		}
		return "Join/employee/employee_join";
	}

	@PostMapping({ "join", "join_ok" })
	public String joinSubmit(@ModelAttribute("joinRequest") @Valid EmployeeSignUpRequestDto joinRequest,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "Join/employee/employee_join";
		}

		joinService.registerMember(joinRequest);
		return "redirect:/login";
	}

	@GetMapping("employee_join")
	public String employeeJoinLegacyRedirect() {
		return "redirect:/join";
	}

	@PostMapping("employee_join")
	public String employeeJoinLegacyPostRedirect() {
		return "redirect:/join";
	}

	@GetMapping("ceo_join")
	public String ceoJoinLegacyRedirect() {
		return "redirect:/join";
	}

	@PostMapping("ceo_join")
	public String ceoJoinLegacyPostRedirect() {
		return "redirect:/join";
	}

	@GetMapping("ceo_store_join")
	public String ceoStoreJoinLegacyRedirect() {
		return "redirect:/join";
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

}
