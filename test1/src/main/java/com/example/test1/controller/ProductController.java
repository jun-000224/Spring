package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.ProductService;
import com.example.test1.model.Menu; // Menu 모델 import
import com.google.gson.Gson;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;
	
	@RequestMapping("/product.do") 
    public String product(Model model) throws Exception{
        return "/product"; // 상품 목록 페이지
    }

	@RequestMapping("/product-add.do") 
    public String productAddPage(Model model) throws Exception{
        return "/product-add"; 
    }
	
	// 상품 목록과 메뉴 목록을 가져오는 요청
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		// ✨ [수정] HashMap의 타입을 <String, Object>로 통일했습니다.
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.addProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/product/getPrimaryMenus.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getPrimaryMenus(Model model) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Menu> menuList = productService.getPrimaryMenuList();
		resultMap.put("menuList", menuList);
		return new Gson().toJson(resultMap);
	}
}