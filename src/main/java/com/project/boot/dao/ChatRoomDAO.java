package com.project.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.ChatRoom;

@Mapper
public interface ChatRoomDAO {
	
	//채팅방생성
	public int createRoom(ChatRoom room);
	//채팅방 삭제
	public int deleteRoom(ChatRoom room);
	//채팅방 목록 불러오기
	public List<ChatRoom> selectRoomList(ChatRoom room);
	//채팅방 하나의 정보 불러오기
	public ChatRoom findRoomById(String roomId);
}
