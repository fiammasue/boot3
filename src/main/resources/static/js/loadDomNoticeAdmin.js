/**
 * dom객체가 생성이 되면 실행
 */
$(function(){
	
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

	/**함수선언부 */
	/**게시글 추가  */
	function addNotice(){
		var radioValue = document.querySelector('input[name="boardtype"]:checked').value;
	    const param = {
		        title: $("#insert-title").val(),
		        contents: $("#contents").val(),
		        boardtype : radioValue,
		        fixed_yn: ($('#fixed_yn:checked').length===0)? 'N' : 'Y',
		        memberid: $("#insert-memberid").val()
		      };
		    $.ajax({
		    	url:InsertNotice ,/****url 수정****/
		    	type:"POST",
		    	contentType: "application/json; charset=UTF-8",
		    	data:JSON.stringify(param),
		    	dataType:"json",
		    	success:function(json){
		    		if(json.status){
		    			alert(json.message);
		    			location.href = AdminNotice; 
		    		}else{
		    			alert(json.message);
						
					}
		    	}
		    }); 
	}
//	function reviseForm(){
//		const param = {
//	        boardid:$("#notice-id").text(),
//	        memberid:$("#loginMember").text()
//		};
//
//      fetch("/legacy/admin/notice/ReviseNoticeForm.do", {/****url 수정****/
//        method: "POST",
//        headers: {
//          "Content-Type": "application/json; charset=UTF-8",
//        },
//        body: JSON.stringify(param),
//      })
//      .then((response) => response.json())
//      .then((json) => {
//		  if(json.status){
//	    	  reviseDialog.dialog("open");
//			  
//		  }else{
//			  alert(json.message);
//		  }
//          
//      });
//	}
	function deleteNotice(){
		var boards = [];
		boards.push($("#notice-id").text());
		
		

		const param = {
	        boards:boards,
	        memberid:$("#loginMember").text(),
	        deleteCount:boards.length
		};

      fetch(DeleteSelectNotice , {/****url 수정****/
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
      })
      .then((response) => response.json())
      .then((json) => {
		  if(json.status){
    	  alert(json.message);
       	  location.href = AdminNotice; 
			  
		  }else{
		    alert(json.message);	  
		  }
          
      });
	}
	function reviseNotice(){
		var radioValue = document.querySelector('input[name="boardtype"]:checked').value;
		console.log(($('#revise-fixed_yn:checked').length===0)? 'N' : 'Y')
		const param = {
	        title: $("#revise-title").val(),
	        contents: $("#revise-contents").val(),
	        boardtype : radioValue,
	        memberid: $("#revise-memberid").val(),
	        fixed_yn :($('#revise-fixed_yn:checked').length===0)? 'N' : 'Y'
	      };

	      fetch(ReviseNotice , {/****url 수정****/
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
	        	  location.href = AdminNotice;
	        	  //history.back();
	          }
	      });
	}
	
	var insertDialog, viewDialog, reviseDialog;

	insertDialog = $( "#insert-Form" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 600,
    	width: 450,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
	      //여기에 등록버튼을 누르면 보내줄 ajax등록해야함
	      "게시글 등록": addNotice,
	      //cancel버튼은 창을 닫음
	      "취소": function() {
	        insertDialog.dialog( "close" );
	      }
	    },
    //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
    close: function() {
      //폼초기화
      $("#insertNotice")[0].reset();
    }
  });
  //게시글 작성 버튼 누르면 insert 창뜬다
    $( "#root-register" ).on( "click", function() {
    insertDialog.dialog( "open" );
  });
	viewDialog = $( "#view-Form" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 500,
	    width: 750,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
			"수정": function(){
				reviseDialog.dialog( "open" );
			},
			"삭제": deleteNotice,
	      	"닫기": function() {
	        viewDialog.dialog( "close" );
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
			"수정": reviseNotice,
	      	"닫기": function() {
	        reviseDialog.dialog( "close" );
	      }
	    },
	    //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
	    close: function() {
		      //폼초기화
		      $( "#reviseNotice" )[0].reset();
    }
  });
  /**이게 부모 요소에 이벤트를 등록해서 자식요소에서 발생한 이벤트를 처리하는 
   * 방식으로 동적으로 생성되는 ajax에 대해서도 처리해준다.
   */
  $(document).on("click",".viewDetail",function(){
		var p_boardid = $(this).data("server-id");
		const param = {
			     boardid:p_boardid
		};
		$.ajax({
			url:ViewOneNotice ,/****url 수정****/
			method: "POST",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(param),
			dataType:"json",
			success:function(json){
				$("#notice-id").text(json.boardid);
				$("#notice-title").text(json.title);
				$("#notice-memberid").text(json.memberid);
				$("#notice-regdate").text(json.regdate);
				$("#notice-hit").text(json.hit);
				$("#notice-contents").text(json.contents);
				
				
				viewDialog.dialog("open");
			}
			
		});
		
	});	
	
	$(document).on("click",".deleteOne",function(){
			var p_boardid = $(this).data("server-id");
			var boards = [];
			boards.push(p_boardid);
			
			var domElement = document.querySelector("[value='" + p_boardid + "']");
			var first = domElement.parentNode;
			//if(first && first.tagName=== 'TR')
			first.parentNode.parentNode.removeChild(first.parentNode);
			
			const param = {
				     boards:boards,
				     deleteCount:boards.length
			};
			$.ajax({
				url:DeleteSelectNotice,/****url 수정****/
				method: "POST",
				contentType: "application/json; charset=UTF-8",
				data: JSON.stringify(param),
				dataType:"json",
				success:function(json){
					alert(json.message);
			          if (json.status) {
	                	const notice = json.noticeList[0];
	                	
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
				
			});
			
		});
	
	
})
