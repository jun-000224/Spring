package com.example.test1.dao; // service 패키지에 위치

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; // @Service 어노테이션 사용
import com.example.test1.mapper.StuMapper;
import com.example.test1.model.Student;

@Service // Service 역할 명시
public class StuService {

    @Autowired
    StuMapper stuMapper; // Mapper를 주입받음

    public HashMap<String, Object> stuInfo(HashMap<String, Object> map) {
        HashMap<String, Object> resultMap = new HashMap<>();
        Student student = stuMapper.selectStudentInfo(map);
        resultMap.put("student", student);
        return resultMap;
    }

    public HashMap<String, Object> getStuList(HashMap<String, Object> map) {
        HashMap<String, Object> resultMap = new HashMap<>();
        List<Student> list = stuMapper.selectStudentList(map);
        resultMap.put("list", list);
        return resultMap;
    }
}