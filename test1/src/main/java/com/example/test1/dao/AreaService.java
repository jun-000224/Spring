package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;
import com.example.test1.model.Area;

@Service
public class AreaService {
	
	@Autowired
	AreaMapper areaMapper;

	public HashMap<String, Object> getAreaList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> list = areaMapper.selectAreaList(map);
		int cnt = areaMapper.selectAreaCount(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
		
	}
	
	//시 리스트 서비스
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> list = areaMapper.selectSiList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
		
	}

}
