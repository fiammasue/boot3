package com.project.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.Message;

@Mapper
public interface MessageDAO {
	//메세지 추가
	public int insertMessage(Message message);
	//읽음 표시
	public int updateReadCount(Message message);
	//전달받은 메세지 불러오기
	public List<Message> selectMessageList(Message message);
}
