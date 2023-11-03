<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"
 %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script type="text/javascript">

	//user - > 게시판
	//게시판 리스트
	var AllBoard = "<c:url value='/board/AllBoard.do'/>";
	//게시판 사용자 글삭제
	var DeleteBoard = "<c:url value='/board/DeleteBoard.do'/>";
	//게시판 글 작성
	var InsertBoard = "<c:url value='/board/InsertBoard.do'/>";
	//게시판 답변 글 작성
	var InsertBoardReply = "<c:url value='/board/InsertBoardReply.do'/>";
	//게시판 글 수정
	var ReviseBoard = "<c:url value='/board/ReviseBoard.do'/>";
	//게시판 글 수정 폼띄우기
	var ReviseBoardForm = "<c:url value='/board/ReviseBoardForm.do'/>";
	//게시글 상세보기
	var ViewOneBoard = "<c:url value='/board/ViewOneBoard.do'/>";
	
	//user - > 공지사항
	// 공지사항 리스트
	var AllNotice = "<c:url value='/notice/AllNotice.do'/>";
	// 공지사항 상세보기
	var ViewOneNotice = "<c:url value='/notice/ViewOneNotice.do'/>";
	
	//user - > 회원관리
	//아이디가 존재하는지
	var isExistUid = "<c:url value='/member/isExistUid.do'/>";
	//main페이지
	var Index = "<c:url value='/main/Index.do'/>";
	//main에서 board보기
	var AjaxIndex = "<c:url value='/member/AjaxIndex.do'/>";
	//member 회원가입
	var InsertMember = "<c:url value='/member/InsertMember.do'/>";
	//member 로그인
	var LoginMember = "<c:url value='/member/LoginMember.do'/>";
	//member 로그아웃
	var LogoutMember = "<c:url value='/member/LogoutMember.do'/>";
	//member 패스워드 찾기
	var PwdFind = "<c:url value='/member/PwdFind.do'/>";
	//member 탈퇴하기
	var RemoveMember = "<c:url value='/member/RemoveMember.do'/>";
	//member 수정
	var ReviseMember = "<c:url value='/member/ReviseMember.do'/>";
	//member 아이디 찾기
	var UidFind = "<c:url value='/member/UidFind.do'/>";
	
	//user, admin - > 댓글
	//reply 댓글 달기
	var InsertReply = "<c:url value='/reply/InsertReply.do'/>";
	//reply 수정
	var UpdateReply = "<c:url value='/reply/UpdateReply.do'/>";
	//reply 삭제
	var DeleteReply = "<c:url value='/reply/DeleteReply.do'/>";
	//reply 댓글 달기
	var GetReplyList = "<c:url value='/reply/GetReplyList.do'/>";
	
	
	//admin -> 관리자 페이지
	//admin member 리스트 출력
	var AdminMember = "<c:url value='/admin/member/AdminMember.do'/>";
	//admin member 하나, 선택삭제
	var DeleteMembers = "<c:url value='/admin/member/DeleteMembers.do'/>";
	//admin 관리자 페이지 메인
	var AdminMain = "<c:url value='/admin/main.do'/>";
	///게시판
	//admin 관리자 게시판
	var AdminBoard = "<c:url value='/admin/board/AdminBoard.do'/>";
	//admin 게시판 글하나 삭제
	var AjaxDeleteBoard = "<c:url value='/admin/board/AjaxDeleteBoard.do'/>";
	//admin 게시판 글 여러개 삭제
	var DeleteSelectPage = "<c:url value='/admin/board/DeleteSelectPage.do'/>";
	//공지사항
	//admin 공지사항
	var AdminNotice = "<c:url value='/admin/notice/AdminNotice.do'/>";
	//admin 공지사항 글 하나 삭제
	var AjaxDeleteNotice = "<c:url value='/admin/notice/AjaxDeleteNotice.do'/>";
	//admin 공지사항 글 여러개 삭제
	var DeleteSelectNotice = "<c:url value='/admin/notice/DeleteSelectNotice.do'/>";
	//admin 공지사항 글 작성
	var InsertNotice = "<c:url value='/admin/notice/InsertNotice.do'/>";
	//admin 공지사항 글 수정
	var ReviseNotice = "<c:url value='/admin/notice/ReviseNotice.do'/>";

	
	//파일다운로드
	var downloadFile = "<c:url value='/attach/download.do?fileNo='/>";
</script>
        <footer>
            <!-- 바닥부분 메뉴 4개 -->
            <div id="bottomMenu">
                <ul>
                    <li><a href="#">회사소개</a></li>
                    <li><a href="#">개인정보처리방침</a></li>
                    <li><a href="#">여행약관</a></li>
                    <li><a href="#">사이트맵</a></li>
                </ul>
            </div>
            <!-- sns 사진부분 -->
            <div id="sns">
                <ul>
                    <li><a href="#"><img src="<c:url value='/images/sns-1.png'/>" alt=""></a></li>
                    <li><a href="#"><img src="<c:url value='/images/sns-2.png'/>" alt=""></a></li>
                    <li><a href="#"><img src="<c:url value='/images/sns-3.png'/>" alt=""></a></li>
                </ul>
            </div>
            <!-- 회사주소 -->
            <div id="company">
                <p>제주특별자치도 ***동 ***로 *** (대표전화) 123-456-7890</p>
            </div>
        </footer>