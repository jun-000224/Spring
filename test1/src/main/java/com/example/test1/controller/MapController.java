package com.example.test1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {

	
	@RequestMapping("/map.do") 
    public String map1(Model model) throws Exception{ 
		System.out.println("호출 체크용");
        return "/map/map1";
       
    }
	
	
	@RequestMapping("/map2.do")
	public String map2(Model model) throws Exception{
		System.out.println("map2 호출 체크용");
		return "/map/map2";
	}
	
	
	
	
	
}
