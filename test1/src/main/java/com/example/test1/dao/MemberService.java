package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session; //스프링에서 세션을 관리하는 클래스(약속임)
	
	public HashMap<String, Object> login(HashMap<String, Object> map){
		 HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.memberLogin(map);
		String message = member != null ? "로그인 성공!" : "로그인 실패!";
		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
		
	}

	public HashMap<String, Object> check(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.memberCheck(map);
		String result = member != null ? "true" : "false";
		
		resultMap.put("result", result);
		
		return resultMap;
	}

	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//세션정보 삭제하는 방법은
		//1개씩 키값을 이용해 삭제하거나, 전체를 한 번에 삭제 하는 방법
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);
		
//		session.removeAttribute("sessionId"); //1개씩 삭제
		session.invalidate(); //세션정보 전체 삭제
		
		
		return resultMap;
	}
	
}
