package com.project.boot.dto;

import java.sql.Timestamp;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Message {
	// 메시지 타입 : 입장, 채팅, 나가기
	public enum MessageType {
	      ENTER, TALK, LEAVE, ALARM
	}
	
	private MessageType type; // 메시지 타입
	private String type_string;
	private int message_id;
	private String message;
	private String read_yn;
	private Timestamp reg_date;
	private String sender;
	private String receiver;
	private String room_id;
	
	
	
}
