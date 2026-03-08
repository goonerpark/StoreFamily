package kr.co.storefamily.repository;

import kr.co.storefamily.model.Member;

public interface LoginRepository {

	Member findLoginMember(String id, String pwd);

	Member findLatestStoreByCeoBno(int ceoBno);
}
