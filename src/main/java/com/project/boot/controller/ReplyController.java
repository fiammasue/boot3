package com.project.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.dto.Member;
import com.project.boot.dto.Reply;
import com.project.boot.service.BoardService;
import com.project.boot.service.ReplyService;



@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	@Autowired
	private BoardService boardService;
	
	@ResponseBody
	@RequestMapping("/reply/InsertReply.do")
	public Map<String, Object> InsertReply(@RequestBody Reply reply, HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<>();
		
		//어느게시판에 댓글을 등록할 것인지
		int boardid = (int)session.getAttribute("boardid");
		reply.setBoardid(boardid);
		
		Reply result = replyService.insertReply(reply);
		
		Member loginMember = (Member)session.getAttribute("loginMember");

		
		if(result != null) {
			map.put("status",true);
			map.put("message", "댓글이 추가 되었습니다.");
			map.put("reply", result);
			map.put("loginMember",loginMember.getUid());
			
		}else {
			map.put("status",false);
			map.put("message","다시 시도 해 주세요");
		}
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/reply/UpdateReply.do")
	public Map<String, Object> UpdateReply(@RequestBody Reply reply, HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> map = new HashMap<>();
		
		int result = replyService.updateReply(reply);
		
		if(result > 0) {
			map.put("status",true);
			map.put("message", "댓글이 수정 되었습니다.");
		}else {
			map.put("status",false);
			map.put("message","다시 시도 해 주세요");
		}
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/reply/DeleteReply.do")
	public Map<String, Object> DeleteReply(@RequestBody Reply reply, HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> map = new HashMap<>();
		
		
		System.out.println("reply Delete => "+reply);
		int result = replyService.deleteReply(reply);
		
		if(result > 0) {
			map.put("status",true);
			map.put("message", "댓글이 삭제 되었습니다.");
		}else {
			map.put("status",false);
			map.put("message","다시 시도 해 주세요");
		}
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/reply/GetReplyList.do")
	public Map<String, Object> GetReplyList(@RequestBody Reply reply, HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<>();
		
		
		int boardid = (int)session.getAttribute("boardid");
		reply.setBoardid(boardid);
		
		
		List<Reply> list = replyService.getReplyList(reply);
		map.put("replyList",list);
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember !=null) {
			
			map.put("loginMember",loginMember.getUid());
		}
		
		
		return map;
	}

	
	
}
