package com.example.test1.model;

import lombok.Data;

@Data
public class Menu {
	private int menuNo;
	private String menuName;
	private int menuPart;
	private int depth;
	private int cnt;
}