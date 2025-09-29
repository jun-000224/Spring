package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.google.gson.Gson;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;

	@RequestMapping("/member/login.do") 
    public String login(Model model) throws Exception{ 
		
        return "/member/member-login";
    }
	
	//회원가입 페이지(join)
	@RequestMapping("/member/join.do") 
    public String join(Model model) throws Exception{ 
		
        return "/member/member-join";
    }
	
	
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.login(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		
		resultMap = memberService.check(map);
		return new Gson().toJson(resultMap);
	}
	
	//로그아웃
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.logout(map);
		
		return new Gson().toJson(resultMap);
	}
	
	//주소
		@RequestMapping("/addr.do") 
	    public String addr(Model model) throws Exception{ 
			
	        return "/jusoPopup";
	    }
	

}