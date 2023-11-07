package com.project.boot.dto;

import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoom {
	private String room_id;
	private String room_name;
	private String receiver;
	private String sender;
	private int board_id;
	
	//현재로그인중인거 user_id저장하려고
	private String user_id;
	
	//현재 접속중인 사용자수 조정하는건데 일단 DB로 조정하게 만들어두고 나중에는
	//메모리로 관리할것임 이거는 저장할 필요가 없음
	private int connected_count;
	
	public void setRoom_id() {
		room_id = UUID.randomUUID().toString();		
	}

//	public void typeProcess(Message message) {
//	  	switch(message.getType()) {
//		  	case ENTER:
//		  		connected_count++;
//		  		break;
//		  	case LEAVE:
//		  		connected_count--;
//		  		break;
//		  	default:
//	  	}
//		
//	}
}
