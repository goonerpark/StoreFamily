package kr.co.storefamily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreEmployee;
import kr.co.storefamily.model.StoreJoinRequest;
import kr.co.storefamily.model.StoreMember;

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
}
