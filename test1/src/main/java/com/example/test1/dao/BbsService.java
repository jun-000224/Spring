package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;

@Service
public class BbsService {
	
	@Autowired
	BbsMapper bbsMapper;
	
	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Bbs> list = bbsMapper.selectBbsList(map);
		
		resultMap.put("list", list); //리스트에 list를 담아서 넘김
		resultMap.put("result", "success");
		return resultMap;
		
	}
	
	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = bbsMapper.insertBbs(map); 
		
		resultMap.put("bss_num", map.get("bssNum"));
		resultMap.put("result", "success");
		return resultMap;
		
	}

	public HashMap<String, Object> removeBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = bbsMapper.deleteBbs(map); 
		
		resultMap.put("result", "success");
		return resultMap;
		
	}

}
