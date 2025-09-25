package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.StuController;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

@Service
public class UserService {

    private final StuController stuController;
	
	@Autowired
	UserMapper userMapper;

    UserService(StuController stuController) {
        this.stuController = stuController;
    }
	
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		User user = userMapper.userLogin(map);
		if(user != null) {
			System.out.println(user.getName());
			System.out.println(user.getNickName());
		}
		
		resultMap.put("info",user);
		resultMap.put("result", "successs");
		
		return resultMap;
	}
	
	
	
}