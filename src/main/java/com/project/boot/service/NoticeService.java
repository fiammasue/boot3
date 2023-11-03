package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.NoticeDAO;
import com.project.boot.dto.Board;
import com.project.boot.dto.Member;

@Service
public class NoticeService {
	@Autowired
	private NoticeDAO noticeDAO ;
	
	public List<Board> getTop5BoardList(String boardtype){
		Map<String, Object> params = new HashMap<>();
		params.put("boardtype",boardtype);
		
		noticeDAO.getTop5BoardList(params);
		
		List<Board> boardList = (List<Board>)params.get("v_cursor");
		
		return boardList;
	}
//	public List<Board> getBoardList1(String boardtype){
//		return noticeDAO.getBoardList1(boardtype);
//	}
	public boolean insertBoard(Board board) {
		noticeDAO.insertBoard(board);
		return true;
	}
	public Board getBoard(int boardid) {
		Map<String, Object> params = new HashMap<>();
		params.put("boardid",boardid);
		
		noticeDAO.getBoard(params);
		
		List<Board> board = (List<Board>)(params.get("v_cursor"));
		
		return board.get(0);
	}
	public void hitUpdate(int boardid) {
		noticeDAO.hitUpdate(boardid);
	}
	public boolean updateBoard(int boardid,Board board) {
		if(board.getFixed_yn() == null) {
			board.setFixed_yn("N");
		}
		board.setBoardid(boardid);
		noticeDAO.updateBoard(board);
		
		return true;
	}
	public boolean deleteBoard(int boardid) {
		return noticeDAO.deleteBoard(boardid);
	}

//	public boolean deleteBoards(Board board) {
//		
//		return noticeDAO.deleteBoards(board);
//	}
	public boolean deleteBoards(Board board) {
		
		return noticeDAO.deleteBoards(board.getBoards());
	}
	public boolean isAdmin(Member member) {
		boolean result = false;
		if(member!= null) {
			result = member.isAdmin();
		}
		
		return result;
	}
	public boolean isWriter(String memberid, Board board) {
		
		return memberid.equals(board.getMemberid());
	}
	public Map<String, Object> getBoardPageList(Board board){
		Map<String, Object> params = new HashMap<>();
		params.put("board",board);
		noticeDAO.getTotalCount(params);
		int count = (int)params.get("p_cnt");
		
		//1. 전체 건수를 얻는다
		board.setTotalCount(count);
		
		params = new HashMap<>();
		params.put("boardtype",board.getBoardtype());
		params.put("endNo",board.getEndNo());
		params.put("startNo",board.getStartNo());
		params.put("searchTitle",board.getSearchTitle());
		
		noticeDAO.getBoardList(params);
		
		List<Board> list = (List<Board>)params.get("v_cursor");
		
		Map<String, Object> result = new HashMap<>();
		result.put("board", board);
		result.put("boardList", list);
		return result;
	}
	public Map<String, Object> getBoardMoreList(Board board){
		Map<String , Object> parmas = new HashMap<>();
		parmas.put("board",board);
		noticeDAO.getBoardMoreList(parmas);
		List<Board> list = (List<Board>)parmas.get("v_cursor");
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("board", board);
		result.put("noticeList", list);
		return result;
	}
	public List<Board> getSomeBoards(Board board){
		Map<String,Object> params = new HashMap<>();
		params.put("boardtype",board.getBoardtype());
		params.put("endNo",board.getEndNo());
		params.put("startNo",board.getEndNo()-board.getDeleteCount()+1);
		params.put("searchTitle",board.getSearchTitle());
		
		noticeDAO.getBoardList(params);
		
		List<Board> list = (List<Board>)params.get("v_cursor");
		
		return list;
	}
}
