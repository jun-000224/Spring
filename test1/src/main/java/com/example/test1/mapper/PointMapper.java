package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Point;

@Mapper
public interface PointMapper {
	List<Point> selectPointList(HashMap<String, Object> map);
}