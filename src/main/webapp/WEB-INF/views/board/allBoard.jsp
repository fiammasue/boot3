<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %> 
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판전체보기</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<%-- <script  src="<c:url value='/resources/js/Project-Context.js'/>"></script> --%>
<script  src="<c:url value='/js/loadDomBoard.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/css/viewBox.css'/>">
<link rel="stylesheet" href="<c:url value='/css/insertBox.css'/>">
<link rel="stylesheet" href="<c:url value='/css/allBoard.css'/>">

</head>
<body>
<!--  회원정보가 필요하다 -->
<label id="loginMember" style="display:none;" >${loginMember.uid}</label>

<!-- 게시판작성 폼을 숨겨보자!  -->
<div id="insert-Form" style="display:none">
	<form id="insertBoard" action="<c:url value='/board/InsertBoard.do'/>" method="post" enctype="multipart/form-data" autocomplete="off" onSubmit="return false;">
		<!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
		<table class="insertTB">
			<caption>
				<span>게시글 작성</span>
			</caption>
			
			
			<tr>
				<th class="col">작성자</th>
				<td><input type="text" name="memberid" id="memberid" value="${loginMember.uid}" readonly  class="text ui-widget-content ui-corner-all"/></td>
			</tr>
			<tr>
				<th class="col"><label for="title">제목</label></th>
				<td><input type="text" name="title" id="title"  class="text ui-widget-content ui-corner-all"/></td>
			</tr>
			<tr>
				<th class="col"><label for="contents">내용</label></th>
				<td><textarea form="insertBoard" name="contents" id="contents"  class="text ui-widget-content ui-corner-all" ></textarea></td>
			</tr>
			
			<tr>
				<th class="col"><label>글종류</label></th>
				<td>
					<div class="boardType">
						<input id="m" type="radio" name="boardtype" value="게시판" checked readonly  class="text ui-widget-content ui-corner-all"> <label for="m">게시판</label>
					</div>
				</td>
			</tr>
			
			<tr id="boardAttach">
				<th><button type="button"  value="파일추가" onClick="fn_addFile()">파일추가</button></th>
				<td>버튼을 눌러 첨부파일 입력란을 추가하세요</td>
			</tr>
			

		</table>
	</form>
</div>
<!-- 게시판작성 폼  end -->
<!-- 답글 작성폼 폼을 숨겨보자!  -->
<div id="boardReply-Form" style="display:none">
	<form id="boardReply" action="<c:url value='/board/InsertBoardReply.do'/>" method="post" enctype="multipart/form-data" autocomplete="off" onSubmit="return false;">
		<!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
		<table class="insertReplyTB">
			<caption>
				<span>답변 작성</span>
			</caption>
			<tr>
				<th class="col">작성자</th>
				<td><input type="text" name="memberid" id="boardReply-memberid" value="${loginMember.uid}" readonly  class="text ui-widget-content ui-corner-all"/></td>
			</tr>
			<tr>
				<th class="col"><label for="title">제목</label></th>
				<td><input type="text" name="title" id="boardReply-title"  class="text ui-widget-content ui-corner-all"/></td>
			</tr>
			<tr>
				<th class="col"><label for="contents">내용</label></th>
				<td><textarea form="boardReply" name="contents" id="boardReply-contents"  class="text ui-widget-content ui-corner-all" ></textarea></td>
			</tr>
			<tr>
				<th class="col"><label>글종류</label></th>
				<td>
					<div class="boardType">
						<input id="m" type="radio" name="boardtype" value="게시판" checked readonly  class="text ui-widget-content ui-corner-all"> <label for="m">게시판</label>
					</div>
				</td>
			</tr>
			<tr id="boardReplyAttach">
				<th><button type="button"  value="파일추가" onClick="fn_addReplyFile()">파일추가</button></th>
				<td></td>
			</tr>
			
		</table>
	</form>
</div>
<!-- 답글작성 폼  end -->
<!-- 글 상세보기 -->
<div id="view-Form" style="display:none">

<label id="board-id" style="display:none;">${board.boardid}</label>
	<table class="post">
		<tbody id="view-table">
			<tr>
				<th>제목</th>
				<td colspan="5" id="board-title">${board.title}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td id="board-memberid">${board.memberid}</td>
				<th>작성날짜</th>
				<td id="board-regdate">${board.regdate}</td>
				<th>조회수</th>
				<td id="board-hit">${board.hit}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="5"><textarea style="margin-left: -3px;" id="board-contents" cols="60" rows="10" readonly>${board.contents}</textarea></td>
			</tr>
			
			
	<%-- 		<tr>
				<th>첨부파일</th>
				<td colspan="5"><img src="<c:url value='/attach/download.do?fileNo='/>${attacheFile.fileNo}"></td>
			</tr>  
			<tr>
				<th>첨부파일</th>
				<td colspan="5">
				<a href="<c:url value='/attach/download.do?fileNo='/>"${attachFile.fileNo }></a>
				<img src="<c:url value='/attach/download.do?fileNo='/>${attacheFile.fileNo}">
				
				</td>
			</tr> --%>  
			
			
			
		</tbody>
	</table>
	
	
	<!-- 댓글 입력폼 시작-->
	 <form id="insertReply" action="<c:url value='/reply/InsertReply.do'/>" method="post" onSubmit="return false;">
            
          <label for="comment" id="comment">댓글 입력</label>
          <input id="insert-userid" name="memberid" value="${loginMember.uid}" readonly>
            <textarea style="margin-left: -3px; margin-top: 5px;" id="insert-comments" form="insertReply" class="comment" name="comment" cols="60" rows="5"></textarea>
            <div class="userButton">
            <c:if test='${not empty loginMember}'>
              <button id="insertReplyButton" type="button">등록</button>
             </c:if>
            </div>
        </form>
	<!-- 댓글 입력폼 끝 -->
            <!-- Sample existing comment -->
        <!-- 복사해서 사용할 태그임 이걸 추가 해줘야함-->
        
        
        
        <div id="replyList"></div>
        
        <div>
			<input type="button" id="moreBtn" value="더보기"/>
		</div>
		
        </div>
     <%-- <div class=\"delete-block\">     
     <span class="comment-id">${reply.memberid }</span>
           <span class="comment-time">${reply.regdate }</span>
            <textarea  id="reviseReply" data-replyid="${reply.replyid}" class="comment" name="comment" cols="60" rows="5" disabled>${reply.comments}</textarea>
        <c:if test="${loginMember.uid eq reply.memberid }">
            <div class="userButton">
            <button  class="edit-button" name="submitValue"type="button" data-replyid="${reply.replyid}">수정</button>
            <button  class="delete-button" type="button" name="submitValue" data-replyid="${reply.replyid}">삭제</button>
            </div>
        </c:if> 
        </div> --%> 
	<!-- 복사해서 사용할 태그임 이걸 추가 해줘야함-->


<!-- 글 상세보기 end-->
<!-- 글 수정하기 -->
<div id="revise-Form" style="display:none">
<form id="reviseBoard" action="<c:url value='/board//ReviseBoard.do'/>" method="get" autocomplete="off" onsubmit="return false;">
            <!-- 현재 아이디를 기본으로 입력하고 있어서 아이디 변경은 없었으면 좋겠다...jsp인가? -->
            <table class="tb">
                <caption><span>게시글 수정</span></caption>
                <tr>
                    <th class="col">작성자</th>
                    <td> <input type="text" name="memberid" id="revise-memberid" value="${loginMember.uid}" readonly/>
                      </td>
                </tr>
                <tr>
                    <th class="col"><label for="title">제목</label></th>
                    <td> <input type="text" name="title" id="revise-title"/></td>
                </tr>
                <tr>
                    <th class="col"><label for="contents">내용</label></th>
                    <td><textarea form="reviseBoard" name="contents" id="revise-contents"></textarea></td>
                </tr>
                <tr>
                    <th class="col"><label>글종류</label></th>
                    <td>
                    <div class="boardType">
                        <input id="m" type="radio" name="boardtype" value="게시판" checked readonly  class="text ui-widget-content ui-corner-all"> <label for="m">게시판</label>
                   </div>
                   </td>
                </tr>
            </table>
            <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </form>
    </div>
<!-- 글 수정하기 end -->



<div id="main">
<form name="pageForm" id="pageForm" action="<c:url value='/board/AllBoard.do'/>" method="post">
		<input type="hidden" name="pageNo" id="pageNo" value="${result.board.pageNo}"/>
		<input type="hidden" name="searchTitle" id="searchTitle" value="${ result.board.searchTitle}"/>
		<input type="hidden" name="pageLength" id="pageLength" value="${result.board.pageLength} "/>
	
	</form>
	
<div id="searchBoard">
	<form onSubmit="jsSearchValue()"name="mForm" id="mForm" action="<c:url value='/board/AllBoard.do'/>" method="post">
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
	<form action="<c:url value='/board/DeleteSelectPage.do'/>" method='post' onsubmit="return false;">
		<div id="contain">
		    <table class="tb">
		      <caption>게시판</caption>
		      
		      <tbody id="boardList">
		        <tr class="head">
		          <th>글번호</th>
		          <th>제목</th>
		          <th>조회수</th>
		          <th>작성자</th>
		        </tr>
		
		<c:if test="${not empty result.boardList}">
		
		<c:forEach var="board" items="${result.boardList }">
		<tr >
				<td class="kk">${board.boardid}</td>
				<td class="viewDetail" data-server-id="${board.boardid }"
							style="text-align: left; padding-left:${(board.level-1)*20}px;width: 25%;">${board.level != 1? "ㄴ[답변]":""} ${board.title}</td>
				<td>${ board.hit}</td>
				<td>${ board.memberid}</td>
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
		
		
		
		
		
		
		
		<a href="<c:url value='/main/Index.do'/>">메인페이지로</a>
		<c:if test="${not empty loginMember}">
			<a href="#" id="registerBoard">게시글작성</a>
		</c:if>
		
		
		
		</div>
	</form>
<!-- 게시글을 보러가기 위한 boardid전달 폼 -->
     
   </div>  
     
      
	<script type="text/javascript">
	var cnt =1 ; 
	function fn_addFile(){
		var fileInfo = "<tr class='attachFile-insert'> <th>첨부파일</th> <td><input type='file' name='file"+cnt+"'/></td> </tr>";
		$('.insertTB').find("tr:last").after(fileInfo);
		cnt++;
		return false;
	}
	var cnt =1 ; 
	function fn_addReplyFile(){
		
		var fileInfo = "<tr class='attachReplyFile-insert'> <th>첨부파일</th> <td><input type='file' name='file"+cnt+"'/></td> </tr>";
		$('.insertReplyTB').find("tr:last").after(fileInfo);
		cnt++;
		
		return false;
	}
	
		function jsPageNo(pageNo){
			document.querySelector("#pageForm > #pageNo").value = pageNo;
			//페이지번호가 계속 기본값 10으로 초기화되는 문제가 발생해서 그냥 직접 대입해줬음
			document.querySelector("#pageForm > #pageLength").value = ${result.board.pageLength};
			document.querySelector("#pageForm").submit();
		}
		
		
		function jsSearchValue(){
			document.querySelector("#mForm > #pageNo").value = "1";

			return true;
		}
		function jsCheckbox(){
			let allChk = document.querySelector("#chk");
		    let boardIds = document.querySelectorAll(".boardid");
		    
	        boardIds.forEach(e=>e.checked = allChk.checked);
			
		}
	/*	    allChk.addEventListener("change", function() {
		    	
	            for (let i = 0; i < boardIds.length; i++) {
	                chkBox[i].checked = allChk.checked;
	            }
	
		        });*/
			/*function jsDetailView(noticeId) {
		        	const param = {
					        boards:boards
					};
		
					      fetch("DeleteSelectPage.do", {
					        method: "POST",
					        headers: {
					          "Content-Type": "application/json; charset=UTF-8",
					        },
					        body: JSON.stringify(param),
					      })
					      .then((response) => response.json())
					      .then((json) => {
					    	  alert(json.message);
					          if (json.status) {
					        	  location.href = "<c:url value='/board/${boardtype}'/>";
					        	  //history.back();
					          }
					      });	
		        	
				document.querySelector("#dForm > #boardid").value = noticeId;
				dForm.submit();	
				
				
				 
			}*/
			/*function jsPageNo(pageNo){
				document.querySelector("#pageForm > #pageNo").value = pageNo;
				document.querySelector("#pageForm").submit();
			}*/
			function jsSelectedDelete(){
				if (!confirm("선택한 게시글을 삭제하시겠습니까?")) return false;
				
				var boards = []
				var checkboxes = document.querySelectorAll("input[name='boardid']:checked");
	
				checkboxes.forEach(function(checkbox) {
					boards.push(checkbox.value);
				});
			    const param = {
				        boards:boards
				};
	
				      fetch("DeleteSelectPage.do", {
				        method: "POST",
				        headers: {
				          "Content-Type": "application/json; charset=UTF-8",
				        },
				        body: JSON.stringify(param),
				      })
				      .then((response) => response.json())
				      .then((json) => {
				    	  alert(json.message);
				          if (json.status) {
				        	  location.href = "<c:url value='/board/AllBoard.do'/>";
				        	  //history.back();
				          }
				      });
				
			}

			$(".deleteOne").click(function(){
				var p_boardid = $(this).data("server-id");
				const param = {
					     boardid:p_boardid
				};
				$.ajax({
					url:"AjaxDeleteBoard.do",
					method: "POST",
					contentType: "application/json; charset=UTF-8",
					data: JSON.stringify(param),
					dataType:"json",
					success:function(json){
						alert(json.message);
				          if (json.status) {
				        	  location.href = "<c:url value='/board/AllBoard.do'/>";
				        	  //history.back();
				          }
					}
					
				});
				
			});

		
		
		
	</script>

</body>
</html>