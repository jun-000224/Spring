package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardMapper.selectBoardList(map);
		
		int cnt = boardMapper.selectBoardCnt(map);
		
		resultMap.put("cnt", cnt);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
		
	}
	
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.deleteBoard(map);
		
		resultMap.put("result", "success");
		return resultMap;
		
	}

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.insertBoard(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	
	
	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = boardMapper.updateCnt(map);
		Board board = boardMapper.selectBoard(map);
		List<Comment> commentList = boardMapper.selectCommentList(map);
		
		resultMap.put("info", board);
		resultMap.put("commentList", commentList);
		resultMap.put("result", "success");
		return resultMap;
		
	}

	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			int cnt = boardMapper.insertComment(map); //에러가 많이 발생할만한 DB연결 코드
			resultMap.put("result", "success");
			resultMap.put("msg", "댓글이 등록되었습니다.");
			
			
		} catch (Exception e) {  //여기로 왔다는건 문제 발생했단 소리
			
			resultMap.put("result", "fail");
			resultMap.put("msg", "서버 오류가 발생했습니다. 다시 시도해주세요.");
		}
		
		return resultMap;
	}
	
	
	
}