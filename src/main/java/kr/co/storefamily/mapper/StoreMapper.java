package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreEmployee;
import kr.co.storefamily.model.StoreJoinRequest;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

@Mapper
public interface StoreMapper {
	Integer findMemberBnoById(String id);
	int countStoreId(String storeId);
	int countStoreCode(String storeCode);
	int insertStore(Store store);
	int insertStoreMember(StoreMember storeMember);
	List<Store> findStoresByCeoBno(int ceoBno);
	Store findStoreById(String storeId);
	Store findStoreByIdAndCeoBno(@Param("storeId") String storeId, @Param("ceoBno") int ceoBno);
	Store findStoreByStoreCode(String storeCode);
	StoreMember findStoreMember(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	List<StoreJoinRequest> findPendingJoinRequestsByStoreId(String storeId);
	int countPendingJoinRequestsByStoreId(String storeId);
	int approveStoreMember(@Param("storeMemberId") int storeMemberId, @Param("storeId") String storeId);
	int rejectStoreMember(@Param("storeMemberId") int storeMemberId, @Param("storeId") String storeId);
	List<StoreEmployee> findApprovedEmployeesByStoreId(String storeId);
	int countApprovedEmployeesByStoreId(String storeId);
	StoreEmployee findEmployeeDetail(@Param("storeId") String storeId, @Param("storeMemberId") int storeMemberId);
	StoreEmployee findEmployeeDetailByStoreAndMember(@Param("storeId") String storeId, @Param("memberBno") int memberBno);
	int updateEmployeeWorkInfo(@Param("storeId") String storeId, @Param("memberBno") int memberBno,
			@Param("employment") String employment, @Param("health") String health, @Param("rate") String rate);
	List<StoreSchedule> findSchedulesByStoreAndMonth(@Param("storeId") String storeId, @Param("monthStart") String monthStart,
			@Param("monthEnd") String monthEnd);
	List<StoreSchedule> findSchedulesByStoreAndDate(@Param("storeId") String storeId, @Param("workDate") String workDate);
	StoreSchedule findScheduleByStoreAndId(@Param("storeId") String storeId, @Param("scheduleId") int scheduleId);
	int insertScheduleForStore(@Param("storeId") String storeId, @Param("storeEmployeeBno") int storeEmployeeBno,
			@Param("workDate") String workDate, @Param("startTime") String startTime, @Param("endTime") String endTime,
			@Param("workMinutes") int workMinutes, @Param("status") String status, @Param("memo") String memo);
	int updateScheduleForStore(@Param("storeId") String storeId, @Param("scheduleId") int scheduleId,
			@Param("storeEmployeeBno") int storeEmployeeBno, @Param("workDate") String workDate,
			@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("workMinutes") int workMinutes,
			@Param("status") String status, @Param("memo") String memo);
	int deleteScheduleForStore(@Param("storeId") String storeId, @Param("scheduleId") int scheduleId);
}
