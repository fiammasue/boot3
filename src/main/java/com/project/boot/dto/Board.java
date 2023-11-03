package com.project.boot.dto;

import java.sql.Date;
import java.util.List;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
	//부모게시글 id
	private int pid;
	private int boardid;
	private String title;
	private String contents;
	private Date regdate;
	private int hit;
	private String boardtype;
	private String delete_yn;
	private String fixed_yn;
	private String memberid;
	private String[] boards;
	//답변글의 계층
	private int level = 1;
	//검색필드
	private String searchTitle = "";
	
	private List<AttachFile> attachList;
	
	private int deleteCount;
	
	
	//페이징
	private int pageNo = 1; //현재 페이지 번호
	private int totalCount; // 전체건수
	private int totalPageSize; // 전체 페이지 수
	private int pageLength = 10; // 한페이지의 길이
	private int navSize = 10; //페이지 하단에 출력되는 페이지의 항목수
	private int navStart = 0; //페이지 하단에 출력되는 페이지 시작번호
	private int navEnd = 0; // 페이지 하단에 출력되는 페이지 끝 번호
	
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		//페이지 건수 계산
		totalPageSize = (int) Math.ceil((double) totalCount/ pageLength);
		//페이지 네비게이터 시작 페이지를 계산한다.
		navStart = ((pageNo - 1)/ navSize)* navSize +1;
		//페이지 네비게이터 끝 페이지를 계산한다.
		navEnd = ((pageNo-1)/navSize + 1)* navSize;
		//전체 페이지보다 크면 전체 페이지값으로 변경한다.
		if(navEnd >= totalPageSize) {
			navEnd = totalPageSize;
		}
	}
	//게시글 네비게이터의 처음 시작 번호
	public int getStartNo() {
		return (pageNo - 1) * pageLength + 1;
	}
	//게시글 네비게이터의 마지막 번호
	public int getEndNo() {
		return pageNo * pageLength;
	}
	
	
	
	
	public boolean isWriter(String loginId) {
		return Objects.equals(memberid, loginId);
	}
	public boolean isNotice(String param) {
		return Objects.equals(boardtype, param);
	}
}
