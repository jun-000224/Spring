package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BbsService;
import com.google.gson.Gson;

@Controller
public class BbsController {
	
	@Autowired
	BbsService bbsService; //인스턴스를 통해서 메소드 호출
	
	//bbs-list 반환 후 이동하는 주소
		@RequestMapping("/bbs/list.do") 
	    public String login(Model model) throws Exception{ 
			System.out.println("리스트 들어옴 체크");
			
	        return "/bbs/list";
	    }
	
	
	@RequestMapping(value = "/bbs/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getBbsList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
		@RequestMapping("/bbs/add.do")
		public String addPage(Model model, HttpSession session) throws Exception{
			return "/bbs/add";
		}
		
		@RequestMapping(value = "/bbs/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String addBbs(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object>resultMap = bbsService.addBbs(map);
			
			return new Gson().toJson(resultMap);
		}
		
		
		@RequestMapping(value = "/bbs/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String bbsRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = bbsService.removeBbs(map);
			
			return new Gson().toJson(resultMap);
		}
		
		
		@RequestMapping("/bbs/update.do")
		public String updatePage(Model model, HttpSession session) throws Exception{
			return "/bbs/update";
		}
	

}
