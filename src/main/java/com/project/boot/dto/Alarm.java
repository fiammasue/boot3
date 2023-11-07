package com.project.boot.dto;

import java.sql.Date;

import com.project.boot.dto.Message.MessageType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Alarm {
	
	private MessageType type;
	private String type_string;
	private int alarm_id;
	private String contents;
	private String alarm_code;
	private String page_type;
	private String receiver;
	private String read_yn;
	private Date reg_date;
}
