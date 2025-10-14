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

	// 메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);

	// 메뉴(제품) 추가
	int insertMenu(HashMap<String, Object> map);

	// 제품 이미지 추가 (새로 추가된 메소드)
	void insertFoodImage(HashMap<String, Object> map);

	// 제품 상세 정보 조회
	Product selectFood(HashMap<String, Object> map);
}