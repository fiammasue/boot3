<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<c:url value='/css/agreeDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/insertDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/loginDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pwdFindDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/uidFindDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/viewDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/reviseDialog.css'/>">
<link rel="stylesheet" href="<c:url value='/css/removeDialog.css'/>">

<!-- 회원가입 폼 -->
     <div id="insertAgree-Dialog" style="display:none">
			     <form action="" id="joinForm">
			        <ul class="join_box">
			            <h2><span>I love Yeonsu</span> 이용약관 동의</h2>
			            <li class="checkBox check01">
			                <ul class="clearfix">
			                    <li>이용약관, 개인정보 수집 및 이용,
			                        위치정보 이용약관(선택), 프로모션 안내
			                        메일 수신(선택)에 모두 동의합니다.</li>
			                    <li class="checkAllBtn">
			                        <input type="checkbox" name="chkAll" id="chk" class="chkAll">
			                    </li>
			                </ul>
			            </li>
			            <li class="checkBox check02">
			                <ul class="clearfix">
			                    <li>이용약관 동의(필수)</li>
			                    <li class="checkBtn">
			                        <input type="checkbox" name="chk" class="button"> 
			                    </li>
			                </ul>
			                <textarea name="" id="">여러분을 환영합니다.
			네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
			   </textarea>
			            </li>
			            <li class="checkBox check03">
			                <ul class="clearfix">
			                    <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
			                    <li class="checkBtn">
			                        <input type="checkbox" name="chk" class="button">
			                    </li>
			                </ul>
			
			                <textarea name="" id="">여러분을 환영합니다.
			네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
			   </textarea>
			            </li>
			            <li class="checkBox check03">
			                <ul class="clearfix">
			                    <li>위치정보 이용약관 동의(선택)</li>
			                    <li class="checkBtn">
			                        <input type="checkbox" name="chk" class="button">
			                    </li>
			                </ul>
			
			                <textarea name="" id="">여러분을 환영합니다.
			네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
			   </textarea>
			            </li>
			            <li class="checkBox check04">
			                <ul class="clearfix">
			                    <li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
			                    <li class="checkBtn">
			                        <input type="checkbox" name="chk" class="button">
			                    </li>
			                </ul>
			
			            </li>
			        </ul>
			    </form>
     
     </div>   
     <!-- 회원가입동의 창 끝----------------- -->
      <!-- 회원 가입 입력폼 시작 -->  
     <div id="insertForm-Dialog" style="display:none">
     <h2><span>I love Yeonsu</span></h2>
      
            <h2>회원가입</h2>
	     <form id="insertForm"action="InsertMember.do" method="post" autocomplete="off" onsubmit="return false;">
	            <div class="register_info">
	                <label for="insert-uid">아이디 </label>
	                <input id="insert-uid" type="text" name="uid" required/>
	                <input type="button" id="existUid" value="중복확인"/>
	            </div>
	            <div class="register_info">
	                <label for="insert-pwd">비밀번호</label>  
	                <input type="password" name="pwd" id="insert-pwd" required/>
	            </div>
	            <div class="register_info">
	                <label for="pwd2">비밀번호 확인</label> 
	                <input type="password" name="pwd2" id="insert-pwd2" required/>
	                
	            </div>
	            <div class="register_info">
	                <label for="insert-uname">이름</label> <input id="insert-uname" type="text" name="name" required/>
	            </div>
	            <div class="register_info">
	                <label for="insert-phone">전화번호</label>
	                <input id="insert-phone" type="tel" name="phone" required/>
	            </div>
	            <div class="register_info">
	                <label for="insert-address">주소</label> 
	                <input id="insert-address" type="text" name="address" required/>
	            </div>
	            <div class="register_info">
	                <label for="insert-age">나이</label> 
	                <input id="insert-age" type="text" name="age" required/>
	            </div>
	            <div class="register_info">
	                <label for="insert-email">이메일</label> 
	                <input id="insert-email" type="email" name="email" required/>
	            </div>
	            
	            <div class="register_info">
	                <div id="last">
	                <label>성별</label> 
	                <div class="gender">
	                <div class="iner">
	                    <input id="m" type="radio" name="gender" value="남">
	                    <label for="m">남</label>
	                </div>
	                <div class="iner">
	                    <input id="w" type="radio" name="gender" value="여" checked>
	                    <label for="w">여</label>
	                </div>
	                
	                </div>
	            </div>
	            </div>
	    
	        </form>
     </div>   
         <!-- 회원 가입 입력폼 끝-------------------- --> 
	<!-- 로그인 창 폼 시작 -->
		<div id="loginForm-Dialog" style="display:none">
			<form id="loginForm" action="LoginMember.do" method="get" autocomplete="off" onsubmit="return false;">
		        <h2>로그인</h2>
		        <div class="input-box">
		            <input id="username" type="text" name="uid" placeholder="아이디" required/>
		            <label for="username">아이디</label>
		        </div>
		        <div class="input-box"> 
		            <input type="password" name="pwd" id="password" placeholder="비밀번호" required/>
		            <label for="password">비밀번호</label>
		        </div>
		        <div class="forgot"><a href="#" id="openID">아이디 찾기</a></div>
		    <div class="forgot"><a href="#" id="openPwd">비밀번호 찾기</a></div>
		    </form>
		</div>
	<!-- 로그인 창 폼 끝 -->
	<!-- 비밀번호 찾기 창 폼 시작 -->
	<div id="pwdForm-Dialog" style="display:none">
		<form id="pwdForm" action="<c:url value='/member/PwdFind.do'/>" method="get" autocomplete="off" onsubmit="return false;">
            <h2>비밀번호 찾기</h2>
            <div class="input-box">
                <input id="pwd-uid" type="text" name="uid" placeholder="아이디" required/>
                <label for="uid">아이디</label>
            </div>
            <div class="input-box">
                <input id="pwd-uname" type="text" name="name" placeholder="이름" required/>
                <label for="name">이름</label>
            </div>
            <div class="input-box">
                <input id="pwd-phone" type="text" name="phone" placeholder="전화번호" required/>
                <label for="phone">전화번호</label>    
            </div>
            <div class="input-box">
                <input type="password" name="pwd" id="pwd-pwd" placeholder="비밀번호 변경" required/>
                <label for="pwd">비밀번호 변경</label>
                <div id="pwdErrorMessage"></div>
            </div>
            
        </form>
	
	</div>
	<!-- 비밀번호 찾기 창 폼 끝 -->
	<!-- 아이디 찾기 창 폼 시작 -->
	<div id="uidForm-Dialog" style="display:none">
		<form id="uidForm" action="/myProject/UidFind.do" method="get" autocomplete="off" onsubmit="return false;">
        <h2>아이디 찾기</h2>
        <div class="input-box">
            <input id="uid-uname" type="text" name="name" placeholder="이름" required/>
            <label for="name">이름</label>
        </div>
        <div class="input-box">
            <input id="uid-phone" type="tel" name="phone" placeholder="전화번호" required/>
            <label for="phone">전화번호</label>
        </div>
        
    </form>
	
	</div>
	<!-- 아이디 찾기 창 폼 끝 -->
	<!-- 상세보기 창 폼 시작 -->
	<div id="view-Dialog" style="display:none">
		<table class="tb">
	        <caption><span>${loginMember.name }</span>님의 상세정보</caption>
	        <tr>
	          <th class="col">아이디</th>
	          <td id="view-uid"> ${loginMember.uid }</td>
	        </tr>
	        <tr>
	          <th class="col">비밀번호</th>
	          <td id="view-pwd"> ${loginMember.pwd }</td>
	        </tr>
	        <tr>
	          <th class="col">이름</th>
	          <td id="view-uname"> ${loginMember.name }</td>
	        </tr>
	        <tr>
	          <th class="col">전화번호</th>
	          <td id="view-phone"> ${loginMember.phone }</td>
	        </tr>
	        <tr>
	          <th class="col">주소</th>
	          <td id="view-address"> ${loginMember.address }</td>
	        </tr>
	        <tr>
	          <th class="col">나이</th>
	          <td id="view-age"> ${loginMember.age }</td>
	        </tr>
	        <tr>
	          <th class="col">email</th>
	          <td id="view-email"> ${loginMember.email }</td>
	        </tr>
	        <tr>
	          <th class="col">성별</th>
	          <td id="view-gender"> ${loginMember.gender }</td>
	        </tr>
	      </table>
	</div>
	<!-- 상세보기 창 폼 끝 -->
	<!-- 회원 수정 창 폼 시작 -->
	<div id="reviseForm-Dialog" style="display:none">
	 <form id="reviseForm" action="<c:url value='/member/ReviseMember.do'/>" method="get" autocomplete="off" onsubmit="return false;">
            <!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
            <table class="tb">
                <caption><span>${loginMember.uid }</span>님의 정보수정 페이지</caption>
                <tr>
                    <th class="col">아이디</th>
                    <td><input id="revise-uid" type="text" name="uid" value="${loginMember.uid}" readonly/></td>
                </tr>
                <tr>
                    <th class="col"><label for="pwd">비밀번호</label></th>
                    <td> <input type="password" name="pwd" id="revise-pwd"/>
                </tr>
                <tr>
                    <th class="col"><label for="pwd2">비밀번호 확인</label></th>
                    <td><input type="password" name="pwd2" id="revise-pwd2" style="border: none;background: #f7f7f7;"/></td>
                </tr>
                <tr>
                    <th class="col"> <label for="name">이름</label></th>
                    <td><input type="text" name="name" id="revise-uname"/><br/></td>
                </tr>
                <tr>
                    <th class="col"><label for="phone">전화번호</label></th>
                    <td><input id="revise-phone" type="tel" name="phone"/></td>
                </tr>
                <tr>
                    <th class="col"><label for="address">주소</label></th>
                    <td><input type="text" name="address" id="revise-address"/></td>
                </tr>
                <tr>
                    <th class="col"><label for="age">나이</label></th>
                    <td><input type="text" name="age" id="revise-age"/></td>
                </tr>
                <tr>
                    <th class="col"><label for="email">이메일</label></th>
                    <td><input type="email" name="email" id="revise-email"/></td>
                </tr>
                <tr>
                    <th class="col"><label>성별</label></th>
                    <td><div class="gender">
                        
                    <div class="iner">
                        <input id="m" type="radio" name="revise-gender" value="남">
                        <label for="m">남</label>
                    </div>
                    <div class="iner">
                            <input id="w" type="radio" name="revise-gender" value="여" checked>
                            <label for="w">여</label>
                        </div>
                    </div>
                    </td>
                </tr>
            </table>
        </form>
	</div>
	<!-- 회원 수정 창 폼 끝 -->
	<!-- 회원 삭제 창 폼 끝 -->
	<div id="removeForm-Dialog" style="display:none">
		<form id="removeForm" action="<c:url value='/member/RemoveMember.do'/>" method="get" autocomplete="off" onsubmit="return false;">
	        <h2>회원 탈퇴</h2>
	        <div class="message">회원탈퇴을 위해 비밀번호를 입력해주세요</div>
	        <div class="input-box">
	            <input type="password" name="pwd" id="remove-pwd" placeholder="비밀번호 변경" required/>
	            <label for="pwd">비밀번호 확인</label>
	            <div id="pwdErrorMessage"></div>
	        </div>
	    </form>
	</div>
	<!-- 회원 삭제 창 폼 끝 -->
	

  <div id="enterMember">
        <c:choose>
        	<c:when test="${empty loginMember }">
	        	<ul class="members" id="loginOptions">
	                <li><a href="#" id="openLogin">로그인</a></li>
	                <li><a href="#" id="openInsert" >회원가입</a></li>
	             </ul>
        	</c:when>
        	<c:when test="${not empty loginMember}">
        		<ul class="members" id="loggedInOptions">
	                <li><a href="#" id="logoutToggle" >로그아웃</a></li>
	                <li><a href="#" id="openView">마이페이지</a></li>
	           </ul>
        	</c:when>
        	
        	
        </c:choose>
        </div>
        <header>
            <!-- 로고만들기 -->
            <div id="logo">
                <a href="<c:url value='/main/Index.do'/>"><h1>I love Yeonsu</h1></a>
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
                    <li><a href="<c:url value='/notice/AllNotice.do'/>">공지사항</a></li>
                    <li><a href="<c:url value='/board/AllBoard.do'/>">게시판</a></li>
                </ul>
            </nav>
        </header>
     
        
      <div>
      
      
      
      </div>  
        
        

        
        
      <!-- 다이얼로그 -->
		<script src="<c:url value='/js/pwdEquals.js'/>"></script>
        <script src="<c:url value='/js/loadDomHeader.js'/>"></script> 
        <!-- input에 대한 내용체크 -->
		<script src="<c:url value='/js/inputCheck2.js'/>"></script>

  