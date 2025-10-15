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
	
	@RequestMapping("/member/join.do") 
    public String join(Model model) throws Exception{ 
		
        return "/member/member-join";
    }
	
	@RequestMapping("/mgr/member/list.do") 
    public String mgr(Model model) throws Exception{ 
		
        return "/mgr/member-list";
    }
	
	@RequestMapping("/mgr/member/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{ 
		
		request.setAttribute("userId", map.get("userId"));
        return "/mgr/member-view";
    }
	
	@RequestMapping("/addr.do") 
    public String addr(Model model) throws Exception{ 
		
        return "/jusoPopup";
    }
	
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.login(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.check(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.logout(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberInsert(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/mgr/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.getMemberList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/mgr/remove-cnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.removeCnt(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping("/member/pwd.do") 
    public String pwd(Model model) throws Exception{ 
		
        return "/member/pwd";
    }
	
	
	@RequestMapping(value = "/member/auth.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String auth(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println("Controller로 넘어온 데이터 : " + map);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.checkMember(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/updatePwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String update(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.updatePwd(map);
		
		return new Gson().toJson(resultMap);
	}
}