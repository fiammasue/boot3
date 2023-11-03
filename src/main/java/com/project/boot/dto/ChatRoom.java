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
	
	private int connectedUser=0;
	
	public void setRoom_id() {
		room_id = UUID.randomUUID().toString();		
	}
}
