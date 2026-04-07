package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.FillApply;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.SchedulePart;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

@Mapper
public interface FillMapper {
	Integer findMemberBnoById(@Param("id") String id);
	Store findStoreById(@Param("storeId") String storeId);
	StoreMember findApprovedStoreMember(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	StoreMember findApprovedStoreMemberByLoginId(@Param("storeId") String storeId, @Param("loginId") String loginId);
	StoreMember findStoreMemberAny(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	String findFirstAccessibleStoreId(@Param("memberBno") int memberBno);

	StoreSchedule findScheduleForFillCreate(@Param("storeId") String storeId, @Param("scheduleBno") int scheduleBno,
			@Param("memberBno") int memberBno);
	StoreSchedule findScheduleByStoreAndId(@Param("storeId") String storeId, @Param("scheduleBno") int scheduleBno);

	List<SchedulePart> findSchedulePartsByStoreId(@Param("storeId") String storeId);
	SchedulePart findSchedulePartByStoreAndId(@Param("storeId") String storeId, @Param("partBno") int partBno);

	FillPost findFillDetailByStore(@Param("storeId") String storeId, @Param("fillBno") int fillBno);
	List<FillPost> findFillListByStore(@Param("storeId") String storeId);
	List<FillApply> findFillApplyList(@Param("fillBno") int fillBno);

	int insertFill(FillPost fill);
	int insertFillApply(FillApply fillApply);

	int countActiveApplyByFillAndId(@Param("fillBno") int fillBno, @Param("id") String id);
	FillApply findMyApplyByFillAndId(@Param("fillBno") int fillBno, @Param("id") String id);
	FillApply findFillApplyByStore(@Param("storeId") String storeId, @Param("fillBno") int fillBno, @Param("applyBno") int applyBno);

	int updateFillApplyCount(@Param("fillBno") int fillBno);
	int updateFillStatus(@Param("fillBno") int fillBno, @Param("chk") int chk);
	int updateFillApplyStatus(@Param("applyBno") int applyBno, @Param("chk") int chk);
	int updateOtherPendingApplyStatus(@Param("fillBno") int fillBno, @Param("winnerApplyBno") int winnerApplyBno,
			@Param("chk") int chk);
	int cancelMyApply(@Param("fillBno") int fillBno, @Param("id") String id);
	int insertTemporaryStoreMember(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	int promoteStoreMemberToTemporary(@Param("storeMemberId") int storeMemberId);
	int deactivateExpiredTemporaryMembers(@Param("storeId") String storeId);

	int countScheduleOverlapForMember(@Param("storeId") String storeId, @Param("storeMemberId") int storeMemberId,
			@Param("workDate") String workDate, @Param("startTime") String startTime, @Param("endTime") String endTime,
			@Param("excludeScheduleBno") Integer excludeScheduleBno);
	int updateScheduleWorkerForStore(@Param("storeId") String storeId, @Param("scheduleBno") int scheduleBno,
			@Param("storeMemberId") int storeMemberId);
	int insertScheduleForFill(@Param("storeMemberId") int storeMemberId, @Param("workDate") String workDate,
			@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("workMinutes") int workMinutes,
			@Param("memo") String memo, @Param("partBno") Integer partBno);
}
