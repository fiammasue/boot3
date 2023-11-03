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
	private int message_id;
	private String message;
	private String read_yn;
	private Timestamp reg_date;
	private String sender;
	private String room_id;
}
