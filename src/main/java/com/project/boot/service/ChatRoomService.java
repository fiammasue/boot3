package com.project.boot.service;

import java.util.List;

import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

import com.project.boot.dao.ChatRoomDAO;
import com.project.boot.dto.ChatRoom;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatRoomService {
	
	private final ChatRoomDAO chatRoomDAO;
	private final SimpMessageSendingOperations messagingTemplate;
	
	//채팅방 생성
	public ChatRoom createRoom(ChatRoom room) {
		
		room.setRoom_id();
		int result = chatRoomDAO.createRoom(room);
		if(result>0) {
			return room;
		}
		
		return null;
	}
	//채팅방 삭제
	public int deleteRoom(ChatRoom room) {
		return chatRoomDAO.deleteRoom(room);
	}
	//채팅방 목록 불러오기
	public List<ChatRoom> selectRoomList(ChatRoom room){
		return chatRoomDAO.selectRoomList(room);
	}
	//채팅방 하나의 정보 불러오기
	public ChatRoom findRoomById(String roomId) {
		// TODO Auto-generated method stub
	
		return chatRoomDAO.findRoomById(roomId);
	}
	
}
