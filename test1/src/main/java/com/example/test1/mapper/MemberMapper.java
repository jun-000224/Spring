package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	// 로그인
	Member memberLogin(HashMap<String, Object> map);
	
	// 아이디 체크
	Member memberCheck(HashMap<String, Object> map);
	
	// 가입
	int memberAdd(HashMap<String, Object> map);
	
	// 회원 목록(관리자)
	List<Member> selectMemberList(HashMap<String, Object> map);
	
	// 로그인 성공 시 cnt 초기화
	int cntInit(HashMap<String, Object> map);
	
	// 로그인 실패 시 cnt 1증가
	int cntIncrease(HashMap<String, Object> map);
	
	// 가입
	Member authMember(HashMap<String, Object> map);
	
	//비번 변경
	int updatePassword(HashMap<String, Object> map);
	
}

