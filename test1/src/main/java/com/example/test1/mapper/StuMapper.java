package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StuMapper {
	Student stuInfo(HashMap<String, Object> map);
	List<Student> stuList(HashMap<String, Object> map);
	
	// 학생 삭제
	int deleteStudent(HashMap<String, Object> map);
	
	//학생 상세정보 조회
	Student selectStudent(HashMap<String, Object> map);
	
	
}




