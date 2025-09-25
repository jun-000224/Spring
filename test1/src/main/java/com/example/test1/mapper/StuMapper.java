package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper //매퍼는 클래스가 아니라 인터페이스다. 임플리먼트로 구체화해야하는 xml에서 구체화.(매퍼라는 언옵테이션)
public interface StuMapper {
	Student stuInfo(HashMap<String, Object> map);
}