package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StuMapper {
	Student stuInfo(HashMap<String, Object> map);
	List<Student> stuList(HashMap<String, Object> map);
}




