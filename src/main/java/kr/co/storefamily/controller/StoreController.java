package kr.co.storefamily.controller;

import java.security.SecureRandom;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.storefamily.mapper.StoreMapper;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreEmployee;
import kr.co.storefamily.model.StoreJoinRequest;
import kr.co.storefamily.model.StoreMember;

@Controller
public class StoreController {

	private static final String POSITION_CEO = "\uC0AC\uC7A5";
	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";
	private static final String STORE_ID_CHARS = "abcdefghijklmnopqrstuvwxyz0123456789";
	private static final String STORE_CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
	private static final int STORE_ID_LENGTH = 12;
	private static final int STORE_CODE_LENGTH = 8;
	private static final SecureRandom RANDOM = new SecureRandom();

	@Autowired
	private StoreMapper storeMapper;

	@GetMapping("/store/register")
	public String storeRegisterForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}
		model.addAttribute("myStores", storeMapper.findStoresByCeoBno(ceoBno));
		model.addAttribute("storeForm", new Store());
		return "Store/store_register";
	}

	@PostMapping("/store/register")
	@Transactional
	public String storeRegisterSubmit(@ModelAttribute("storeForm") Store storeForm, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}

		if (isBlank(storeForm.getStore_name()) || isBlank(storeForm.getStore_address()) || isBlank(storeForm.getStore_phone())) {
			model.addAttribute("message", "\uB9E4\uC7A5\uBA85, \uB9E4\uC7A5 \uC8FC\uC18C, \uB9E4\uC7A5 \uC804\uD654\uBC88\uD638\uB97C \uBAA8\uB450 \uC785\uB825\uD574 \uC8FC\uC138\uC694.");
			model.addAttribute("storeForm", storeForm);
			model.addAttribute("myStores", storeMapper.findStoresByCeoBno(ceoBno));
			return "Store/store_register";
		}

		String storeId = generateUniqueStoreId();
		String storeCode = generateUniqueStoreCode();

		Store store = new Store();
		store.setStore_id(storeId);
		store.setStore_code(storeCode);
		store.setStore_name(storeForm.getStore_name());
		store.setStore_address(storeForm.getStore_address());
		store.setStore_phone(storeForm.getStore_phone());
		store.setCeo_bno(ceoBno);

		if (storeMapper.insertStore(store) != 1) {
			throw new IllegalStateException("\uB9E4\uC7A5 \uB4F1\uB85D\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4.");
		}

		StoreMember ceoStoreMember = new StoreMember();
		ceoStoreMember.setStore_id(storeId);
		ceoStoreMember.setMember_bno(ceoBno);
		ceoStoreMember.setPosition(POSITION_CEO);
		ceoStoreMember.setChk(1);

		if (storeMapper.insertStoreMember(ceoStoreMember) != 1) {
			throw new IllegalStateException("\uB9E4\uC7A5 \uC18C\uC18D \uC815\uBCF4 \uC0DD\uC131\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4.");
		}

		session.setAttribute("position", POSITION_CEO);
		redirectAttributes.addFlashAttribute("message",
				"\uB9E4\uC7A5 \uB4F1\uB85D\uC774 \uC644\uB8CC\uB418\uC5C8\uC2B5\uB2C8\uB2E4. \uC9C1\uC6D0 \uAC00\uC785 \uCF54\uB4DC\uB294 " + storeCode + " \uC785\uB2C8\uB2E4.");
		return "redirect:/store/register";
	}

	@GetMapping("/store/my")
	public String myStores(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}

		List<Store> myStores = storeMapper.findStoresByCeoBno(ceoBno);
		if (myStores.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "\uB4F1\uB85D\uD55C \uB9E4\uC7A5\uC774 \uC5C6\uC2B5\uB2C8\uB2E4. \uBA3C\uC800 \uB9E4\uC7A5\uC744 \uB4F1\uB85D\uD574 \uC8FC\uC138\uC694.");
			return "redirect:/store/register";
		}

		model.addAttribute("myStores", myStores);
		return "Store/store_my";
	}

	@GetMapping("/store/manage")
	public String storeManage(@RequestParam("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		model.addAttribute("myStore", ownedStore);
		return "Store/store_manage";
	}

	@GetMapping("/store/join")
	public String storeJoinForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		if (getLoginMemberBno(session, redirectAttributes) == null) {
			return "redirect:/login";
		}
		model.addAttribute("storeCode", "");
		return "Store/store_join";
	}

	@PostMapping("/store/join")
	@Transactional
	public String storeJoinSubmit(@RequestParam("storeCode") String storeCode, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String trimmedStoreCode = storeCode == null ? "" : storeCode.trim();
		if (trimmedStoreCode.isEmpty()) {
			model.addAttribute("message", "\uB9E4\uC7A5 \uCF54\uB4DC\uB97C \uC785\uB825\uD574 \uC8FC\uC138\uC694.");
			model.addAttribute("storeCode", "");
			return "Store/store_join";
		}

		Store store = storeMapper.findStoreByStoreCode(trimmedStoreCode);
		if (store == null) {
			model.addAttribute("message", "\uC77C\uCE58\uD558\uB294 \uB9E4\uC7A5 \uCF54\uB4DC\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4.");
			model.addAttribute("storeCode", trimmedStoreCode);
			return "Store/store_join";
		}

		StoreMember existed = storeMapper.findStoreMember(store.getStore_id(), memberBno);
		if (existed != null) {
			if (Integer.valueOf(1).equals(existed.getChk())) {
				model.addAttribute("message", "\uC774\uBBF8 \uD574\uB2F9 \uB9E4\uC7A5\uC5D0 \uAC00\uC785\uB41C \uACC4\uC815\uC785\uB2C8\uB2E4.");
			} else if (Integer.valueOf(0).equals(existed.getChk())) {
				model.addAttribute("message", "\uC774\uBBF8 \uAC00\uC785 \uC694\uCCAD\uC744 \uBCF4\uB0B8 \uC0C1\uD0DC\uC785\uB2C8\uB2E4.");
			} else {
				model.addAttribute("message", "\uC774\uBBF8 \uD574\uB2F9 \uB9E4\uC7A5\uC5D0 \uB4F1\uB85D\uB41C \uC774\uB825\uC774 \uC788\uC2B5\uB2C8\uB2E4.");
			}
			model.addAttribute("storeCode", trimmedStoreCode);
			return "Store/store_join";
		}

		StoreMember storeMember = new StoreMember();
		storeMember.setStore_id(store.getStore_id());
		storeMember.setMember_bno(memberBno);
		storeMember.setPosition(POSITION_EMPLOYEE);
		storeMember.setChk(0);

		if (storeMapper.insertStoreMember(storeMember) != 1) {
			throw new IllegalStateException("\uB9E4\uC7A5 \uAC00\uC785 \uC694\uCCAD \uC800\uC7A5\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4.");
		}

		redirectAttributes.addFlashAttribute("message", "\uB9E4\uC7A5 \uAC00\uC785 \uC694\uCCAD\uC774 \uC644\uB8CC\uB418\uC5C8\uC2B5\uB2C8\uB2E4. \uC0AC\uC7A5 \uC2B9\uC778 \uD6C4 \uC774\uC6A9 \uAC00\uB2A5\uD569\uB2C8\uB2E4.");
		return "redirect:/store/join";
	}

	@GetMapping("/store/approval")
	public String storeApprovalPage(@RequestParam("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		List<StoreJoinRequest> pendingRequests = storeMapper.findPendingJoinRequestsByStoreId(ownedStore.getStore_id());
		model.addAttribute("myStore", ownedStore);
		model.addAttribute("pendingRequests", pendingRequests);
		return "Store/store_approval";
	}

	@PostMapping("/store/approval/approve")
	@Transactional
	public String approveStoreMember(@RequestParam("storeId") String storeId, @RequestParam("storeMemberId") int storeMemberId,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		int updated = storeMapper.approveStoreMember(storeMemberId, ownedStore.getStore_id());
		if (updated == 1) {
			redirectAttributes.addFlashAttribute("message", "\uAC00\uC785 \uC694\uCCAD\uC744 \uC2B9\uC778\uD588\uC2B5\uB2C8\uB2E4.");
		} else {
			redirectAttributes.addFlashAttribute("message", "\uC2B9\uC778 \uCC98\uB9AC \uB300\uC0C1\uC774 \uC5C6\uAC70\uB098 \uC774\uBBF8 \uCC98\uB9AC\uB41C \uC694\uCCAD\uC785\uB2C8\uB2E4.");
		}
		return "redirect:/store/approval?storeId=" + ownedStore.getStore_id();
	}

	@PostMapping("/store/approval/reject")
	@Transactional
	public String rejectStoreMember(@RequestParam("storeId") String storeId, @RequestParam("storeMemberId") int storeMemberId,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		int deleted = storeMapper.rejectStoreMember(storeMemberId, ownedStore.getStore_id());
		if (deleted == 1) {
			redirectAttributes.addFlashAttribute("message", "\uAC00\uC785 \uC694\uCCAD\uC744 \uAC70\uC808\uD588\uC2B5\uB2C8\uB2E4.");
		} else {
			redirectAttributes.addFlashAttribute("message", "\uAC70\uC808 \uCC98\uB9AC \uB300\uC0C1\uC774 \uC5C6\uAC70\uB098 \uC774\uBBF8 \uCC98\uB9AC\uB41C \uC694\uCCAD\uC785\uB2C8\uB2E4.");
		}
		return "redirect:/store/approval?storeId=" + ownedStore.getStore_id();
	}

	@GetMapping("/store/employees")
	public String storeEmployeeList(@RequestParam("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		List<StoreEmployee> employees = storeMapper.findApprovedEmployeesByStoreId(ownedStore.getStore_id());
		model.addAttribute("myStore", ownedStore);
		model.addAttribute("employees", employees);
		return "Store/store_employee_list";
	}

	@GetMapping("/store/employees/detail")
	public String storeEmployeeDetail(@RequestParam("storeId") String storeId, @RequestParam("storeMemberId") int storeMemberId,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		StoreEmployee employee = storeMapper.findEmployeeDetail(ownedStore.getStore_id(), storeMemberId);
		if (employee == null) {
			redirectAttributes.addFlashAttribute("message", "\uD574\uB2F9 \uC9C1\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC744 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.");
			return "redirect:/store/employees?storeId=" + ownedStore.getStore_id();
		}

		model.addAttribute("myStore", ownedStore);
		model.addAttribute("employee", employee);
		return "Store/store_employee_detail";
	}

	private Integer getLoginMemberBno(HttpSession session, RedirectAttributes redirectAttributes) {
		String loginId = (String) session.getAttribute("id");
		if (loginId == null) {
			redirectAttributes.addFlashAttribute("message", "\uB85C\uADF8\uC778 \uD6C4 \uC774\uC6A9\uD574 \uC8FC\uC138\uC694.");
			return null;
		}

		Integer bno = storeMapper.findMemberBnoById(loginId);
		if (bno == null) {
			redirectAttributes.addFlashAttribute("message", "\uD68C\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC744 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.");
		}
		return bno;
	}

	private Store getOwnedStore(String storeId, HttpSession session, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return null;
		}

		if (isBlank(storeId)) {
			redirectAttributes.addFlashAttribute("message", "\uB9E4\uC7A5\uC744 \uBA3C\uC800 \uC120\uD0DD\uD574 \uC8FC\uC138\uC694.");
			return null;
		}

		Store ownedStore = storeMapper.findStoreByIdAndCeoBno(storeId, ceoBno);
		if (ownedStore == null) {
			redirectAttributes.addFlashAttribute("message", "\uC120\uD0DD\uD55C \uB9E4\uC7A5\uC744 \uAD00\uB9AC\uD560 \uAD8C\uD55C\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.");
			return null;
		}
		return ownedStore;
	}

	private String generateUniqueStoreId() {
		for (int i = 0; i < 30; i++) {
			String candidate = randomString(STORE_ID_CHARS, STORE_ID_LENGTH);
			if (storeMapper.countStoreId(candidate) == 0) {
				return candidate;
			}
		}
		throw new IllegalStateException("\uACE0\uC720\uD55C \uB9E4\uC7A5 ID\uB97C \uC0DD\uC131\uD558\uC9C0 \uBABB\uD588\uC2B5\uB2C8\uB2E4.");
	}

	private String generateUniqueStoreCode() {
		for (int i = 0; i < 30; i++) {
			String candidate = randomString(STORE_CODE_CHARS, STORE_CODE_LENGTH);
			if (storeMapper.countStoreCode(candidate) == 0) {
				return candidate;
			}
		}
		throw new IllegalStateException("\uACE0\uC720\uD55C \uB9E4\uC7A5 \uCF54\uB4DC\uB97C \uC0DD\uC131\uD558\uC9C0 \uBABB\uD588\uC2B5\uB2C8\uB2E4.");
	}

	private String randomString(String chars, int length) {
		StringBuilder sb = new StringBuilder(length);
		for (int i = 0; i < length; i++) {
			sb.append(chars.charAt(RANDOM.nextInt(chars.length())));
		}
		return sb.toString();
	}

	private boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}
}
