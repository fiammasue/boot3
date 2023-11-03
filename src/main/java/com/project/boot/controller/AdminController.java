package com.project.boot.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.dto.Board;
import com.project.boot.dto.Member;
import com.project.boot.service.AttachService;
import com.project.boot.service.BoardService;
import com.project.boot.service.MemberService;
import com.project.boot.service.NoticeService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private AttachService attachService;
	
	
	@RequestMapping("/member/AdminMember.do")
	public String AdminMember(@ModelAttribute("member") Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("관리자 회원 전체보기");
		request.setAttribute("result", memberService.getMemberList(member));
		
		
		return "admin/member/allMemberShow";
	}
	//멤버 선택삭제와 삭제를 모두 담당
	@ResponseBody
	@RequestMapping("/member/DeleteMembers.do")
	public Map<String, Object> DeleteMembers(@RequestBody Member member,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("관리자 멤버 삭제");
		Map<String, Object> map = new HashMap<>();
		boolean status = memberService.deleteMembers(member);
		
		
		if(status == true) {
			map.put("memberList", memberService.getMemberList2(member) );
			map.put("status", true);
			map.put("message","선택한 회원정보가 삭제되었습니다.");
			
		}else {
			map.put("status", false);
			map.put("message","다시시도해주세요");
		}
		
		return map;
	}

	
	
	/////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/main.do")
	public String AdminMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "admin/common/main";
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////
	//Board 기능
	@RequestMapping("/board/AdminBoard.do")
	public String AdminBoard(@ModelAttribute("board") Board board , HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("관리자 게시판 전체보기");
		board.setBoardtype("게시판");
		Map<String, Object> result = boardService.getBoardPageList(board);
		//request.setAttribute("boardList", boardList);
		request.setAttribute("result", result);
		
		
		
		return "admin/board/allBoard";
	}
	//관리자의 글 하나 삭제
	@ResponseBody
	@RequestMapping(value = "/board/AjaxDeleteBoard.do", method = RequestMethod.POST)
	public Map<String,Object> AjaxDeleteBoard(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("관리자 게시판 글 개별삭제");
		
		Map<String,Object> map = new HashMap<>();
		
		
		board.setAttachList(attachService.getAttachList(board.getBoardid()));
		
		
		//삭제를위해 boardid만 가져옴
		boolean result  = boardService.deleteBoard(board);
		
		if(result) {
			attachService.deleteAttachFile(board.getAttachList());
			board.setBoardtype("게시판");
			map.put("boardList",boardService.getSomeBoards(board));
			map.put("status", result);
			map.put("message", "게시글이 삭제되었습니다.");
			
		}else {
			map.put("status", result);
			map.put("message", "다시 시도해 주세요");
		}
		return map;
	}
	//선택한 게시글 삭제
		@ResponseBody
		@RequestMapping(value = "/board/DeleteSelectPage.do", method = RequestMethod.POST)
		public Map<String,Object> DeleteSelectPage(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("관리자 게시판 글 선택 삭제");
			Map<String,Object> map = new HashMap<>();
			
			board.setAttachList(attachService.getAttachList(board.getBoards()));
			
			
			boolean status = boardService.deleteBoards(board.getBoards());
			
			if(status) {
				attachService.deleteAttachFile(board.getAttachList());
				board.setBoardtype("게시판");
				map.put("boardList",boardService.getSomeBoards(board));
				
				
				map.put("message", "선택한 게시글이 삭제되었습니다.");
				map.put("status", status);
			}
			else {
				map.put("message", "다시시도해주세요");
				map.put("status", status);
			}
			return map;
		}

	
	////////////////////////////////////////////////////////////////////////////////////
	//공지사항 기능
	@RequestMapping("/notice/AdminNotice.do")
	public String AdminMain(@ModelAttribute("board") Board board ,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("관리자 공지사항글 전체보기");
		HttpSession session = request.getSession();
		session.setAttribute("boardtype", "AllNotice.do");
		
		board.setBoardtype("공지사항");
		Map<String, Object> result = noticeService.getBoardPageList(board);
		
		//result를 넘겨서 걍 싹다 result하나에 넘겨주는 방법도 잇음
		//request.setAttribute("noticeList", result.get("boardList"));
		//공지사항 게시글의 리스트와 페이징에 대한 정보가 있다.
		request.setAttribute("result", result);
		

		
		return "admin/notice/allNotice";
	}
	//공지사항 삭제 게시글 옆 작은 삭제버튼 // 관리자가 삭제시 사용
		@ResponseBody
		@RequestMapping(value = "/notice/AjaxDeleteNotice.do", method = RequestMethod.POST)
		public Map<String ,Object> AjaxDeleteNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("관리자 공지사항 개별삭제");
			Map<String ,Object> map = new HashMap<>();
			
			boolean result = noticeService.deleteBoard(board.getBoardid());
			
			if(result) {
				board.setBoardtype("공지사항");
				map.put("noticeList",noticeService.getSomeBoards(board));
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
			System.out.println("관리자 공지사항 선택삭제");
			Map<String ,Object> map = new HashMap<>();
			
			boolean result = noticeService.deleteBoards(board);
			
			if(result) {
				board.setBoardtype("공지사항");
				map.put("noticeList",noticeService.getSomeBoards(board));
				map.put("message", "선택한 게시글이 삭제되었습니다.");
				map.put("status", result);
				
			}else {
				map.put("message", "다시 시도해주세요");
				map.put("status", result);
			}
			
			return map;
		}
		//공지사항 작성
		@ResponseBody
		@RequestMapping(value = "/notice/InsertNotice.do", method = RequestMethod.POST)
		public Map<String ,Object> InsertNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("관리자 공지사항 글쓰기");
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
		//공지사항 수정
		@ResponseBody
		@RequestMapping(value = "/notice/ReviseNotice.do", method = RequestMethod.POST)
		public Map<String ,Object> ReviseNotice(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("관리자 공지사항 글수정");
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

	
	
}
