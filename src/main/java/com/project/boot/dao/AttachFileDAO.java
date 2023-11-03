package com.project.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.AttachFile;

@Mapper
public interface AttachFileDAO {
	
	//첨부파일등록
	//fileno, regdate빼고 다씀
	public int insertAttach(AttachFile attach);
	//해당 게시글의 첨부파일 목록
	//boardid만쓸꺼임
	public List<AttachFile> selectFileList(AttachFile attach);
	public List<AttachFile> selectFileListBoards(AttachFile attach);
	//해당 링크의 첨부파일하나 검색
	//fileNo만 사용
	public AttachFile selectFileOne(AttachFile attach);
	
}
