package com.project.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.ReplyDAO;
import com.project.boot.dto.Reply;


@Service
public class ReplyService {
	@Autowired
	private ReplyDAO replyDAO;
	
	public Reply insertReply(Reply reply) {	
		replyDAO.insertReply(reply);
		int replyid = reply.getReplyid();
		Reply result = replyDAO.getReply(replyid);
		return result;
	}
//	public Reply get(Reply reply) {		
//		return replyDAO.insertReply(reply);
//	}
	//이거 이렇게 해도 될것같은
	public  List<Reply> getReplyList(int boardid) {
		
		return replyDAO.getReplyList(boardid);
	}
	public  int updateReply(Reply reply) {
		return replyDAO.updateReply(reply);
	}
	public  int deleteReply(Reply reply) {
		return replyDAO.deleteReply(reply);
	}
	public List<Reply> getReplyList(Reply reply) {
		
		return replyDAO.getReplyList(reply);
	}

}
