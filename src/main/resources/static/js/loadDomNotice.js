/**
 * dom객체가 생성이 되면 실행
 */
$(function(){
	
	
	var  viewDialog;


	viewDialog = $( "#view-Form" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 500,
	    width: 800,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
	      	"닫기": function() {
	        viewDialog.dialog( "close" );
	      }
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
			url:ViewOneNotice,
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
	

	
})
