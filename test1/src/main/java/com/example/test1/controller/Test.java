package com.example.test1.controller;

import java.util.Random;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//랜덤한 숫자 6자리(0~9)
		//radom(10)
		
		 Random ran = new Random();
	        
	        int firstNum = ran.nextInt(9) + 1;
	        
	        String remainNum = "";
	        
	        for (int i = 0; i < 5; i++) {
	            remainNum += ran.nextInt(10);
	        }
	        
	        String finalNumber = firstNum + remainNum;
	        
	        System.out.println("생성된 6자리 랜덤 숫자: " + finalNumber);
	    }

}
