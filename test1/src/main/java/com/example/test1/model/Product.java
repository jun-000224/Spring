package com.example.test1.model;

import lombok.Data;

@Data
public class Product {
	private int foodNo;
	private String foodName;
	private int price;
	private String foodKind;
	private String foodInfo;
	private String sellYn;
	private String filePath;
	private String fileName;
	private String thumbnailYn;
}
