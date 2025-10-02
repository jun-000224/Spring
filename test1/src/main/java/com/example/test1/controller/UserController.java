package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.BoardService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@Autowired
	BoardService boardService; // 게시판 파일 업로드를 위해 필요

	@RequestMapping("/login.do") 
	public String login(Model model) throws Exception{ 
		return "/login"; 
	}
	
	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userLogin(map);
		return new Gson().toJson(resultMap);
	}

	// 회원가입 요청 처리 (1단계: 텍스트 정보만)
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = userService.addUser(map);
		// 성공 시 userId를 다시 보내주어 파일 업로드에 사용하게 함
		if ("success".equals(resultMap.get("result"))) {
			resultMap.put("userId", map.get("id"));
		}
		return new Gson().toJson(resultMap);
	}

	// 프로필 이미지 업로드 처리 (2단계: 파일 정보만)
	@RequestMapping(value = "/profileUpload.dox", method = RequestMethod.POST)
	@ResponseBody
	public String profileUpload(@RequestParam("file1") MultipartFile multi, @RequestParam("userId") String userId) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			// 웹 접근이 가능한 경로에 저장
			String path2 = System.getProperty("user.dir");
			String savePath = path2 + "\\src\\main\\webapp\\img\\profile";

			// 저장 폴더가 없으면 생성
			File saveFolder = new File(savePath);
			if (!saveFolder.exists()){
				saveFolder.mkdirs();
			}

			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."));
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);
			
			if(!multi.isEmpty()) {
				File file = new File(savePath, saveFileName);
				multi.transferTo(file);
				
				HashMap<String, Object> map = new HashMap<>();
				map.put("fileName", saveFileName);
				map.put("path", "/img/profile/" + saveFileName); // 웹에서 접근할 경로
				map.put("userId", userId);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);
				
				// DB에 파일 정보 저장
				userService.addProfileImg(map);
				
				resultMap.put("result", "success");
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return new Gson().toJson(resultMap);
	}

	// 기존 게시판 파일 업로드 메소드 (BoardService 사용)
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model) {
		String path="c:\\img";
		try {
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);
			
			String path2 = System.getProperty("user.dir");
			if(!multi.isEmpty()) {
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
				multi.transferTo(file);
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("fileName", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("boardNo", boardNo);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);
				
				// BoardService의 메소드를 호출해야 함
				boardService.addBoardImg(map);
				
				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				
				return "redirect:list.do";
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}
	
	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}
}