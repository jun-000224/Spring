package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

	@Autowired
	PasswordEncoder passwordEncoder;
	
	public HashMap<String, Object> login(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String rawPassword = (String) map.get("pwd");
		Member member = memberMapper.memberCheck(map);
		
		String message = "";
		String result = "fail";

		if(member != null) {
			if(member.getCnt() >= 5 ) {
				message = "비밀번호를 5회 이상 잘못 입력하여 계정이 잠겼습니다.";
			} else { 
				String encodedPassword = member.getPassword();
				boolean isMatch = passwordEncoder.matches(rawPassword, encodedPassword);
				
				if(isMatch) {
					memberMapper.cntInit(map);
					message = "로그인 성공!";
					result = "success";
					session.setAttribute("sessionId", member.getUserId());
					session.setAttribute("sessionName", member.getName());
					session.setAttribute("sessionStatus", member.getStatus());
					if(member.getStatus().equals("A")) {
						resultMap.put("url", "/mgr/member/list.do");
					} else {
						resultMap.put("url", "/main.do");
					}
				} else {
					memberMapper.cntIncrease(map);
					message = "패스워드를 확인해주세요.";		
				}
			}
		} else {
			message = "아이디가 존재하지 않습니다.";
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	public HashMap<String, Object> check(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.memberCheck(map);
		
		String result = member != null ? "true" : "false";
		resultMap.put("result", result);
		
		return resultMap;
	}

	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);
		session.invalidate();
		return resultMap;
	}
	
	public HashMap<String, Object> memberInsert(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		String rawPassword = (String) map.get("pwd");
		String encodedPassword = passwordEncoder.encode(rawPassword);
		map.put("pwd", encodedPassword);

		int cnt = memberMapper.memberAdd(map);
		if(cnt < 1) {
			resultMap.put("result", "fail");
		} else {
			resultMap.put("result", "success");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getMemberList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Member> list =  memberMapper.selectMemberList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> removeCnt(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			memberMapper.cntInit(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	
	public HashMap<String, Object> checkMember(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Member member = memberMapper.authMember(map);
		
		if(member != null) {
			resultMap.put("result", "success");
			resultMap.put("msg", "인증에 성공했습니다.");
		}else {
			resultMap.put("result", "fail");
			resultMap.put("msg", "회원정보가 없습니다. 가입을 진행해주세요");
		}
		return resultMap;
	}


	/**
	 * 비밀번호를 변경하는 메소드.
	 * 1. 현재 사용자 정보를 DB에서 조회.
	 * 2. 새 비밀번호가 현재 비밀번호와 동일한지 비교.
	 * 3. 동일하지 않을 경우에만 암호화하여 DB 업데이트.
	 */
	public HashMap<String, Object> updatePwd(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<>();
		
		String rawPassword = (String) map.get("pwd");

		// 비밀번호 값이 비어있는지 확인
		if (rawPassword == null || rawPassword.trim().isEmpty()) {
			resultMap.put("result", "fail");
			resultMap.put("msg", "새 비밀번호를 입력해주세요.");
			return resultMap;
		}

		// 1. DB에서 현재 사용자 정보를 가져옴 (기존 memberCheck 재활용)
		//    이 로직이 제대로 동작하려면 map에 'userId'가 반드시 포함되어야 함!
		Member member = memberMapper.memberCheck(map);
		
		if (member == null) {
			resultMap.put("result", "fail");
			resultMap.put("msg", "사용자 정보가 존재하지 않습니다.");
			return resultMap;
		}

		// 2. 새 비밀번호가 현재 비밀번호와 동일한지 비교
		String oldEncodedPassword = member.getPassword();
		if (passwordEncoder.matches(rawPassword, oldEncodedPassword)) {
			// 비밀번호가 같으면 실패 처리하고 함수 종료
			resultMap.put("result", "fail");
			resultMap.put("msg", "현재 비밀번호와 동일한 비밀번호로는 변경할 수 없습니다.");
			return resultMap;
		}
		
		// 3. (비밀번호가 다른 경우) 암호화 및 DB 업데이트 진행
		String encodedPassword = passwordEncoder.encode(rawPassword);
		map.put("pwd", encodedPassword);
		
		try {
			int cnt = memberMapper.updatePassword(map);
			
			if(cnt > 0) {
				resultMap.put("result", "success");
				resultMap.put("msg", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
			} else {
				resultMap.put("result", "fail");
				resultMap.put("msg", "비밀번호 변경에 실패했습니다. 사용자 정보를 확인해주세요.");
			}
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("msg", "비밀번호 변경 중 오류가 발생했습니다.");
		}
		
		return resultMap;
	}
}