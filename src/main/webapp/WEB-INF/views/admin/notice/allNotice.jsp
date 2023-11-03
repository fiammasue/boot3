<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 사항 전체보기</title>
<link rel="stylesheet" href="<c:url value='/css/allBoardAdmin.css'/>">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<c:url value='/css/insertBox.css'/>">
<link rel="stylesheet" href="<c:url value='/css/viewBoxMain.css'/>">
<script src="<c:url value='/js/loadDomNoticeAdmin.js'/>"></script>

</head>
<body>
<!--  회원정보가 필요하다 -->
<label id="loginMember" style="display:none;" >${loginMember.uid}</label>
<label id="noticeUrl" style="display:none;" ><c:url value="/notice/AllNotice.do"/></label>
<!-- 공지사항 작성폼을 숨겨보자 -->
<div id="insert-Form" style="display:none">
	<form id="insertNotice" action="<c:url value='/notice/InsertNotice.do'/>" method="post" autocomplete="off" onsubmit="return false;">
			<!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
			<table class="insertTB">
				<caption>
					<span>게시글 작성</span>
				</caption>
				<tr>
					<th class="col">작성자</th>
					<td><input type="text" name="memberid" id="insert-memberid"
						value="${loginMember.uid}" readonly /></td>
				</tr>
				<tr>
					<th class="col"><label for="title">제목</label></th>
					<td><input type="text" name="title" id="insert-title" /></td>
				</tr>
				<tr>
					<th class="col"><label for="contents">내용</label></th>
					<td><textarea form="insertBoard" name="contents" id="contents" ></textarea></td>
				</tr>
				<tr>
					<th class="col"><label>글종류</label></th>
					<td>
						<div class="boardType">
							<input id="w" type="radio" name="boardtype" value="공지사항" checked readonly>
							<label for="w">공지사항</label> 
						</div>
					</td>
				</tr>
				<tr>
					<th class="col"><label for="fixed_yn">상단 고정</label></th>
					<td><input type="checkbox" name="fixed_yn" id="fixed_yn"
						value='Y' /></td>
				</tr>
			</table>
			<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
		</form>
</div>
<!-- 공지사항 작성폼 end -->

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
<!-- 글 수정 -->
<div id="revise-Form" style="display:none">
<form id="reviseNotice" action="<c:url value='/notice/ReviseBoard.do'/>" method="get" autocomplete="off" onsubmit="return false;">
            <!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
            <table class="tb">
                <caption><span>게시글 수정</caption>
                <tr>
                    <th class="col">작성자</th>
                    <td> <input type="text" name="memberid" id="revise-memberid" value="${loginMember.uid}" readonly/>
                      </td>
                </tr>
                <tr>
                    <th class="col"><label for="title">제목</label></th>
                    <td> <input type="text" name="title"id="revise-title"/></td>
                </tr>
                <tr>
                    <th class="col"><label for="contents">내용</label></th>
                    <td><textarea form="reviseBoard" name="contents" id="revise-contents"></textarea></td>
                </tr>
                <tr>
                    <th class="col"><label>글종류</label></th>
                    <td>
                    <div class="boardType">
                        <input id="w" type="radio" name="boardtype" value="공지사항" checked>
                        <label for="w">공지사항</label>
                   </div>
                   </td>
                </tr>
                <tr>
                    <th class="col"><label for="fixed_yn">상단 고정</label></th>
                    <td><input type="checkbox" name="fixed_yn" id="revise-fixed_yn" value='Y'/></td>
                </tr>
            </table>
            <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </form>


</div>
<!-- 글 수정 end-->





<div id=main>
<form name="pageForm" id="pageForm" action="<c:url value='/notice/AllNotice.do'/>" method="post">
		<input type="hidden" name="pageNo" id="pageNo" value="${result.board.pageNo}"/>
		<input type="hidden" name="searchTitle" id="searchTitle" value="${ result.board.searchTitle}"/>
		<input type="hidden" name="pageLength" id="pageLength" value="${result.board.pageLength} "/>
	
	</form>
	
<div id="searchBoard">
	<form onSubmit="jsSearchValue()"name="mForm" id="mForm" action="<c:url value='/notice/AllNotice.do'/>" method="post">
		<input type="hidden" name="pageNo" id="pageNo" value="${result.board.pageNo }"/>

				<div id="totalCount">
					<label>건수 : </label>
					<select name="pageLength" id="pageLength">
						<option value="10" ${result.board.pageLength == 10? 'selected="selected"':'' }>10건</option>
						<option value="20" ${result.board.pageLength == 20? 'selected="selected"':'' }>20건</option>
						<option value="50" ${result.board.pageLength == 50? 'selected="selected"':'' }>50건</option>
						<option value="100" ${result.board.pageLength == 100? 'selected="selected"':'' }>100건</option>
					</select>
					</div>
			<div id="boardTitle" >
					<label>제목 : </label>
					<input type="text" name="searchTitle" id="searchTitle" value="${result.board.searchTitle }"/>
					<input type="submit" value="검색"/>
					
				
			</div>
	
	
	</form>

</div>

 <!-- 게시글을 삭제하기 위한 form -->
	<form action="<c:url value='/notice/DeleteSelectPage.do'/>" method='post' onsubmit="return false;">
		<div id="contain">
			
			<table class="tb">
				<caption>공지사항</caption>
			<%-- 	<tr id="noticeItem" style="display:none">
				<c:if test='${ (not empty loginMember) && (loginMember.uid eq "root") }'>
					<th><input type='checkbox' class='boardid' name='boardid'  ></th>
				</c:if>
		      	<td  class="kk" id="boardid"></td>
		      	<td ><a href="ViewOneBoard.do?boardid={boardid}" id="title"></a></td>
		      	<td id="hit"></td>
		      	<td id="memberid"></td>
		      </tr> --%>
		      
		      <tbody id="noticeList">
				<tr class="head">
					<th>전체선택 <input type='checkbox' id='chk' onchange="jsCheckbox()"></th>
					<th>글번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성자</th>
						<th>삭제</th>
				</tr>

				<c:if test="${not empty result.boardList}">
					<c:forEach var="notice" items="${result.boardList }">
						<tr >
							<th><input type='checkbox' class='boardid' name='boardid'
								value='${notice.boardid}'   ></th>
							<td class="kk">${notice.boardid}</td>
							<td class="viewDetail" data-server-id="${notice.boardid }">${notice.title}</td>
							<td>${notice.hit}</td>
							<td>${notice.memberid}</td>
							<td ><button class="deleteOne" data-server-id="${notice.boardid }">삭제</button></td>
						</tr>
					</c:forEach>

				</c:if>
				</tbody>
			</table>
			
			<div style='width: 65%;margin: 10px auto;'>
				<c:if test="${result.board.navStart != 1}">
					<a href = "javascript:jsPageNo(${result.board.navStart-1 })">&lt;</a>
				</c:if>
				<c:forEach var="item" begin="${result.board.navStart }" end="${result.board.navEnd }">
					<c:choose>
						<c:when test="${result.board.pageNo!= item }">
							<label><a href="javascript:jsPageNo(${item })">${item}</a></label>
						</c:when>
						<c:otherwise>
							<strong>${item}</strong>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${result.board.navEnd != result.board.totalPageSize }">
					<a href="javascript:jsPageNo(${result.board.navEnd+1 })">&gt;</a>
				</c:if>
				
			</div>
			<!-- <div>
			<input type="button" id="moreBtn" value="더보기" onclick="jsMoreBoard()"/>
		</div> -->
			
			
			<a href="<c:url value='/admin/main.do'/>">메인페이지로</a> 
			<a id="root-register">게시글작성</a>

				<input class="delete-button" type='submit' value="삭제" onclick="jsSelectedDelete()">

		</div>
	</form>
	 <!-- 게시글을 삭제하기 위한 form -->
</div>	
	
	<script type="text/javascript">
//	function nextMoreBoard(pageNo){
//		document.querySelector("#pageForm > #pageNo").value = pageNo+1;
		//페이지번호가 계속 기본값 10으로 초기화되는 문제가 발생해서 그냥 직접 대입해줬음
//		document.querySelector("#pageForm > #pageLength").value = ${result.board.pageLength};

//		document.querySelector("#pageForm").submit();
//	}
//다음페이지로
	function jsPageNo(pageNo){
		document.querySelector("#pageForm > #pageNo").value = pageNo;
		//페이지번호가 계속 기본값 10으로 초기화되는 문제가 발생해서 그냥 직접 대입해줬음
		document.querySelector("#pageForm > #pageLength").value = ${result.board.pageLength};
		document.querySelector("#pageForm").submit();
	}
	//검색했을때는 페이지 번호가 1로 초기화 되도록한다.
	function jsSearchValue(){
		document.querySelector("#mForm > #pageNo").value = "1";
		return true;
	}
	
	function jsCheckbox(){
		let allChk = document.querySelector("#chk");
	    let boardIds = document.querySelectorAll(".boardid");
	    
	    boardIds.forEach(e=>e.checked = allChk.checked);
        
	}

	//체크박스 게시글 삭제
	function jsSelectedDelete(){
		if (!confirm("선택한 게시글을 삭제하시겠습니까?")) return false;
		
		var boards = []
		var checkboxes = document.querySelectorAll("input[name='boardid']:checked");

		checkboxes.forEach(function(checkbox) {
			boards.push(checkbox.value);
			var first = checkbox.parentNode;
			//if(first && first.tagName=== 'TR')
				//한줄 dom객체 날리기
			first.parentNode.parentNode.removeChild(first.parentNode);
		});
		
		
	    const param = {
		     boards:boards,
		     deleteCount:boards.length
	};
		     
		     
	    $.ajax({
	        url: "<c:url value='/admin/notice/DeleteSelectNotice.do'/>",
	        type: "POST",
	        contentType: "application/json; charset=UTF-8",
	        data: JSON.stringify(param),
	        dataType: "json",
	        success: function(json) {
	            alert(json.message);
	            if (json.status) {
// 	                location.href = "<c:url value='/admin/notice/AdminNotice.do'/>";
	                //history.back();
	                const noticeList = json.noticeList;
	                
	                for(let i=0;i<noticeList.length;i++){
	                	const notice = noticeList[i];
	                	var noticeInfo = [];
	                	
	                	noticeInfo += "<tr >";
	                	noticeInfo += "<th><input type='checkbox' class='boardid' name='boardid' value='"+notice.boardid+"'></th>";
	                	noticeInfo += "<td class='kk'>"+notice.boardid+"</td>";
	                	noticeInfo += "<td class='viewDetail' data-server-id='"+notice.boardid+"'>"+notice.title+"</td>";
	                	noticeInfo += "<td>"+notice.hit+"</td>";
	                	noticeInfo += "<td>"+notice.memberid+"</td>";
	                	noticeInfo += "<td ><button class='deleteOne' data-server-id='"+notice.boardid+"'>삭제</button></td>";
	                	noticeInfo += "</tr>";
	                	
	                	$('#noticeList').html($('#noticeList').html()+noticeInfo);
	                }
	                               
	                
	                
	                
	            }
	        }
	    });
		
	}
		
	
	


		
	</script>



</body>
</html>