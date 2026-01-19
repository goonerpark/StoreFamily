package kr.co.storefamily.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.storefamily.model.Member;

@Mapper
public interface LoginMapper {

	Member getLogin(@Param("id")String id, @Param("pwd")String pwd);
	Member getStore(@Param("code")String code, @Param("id")String id);

}
