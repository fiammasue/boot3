<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 버튼 컨테이너 스타일 */
.button-container {
 
  height: 70vh; /* 화면 높이만큼 버튼 컨테이너의 높이 설정 */
}

/* 버튼 스타일 */
.custom-button {
position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -36px;
    margin-left: -120px;
    height: 72px;
    width: 240px;
    padding: 20px 40px;
    font-size: 24px;
    background-color:#675d54b3;
    color: #fff;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

/* 마우스를 버튼 위로 올릴 때의 스타일 변화 */
.custom-button:hover {
  background-color: #d36f12b3;
  transform: scale(1.2);
}





</style>
</head>
<body>

<div class="button-container">
  <button style="margin-left: -400px;" type="button" class="custom-button" onclick="goMember()">회원관리</button>
  <button type="button" class="custom-button" onclick="goBoard()">게시판관리</button>
  <button style="margin-left: 160px;"type="button" class="custom-button" onclick="goNotice()">공지사항관리</button>
</div>
<script>
function goMember(){
	location.href="<c:url value='/admin/member/AdminMember.do'/>";
}
function goBoard(){
	location.href="<c:url value='/admin/board/AdminBoard.do'/>";
}
function goNotice(){
	location.href="<c:url value='/admin/notice/AdminNotice.do'/>";
}
</script>
</body>
</html>