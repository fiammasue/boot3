package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.AttachFileDAO;
import com.project.boot.dao.BoardDAO;
import com.project.boot.dto.AttachFile;
import com.project.boot.dto.Board;
import com.project.boot.dto.Member;
@Service
public class BoardService {
	@Autowired
	private BoardDAO boardDAO ;
	
	@Autowired
	private AttachFileDAO attachFileDAO;
	
	public List<Board> getTop5BoardList(String boardtype){
		return boardDAO.getTop5BoardList(boardtype);
	}
//	public List<Board> getBoardList(String boardtype){
//		return boardDAO.getBoardList(boardtype);
//	}
	//게시글 작성
	public int insertBoard(Board board) {
		boardDAO.insertBoard(board);
		int boardid = board.getBoardid() ;
		
		if(board.getAttachList()!=null) {
			for(AttachFile attach : board.getAttachList()) {
				attach.setBoardId(boardid);
				attachFileDAO.insertAttach(attach);
			}
		}
		
		
		return boardid;
	}
	//답변달기
	public int insertBoardReply(Board board) {
		boardDAO.insertBoardReply(board);
		int boardid = board.getBoardid();
		
		System.out.println("BoardIMp - > "+board.getAttachList());
		if(board.getAttachList()!=null) {
			for(AttachFile attach : board.getAttachList()) {
				attach.setBoardId(boardid);
				attachFileDAO.insertAttach(attach);
			}
		}
		
		return boardid;
	}
	public Board getBoard(int boardid) {
		return boardDAO.getBoard(boardid);
	}

	
	public void hitUpdate(int boardid) {
		boardDAO.hitUpdate(boardid);
	}
	public void updateBoard(int boardid,Board board) {
		board.setBoardid(boardid);
		boardDAO.updateBoard(board);
	}
	public boolean deleteBoard(Board board) {
		int count = boardDAO.deleteBoard(board.getBoardid());
		
		return count > 0;
	}

	public boolean deleteBoards(String[] boardidList) {
		boolean result =false;
		
		int count = boardDAO.deleteBoards(boardidList);
		if(count>0) {
			result = true;
		}
		
		return result;
		
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
		//1. 전체 건수를 얻는다
		board.setTotalCount(boardDAO.getTotalCount(board));
		
		
		Map<String, Object> params = new HashMap<>();
		params.put("searchTitle",board.getSearchTitle());
		params.put("startNo",board.getStartNo());
		params.put("endNo",board.getEndNo());
		params.put("boardtype",board.getBoardtype());
		
		
		Map<String, Object> result = new HashMap<>();
		result.put("board", board);
		result.put("boardList", boardDAO.getBoardList(params));
		return result;
	}
	public List<Board> getSomeBoards(Board board){
		//1. 전체 건수를 얻는다
		board.setTotalCount(boardDAO.getTotalCount(board));
		
		Map<String, Object> params = new HashMap<>();
		params.put("searchTitle",board.getSearchTitle());
		params.put("startNo",board.getEndNo()-board.getDeleteCount()+1);
		params.put("endNo",board.getEndNo());
		params.put("boardtype",board.getBoardtype());
		
		return boardDAO.getSomeBoards(params);
	}

	
}
