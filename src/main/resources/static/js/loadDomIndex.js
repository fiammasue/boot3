/**
 * 
 */

 $(function(){
	 viewDialog = $( "#view-Form" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 500,
	    width: 650,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
	      	"닫기": function() {
	        viewDialog.dialog( "close" );
	      }
	    }
  });//viewDialog
  
   $(document).on("click",".viewDetail",function(){
		var p_boardid = $(this).data("server-id");
		var p_url = $(this).data("url");
		const param = {
			     boardid:p_boardid
		};
		$.ajax({
			url:p_url,
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
	 
})//끝