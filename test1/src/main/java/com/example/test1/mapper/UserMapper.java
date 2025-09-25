package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.User;

@Mapper  //디비로 연결하는 애는 상단에 꼭 Mapper가 붙어야 합니다. 
public interface UserMapper {
	
	User userLogin(HashMap<String, Object> map);
	
	
}