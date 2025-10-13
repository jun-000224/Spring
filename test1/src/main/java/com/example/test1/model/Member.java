package com.example.test1.model;

import lombok.Data;

@Data
public class Member {
	private String userId;
	private String password;
	private String name;
	private String birth;
	private String nickName;
	private String status;
	private int cnt;
	private String gender;
	private String cBirth;
}