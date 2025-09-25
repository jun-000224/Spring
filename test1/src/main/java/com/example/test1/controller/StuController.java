package com.example.test1.controller;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.test1.dao.StuService; // service 패키지를 바라보도록 수정
import com.google.gson.Gson;

@Controller
public class StuController {

    @Autowired
    StuService stuService; // Service를 주입받음

    @RequestMapping("/stu-list.do")
    public String showStudentListPage() {
        return "/stu-list";
    }

    @RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String getStudentInfo(@RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = stuService.stuInfo(map); // Service의 메소드 호출
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String getStudentList(@RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = stuService.getStuList(map); // Service의 메소드 호출
        return new Gson().toJson(resultMap);
    }
}