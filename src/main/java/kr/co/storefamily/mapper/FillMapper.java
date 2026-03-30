package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.FillApply;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

@Mapper
public interface FillMapper {
	Integer findMemberBnoById(@Param("id") String id);
	Store findStoreById(@Param("storeId") String storeId);
	StoreMember findApprovedStoreMember(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	String findFirstAccessibleStoreId(@Param("memberBno") int memberBno);

	StoreSchedule findScheduleForFillCreate(@Param("storeId") String storeId, @Param("scheduleBno") int scheduleBno,
			@Param("memberBno") int memberBno);

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
}
