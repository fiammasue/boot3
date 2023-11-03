package com.project.boot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.Board;


@Mapper
public interface NoticeDAO {
	//게시판 글 목록 전체보기 // 선택된 게시판에 따른 목록불러오기
		//select boardid, title, memberid from board;
		//select boardid, title, contents, hit, good, memberid from board;
		public List<Board> getTop5BoardList(Map<String, Object> params);
//		public List<Board> getBoardList1(String boardtype);
//		//게시판 글 삽입
////		insert into board(boardid, title, contents,regdate, hit, good, memberid) values(?,?,?,?,?,?)
//		//insert into board(boardid, title, contents, hit, good, memberid) values(?,?,?,?,?,?)
////		insert into board(boardid, title, contents,regdate, hit, good, memberid,boardtype) values(board_num.nextval,'제목','내용',sysdate,0,0,'yeonsul','공지사항');
		public boolean insertBoard(Board board);
//		//게시판 글 상세보기
//		//select boardid, title, contents, regdate, hit, good, memberid from board;
//		//select boardid, title, contents, regdate, hit, good, memberid from board;
		public Board getBoard(Map<String, Object> params);
		public void hitUpdate(int boardid);
//		//글 업데이트
//		//update board set title=?,contents=?,regdate=? from boardid=?
		public boolean updateBoard(Board board);
//		//글삭제 //관리자모드까지 하려면 이거 배열로 받아와야할듯;;
//		//delete from board where boardid=?
		public boolean deleteBoard(int boardid);
//		//관리자의 글 전체삭제
		public boolean deleteBoards(Board board);
		public boolean deleteBoards(String[] boards);
//		//게시글 전체 갯수가져옴
		public Integer getTotalCount(Map<String, Object> params);
//		//boardtype으로 구분해야하는데;;;흠..
//		//
		public List<Board> getBoardList(Map<String, Object> params);
//		//더보기해볼께
		public List<Board> getBoardMoreList(Map<String , Object> parmas);
		public List<Board> getSomeBoards(Map<String,Object> params);
}
