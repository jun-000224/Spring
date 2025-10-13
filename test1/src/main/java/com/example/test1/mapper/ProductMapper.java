package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	
	// 제품 목록
	List<Product> selectProductList(HashMap<String, Object> map);
	
	//메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);
	
	//  상품 추가
	int insertProduct(HashMap<String, Object> map);
	
	//  상품 이미지 추가
	int insertProductImage(HashMap<String, Object> map);
	
	//  depth=1인 메뉴 목록 조회
	List<Menu> selectPrimaryMenuList();
}