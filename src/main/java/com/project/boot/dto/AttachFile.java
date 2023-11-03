package com.project.boot.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AttachFile {
	private int fileNo; //첨부파일 아이디
	private int boardId; //게시글 번호
	private String file_name_org; //사용자가 올린 원본 파일명
	private String file_name_real; //서버에 저장된 파일명
	private long length; //파일의 길이
	private String content_type; //컨텐츠 타입
	private Date reg_date; //등록일시
	
	private String [] boards;
}
