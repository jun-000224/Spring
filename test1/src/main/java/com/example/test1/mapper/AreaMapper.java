package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;


@Mapper
public interface AreaMapper {

	// 게시글 목록
	List<Area> selectAreaList(HashMap<String, Object> map);
	
	//카운트 
	int selectAreaCount(HashMap<String, Object> map);
	
	//시/도 리스트
	List<Area> selectSiList(HashMap<String, Object> map);
}

