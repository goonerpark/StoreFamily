package kr.co.storefamily.service;

import java.util.List;

import kr.co.storefamily.model.FillApply;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.SchedulePart;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

public interface FillService {
	int getLoginMemberBno(String loginId);
	String findDefaultStoreId(int memberBno);
	Store findStore(String storeId);
	StoreMember findApprovedStoreMember(String storeId, int memberBno);
	boolean canManageStore(String storeId, int memberBno);

	List<FillPost> getStoreFillList(String storeId);
	FillPost getStoreFillDetail(String storeId, int fillBno);
	List<FillApply> getFillApplyList(int fillBno);
	StoreSchedule getScheduleForFillCreate(String storeId, int scheduleBno, int memberBno);
	List<SchedulePart> getScheduleParts(String storeId);

	void createFill(String storeId, int scheduleBno, int memberBno, String loginId, String loginName,
			String title, String content, String applyStartDay, String applyEndDay);
	void createDirectFill(String storeId, int memberBno, String loginId, String loginName, String title, String content,
			String fillDay, String startTime, String endTime, Integer partBno, String applyStartDay, String applyEndDay);
	void applyFill(String storeId, int fillBno, int memberBno, String loginId, String loginName);
	void cancelMyApply(String storeId, int fillBno, int memberBno, String loginId);
	void approveApply(String storeId, int fillBno, int applyBno, int memberBno);
	void rejectApply(String storeId, int fillBno, int applyBno, int memberBno);
	void closeFill(String storeId, int fillBno, int memberBno);
	void cancelFillByRequester(String storeId, int fillBno, int memberBno, String loginId);
}
