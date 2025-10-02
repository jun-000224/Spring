package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {
	// 지역 전체 목록
	List<Area> selectAreaList(HashMap<String, Object> map);
	
	// 지역 전체 개수
	int selectAreaCnt(HashMap<String, Object> map);
	
	// 시/도 리스트
	List<Area> selectSiList(HashMap<String, Object> map);
	
	// 구 리스트
	List<Area> selectGuList(HashMap<String, Object> map);
	
}



