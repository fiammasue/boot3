package com.project.boot.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.dto.Board;
import com.project.boot.dto.Member;
import com.project.boot.service.NoticeService;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	//공지사항 더보기 //페이징 해서 사용하지 않는다.
//	@ResponseBody
//	@RequestMapping(value = "/notice/AjaxAllNotice.do", method = RequestMethod.POST)
//	public Map<String,Object> AjaxAllNotice(@RequestBody Board board ,HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Map<String, Object> map = new HashMap<>();
//		
//		board.setBoardtype("공지사항");
//		Map<String, Object> result =noticeService.getBoardMoreList(board);
//		
//		map.put("result", result);
//		
//		return map;
//	}
	//공지사항 목록 출력
	@RequestMapping("/notice/AllNotice.do")
	public String AllNotice(Board board , HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		session.setAttribute("boardtype", "AllNotice.do");
		
		board.setBoardtype("공지사항");
		Map<String, Object> result = noticeService.getBoardPageList(board);
		
		//result를 넘겨서 걍 싹다 result하나에 넘겨주는 방법도 잇음
		//request.setAttribute("noticeList", result.get("boardList"));
		//공지사항 게시글의 리스트와 페이징에 대한 정보가 있다.
		request.setAttribute("result", result);
		
		boolean isAdmin = noticeService.isAdmin(loginMember);
		request.setAttribute("isAdmin", isAdmin);
		
		return "notice/allNotice";
	}
	//일반사용자는 삭제 못함 
	//공지사항 삭제 //일반 사용자가 삭제시
	@ResponseBody
	@RequestMapping(value = "/notice/DeleteNotice.do", method = RequestMethod.POST)
	public Map<String ,Object> DeleteNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		if(board.getMemberid()!="" && board.getMemberid().equals("root")) {
			
			noticeService.deleteBoard(board.getBoardid());
			map.put("message", "게시글이 삭제되었습니다.");
			map.put("status", true);
			return map;
		}else {
			map.put("message", "관리자만 게시글을 삭제할수있습니다.");
			map.put("status", false);
			
		}
		return map;

	}
	//공지사항 삭제 게시글 옆 작은 삭제버튼 // 관리자가 삭제시 사용
	@ResponseBody
	@RequestMapping(value = "/notice/AjaxDeleteNotice.do", method = RequestMethod.POST)
	public Map<String ,Object> AjaxDeleteNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		
		boolean result = noticeService.deleteBoard(board.getBoardid());
		
		if(result) {
			map.put("status", result);
			map.put("message", "게시글이 삭제되었습니다.");
			
		}else {
			map.put("status", result);
			map.put("message", "다시 시도 해주세요");
		}
		
		return map;
	}
	//선택한 공지사항 삭제 //관리자가 체크박스로 삭제시 사용
	@ResponseBody
	@RequestMapping(value = "/notice/DeleteSelectNotice.do", method = RequestMethod.POST)
	public Map<String ,Object> DeleteSelectNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		
		boolean result = noticeService.deleteBoards(board);
		
		if(result) {
			map.put("message", "선택한 게시글이 삭제되었습니다.");
			map.put("status", result);
			
		}else {
			map.put("message", "다시 시도해주세요");
			map.put("status", result);
		}
		
		return map;
	}
	//관리자로 가져감
	//공지사항 작성
	@ResponseBody
	@RequestMapping(value = "/notice/InsertNotice.do", method = RequestMethod.POST)
	public Map<String ,Object> InsertNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		
		if(board.getMemberid()==""||!board.getMemberid().equals("root")) {
			map.put("status", false);
			map.put("message", "관리자만 게시글을 작성할 수있습니다.");
			return map;
		}else {
			boolean result = noticeService.insertBoard(board);
			if(result) {
				map.put("message", "게시글작성이 완료되었습니다.");
				map.put("status", result);
				
			}else {
				map.put("message", "다시 시도해 주세요");
				map.put("status", result);
			}
			
		}

		return map;
	}
	//관리자로 가져감
	//공지사항 수정
	@ResponseBody
	@RequestMapping(value = "/notice/ReviseNotice.do", method = RequestMethod.POST)
	public Map<String ,Object> ReviseNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		
		int boardid = (int)session.getAttribute("boardid");
		
		boolean result =  noticeService.updateBoard(boardid,board);
		if(result) {
			map.put("message", "게시글을 수정하였습니다.");
			map.put("status", result);
			
		}else {
			map.put("message", "다시 시도해 주세요");
			map.put("status", result);
		}
		
		return map;
	}
	//관리자 페이지가 따로 있기 때문에 필요 없음
	//공지사항 수정 폼 호출전 관리자인지 확인
	@ResponseBody
	@RequestMapping(value = "/notice/ReviseNoticeForm.do", method = RequestMethod.POST)
	public Map<String ,Object> ReviseNoticeForm(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String ,Object> map = new HashMap<>();
		
		Board temp = noticeService.getBoard(board.getBoardid());
		if(board.getMemberid().equals("root")) {
			map.put("status", true);
			return map;
		}else {
			map.put("message", "관리자만 글을 수정할 수 있습니다.");
			map.put("status", false);
			
		}
		
		
		return map;
	}
	
	
	//공지사항 상세보기
	@ResponseBody
	@RequestMapping(value = "/notice/ViewOneNotice.do", method = RequestMethod.POST)
	public Board ViewOneNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		noticeService.hitUpdate(board.getBoardid());
		
		Board boardTemp =  noticeService.getBoard(board.getBoardid());
		
		//수정할때 boardid가필요하다..
		session.setAttribute("boardid", board.getBoardid());

		return boardTemp;
	}
}
