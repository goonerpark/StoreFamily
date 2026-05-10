package kr.co.storefamily.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import kr.co.storefamily.mapper.FillMapper;
import kr.co.storefamily.model.FillPost;
import kr.co.storefamily.model.Store;
import kr.co.storefamily.model.StoreMember;
import kr.co.storefamily.model.StoreSchedule;

class FillServiceImplTest {

	private FillMapper fillMapper;
	private FillServiceImpl fillService;

	@BeforeEach
	void setUp() {
		fillMapper = mock(FillMapper.class);
		fillService = new FillServiceImpl();
		ReflectionTestUtils.setField(fillService, "fillMapper", fillMapper);
	}

	@Test
	void createFillRejectsDuplicateOpenRequestForSchedule() {
		Store store = new Store();
		store.setStore_id("store-1");
		store.setStore_code("SF-1");

		StoreMember member = new StoreMember();
		member.setStore_id("store-1");
		member.setMember_bno(10);
		member.setPosition("직원");
		member.setChk(1);

		StoreSchedule schedule = new StoreSchedule();
		schedule.setBno(100);
		schedule.setWork_date("2026-05-20");
		schedule.setStart_time("09:00");
		schedule.setEnd_time("14:00");
		schedule.setEmployee_name("김직원");

		when(fillMapper.findStoreById("store-1")).thenReturn(store);
		when(fillMapper.findApprovedStoreMember("store-1", 10)).thenReturn(member);
		when(fillMapper.findScheduleForFillCreate("store-1", 100, 10)).thenReturn(schedule);
		when(fillMapper.countOpenFillBySchedule("store-1", 100)).thenReturn(1);

		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
				() -> fillService.createFill("store-1", 100, 10, "employee1", "김직원", "대타 요청", "개인 일정",
						"2026-05-10", "2026-05-15"));

		assertEquals("This schedule already has an active fill request.", ex.getMessage());
	}

	@Test
	void acceptFillRejectsRequesterSelfAccept() {
		Store store = new Store();
		store.setStore_id("store-1");
		store.setStore_code("SF-1");

		StoreMember member = new StoreMember();
		member.setStore_id("store-1");
		member.setMember_bno(10);
		member.setPosition("직원");
		member.setChk(1);

		FillPost fill = new FillPost();
		fill.setBno(1);
		fill.setId("employee1");
		fill.setName("김직원");
		fill.setChk(0);
		fill.setApply_start_day("2026-05-01");
		fill.setApply_end_day("2026-05-31");

		when(fillMapper.findStoreById("store-1")).thenReturn(store);
		when(fillMapper.findFillDetailByStore("store-1", 1)).thenReturn(fill);
		when(fillMapper.findApprovedStoreMember("store-1", 10)).thenReturn(member);

		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
				() -> fillService.acceptFill("store-1", 1, 10, "employee1", "김직원"));

		assertEquals("Cannot accept your own fill request.", ex.getMessage());
	}

	@Test
	void cancelFillRejectsClosedRequest() {
		Store store = new Store();
		store.setStore_id("store-1");
		store.setStore_code("SF-1");

		StoreMember member = new StoreMember();
		member.setStore_id("store-1");
		member.setMember_bno(10);
		member.setPosition("직원");
		member.setChk(1);

		FillPost fill = new FillPost();
		fill.setBno(1);
		fill.setId("employee1");
		fill.setChk(2);

		when(fillMapper.findStoreById("store-1")).thenReturn(store);
		when(fillMapper.findApprovedStoreMember("store-1", 10)).thenReturn(member);
		when(fillMapper.findFillDetailByStore("store-1", 1)).thenReturn(fill);

		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
				() -> fillService.cancelFillByRequester("store-1", 1, 10, "employee1"));

		assertEquals("Only open fill requests can be canceled.", ex.getMessage());
	}

	@Test
	void acceptFillRejectsBlankLoginId() {
		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
				() -> fillService.acceptFill("store-1", 1, 10, " ", "김직원"));

		assertEquals("Login required.", ex.getMessage());
	}
}
