package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Board;

@Mapper
public interface BbsMapper {
	
	//리스트 매핑
	List<Bbs> selectBbsList(HashMap<String, Object> map);
	
	//게시글 추가 
	int insertBbs(HashMap<String, Object> map);
	
	//게시글 삭제
	int deleteBbs(HashMap<String, Object> map);
}
