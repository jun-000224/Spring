package com.example.test1.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;

	@RequestMapping("/product.do")
	public String product(Model model) throws Exception {
		return "/product";
	}

	@RequestMapping("/product/add.do")
	public String add(Model model) throws Exception {
		return "/product-add";
	}

	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductList(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/product/menu.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String menu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getMenuList(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addMenu(Model model, @RequestParam HashMap<String, Object> map,
			@RequestParam("file1") MultipartFile file) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.addMenu(map, file);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping("/product/view.do")
	public String view(Model model, @RequestParam("foodNo") String foodNo) throws Exception {
		request.setAttribute("foodNo", foodNo);
		return "/product-view";
	}

	@RequestMapping(value = "/product/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getProductData(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = productService.getFood(map);
		return new Gson().toJson(resultMap);
	}
}