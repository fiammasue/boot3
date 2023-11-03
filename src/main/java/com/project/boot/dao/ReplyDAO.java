package com.project.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.Reply;

@Mapper
public interface ReplyDAO {
	void insertReply(Reply reply);
	List<Reply> getReplyList(int boardid);
	List<Reply> getReplyList(Reply reply);
	int updateReply(Reply reply);
	int deleteReply(Reply reply);
	Reply getReply(int replyid);
}
