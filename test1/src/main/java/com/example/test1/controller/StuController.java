package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.StuService;
import com.google.gson.Gson;

@Controller
public class StuController {
	
	@Autowired
	StuService stuService;
	
	@RequestMapping("/stu-list.do") 
    public String login(Model model) throws Exception{ 
		
        return "/stu-list";
    }
	
	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = stuService.stuInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStuList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.removeStudent(map);
		
		return new Gson().toJson(resultMap);
	}
	
	//view이동 컨트롤러
	@RequestMapping("/stu-view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{ 
		System.out.println(map);
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-view";
    }
	
	
	//view내부 데이터 컨트롤러
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStudent(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
}