package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.stuController;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

@Service
public class UserService{
	
	
	@Autowired
	UserMapper userMapper;
	
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service=>" + map);
		User user = userMapper.userLogin(map);
		if(user != null) {
			System.out.println(user.getName());
			System.out.println(user.getNickName());
		}
		return resultMap;
	}
}
