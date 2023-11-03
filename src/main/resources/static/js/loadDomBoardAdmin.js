/**
 * 
 */
$( function() {
	
	//이거는 체크박스 선택부분
    // "boardid" 클래스를 가진 모든 체크박스 요소를 선택합니다.
    const boardCheckboxes = document.querySelectorAll(".boardid");

    // "chk" 체크박스 요소를 선택합니다.
    const chkCheckbox = document.getElementById("chk");

    // 각 "boardid" 체크박스에 대한 클릭 이벤트를 추가합니다.
    boardCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("click", function () {
        	const allSelected = Array.from(boardCheckboxes).every((cb) => cb.checked);

            // "chk" 체크박스의 체크 상태를 변경합니다.
            chkCheckbox.checked = allSelected;
        });
    });
	
	
	
  var dialog;

 
//ajax가 들어가야할 부분
  function addBoard() {
	 

    var form = $('#insertBoard')[0];
    var formData = new FormData(form);
 
    $.ajax({
        url : InsertBoard,/**수정할 url***/
        type : 'POST',
        data : formData,
        contentType : false,
        processData : false ,
        success:function(json){
        	 if (json.status) {
	   			  alert(json.message);
	   	    	  location.href = AdminBoard; /**board 전체리스트 보기 url***/
	   	      }else{
     			  alert(json.message);
	   		  }
        }
        
    });

  }

  


/*게시글 상세보기 */ 
/*게시글 수정*/

/**게시글 수정 함수 */
function reviseBoard(){
	 var radioValue = document.querySelector('input[name="boardtype"]:checked').value;
	const param = {
		        title: $("#revise-title").val(),
		        contents: $("#revise-contents").val(),
		        fixed_yn : $("#revise-fixed_yn").val(),
		        boardtype : radioValue,
		        memberid: $("#revise-memberid").val()
		      };

		      fetch(ReviseBoard, {/**수정할 url***/
		        method: "POST",
		        headers: {
		          "Content-Type": "application/json; charset=UTF-8",
		        },
		        body: JSON.stringify(param),
		      })
		      .then((response) => response.json())
		      .then((json) => {
		    	  alert(json.message);
		    	  if(json.status){
		    		  location.href = AdminBoard;
		    		  
		    	  }
		      });
}

  /**사용자인지 확인하고 수정 폼띄우기 */
function reviseForm(){
	const param = {
        boardid:$("#board-id").text(),
        memberid:$("#loginMember").text()
		};

      fetch(ReviseBoardForm , {/**수정할 url***/
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
      })
      .then((response) => response.json())
      .then((json) => {
		  if(json.status){
	    	  reviseDialog.dialog("open");
			  
		  }else{
			  alert(json.message);
		  }
          
      });
	
}

/* 게시글 삭제 */
function deleteBoard(){
	 const param = {
        boardid:$("#board-id").text(),
        memberid:$("#loginMember").text()
		};
	 
      fetch(DeleteBoard , {/**수정할 url***/
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
      })
      .then((response) => response.json())
      .then((json) => {
    	  
    	  alert(json.message);
    	  if(json.status){
    		  location.href = AdminBoard;
    		  
    	  }
          
      });
}

//답글달기
function insertBoardReply(){
	
	var form = $('#boardReply')[0];
    var formData = new FormData(form);
    
    $.ajax({
        url : InsertBoardReply ,
        type : 'POST',
        data : formData,
        contentType : false,
        processData : false,        
        success:function(json){
        	if (json.status) {
  			  alert(json.message);
  	    	  location.href = AdminBoard; 
  	      }else{
    			  alert(json.message);
  		  }
        }
    });	
}



dialog = $( "#insert-Form" ).dialog({
    //페이지로드시 자동으로 열림 방지
    autoOpen: false,
    height: 750,
    width: 500,
    //다른거 안눌림
    modal: true,
    //버튼을 누르면 adduser함수 실행
    buttons: {
      //여기에 등록버튼을 누르면 보내줄 ajax등록해야함
      "게시글 등록": addBoard,
      //cancel버튼은 창을 닫음
      "취소": function() {
        dialog.dialog( "close" );
      }
    },
    //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
    close: function() {
      //폼초기화
      $('#insertBoard')[0].reset();
      $('.attachFile-insert').remove();
    }
  });

//create new user 버튼을 클릭하면 팝업 나옴
$( "#registerBoard" ).on( "click", function() {
    dialog.dialog( "open" );
  });
	viewDialog = $( "#view-Form" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 1000,
	    width: 1200,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
	    	"답글": function(){
	    		boardReplyDialog.dialog("open");
	    	},
			"수정": reviseForm,
			"삭제": deleteBoard,
	      	"닫기": function() {
	        viewDialog.dialog( "close" );
	        $('.attachFile-view').remove();
	        $('#replyList').html("");
	      }
	    }
  });
  reviseDialog = $( "#revise-Form" ).dialog({
    //페이지로드시 자동으로 열림 방지
    autoOpen: false,
    height: 600,
    width: 450,
    //다른거 안눌림
    modal: true,
    //버튼을 누르면 adduser함수 실행
    buttons: {
		"수정": reviseBoard,
      	"닫기": function() {
        reviseDialog.dialog( "close" );
      }
    },
    //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
    close: function() {
      //폼초기화
      $( "#reviseBoard" )[0].reset();
  
      
    }
  });
  boardReplyDialog = $( "#boardReply-Form" ).dialog({
	  //페이지로드시 자동으로 열림 방지
	  autoOpen: false,
	  height: 600,
	  width: 450,
	  //다른거 안눌림
	  modal: true,
	  //버튼을 누르면 adduser함수 실행
	  buttons: {
		  "등록": insertBoardReply,
		  "닫기": function() {
			  boardReplyDialog.dialog( "close" );
		  }
	  },
	  //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
	  close: function() {
		  //폼초기화
		  $( "#boardReply" )[0].reset();
		  $('.attachReplyFile-insert').remove();
		  
	  }
  });
	
	$(".viewDetail").click(function(){
		var p_boardid = $(this).data("server-id");
		const param = {
			     boardid:p_boardid
		};
		$.ajax({
			url:ViewOneBoard ,/**수정할 url***/
			method: "POST",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(param),
			dataType:"json",
			success:function(json){
				const board = json.board;
				const replyList = json.replyList;
				const attachList = json.attachList;
				
				
				
				$("#board-id").text(board.boardid);
				$("#board-title").text(board.title);
				$("#board-memberid").text(board.memberid);
				$("#board-regdate").text(board.regdate);
				$("#board-hit").text(board.hit);
				$("#board-contents").text(board.contents);
				
				var replyInfo = [];
				for(let i=0;i<replyList.length;i++){
					const reply = replyList[i];
					
					replyInfo += "	<div class=\"delete-block\">";
					replyInfo += "<input style =\"display: none;\" id=\"boardid\" name =\"boardid\" value='"+reply.boardid+"'/> ";
					replyInfo += "	<input style =\"display: none;\" id=\"replyid\" name=\"replyid\" value='"+ reply.replyid +"'/>";
					replyInfo += "	<span class=\"comment-id\">" + reply.memberid + "</span>";
					replyInfo += "	<span class=\"comment-time\">" + reply.regdate + "</span>";
					replyInfo += "	<textarea  id=\"reviseReply\" data-replyid='"+reply.replyid+"' class=\"comment\" name=\"comment\" cols=\"60\" rows=\"5\" disabled>"+reply.comments+"</textarea>";
					if(json.loginMember==reply.memberid){
						replyInfo += "	<div class=\"userButton\">"
						replyInfo += "	<button  class=\"edit-button\" name=\"submitValue\" type=\"button\" data-replyid='"+reply.replyid+"'>수정</button>";
						replyInfo += "	<button  class=\"delete-button\" type=\"button\" name=\"submitValue\" data-replyid='"+reply.replyid+"'>삭제</button>";
						replyInfo += "	</div>";
					}
					replyInfo += "	</div>";
					
				}
				$("#replyList").html($('#replyList').html()+replyInfo);
				
				
				
				var attachInfo = [];
				
				for(let i=0;i<attachList.length;i++){
					const attach = attachList[i];
					if(attach.content_type.startsWith('image')){
						attachInfo += "<tr class = 'attachFile-view'>";
						attachInfo += "<th>첨부파일</th>";
						attachInfo += "<td colspan='5'>";
						attachInfo += "<img src='"+downloadFile+attach.fileNo+"'>";
						attachInfo +=		"</td>";
						
						attachInfo += "</td>";
						attachInfo += "</tr>";
					}else{
						attachInfo += "<tr class = 'attachFile-view'>";
						attachInfo += "<th>첨부파일</th>";
						attachInfo += "<td colspan='5'>";
						attachInfo += "<a href='"+downloadFile+attach.fileNo+"'>";
						attachInfo += attach.file_name_org
						attachInfo +=	"</a>";
						
						attachInfo +=		"</td>";
						attachInfo += "</tr>";
					}
					

				}

				$('#view-table').html($('#view-table').html()+attachInfo);
				
				viewDialog.dialog("open");
			}
			
		});
		
	});
	
	//이거는 댓글 등록 버튼을 누르면 댓글이 딱 등록되게 한거임
	$( "#insertReplyButton" ).on( "click", function() {
		var p_boardid = $(this).data("server-id");
		const param = {
			     comments:$('#insert-comments').val(),
			     memberid:$('#insert-userid').val()
		};
		$.ajax({
			url:InsertReply ,/**수정할 url***/
			method: "POST",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(param),
			dataType:"json",
			success:function(json){
				if(json.status){
					alert(json.message);
					const reply = json.reply;
					
					var replyInfo = [];
					
					replyInfo += "	<div class=\"delete-block\">";
					replyInfo += "	<span class=\"comment-id\">" + reply.memberid + "</span>";
					replyInfo += "	<span class=\"comment-time\">" + reply.regdate + "</span>";
					replyInfo += "	<textarea  id=\"reviseReply\" data-replyid='"+reply.replyid+"' class=\"comment\" name=\"comment\" cols=\"60\" rows=\"5\" disabled>"+reply.comments+"</textarea>";
					if(json.loginMember==reply.memberid){
						replyInfo += "	<div class=\"userButton\">"
						replyInfo += "	<button  class=\"edit-button\" name=\"submitValue\" type=\"button\" data-replyid='"+reply.replyid+"'>수정</button>";
						replyInfo += "	<button  class=\"delete-button\" type=\"button\" name=\"submitValue\" data-replyid='"+reply.replyid+"'>삭제</button>";
						replyInfo += "	</div>";
					}
					replyInfo += "	</div>";
						
					
					$("#replyList").html(replyInfo+$('#replyList').html());
					$("#insertReply")[0].reset();
				}
				else{
					alert(json.message);
				}
				
			}
			
		});
	});
	
	
	//댓글 수정버튼!!
	 $(document).on("click", ".edit-button", function () {
	        var p_replyid = $(this).data("replyid");
	        var p_comments = $("textarea[data-replyid='" + p_replyid + "']");
	        if ($(this).text() == '수정') {
	            p_comments.prop("disabled", false);
	            $(this).text("수정완료");
	            return;
	        } else {
	        	$(this).text("수정");
	        	p_comments.prop("disabled", false);
	            const param = {
	                replyid: p_replyid,
	                comments: p_comments.val()
	            };
	            $.ajax({
	                url: UpdateReply ,/**수정할 url***/
	                method: "POST",
	                contentType: "application/json; charset=UTF-8",
	                data: JSON.stringify(param),
	                dataType: "json",
	                success: function (json) {
	                    if (json.status) {
	                        alert(json.message);
	                    } else {
	                        alert(json.message);
	                    }
	                }
	            });
	        }
	    });
	 //댓글 삭제버튼!!
	 $(document).on("click", ".delete-button", function () {
		 const flag = confirm("댓글을 삭제하시겠습니까?");
		 if(!flag){
			 return;
		 }
		 var p_replyid = $(this).data("replyid");
		 var local = $(this)
			 const param = {
					 replyid: p_replyid,
			 };
			 $.ajax({
				 url : DeleteReply ,/**수정할 url***/
				 method: "POST",
				 contentType: "application/json; charset=UTF-8",
				 data: JSON.stringify(param),
				 dataType: "json",
				 success: function (json) {
					 if (json.status) {
						 local.closest("div.delete-block").remove();
						 alert(json.message);
					 } else {
						 alert(json.message);
					 }
				 }
			 });
		 
	 });
	 
	 //더보기 버튼
		$( "#moreBtn" ).on( "click", function() {
			//#replyList div태그 안의 가장 마지막 div태그를 가져와서 DOM 객체 Object를 갖는 lastDelete_block
			var lastDelete_block = $('#replyList .delete-block:last');
			//가장마지막 DOM객체 안에서 수정버튼안에 속성 data-replyid에 대입되어있는 값을 가져온다.
			var p_replyid = lastDelete_block.find('.comment').data('replyid');
			//-->이제 더보기를 누르면 가장 마지막의 댓글 번호 이후의 댓글을 가져올 수있다.
			const param = {
					 replyid: p_replyid,
			 };
			 $.ajax({
				 url: GetReplyList ,/**수정할 url***/
				 method: "POST",
				 contentType: "application/json; charset=UTF-8",
				 data: JSON.stringify(param),
				 dataType: "json",
				 success: function (json) {
					var replyList = json.replyList;
					
					for(let i=0;i<replyList.length;i++){
						var reply = replyList[i];
						
						var replyInfo = [];
						
						replyInfo += "	<div class=\"delete-block\">";
						replyInfo += "	<span class=\"comment-id\">" + reply.memberid + "</span>";
						replyInfo += "	<span class=\"comment-time\">" + reply.regdate + "</span>";
						replyInfo += "	<textarea  id=\"reviseReply\" data-replyid='"+reply.replyid+"' class=\"comment\" name=\"comment\" cols=\"60\" rows=\"5\" disabled>"+reply.comments+"</textarea>";
//						replyInfo += "	<c:if test=\"${(not empty loginMember) && (loginMember.uid == '"+reply.memberid+"')  }\">";
						if(json.loginMember==reply.memberid){
							replyInfo += "	<div class=\"userButton\">"
							replyInfo += "	<button  class=\"edit-button\" name=\"submitValue\" type=\"button\" data-replyid='"+reply.replyid+"'>수정</button>";
							replyInfo += "	<button  class=\"delete-button\" type=\"button\" name=\"submitValue\" data-replyid='"+reply.replyid+"'>삭제</button>";
							replyInfo += "	</div>";
						}
//						replyInfo += "	</c:if>";
						replyInfo += "	</div>";
						
						
						$("#replyList").html($('#replyList').html()+ replyInfo);
						
					}
				 }
			 });
			
			
		});
		
		


} );



	