package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

	public HashMap<String, Object> addProduct(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// 1. TBL_FOOD에 상품 정보 추가
			productMapper.insertProduct(map); 

			productMapper.insertProductImage(map); 
			

			resultMap.put("foodNo", map.get("foodNo")); 
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public List<Menu> getPrimaryMenuList() {
		return productMapper.selectPrimaryMenuList();
	}
}