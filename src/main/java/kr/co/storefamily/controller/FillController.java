package kr.co.storefamily.controller;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.storefamily.model.FillApply;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.SchedulePart;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;
import kr.co.storefamily.service.FillService;

@Controller
public class FillController {

	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";

	private static final int FILL_CHK_RECRUITING = 0;
	private static final int FILL_CHK_APPROVED = 1;
	private static final int FILL_CHK_CANCELED = 3;

	private static final int APPLY_CHK_PENDING = 0;

	@Autowired
	private FillService fillService;

	@GetMapping({ "/fill", "/fill_all_list" })
	public String fillLegacyEntry(HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String storeId = fillService.findDefaultStoreId(memberBno.intValue());
		if (isBlank(storeId)) {
			redirectAttributes.addFlashAttribute("message", "No joined store found.");
			return "redirect:/store/join";
		}
		return "redirect:/stores/" + storeId + "/fills";
	}

	@GetMapping("/stores/{storeId}/fills")
	public String fillList(@PathVariable("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		Store store = fillService.findStore(storeId);
		if (store == null) {
			redirectAttributes.addFlashAttribute("message", "Store not found.");
			return "redirect:/store/my";
		}

		StoreMember storeMember = fillService.findApprovedStoreMember(storeId, memberBno.intValue());
		if (storeMember == null) {
			redirectAttributes.addFlashAttribute("message", "No permission for this store.");
			return "redirect:/store/my";
		}

		List<FillPost> fills = fillService.getStoreFillList(storeId);
		boolean canManage = fillService.canManageStore(storeId, memberBno.intValue());

		model.addAttribute("myStore", store);
		model.addAttribute("fills", fills);
		model.addAttribute("canManage", Boolean.valueOf(canManage));
		model.addAttribute("storeMember", storeMember);
		return "Fill/store_fill_list";
	}

	@GetMapping("/stores/{storeId}/fills/{fillBno}")
	public String fillDetail(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		Store store = fillService.findStore(storeId);
		if (store == null) {
			redirectAttributes.addFlashAttribute("message", "Store not found.");
			return "redirect:/store/my";
		}

		StoreMember storeMember = fillService.findApprovedStoreMember(storeId, memberBno.intValue());
		if (storeMember == null) {
			redirectAttributes.addFlashAttribute("message", "No permission for this store.");
			return "redirect:/store/my";
		}

		FillPost fill = fillService.getStoreFillDetail(storeId, fillBno);
		if (fill == null) {
			redirectAttributes.addFlashAttribute("message", "Fill request not found.");
			return "redirect:/stores/" + storeId + "/fills";
		}

		boolean canManage = fillService.canManageStore(storeId, memberBno.intValue());
		String loginId = (String) session.getAttribute("id");
		boolean isRequester = loginId != null && loginId.equals(fill.getId());
		boolean isEmployee = POSITION_EMPLOYEE.equals(storeMember.getPosition());
		boolean recruitOpen = fill.getChk() != null && fill.getChk().intValue() == FILL_CHK_RECRUITING;
		boolean periodOpen = isWithinApplyPeriod(fill.getApply_start_day(), fill.getApply_end_day());

		List<FillApply> applies = fillService.getFillApplyList(fillBno);
		boolean hasActiveMyApply = false;
		boolean hasPendingMyApply = false;
		if (loginId != null) {
			for (FillApply apply : applies) {
				if (!loginId.equals(apply.getId())) {
					continue;
				}
				if (apply.getChk() != null && apply.getChk().intValue() == APPLY_CHK_PENDING) {
					hasPendingMyApply = true;
				}
				if (apply.getChk() != null && apply.getChk().intValue() != 3) {
					hasActiveMyApply = true;
				}
			}
		}

		boolean canApply = isEmployee && !isRequester && recruitOpen && periodOpen && !hasActiveMyApply;
		boolean canCancelFill = isRequester && fill.getChk() != null
				&& fill.getChk().intValue() != FILL_CHK_APPROVED && fill.getChk().intValue() != FILL_CHK_CANCELED;
		boolean showApplyList = canManage || isRequester;

		model.addAttribute("myStore", store);
		model.addAttribute("fill", fill);
		model.addAttribute("applies", applies);
		model.addAttribute("canManage", Boolean.valueOf(canManage));
		model.addAttribute("isRequester", Boolean.valueOf(isRequester));
		model.addAttribute("canApply", Boolean.valueOf(canApply));
		model.addAttribute("hasPendingMyApply", Boolean.valueOf(hasPendingMyApply));
		model.addAttribute("canCancelFill", Boolean.valueOf(canCancelFill));
		model.addAttribute("showApplyList", Boolean.valueOf(showApplyList));
		return "Fill/store_fill_detail";
	}

	@GetMapping("/stores/{storeId}/schedule/{scheduleBno}/fill/new")
	public String fillNewForm(@PathVariable("storeId") String storeId, @PathVariable("scheduleBno") int scheduleBno,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		Store store = fillService.findStore(storeId);
		if (store == null) {
			redirectAttributes.addFlashAttribute("message", "Store not found.");
			return "redirect:/store/my";
		}

		StoreSchedule schedule = fillService.getScheduleForFillCreate(storeId, scheduleBno, memberBno.intValue());
		if (schedule == null) {
			redirectAttributes.addFlashAttribute("message", "Only your own schedule can be requested as fill.");
			return "redirect:/stores/" + storeId + "/my-schedules";
		}

		model.addAttribute("myStore", store);
		model.addAttribute("isDirect", Boolean.FALSE);
		model.addAttribute("schedule", schedule);
		model.addAttribute("defaultApplyStart", LocalDate.now().toString());
		model.addAttribute("defaultApplyEnd", LocalDate.now().plusDays(3).toString());
		return "Fill/store_fill_form";
	}

	@GetMapping("/stores/{storeId}/fills/new")
	public String directFillNewForm(@PathVariable("storeId") String storeId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		Store store = fillService.findStore(storeId);
		if (store == null) {
			redirectAttributes.addFlashAttribute("message", "Store not found.");
			return "redirect:/store/my";
		}
		if (!fillService.canManageStore(storeId, memberBno.intValue())) {
			redirectAttributes.addFlashAttribute("message", "No permission to create direct fill.");
			return "redirect:/stores/" + storeId + "/fills";
		}

		List<SchedulePart> parts = fillService.getScheduleParts(storeId);
		model.addAttribute("myStore", store);
		model.addAttribute("isDirect", Boolean.TRUE);
		model.addAttribute("scheduleParts", parts);
		model.addAttribute("defaultFillDay", LocalDate.now().toString());
		model.addAttribute("defaultApplyStart", LocalDate.now().toString());
		model.addAttribute("defaultApplyEnd", LocalDate.now().plusDays(3).toString());
		return "Fill/store_fill_form";
	}

	@PostMapping("/stores/{storeId}/schedule/{scheduleBno}/fill/new")
	public String fillCreate(@PathVariable("storeId") String storeId, @PathVariable("scheduleBno") int scheduleBno,
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("applyStartDay") String applyStartDay,
			@RequestParam("applyEndDay") String applyEndDay,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String loginId = (String) session.getAttribute("id");
		String loginName = (String) session.getAttribute("name");
		try {
			fillService.createFill(storeId, scheduleBno, memberBno.intValue(), loginId, loginName, title, content, applyStartDay,
					applyEndDay);
			redirectAttributes.addFlashAttribute("message", "Fill request has been created.");
			return "redirect:/stores/" + storeId + "/fills";
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
			return "redirect:/stores/" + storeId + "/schedule/" + scheduleBno + "/fill/new";
		}
	}

	@PostMapping("/stores/{storeId}/fills/new")
	public String directFillCreate(@PathVariable("storeId") String storeId,
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("fillDay") String fillDay,
			@RequestParam(value = "partBno", required = false) Integer partBno,
			@RequestParam(value = "startTime", required = false) String startTime,
			@RequestParam(value = "endTime", required = false) String endTime,
			@RequestParam("applyStartDay") String applyStartDay,
			@RequestParam("applyEndDay") String applyEndDay,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String loginId = (String) session.getAttribute("id");
		String loginName = (String) session.getAttribute("name");
		try {
			fillService.createDirectFill(storeId, memberBno.intValue(), loginId, loginName, title, content, fillDay, startTime,
					endTime, partBno, applyStartDay, applyEndDay);
			redirectAttributes.addFlashAttribute("message", "Direct fill request has been created.");
			return "redirect:/stores/" + storeId + "/fills";
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
			return "redirect:/stores/" + storeId + "/fills/new";
		}
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/apply")
	public String fillApply(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String loginId = (String) session.getAttribute("id");
		String loginName = (String) session.getAttribute("name");
		try {
			fillService.applyFill(storeId, fillBno, memberBno.intValue(), loginId, loginName);
			redirectAttributes.addFlashAttribute("message", "Apply submitted.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/apply/cancel")
	public String fillApplyCancel(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String loginId = (String) session.getAttribute("id");
		try {
			fillService.cancelMyApply(storeId, fillBno, memberBno.intValue(), loginId);
			redirectAttributes.addFlashAttribute("message", "Apply canceled.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/applications/{applyBno}/approve")
	public String approveApply(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			@PathVariable("applyBno") int applyBno, HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		try {
			fillService.approveApply(storeId, fillBno, applyBno, memberBno.intValue());
			redirectAttributes.addFlashAttribute("message", "Applicant approved.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/applications/{applyBno}/reject")
	public String rejectApply(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			@PathVariable("applyBno") int applyBno, HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		try {
			fillService.rejectApply(storeId, fillBno, applyBno, memberBno.intValue());
			redirectAttributes.addFlashAttribute("message", "Applicant rejected.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/close")
	public String closeFill(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		try {
			fillService.closeFill(storeId, fillBno, memberBno.intValue());
			redirectAttributes.addFlashAttribute("message", "Fill request closed.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	@PostMapping("/stores/{storeId}/fills/{fillBno}/cancel")
	public String cancelFill(@PathVariable("storeId") String storeId, @PathVariable("fillBno") int fillBno,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Integer memberBno = getLoginMemberBno(session, redirectAttributes);
		if (memberBno == null) {
			return "redirect:/login";
		}

		String loginId = (String) session.getAttribute("id");
		try {
			fillService.cancelFillByRequester(storeId, fillBno, memberBno.intValue(), loginId);
			redirectAttributes.addFlashAttribute("message", "Fill request canceled.");
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
		}
		return "redirect:/stores/" + storeId + "/fills/" + fillBno;
	}

	private Integer getLoginMemberBno(HttpSession session, RedirectAttributes redirectAttributes) {
		String loginId = (String) session.getAttribute("id");
		if (loginId == null) {
			redirectAttributes.addFlashAttribute("message", "Login required.");
			return null;
		}
		try {
			return Integer.valueOf(fillService.getLoginMemberBno(loginId));
		} catch (IllegalArgumentException ex) {
			redirectAttributes.addFlashAttribute("message", ex.getMessage());
			return null;
		}
	}

	private boolean isWithinApplyPeriod(String startText, String endText) {
		if (isBlank(startText) || isBlank(endText)) {
			return false;
		}
		try {
			LocalDate today = LocalDate.now();
			LocalDate start = LocalDate.parse(startText);
			LocalDate end = LocalDate.parse(endText);
			return !(today.isBefore(start) || today.isAfter(end));
		} catch (DateTimeParseException ex) {
			return false;
		}
	}

	private boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}
}
