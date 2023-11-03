<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <div id="enterMember">
        
    	<ul class="members" id="loggedInOptions">
            <li><a  id="logoutToggle"  >로그아웃</a></li>
   		</ul>

        <header>
        
            <!-- 로고만들기 -->
            <div id="logo">
                <a href="<c:url value='/admin/main.do'/>"><h1>I love Yeonsu</h1></a>
            </div>
            <!-- 메뉴만들기 -->
            <nav>
                <ul id="topMenu">
                    <li><a href="#">놀러갈 곳<span>▼</span></a>
                        <ul>
                            <li><a href="#">별이언니네</a></li>
                            <li><a href="#">외할머니네</a></li>
                        </ul>
                    </li>
                    <li><a href="#">급식이<span>▼</span></a>
                    <ul>
                        <li><a href="#">초딩</a></li>
                        <li><a href="#">중딩</a></li>
                        <li><a href="#">고딩</a></li>
                    </ul>
                    </li>
                    <li><a href="<c:url value='/admin/notice/AdminNotice.do'/>">공지사항</a></li>
                    <li><a href="<c:url value='/admin/board/AdminBoard.do'/>">게시판</a></li>
                </ul>
            </nav>
        </header>
     
  </div> 
   <script src="<c:url value='/js/loadDomHeader.js'/>"></script> 

        
  