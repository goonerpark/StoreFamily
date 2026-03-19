package kr.co.storefamily.controller;

import java.security.SecureRandom;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.storefamily.dto.StoreDashboardView;
import kr.co.storefamily.mapper.StoreMapper;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreEmployee;
import kr.co.storefamily.model.StoreJoinRequest;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

@Controller
public class StoreController {

	private static final String POSITION_CEO = "\uC0AC\uC7A5";
	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";
	private static final String STORE_ID_CHARS = "abcdefghijklmnopqrstuvwxyz0123456789";
	private static final String STORE_CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
	private static final int STORE_ID_LENGTH = 12;
	private static final int STORE_CODE_LENGTH = 8;
	private static final SecureRandom RANDOM = new SecureRandom();
	private static final String SCHEDULE_STATUS_SCHEDULED = "SCHEDULED";
	private static final String SCHEDULE_STATUS_COMPLETED = "COMPLETED";
	private static final String SCHEDULE_STATUS_CANCELED = "CANCELED";

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
	public String storeRegisterSubmit(@ModelAttribute("storeForm") Store storeForm,
			@RequestParam(value = "store_address_detail", required = false) String storeAddressDetail,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}

		if (isBlank(storeForm.getStore_name()) || isBlank(storeForm.getStore_address()) || isBlank(storeForm.getStore_phone())) {
			model.addAttribute("message", "\uB9E4\uC7A5\uBA85, \uB9E4\uC7A5 \uC8FC\uC18C, \uB9E4\uC7A5 \uC804\uD654\uBC88\uD638\uB97C \uBAA8\uB450 \uC785\uB825\uD574 \uC8FC\uC138\uC694.");
			model.addAttribute("storeForm", storeForm);
			model.addAttribute("storeAddressDetail", storeAddressDetail);
			model.addAttribute("myStores", storeMapper.findStoresByCeoBno(ceoBno));
			return "Store/store_register";
		}

		String storeId = generateUniqueStoreId();
		String storeCode = generateUniqueStoreCode();

		Store store = new Store();
		store.setStore_id(storeId);
		store.setStore_code(storeCode);
		store.setStore_name(storeForm.getStore_name());
		store.setStore_address(mergeAddress(storeForm.getStore_address(), storeAddressDetail));
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
		ceoStoreMember.setEmployment(null);
		ceoStoreMember.setHealth(null);
		ceoStoreMember.setRate(null);
		ceoStoreMember.setColor(null);

		if (storeMapper.insertStoreMember(ceoStoreMember) != 1) {
			throw new IllegalStateException("\uB9E4\uC7A5 \uC18C\uC18D \uC815\uBCF4 \uC0DD\uC131\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4.");
		}

		session.setAttribute("position", POSITION_CEO);
		redirectAttributes.addFlashAttribute("message",
				"\uB9E4\uC7A5 \uB4F1\uB85D\uC774 \uC644\uB8CC\uB418\uC5C8\uC2B5\uB2C8\uB2E4. \uC9C1\uC6D0 \uAC00\uC785 \uCF54\uB4DC\uB294 " + storeCode + " \uC785\uB2C8\uB2E4.");
		return "redirect:/store/register";
	}

	@GetMapping("/store/my")
	public String myStores(@RequestParam(value = "q", required = false) String q,
			@RequestParam(value = "sort", required = false, defaultValue = "latest") String sort,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}

		List<Store> myStores = storeMapper.findStoresByCeoBno(ceoBno);
		if (myStores.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "\uB4F1\uB85D\uD55C \uB9E4\uC7A5\uC774 \uC5C6\uC2B5\uB2C8\uB2E4. \uBA3C\uC800 \uB9E4\uC7A5\uC744 \uB4F1\uB85D\uD574 \uC8FC\uC138\uC694.");
			return "redirect:/store/register";
		}

		String keyword = q == null ? "" : q.trim();
		if (!keyword.isEmpty()) {
			String lowered = keyword.toLowerCase(Locale.ROOT);
			myStores.removeIf(store -> !containsIgnoreCase(store.getStore_name(), lowered)
					&& !containsIgnoreCase(store.getStore_code(), lowered)
					&& !containsIgnoreCase(store.getStore_address(), lowered));
		}

		if ("name_asc".equals(sort)) {
			myStores.sort(Comparator.comparing(store -> defaultString(store.getStore_name())));
		} else if ("name_desc".equals(sort)) {
			myStores.sort(Comparator.comparing((Store store) -> defaultString(store.getStore_name())).reversed());
		} else {
			sort = "latest";
		}

		model.addAttribute("myStores", myStores);
		model.addAttribute("q", keyword);
		model.addAttribute("sort", sort);
		return "Store/store_my";
	}

	@GetMapping("/my-stores")
	public String myStoresAlias() {
		return "redirect:/store/my";
	}

	@GetMapping("/store/manage")
	public String storeManage(@RequestParam("storeId") String storeId) {
		return "redirect:/stores/" + storeId;
	}

	@GetMapping("/stores/{storeId}")
	public String storeDashboard(@PathVariable("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		StoreDashboardView dashboard = buildDashboardView(ownedStore);
		model.addAttribute("dashboard", dashboard);
		model.addAttribute("myStore", ownedStore);
		return "Store/store_manage";
	}

	@GetMapping("/store/approval/select")
	public String storeApprovalSelect(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer ceoBno = getLoginMemberBno(session, redirectAttributes);
		if (ceoBno == null) {
			return "redirect:/login";
		}

		List<Store> myStores = storeMapper.findStoresByCeoBno(ceoBno);
		if (myStores.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "등록한 매장이 없습니다. 먼저 매장을 등록해 주세요.");
			return "redirect:/store/register";
		}

		model.addAttribute("myStores", myStores);
		return "Store/store_approval_select";
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
		storeMember.setEmployment(null);
		storeMember.setHealth(null);
		storeMember.setRate(null);
		storeMember.setColor(null);

		if (storeMapper.insertStoreMember(storeMember) != 1) {
			throw new IllegalStateException("\uB9E4\uC7A5 \uAC00\uC785 \uC694\uCCAD \uC800\uC7A5\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4.");
		}

		redirectAttributes.addFlashAttribute("message", "\uB9E4\uC7A5 \uAC00\uC785 \uC694\uCCAD\uC774 \uC644\uB8CC\uB418\uC5C8\uC2B5\uB2C8\uB2E4. \uC0AC\uC7A5 \uC2B9\uC778 \uD6C4 \uC774\uC6A9 \uAC00\uB2A5\uD569\uB2C8\uB2E4.");
		return "redirect:/store/join";
	}

	@GetMapping("/store/approval")
	public String storeApprovalPage(@RequestParam("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		return storeApprovalPageByStoreId(storeId, session, model, redirectAttributes);
	}

	@GetMapping("/stores/{storeId}/approvals")
	public String storeApprovalPageByPath(@PathVariable("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		return storeApprovalPageByStoreId(storeId, session, model, redirectAttributes);
	}

	private String storeApprovalPageByStoreId(String storeId, HttpSession session, Model model,
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
		return "redirect:/stores/" + ownedStore.getStore_id() + "/approvals";
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
		return "redirect:/stores/" + ownedStore.getStore_id() + "/approvals";
	}

	@GetMapping("/store/employees")
	public String storeEmployeeList(@RequestParam("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		return storeEmployeeListByStoreId(storeId, session, model, redirectAttributes);
	}

	@GetMapping("/stores/{storeId}/employees")
	public String storeEmployeeListByPath(@PathVariable("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		return storeEmployeeListByStoreId(storeId, session, model, redirectAttributes);
	}

	private String storeEmployeeListByStoreId(String storeId, HttpSession session, Model model,
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
	public String storeEmployeeDetailLegacy(@RequestParam("storeId") String storeId,
			@RequestParam(value = "employeeId", required = false) String employeeIdParam,
			@RequestParam(value = "storeMemberId", required = false) Integer storeMemberId,
			HttpSession session, RedirectAttributes redirectAttributes) {
		if (employeeIdParam != null && !employeeIdParam.trim().isEmpty()) {
			return "redirect:/stores/" + storeId + "/employees/" + employeeIdParam.trim();
		}

		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		if (storeMemberId == null) {
			redirectAttributes.addFlashAttribute("message", "\uC9C1\uC6D0 \uC815\uBCF4 \uC694\uCCAD\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees";
		}

		StoreEmployee legacyEmployee = storeMapper.findEmployeeDetail(ownedStore.getStore_id(), storeMemberId);
		if (legacyEmployee == null || legacyEmployee.getMember_bno() == null) {
			redirectAttributes.addFlashAttribute("message", "\uD574\uB2F9 \uC9C1\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC744 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees";
		}

		return "redirect:/stores/" + ownedStore.getStore_id() + "/employees/" + legacyEmployee.getMember_bno();
	}

	@GetMapping("/stores/{storeId}/employees/{employeeId}")
	public String storeEmployeeDetailByPath(@PathVariable("storeId") String storeId,
			@PathVariable("employeeId") int employeeId,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		StoreEmployee employee = storeMapper.findEmployeeDetailByStoreAndMember(ownedStore.getStore_id(), employeeId);
		if (employee == null) {
			redirectAttributes.addFlashAttribute("message", "\uD574\uB2F9 \uB9E4\uC7A5 \uC18C\uC18D \uC9C1\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC744 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees";
		}

		addHealthCertificateInfo(model, employee);
		model.addAttribute("myStore", ownedStore);
		model.addAttribute("employee", employee);
		return "Store/store_employee_detail";
	}

	@PostMapping("/stores/{storeId}/employees/{employeeId}")
	@Transactional
	public String updateStoreEmployeeInfo(@PathVariable("storeId") String storeId,
			@PathVariable("employeeId") int employeeId,
			@RequestParam(value = "employment", required = false) String employment,
			@RequestParam(value = "health", required = false) String health,
			@RequestParam(value = "rate", required = false) String rate,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		StoreEmployee employee = storeMapper.findEmployeeDetailByStoreAndMember(ownedStore.getStore_id(), employeeId);
		if (employee == null) {
			redirectAttributes.addFlashAttribute("message", "\uD574\uB2F9 \uB9E4\uC7A5 \uC18C\uC18D \uC9C1\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC744 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees";
		}

		String normalizedEmployment = normalizeDateInput(employment);
		if (normalizedEmployment == null && !isBlank(employment)) {
			redirectAttributes.addFlashAttribute("message", "\uC785\uC0AC\uC77C \uD615\uC2DD\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4. (YYYY-MM-DD)");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees/" + employeeId;
		}

		String normalizedHealth = normalizeDateInput(health);
		if (normalizedHealth == null && !isBlank(health)) {
			redirectAttributes.addFlashAttribute("message", "\uBCF4\uAC74\uC99D \uB4F1\uB85D\uC77C \uD615\uC2DD\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4. (YYYY-MM-DD)");
			return "redirect:/stores/" + ownedStore.getStore_id() + "/employees/" + employeeId;
		}

		String normalizedRate = normalizeText(rate);
		int updated = storeMapper.updateEmployeeWorkInfo(ownedStore.getStore_id(), employeeId, normalizedEmployment, normalizedHealth,
				normalizedRate);
		if (updated == 1) {
			redirectAttributes.addFlashAttribute("message", "\uC9C1\uC6D0 \uC815\uBCF4\uAC00 \uC218\uC815\uB418\uC5C8\uC2B5\uB2C8\uB2E4.");
		} else {
			redirectAttributes.addFlashAttribute("message", "\uC218\uC815\uD560 \uC9C1\uC6D0 \uC815\uBCF4\uB97C \uCC3E\uC9C0 \uBABB\uD588\uC2B5\uB2C8\uB2E4.");
		}

		return "redirect:/stores/" + ownedStore.getStore_id() + "/employees/" + employeeId;
	}

	@GetMapping("/stores/{storeId}/schedules")
	public String storeScheduleCalendar(@PathVariable("storeId") String storeId,
			@RequestParam(value = "month", required = false) String monthText,
			@RequestParam(value = "date", required = false) String dateText,
			@RequestParam(value = "editScheduleId", required = false) Integer editScheduleId,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		YearMonth month = parseYearMonthOrDefault(monthText, YearMonth.now());
		LocalDate selectedDate = parseLocalDateOrNull(dateText);
		if (selectedDate == null || !YearMonth.from(selectedDate).equals(month)) {
			selectedDate = month.atDay(1);
		}

		String monthStart = month.atDay(1).toString();
		String monthEnd = month.atEndOfMonth().toString();
		String selectedDateText = selectedDate.toString();

		List<StoreEmployee> employees = storeMapper.findApprovedEmployeesByStoreId(ownedStore.getStore_id());
		List<StoreSchedule> monthSchedules = storeMapper.findSchedulesByStoreAndMonth(ownedStore.getStore_id(), monthStart, monthEnd);
		List<StoreSchedule> daySchedules = storeMapper.findSchedulesByStoreAndDate(ownedStore.getStore_id(), selectedDateText);

		StoreSchedule editSchedule = null;
		if (editScheduleId != null) {
			editSchedule = storeMapper.findScheduleByStoreAndId(ownedStore.getStore_id(), editScheduleId);
			if (editSchedule == null) {
				redirectAttributes.addFlashAttribute("message", "수정할 스케줄 정보를 찾을 수 없습니다.");
				return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), selectedDateText);
			}
		}

		Map<String, Integer> scheduleCountByDate = new HashMap<String, Integer>();
		for (StoreSchedule schedule : monthSchedules) {
			if (schedule.getWork_date() == null) {
				continue;
			}
			Integer count = scheduleCountByDate.get(schedule.getWork_date());
			scheduleCountByDate.put(schedule.getWork_date(), count == null ? 1 : count + 1);
		}

		model.addAttribute("myStore", ownedStore);
		model.addAttribute("month", month.toString());
		model.addAttribute("selectedDate", selectedDateText);
		model.addAttribute("prevMonth", month.minusMonths(1).toString());
		model.addAttribute("nextMonth", month.plusMonths(1).toString());
		model.addAttribute("calendarCells", buildCalendarCells(month, selectedDate, scheduleCountByDate));
		model.addAttribute("employees", employees);
		model.addAttribute("daySchedules", daySchedules);
		model.addAttribute("editSchedule", editSchedule);
		model.addAttribute("statusOptions", Arrays.asList(SCHEDULE_STATUS_SCHEDULED, SCHEDULE_STATUS_COMPLETED, SCHEDULE_STATUS_CANCELED));
		return "Store/store_schedule_calendar";
	}

	@PostMapping("/stores/{storeId}/schedules")
	@Transactional
	public String createStoreSchedule(@PathVariable("storeId") String storeId,
			@RequestParam("storeEmployeeBno") Integer storeEmployeeBno,
			@RequestParam("workDate") String workDate,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "memo", required = false) String memo,
			@RequestParam(value = "month", required = false) String monthText,
			@RequestParam(value = "selectedDate", required = false) String selectedDateText,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		LocalDate parsedWorkDate = parseLocalDateOrNull(workDate);
		LocalTime parsedStartTime = parseLocalTimeOrNull(startTime);
		LocalTime parsedEndTime = parseLocalTimeOrNull(endTime);
		YearMonth month = parseYearMonthOrDefault(monthText,
				parsedWorkDate == null ? YearMonth.now() : YearMonth.from(parsedWorkDate));

		if (storeEmployeeBno == null || parsedWorkDate == null || parsedStartTime == null || parsedEndTime == null) {
			redirectAttributes.addFlashAttribute("message", "스케줄 등록값을 다시 확인해 주세요.");
			return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(),
					fallbackDateForRedirect(selectedDateText, parsedWorkDate, month));
		}

		if (!parsedEndTime.isAfter(parsedStartTime)) {
			redirectAttributes.addFlashAttribute("message", "종료 시간은 시작 시간보다 늦어야 합니다.");
			return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), parsedWorkDate.toString());
		}

		int workMinutes = (int) ChronoUnit.MINUTES.between(parsedStartTime, parsedEndTime);
		String normalizedStatus = normalizeScheduleStatus(status);
		String normalizedMemo = normalizeScheduleMemo(memo);
		int inserted = storeMapper.insertScheduleForStore(ownedStore.getStore_id(), storeEmployeeBno.intValue(),
				parsedWorkDate.toString(), parsedStartTime.toString(), parsedEndTime.toString(), workMinutes,
				normalizedStatus, normalizedMemo);

		if (inserted == 1) {
			redirectAttributes.addFlashAttribute("message", "스케줄이 등록되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "등록 대상 직원이 없거나 권한이 없습니다.");
		}
		return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), parsedWorkDate.toString());
	}

	@PostMapping("/stores/{storeId}/schedules/{scheduleId}")
	@Transactional
	public String updateStoreSchedule(@PathVariable("storeId") String storeId,
			@PathVariable("scheduleId") int scheduleId,
			@RequestParam("storeEmployeeBno") Integer storeEmployeeBno,
			@RequestParam("workDate") String workDate,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "memo", required = false) String memo,
			@RequestParam(value = "month", required = false) String monthText,
			@RequestParam(value = "selectedDate", required = false) String selectedDateText,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		LocalDate parsedWorkDate = parseLocalDateOrNull(workDate);
		LocalTime parsedStartTime = parseLocalTimeOrNull(startTime);
		LocalTime parsedEndTime = parseLocalTimeOrNull(endTime);
		YearMonth month = parseYearMonthOrDefault(monthText,
				parsedWorkDate == null ? YearMonth.now() : YearMonth.from(parsedWorkDate));

		if (storeEmployeeBno == null || parsedWorkDate == null || parsedStartTime == null || parsedEndTime == null) {
			redirectAttributes.addFlashAttribute("message", "스케줄 수정값을 다시 확인해 주세요.");
			return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(),
					fallbackDateForRedirect(selectedDateText, parsedWorkDate, month));
		}

		if (!parsedEndTime.isAfter(parsedStartTime)) {
			redirectAttributes.addFlashAttribute("message", "종료 시간은 시작 시간보다 늦어야 합니다.");
			return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), parsedWorkDate.toString());
		}

		int workMinutes = (int) ChronoUnit.MINUTES.between(parsedStartTime, parsedEndTime);
		String normalizedStatus = normalizeScheduleStatus(status);
		String normalizedMemo = normalizeScheduleMemo(memo);
		int updated = storeMapper.updateScheduleForStore(ownedStore.getStore_id(), scheduleId, storeEmployeeBno.intValue(),
				parsedWorkDate.toString(), parsedStartTime.toString(), parsedEndTime.toString(), workMinutes,
				normalizedStatus, normalizedMemo);

		if (updated == 1) {
			redirectAttributes.addFlashAttribute("message", "스케줄이 수정되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "수정할 스케줄이 없거나 권한이 없습니다.");
		}
		return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), parsedWorkDate.toString());
	}

	@PostMapping("/stores/{storeId}/schedules/{scheduleId}/delete")
	@Transactional
	public String deleteStoreSchedule(@PathVariable("storeId") String storeId,
			@PathVariable("scheduleId") int scheduleId,
			@RequestParam(value = "month", required = false) String monthText,
			@RequestParam(value = "selectedDate", required = false) String selectedDateText,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Store ownedStore = getOwnedStore(storeId, session, redirectAttributes);
		if (ownedStore == null) {
			return "redirect:/store/my";
		}

		YearMonth month = parseYearMonthOrDefault(monthText, YearMonth.now());
		LocalDate selectedDate = parseLocalDateOrNull(selectedDateText);
		String redirectDate = selectedDate == null ? month.atDay(1).toString() : selectedDate.toString();

		int deleted = storeMapper.deleteScheduleForStore(ownedStore.getStore_id(), scheduleId);
		if (deleted == 1) {
			redirectAttributes.addFlashAttribute("message", "스케줄이 삭제되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "삭제할 스케줄이 없거나 권한이 없습니다.");
		}
		return "redirect:" + buildScheduleRedirectUrl(ownedStore.getStore_id(), month.toString(), redirectDate);
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

	private StoreDashboardView buildDashboardView(Store ownedStore) {
		StoreDashboardView dashboard = new StoreDashboardView();
		dashboard.setStoreId(ownedStore.getStore_id());
		dashboard.setStoreName(ownedStore.getStore_name());
		dashboard.setStoreCode(ownedStore.getStore_code());
		dashboard.setAddress(ownedStore.getStore_address());
		dashboard.setPhone(ownedStore.getStore_phone());
		dashboard.setCreatedAt(ownedStore.getCreated_at());
		dashboard.setEmployeeCount(storeMapper.countApprovedEmployeesByStoreId(ownedStore.getStore_id()));
		dashboard.setPendingApprovalCount(storeMapper.countPendingJoinRequestsByStoreId(ownedStore.getStore_id()));
		return dashboard;
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

		Store existingStore = storeMapper.findStoreById(storeId);
		if (existingStore == null) {
			redirectAttributes.addFlashAttribute("message", "\uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uB9E4\uC7A5\uC785\uB2C8\uB2E4.");
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

	private boolean containsIgnoreCase(String value, String loweredKeyword) {
		return value != null && value.toLowerCase(Locale.ROOT).contains(loweredKeyword);
	}

	private String defaultString(String value) {
		return value == null ? "" : value;
	}

	private String mergeAddress(String baseAddress, String detailAddress) {
		if (isBlank(detailAddress)) {
			return baseAddress;
		}
		return baseAddress + " " + detailAddress.trim();
	}

	private String normalizeDateInput(String dateText) {
		if (isBlank(dateText)) {
			return null;
		}
		try {
			return LocalDate.parse(dateText.trim()).toString();
		} catch (DateTimeParseException ex) {
			return null;
		}
	}

	private String normalizeText(String value) {
		if (isBlank(value)) {
			return null;
		}
		return value.trim();
	}

	private YearMonth parseYearMonthOrDefault(String text, YearMonth fallback) {
		if (isBlank(text)) {
			return fallback;
		}
		try {
			return YearMonth.parse(text.trim());
		} catch (DateTimeParseException ex) {
			return fallback;
		}
	}

	private LocalDate parseLocalDateOrNull(String text) {
		if (isBlank(text)) {
			return null;
		}
		try {
			return LocalDate.parse(text.trim());
		} catch (DateTimeParseException ex) {
			return null;
		}
	}

	private LocalTime parseLocalTimeOrNull(String text) {
		if (isBlank(text)) {
			return null;
		}
		String trimmed = text.trim();
		try {
			return LocalTime.parse(trimmed);
		} catch (DateTimeParseException ex) {
			if (trimmed.length() == 5) {
				try {
					return LocalTime.parse(trimmed + ":00");
				} catch (DateTimeParseException ignored) {
					return null;
				}
			}
			return null;
		}
	}

	private String normalizeScheduleStatus(String statusText) {
		if (isBlank(statusText)) {
			return SCHEDULE_STATUS_SCHEDULED;
		}
		String normalized = statusText.trim().toUpperCase(Locale.ROOT);
		if (SCHEDULE_STATUS_COMPLETED.equals(normalized)) {
			return SCHEDULE_STATUS_COMPLETED;
		}
		if (SCHEDULE_STATUS_CANCELED.equals(normalized)) {
			return SCHEDULE_STATUS_CANCELED;
		}
		return SCHEDULE_STATUS_SCHEDULED;
	}

	private String normalizeScheduleMemo(String memo) {
		if (isBlank(memo)) {
			return null;
		}
		String trimmed = memo.trim();
		if (trimmed.length() > 255) {
			return trimmed.substring(0, 255);
		}
		return trimmed;
	}

	private String fallbackDateForRedirect(String selectedDateText, LocalDate parsedWorkDate, YearMonth month) {
		if (parsedWorkDate != null) {
			return parsedWorkDate.toString();
		}
		LocalDate selectedDate = parseLocalDateOrNull(selectedDateText);
		if (selectedDate != null) {
			return selectedDate.toString();
		}
		return month.atDay(1).toString();
	}

	private String buildScheduleRedirectUrl(String storeId, String month, String selectedDate) {
		return "/stores/" + storeId + "/schedules?month=" + month + "&date=" + selectedDate;
	}

	private List<Map<String, Object>> buildCalendarCells(YearMonth month, LocalDate selectedDate, Map<String, Integer> countByDate) {
		List<Map<String, Object>> cells = new ArrayList<Map<String, Object>>();
		LocalDate start = month.atDay(1);
		while (start.getDayOfWeek() != DayOfWeek.SUNDAY) {
			start = start.minusDays(1);
		}
		LocalDate end = month.atEndOfMonth();
		while (end.getDayOfWeek() != DayOfWeek.SATURDAY) {
			end = end.plusDays(1);
		}

		LocalDate today = LocalDate.now();
		for (LocalDate cursor = start; !cursor.isAfter(end); cursor = cursor.plusDays(1)) {
			Map<String, Object> cell = new HashMap<String, Object>();
			String dateKey = cursor.toString();
			cell.put("date", dateKey);
			cell.put("day", Integer.valueOf(cursor.getDayOfMonth()));
			cell.put("currentMonth", Boolean.valueOf(YearMonth.from(cursor).equals(month)));
			cell.put("selected", Boolean.valueOf(cursor.equals(selectedDate)));
			cell.put("today", Boolean.valueOf(cursor.equals(today)));
			cell.put("count", Integer.valueOf(countByDate.containsKey(dateKey) ? countByDate.get(dateKey) : 0));
			cells.add(cell);
		}
		return cells;
	}

	private void addHealthCertificateInfo(Model model, StoreEmployee employee) {
		if (employee == null || isBlank(employee.getHealth())) {
			model.addAttribute("healthExpiryDate", null);
			model.addAttribute("healthDDayText", "\uB4F1\uB85D \uD544\uC694");
			return;
		}

		try {
			LocalDate registeredDate = LocalDate.parse(employee.getHealth().trim());
			LocalDate expiryDate = registeredDate.plusYears(1);
			LocalDate today = LocalDate.now();
			long days = ChronoUnit.DAYS.between(today, expiryDate);

			model.addAttribute("healthExpiryDate", expiryDate.toString());
			if (days >= 0) {
				model.addAttribute("healthDDayText", "D-" + days);
			} else {
				model.addAttribute("healthDDayText", "\uB9CC\uB8CC\uB428 (D+" + Math.abs(days) + ")");
			}
		} catch (DateTimeParseException ex) {
			model.addAttribute("healthExpiryDate", null);
			model.addAttribute("healthDDayText", "\uB4F1\uB85D\uC77C \uD615\uC2DD \uD655\uC778 \uD544\uC694");
		}
	}
}
