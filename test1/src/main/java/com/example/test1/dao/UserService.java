package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;

	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		User user = userMapper.userLogin(map);
		if(user != null) {
			System.out.println(user.getName());
			System.out.println(user.getNickName());
		}
		
		resultMap.put("info",user);
		resultMap.put("result", "success");
		return resultMap;
	}

	// 회원 정보 추가 서비스
	public HashMap<String, Object> addUser(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			userMapper.insertUser(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	// 프로필 이미지 추가 서비스
	public void addProfileImg(HashMap<String, Object> map) {
		userMapper.insertProfileImg(map);
	}
}