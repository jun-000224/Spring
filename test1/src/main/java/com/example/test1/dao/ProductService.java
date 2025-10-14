package com.example.test1.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {

	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list = productMapper.selectProductList(map);
			List<Menu> menuList = productMapper.selectMenuList(map);
			resultMap.put("list", list);
			resultMap.put("menuList", menuList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			e.printStackTrace();
		}
		
		return resultMap;
	}

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Menu> menuList = productMapper.selectMenuList(map);
			resultMap.put("menuList", menuList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getFood(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product food = productMapper.selectFood(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	
}