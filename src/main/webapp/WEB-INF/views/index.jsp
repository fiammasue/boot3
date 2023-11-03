<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="<c:url value='/css/index.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/viewBoxMain.css'/>">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="<c:url value='/js/loadDomIndex.js'/>"></script>
	
</head>
<body>

<!-- 글 상세보기 -->
<div id="view-Form" style="display:none">
<label id="notice-id" style="display:none;">${board.boardid}</label>
	<table class="post">
            <tr>
                <th>제목</th>
                <td colspan="5" id="notice-title">${board.title}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td id="notice-memberid">${board.memberid}</td>
                <th>작성날짜</th>
                <td id="notice-regdate">${board.regdate}</td>
                <th>조회수</th>
                <td id="notice-hit">${board.hit}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="5"><textarea id="notice-contents" cols="60" rows="10" readonly>${board.contents}</textarea></td>
            </tr>
        </table>

</div>
<!-- 글 상세보기 폼 end -->

<!-- 슬라이드 그림부분 -->
        <div id="slideShow"> 
            <div id="slides">
                <img src='<c:url value="/images/slide01.jpg"/>' alt="">
                <img src="<c:url value='/images/slide02.jpg'/>" alt="">
                <img src="<c:url value='/images/slide03.jpg'/>" alt="">
                <button id="prev">&lang;</button>
                <button id="next">&rang;</button>
            </div>
        </div>
        <!-- 탭부분과 퀵메뉴 -->
        <div id="contents">
            <!-- 탭부분 -->
            <div id="tabMenu">
                <input type="radio" id="tab1" name="tabs" checked>
                <label for="tab1">공지사항</label>
                <input type="radio" id="tab2" name="tabs">
                <label for="tab2">게시판</label>
           <!-- 공지사항 내용 -->
            <div id="notice" class="tabContent">
                <h2>공지사항 내용입니다.</h2>
                
                <table>
                <c:forEach var="notice" items="${noticeList}">
                	<tr>
		                 <td>${notice.boardid }</td>
		                 <td class="viewDetail" data-server-id="${notice.boardid}"
		                 data-url="<c:url value='/member/AjaxIndex.do'/>">${notice.title }</td>
		                 <td>${notice.memberid }</td>
	                 </tr>
                </c:forEach>
                <c:if test="${ noticeListSize == 0}">
               		 <tr>
	                 	<td colspan=3>현재 자료가 존재 하지 않습니다</td>
                 	 </tr>
                </c:if>
                </table>
            </div>
            <!-- 게시판 내용 -->
            <div id="gallery" class="tabContent">
                <h2>게시판 내용입니다.</h2>
                <table>
                <c:forEach var="board" items="${boardList}">
	                <tr>
		                 <td>${board.boardid }</td>
		                 <td class="viewDetail" data-server-id="${board.boardid}"
		                 data-url="<c:url value='/member/AjaxIndex.do'/>">${board.title }</td>
		                 <td>${board.memberid }</td>
	                 </tr>
                </c:forEach>
                <c:if test="${noticeListSize ==0 }">
                	<tr>
	                 	<td colspan=3>현재 자료가 존재 하지 않습니다</td>
	             	 </tr>
                </c:if>
                </table>
            </div>
        </div>
        <!-- 동그란 퀵메뉴 -->
            <div id="links">
                <ul>
                    <li>
                        <a href="#">
                            <span id="quick-icon1"></span>
                            <p>승기천</p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span id="quick-icon2"></span>
                            <p>연안부두</p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span id="quick-icon3"></span>
                            <p>강화루지</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
 <!-- 슬라이드 쇼 넘기는 js -->
    <script src="<c:url value='/js/slidesshow.js'/>"></script>
    <!-- 로그인 유무로 버튼을 다르게 뜨게하는 js-->
    <!-- <script src="js/loginState.js"></script> -->
</body>
</html>