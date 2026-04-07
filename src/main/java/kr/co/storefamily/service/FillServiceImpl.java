package kr.co.storefamily.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.storefamily.mapper.FillMapper;
import kr.co.storefamily.model.FillApply;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.SchedulePart;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

@Service
public class FillServiceImpl implements FillService {

	private static final String POSITION_CEO = "\uC0AC\uC7A5";
	private static final String POSITION_MANAGER = "\uAD00\uB9AC\uC790";
	private static final String POSITION_EMPLOYEE = "\uC9C1\uC6D0";

	private static final int FILL_CHK_RECRUITING = 0;
	private static final int FILL_CHK_APPROVED = 1;
	private static final int FILL_CHK_CLOSED = 2;
	private static final int FILL_CHK_CANCELED = 3;

	private static final int APPLY_CHK_PENDING = 0;
	private static final int APPLY_CHK_APPROVED = 1;
	private static final int APPLY_CHK_REJECTED = 2;

	@Autowired
	private FillMapper fillMapper;

	@Override
	public int getLoginMemberBno(String loginId) {
		Integer memberBno = fillMapper.findMemberBnoById(loginId);
		if (memberBno == null) {
			throw new IllegalArgumentException("Member not found.");
		}
		return memberBno.intValue();
	}

	@Override
	public String findDefaultStoreId(int memberBno) {
		return fillMapper.findFirstAccessibleStoreId(memberBno);
	}

	@Override
	public Store findStore(String storeId) {
		return fillMapper.findStoreById(storeId);
	}

	@Override
	public StoreMember findApprovedStoreMember(String storeId, int memberBno) {
		return fillMapper.findApprovedStoreMember(storeId, memberBno);
	}

	@Override
	public boolean canManageStore(String storeId, int memberBno) {
		StoreMember member = requireApprovedMember(storeId, memberBno);
		String position = member.getPosition();
		return POSITION_CEO.equals(position) || POSITION_MANAGER.equals(position);
	}

	@Override
	public List<FillPost> getStoreFillList(String storeId) {
		fillMapper.deactivateExpiredTemporaryMembers(storeId);
		return fillMapper.findFillListByStore(storeId);
	}

	@Override
	public FillPost getStoreFillDetail(String storeId, int fillBno) {
		fillMapper.deactivateExpiredTemporaryMembers(storeId);
		return fillMapper.findFillDetailByStore(storeId, fillBno);
	}

	@Override
	public List<FillApply> getFillApplyList(int fillBno) {
		return fillMapper.findFillApplyList(fillBno);
	}

	@Override
	public StoreSchedule getScheduleForFillCreate(String storeId, int scheduleBno, int memberBno) {
		return fillMapper.findScheduleForFillCreate(storeId, scheduleBno, memberBno);
	}

	@Override
	public List<SchedulePart> getScheduleParts(String storeId) {
		return fillMapper.findSchedulePartsByStoreId(storeId);
	}

	@Override
	@Transactional
	public void createFill(String storeId, int scheduleBno, int memberBno, String loginId, String loginName, String title,
			String content, String applyStartDay, String applyEndDay) {
		requireStoreAndMember(storeId, memberBno);

		StoreSchedule schedule = fillMapper.findScheduleForFillCreate(storeId, scheduleBno, memberBno);
		if (schedule == null) {
			throw new IllegalArgumentException("Only your own schedule can be requested as fill.");
		}

		Store store = requireStore(storeId);
		LocalDate startDate = parseRequiredDate(applyStartDay, "Invalid applyStartDay format (YYYY-MM-DD).");
		LocalDate endDate = parseRequiredDate(applyEndDay, "Invalid applyEndDay format (YYYY-MM-DD).");
		if (endDate.isBefore(startDate)) {
			throw new IllegalArgumentException("Apply end date must be on or after apply start date.");
		}

		FillPost fill = new FillPost();
		fill.setTitle(normalizeRequiredText(title, "Title is required."));
		fill.setContent(normalizeRequiredText(content, "Content is required."));
		fill.setName(isBlank(loginName) ? schedule.getEmployee_name() : loginName.trim());
		fill.setId(loginId);
		fill.setFill_day(schedule.getWork_date());
		fill.setFill_start_time(normalizeTimeString(schedule.getStart_time()));
		fill.setFill_end_time(normalizeTimeString(schedule.getEnd_time()));
		fill.setFill_di_time(isBlank(schedule.getPart_name()) ? "" : schedule.getPart_name());
		fill.setSchedule_bno(schedule.getBno());
		fill.setCode(store.getStore_code());
		fill.setApply_start_day(startDate.toString());
		fill.setApply_end_day(endDate.toString());
		fill.setChk(FILL_CHK_RECRUITING);
		fill.setApply_su(0);

		if (fillMapper.insertFill(fill) != 1) {
			throw new IllegalArgumentException("Failed to create fill request.");
		}
	}

	@Override
	@Transactional
	public void createDirectFill(String storeId, int memberBno, String loginId, String loginName, String title, String content,
			String fillDay, String startTime, String endTime, Integer partBno, String applyStartDay, String applyEndDay) {
		if (!canManageStore(storeId, memberBno)) {
			throw new IllegalArgumentException("No permission to create direct fill.");
		}
		Store store = requireStore(storeId);

		LocalDate workDate = parseRequiredDate(fillDay, "Invalid work date format (YYYY-MM-DD).");
		LocalDate startDate = parseRequiredDate(applyStartDay, "Invalid applyStartDay format (YYYY-MM-DD).");
		LocalDate endDate = parseRequiredDate(applyEndDay, "Invalid applyEndDay format (YYYY-MM-DD).");
		if (endDate.isBefore(startDate)) {
			throw new IllegalArgumentException("Apply end date must be on or after apply start date.");
		}

		LocalTime parsedStart;
		LocalTime parsedEnd;
		String partLabel = "";
		if (partBno != null) {
			SchedulePart part = fillMapper.findSchedulePartByStoreAndId(storeId, partBno.intValue());
			if (part == null) {
				throw new IllegalArgumentException("Schedule part not found.");
			}
			parsedStart = parseRequiredTime(part.getStart_time(), "Invalid part start time.");
			parsedEnd = parseRequiredTime(part.getEnd_time(), "Invalid part end time.");
			partLabel = part.getPart_name();
		} else {
			parsedStart = parseRequiredTime(startTime, "Start time is required (HH:mm).");
			parsedEnd = parseRequiredTime(endTime, "End time is required (HH:mm).");
		}
		if (!parsedEnd.isAfter(parsedStart)) {
			throw new IllegalArgumentException("End time must be after start time.");
		}

		FillPost fill = new FillPost();
		fill.setTitle(normalizeRequiredText(title, "Title is required."));
		fill.setContent(normalizeRequiredText(content, "Content is required."));
		fill.setName(isBlank(loginName) ? loginId : loginName.trim());
		fill.setId(loginId);
		fill.setFill_day(workDate.toString());
		fill.setFill_start_time(parsedStart.toString().substring(0, 5));
		fill.setFill_end_time(parsedEnd.toString().substring(0, 5));
		fill.setFill_di_time(isBlank(partLabel) ? "" : partLabel);
		fill.setSchedule_bno(0);
		fill.setCode(store.getStore_code());
		fill.setApply_start_day(startDate.toString());
		fill.setApply_end_day(endDate.toString());
		fill.setChk(FILL_CHK_RECRUITING);
		fill.setApply_su(0);

		if (fillMapper.insertFill(fill) != 1) {
			throw new IllegalArgumentException("Failed to create direct fill.");
		}
	}

	@Override
	@Transactional
	public void applyFill(String storeId, int fillBno, int memberBno, String loginId, String loginName) {
		requireStore(storeId);
		fillMapper.deactivateExpiredTemporaryMembers(storeId);
		FillPost fill = requireFill(storeId, fillBno);
		StoreMember storeMember = fillMapper.findApprovedStoreMember(storeId, memberBno);
		boolean directFill = fill.getSchedule_bno() == null || fill.getSchedule_bno().intValue() == 0;
		boolean activeEmployee = storeMember != null && POSITION_EMPLOYEE.equals(storeMember.getPosition());
		if (!activeEmployee && !directFill) {
			throw new IllegalArgumentException("Only active employees can apply.");
		}
		if (storeMember != null && !POSITION_EMPLOYEE.equals(storeMember.getPosition())) {
			throw new IllegalArgumentException("Only employees can apply.");
		}
		if (fill.getChk() == null || fill.getChk().intValue() != FILL_CHK_RECRUITING) {
			throw new IllegalArgumentException("Fill request is not open.");
		}
		if (loginId.equals(fill.getId())) {
			throw new IllegalArgumentException("Cannot apply to your own request.");
		}

		LocalDate today = LocalDate.now();
		LocalDate startDate = parseRequiredDate(fill.getApply_start_day(), "Invalid apply_start_day data.");
		LocalDate endDate = parseRequiredDate(fill.getApply_end_day(), "Invalid apply_end_day data.");
		if (today.isBefore(startDate) || today.isAfter(endDate)) {
			throw new IllegalArgumentException("Apply period is closed.");
		}

		if (fillMapper.countActiveApplyByFillAndId(fillBno, loginId) > 0) {
			throw new IllegalArgumentException("Already applied.");
		}

		FillApply apply = new FillApply();
		apply.setW_name(fill.getName());
		apply.setM_name(isBlank(loginName) ? loginId : loginName.trim());
		apply.setId(loginId);
		apply.setCode(fill.getCode());
		apply.setSchedule_bno(fill.getSchedule_bno());
		apply.setFill_bno(fill.getBno());
		apply.setW_code(fill.getCode());
		apply.setChk(APPLY_CHK_PENDING);
		apply.setResume_bno(0);
		apply.setResume_title(null);

		if (fillMapper.insertFillApply(apply) != 1) {
			throw new IllegalArgumentException("Failed to apply.");
		}
		fillMapper.updateFillApplyCount(fillBno);
	}

	@Override
	@Transactional
	public void cancelMyApply(String storeId, int fillBno, int memberBno, String loginId) {
		requireStoreAndMember(storeId, memberBno);
		requireFill(storeId, fillBno);
		int updated = fillMapper.cancelMyApply(fillBno, loginId);
		if (updated != 1) {
			throw new IllegalArgumentException("No pending apply to cancel.");
		}
		fillMapper.updateFillApplyCount(fillBno);
	}

	@Override
	@Transactional
	public void approveApply(String storeId, int fillBno, int applyBno, int memberBno) {
		if (!canManageStore(storeId, memberBno)) {
			throw new IllegalArgumentException("No approval permission.");
		}
		fillMapper.deactivateExpiredTemporaryMembers(storeId);

		FillPost fill = requireFill(storeId, fillBno);
		if (fill.getChk() == null || fill.getChk().intValue() != FILL_CHK_RECRUITING) {
			throw new IllegalArgumentException("Fill request is not open.");
		}

		FillApply apply = fillMapper.findFillApplyByStore(storeId, fillBno, applyBno);
		if (apply == null) {
			throw new IllegalArgumentException("Apply row not found.");
		}
		if (apply.getChk() == null || apply.getChk().intValue() != APPLY_CHK_PENDING) {
			throw new IllegalArgumentException("Only pending apply can be approved.");
		}

		StoreMember approvedMember = fillMapper.findApprovedStoreMemberByLoginId(storeId, apply.getId());
		boolean directFill = fill.getSchedule_bno() == null || fill.getSchedule_bno().intValue() == 0;
		if (approvedMember == null && directFill) {
			Integer applyMemberBno = fillMapper.findMemberBnoById(apply.getId());
			if (applyMemberBno == null) {
				throw new IllegalArgumentException("Applicant member not found.");
			}
			StoreMember existing = fillMapper.findStoreMemberAny(storeId, applyMemberBno.intValue());
			if (existing == null) {
				int inserted = fillMapper.insertTemporaryStoreMember(storeId, applyMemberBno.intValue());
				if (inserted != 1) {
					throw new IllegalArgumentException("Failed to create temporary store member.");
				}
			} else if (existing.getChk() == null || existing.getChk().intValue() != 1
					|| !POSITION_EMPLOYEE.equals(existing.getPosition())) {
				int promoted = fillMapper.promoteStoreMemberToTemporary(existing.getStore_member_id().intValue());
				if (promoted != 1) {
					throw new IllegalArgumentException("Failed to activate temporary store member.");
				}
			}
			approvedMember = fillMapper.findApprovedStoreMemberByLoginId(storeId, apply.getId());
		}
		if (approvedMember == null || !POSITION_EMPLOYEE.equals(approvedMember.getPosition())) {
			throw new IllegalArgumentException("Approved applicant must be an active employee of this store.");
		}

		LocalDate workDate = parseRequiredDate(fill.getFill_day(), "Invalid fill day data.");
		LocalTime start = parseRequiredTime(fill.getFill_start_time(), "Invalid fill start time.");
		LocalTime end = parseRequiredTime(fill.getFill_end_time(), "Invalid fill end time.");
		if (!end.isAfter(start)) {
			throw new IllegalArgumentException("Invalid fill time range.");
		}

		Integer excludeSchedule = (fill.getSchedule_bno() != null && fill.getSchedule_bno().intValue() > 0)
				? fill.getSchedule_bno()
				: null;
		int overlap = fillMapper.countScheduleOverlapForMember(storeId, approvedMember.getStore_member_id(), workDate.toString(),
				start.toString(), end.toString(), excludeSchedule);
		if (overlap > 0) {
			throw new IllegalArgumentException("Approved employee already has overlapping schedule.");
		}

		if (fill.getSchedule_bno() != null && fill.getSchedule_bno().intValue() > 0) {
			StoreSchedule schedule = fillMapper.findScheduleByStoreAndId(storeId, fill.getSchedule_bno().intValue());
			if (schedule == null) {
				throw new IllegalArgumentException("Source schedule not found.");
			}
			int updated = fillMapper.updateScheduleWorkerForStore(storeId, fill.getSchedule_bno().intValue(),
					approvedMember.getStore_member_id());
			if (updated != 1) {
				throw new IllegalArgumentException("Failed to update source schedule worker.");
			}
		} else {
			Integer partBno = null;
			if (!isBlank(fill.getFill_di_time())) {
				List<SchedulePart> parts = fillMapper.findSchedulePartsByStoreId(storeId);
				for (SchedulePart part : parts) {
					if (fill.getFill_di_time().equals(part.getPart_name())) {
						partBno = part.getBno();
						break;
					}
				}
			}
			int minutes = (int) ChronoUnit.MINUTES.between(start, end);
			int inserted = fillMapper.insertScheduleForFill(approvedMember.getStore_member_id(), workDate.toString(),
					start.toString(), end.toString(), minutes, "Created from fill approval #" + fill.getBno(), partBno);
			if (inserted != 1) {
				throw new IllegalArgumentException("Failed to create schedule from direct fill approval.");
			}
		}

		fillMapper.updateFillApplyStatus(applyBno, APPLY_CHK_APPROVED);
		fillMapper.updateOtherPendingApplyStatus(fillBno, applyBno, APPLY_CHK_REJECTED);
		fillMapper.updateFillStatus(fillBno, FILL_CHK_APPROVED);
		fillMapper.updateFillApplyCount(fillBno);
	}

	@Override
	@Transactional
	public void rejectApply(String storeId, int fillBno, int applyBno, int memberBno) {
		if (!canManageStore(storeId, memberBno)) {
			throw new IllegalArgumentException("No reject permission.");
		}

		requireFill(storeId, fillBno);
		FillApply apply = fillMapper.findFillApplyByStore(storeId, fillBno, applyBno);
		if (apply == null) {
			throw new IllegalArgumentException("Apply row not found.");
		}
		if (apply.getChk() == null || apply.getChk().intValue() != APPLY_CHK_PENDING) {
			throw new IllegalArgumentException("Only pending apply can be rejected.");
		}

		fillMapper.updateFillApplyStatus(applyBno, APPLY_CHK_REJECTED);
		fillMapper.updateFillApplyCount(fillBno);
	}

	@Override
	@Transactional
	public void closeFill(String storeId, int fillBno, int memberBno) {
		if (!canManageStore(storeId, memberBno)) {
			throw new IllegalArgumentException("No close permission.");
		}

		FillPost fill = requireFill(storeId, fillBno);
		if (fill.getChk() == null || fill.getChk().intValue() != FILL_CHK_RECRUITING) {
			throw new IllegalArgumentException("Only recruiting fill can be closed.");
		}
		fillMapper.updateFillStatus(fillBno, FILL_CHK_CLOSED);
	}

	@Override
	@Transactional
	public void cancelFillByRequester(String storeId, int fillBno, int memberBno, String loginId) {
		requireStoreAndMember(storeId, memberBno);
		FillPost fill = requireFill(storeId, fillBno);
		if (!loginId.equals(fill.getId())) {
			throw new IllegalArgumentException("Only requester can cancel.");
		}
		if (fill.getChk() != null && fill.getChk().intValue() == FILL_CHK_APPROVED) {
			throw new IllegalArgumentException("Approved fill cannot be canceled.");
		}
		fillMapper.updateFillStatus(fillBno, FILL_CHK_CANCELED);
		fillMapper.updateOtherPendingApplyStatus(fillBno, -1, APPLY_CHK_REJECTED);
		fillMapper.updateFillApplyCount(fillBno);
	}

	private Store requireStore(String storeId) {
		Store store = fillMapper.findStoreById(storeId);
		if (store == null) {
			throw new IllegalArgumentException("Store not found.");
		}
		return store;
	}

	private void requireStoreAndMember(String storeId, int memberBno) {
		requireStore(storeId);
		requireApprovedMember(storeId, memberBno);
	}

	private StoreMember requireApprovedMember(String storeId, int memberBno) {
		StoreMember storeMember = fillMapper.findApprovedStoreMember(storeId, memberBno);
		if (storeMember == null) {
			throw new IllegalArgumentException("No permission for this store.");
		}
		return storeMember;
	}

	private FillPost requireFill(String storeId, int fillBno) {
		FillPost fill = fillMapper.findFillDetailByStore(storeId, fillBno);
		if (fill == null) {
			throw new IllegalArgumentException("Fill request not found.");
		}
		return fill;
	}

	private String normalizeRequiredText(String value, String message) {
		if (isBlank(value)) {
			throw new IllegalArgumentException(message);
		}
		return value.trim();
	}

	private LocalDate parseRequiredDate(String value, String message) {
		if (isBlank(value)) {
			throw new IllegalArgumentException(message);
		}
		try {
			return LocalDate.parse(value.trim());
		} catch (DateTimeParseException ex) {
			throw new IllegalArgumentException(message);
		}
	}

	private LocalTime parseRequiredTime(String value, String message) {
		if (isBlank(value)) {
			throw new IllegalArgumentException(message);
		}
		String trimmed = value.trim();
		try {
			return LocalTime.parse(trimmed.length() == 5 ? trimmed + ":00" : trimmed);
		} catch (DateTimeParseException ex) {
			throw new IllegalArgumentException(message);
		}
	}

	private String normalizeTimeString(String value) {
		if (isBlank(value)) {
			return "";
		}
		String trimmed = value.trim();
		try {
			String parsed = LocalTime.parse(trimmed.length() == 5 ? trimmed + ":00" : trimmed).toString();
			return parsed.length() >= 5 ? parsed.substring(0, 5) : parsed;
		} catch (DateTimeParseException ex) {
			return trimmed.length() >= 5 ? trimmed.substring(0, 5) : trimmed;
		}
	}

	private boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}
}
