<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.2.0/stomp.min.js"></script>
<style>
.chatRoom{
  width: 414px;
  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.3); 
}
.chatRoom-header{
  background-color: #a8c0d6;
}
.cover-image{
  width: 50px;
  height: 50px;
    position: relative;
    top: 26px;
    left: 26px;
    border-radius: 70%;
    overflow: hidden;
}
.userImage{
  width: 100%;
    height: 100%;
    object-fit: cover;
}
.chatRoom-name{
  position: relative;
  top: -33px;
  left: 96px;
  font-size: 20px;
  color: #514d4d;
}
.chatRoom-receiver{
  position: relative;
  top: -30px;
  left: 95px;
}
.wrap {
  padding: 40px 0;
  background-color: #A8C0D6;
  height: 477px;
  overflow-y: scroll;
}


.wrap .chat {
  display: flex;
  align-items: flex-start;
  padding: 20px;
}

.wrap .chat .icon {
  position: relative;
  overflow: hidden;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background-color: #eee;
}

.wrap .chat .icon i {
  position: absolute;
  top: 10px;
  left: 50%;
  font-size: 2.5rem;
  color: #aaa;
  transform: translateX(-50%);
}

.wrap .chat .textbox {
  position: relative;
  display: inline-block;
  max-width: calc(100% - 70px);
  padding: 10px;
  margin-top: 7px;
  font-size: 13px;
  border-radius: 10px;
}

.wrap .chat .textbox::before {
  position: absolute;
  display: block;
  top: 0;
  font-size: 1.5rem;
}

.wrap .ch1 .textbox {
  margin-left: 20px;
  background-color: #ddd;
}

.wrap .ch1 .textbox::before {
  left: -15px;
  content: "◀";
  color: #ddd;
}

.wrap .ch2 {
  flex-direction: row-reverse;
}

.wrap .ch2 .textbox {
  margin-right: 20px;
  background-color: #F9EB54;
}

.wrap .ch2 .textbox::before {
  right: -15px;
  content: "▶";
  color: #F9EB54;
}

.sender-time{
  position: relative;
  top: 26px;
  left: 10px;
  font-size: 14px;
}

.sender-readCount{
  position: relative;
  top: 24px;
  left: 20px;
  color: yellow;
}

.receiver-time{
  position: relative;
  top: 26px;
  right: 9px;
  font-size: 14px;
}

.receiver-readCount{
  position: relative;
  top: 25px;
  right: 20px;
  color: yellow;
}
.chatRoom-footer{
  padding-bottom: 10px;
      background-color: #f7f7f7
  
}
#messageBox{
      width: 493px;
  height: 84px;
  border: none;
  resize: none;
}
#sendMessage{
  position: relative;
  left: 402px;
  background-color: #f9eb54;
  padding: 10px 20px;
  border: none;
  border-radius: 9px;
  cursor: pointer;
  
}


</style>


</head>
<body>
	<label id="loginMember" style="display:none;">${loginMember}</label>
	<div id="roomList">
		<c:forEach var="chatRoom" items="${ roomList}">
			<div class="card text-bg-info mb-3" style="max-width: 18rem;">
	           <div class="card-header" data-roomid="${chatRoom.room_id}">${chatRoom.room_id}</div>
	           <div class="card-body">
	             <h5 class="card-title">${chatRoom.room_name}</h5>
	             <p class="card-text">${chatRoom.receiver}</p>
	           </div>
	         </div>
	      </c:forEach>
	</div>
	
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
	  채팅방 생성하기
	</button>
	<!-- 모달창 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <label for="roomName">채팅방 이름 : </label>
	        <input type="text" id="roomName"/>
	        <label for="receiver">채팅상대 : </label>
	        <input type="text" id="receiver"/>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" id="createRoom" class="btn btn-primary">채팅방 생성</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 모달창끝 -->
	
	
	<!-- 채팅창 -->
	<div class="chatRoom" style="display:none;">
	    <div class="chatRoom-header">
	    <div class="roomId"></div>
	      <div class="cover-image">
	        <img src="/assets/유저.png" alt="" class="userImage">
	      </div>
	      <div class="chatRoom-name">수학, 과학 알려주는 방</div>
	      <div class="chatRoom-receiver">유저삼</div>
	    </div>
	    
	    <div class="wrap">
	        <!-- <div class="chat ch1">
	            <div class="textbox">안녕하세요. 반갑습니다.</div>
	            <div class="sender-time">6:30</div>
	            <div class="sender-readCount">1</div>
	        </div>
	        <div class="chat ch2">
	            <div class="textbox">안녕하세요. 친절한효자손입니다. 그동안 잘 지내셨어요?</div>
	            <div class="receiver-time">6:30</div>
	            <div class="receiver-readCount">1</div>
	        </div>
	        <div class="chat ch1">
	            <div class="textbox">아유~ 너무요너무요! 요즘 어떻게 지내세요?</div>
	        </div>
	        <div class="chat ch2">
	            <div class="textbox">뭐~ 늘 똑같은 하루 하루를 보내는 중이에요. 코로나가 다시 극성이어서 모이지도 못하구 있군요 ㅠㅠ 얼른 좀 잠잠해졌으면 좋겠습니다요!</div>
	        </div> -->
	    </div>
	    <div class="chatRoom-footer">
	      <textarea id ="messageBox"></textarea>
	      <button type="button" id="sendMessage">전송</button>
	    </div> 
	</div>
	<!-- 채팅창 끝 -->
	
	
	
	<script type="text/javascript">
	var roomId = "";
	chatRoom= $( ".chatRoom" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		width: 550,
		//다른거 안눌림
		modal: true,
		//창이 닫혔을때 
		close: function() {
			$("#messageBox").text("");
			ws.send("<c:url value='/pub/chat/message'/>", {}
	        , JSON.stringify({type:'LEAVE',room_id:roomId}));
			$(".wrap").html("");
		}
	});//회원 수정 폼
	
// 		$(document).ready(()=>{
// 			$.ajax({
// 				url:"/chat/createRoom",
// 				method: "POST",
// 				contentType: "application/json; charset=UTF-8",
// 				data: JSON.stringify(param),
// 				dataType:"json",
// 				success:function(json){
// 					 var roomListInfo = `<div class="card text-bg-info mb-3" style="max-width: 18rem;">
//                          <div class="card-header" >`+json.room_id+`</div>
//                          <div class="card-body">
//                            <h5 class="card-title">`+json.room_name+`</h5>
//                            <p class="card-text">`+json.receiver+`</p>
//                          </div>
//                        </div>`;
//   					 $("#roomList").append(roomListInfo);
// 				}
// 			});
// 		});
		
		
		$(document).on("click", ".card-header", function() {
		  	roomId = $(this).data("roomid");
		  	alert(roomId);
// 		  	location.href = "/chat/enterRoom/"+roomId;
		  	ws.send("/pub/chat/message", {}
	        , JSON.stringify({type:'ENTER',room_id:roomId, sender : sender}));
		  	
		  	
		  	$.ajax({
		    	url:"/chat/enterRoom/"+roomId,
		    	type:"GET",
		    	contentType: "application/json; charset=UTF-8",
		    	dataType:"json",
		    	success:function(json){
		    		
		    		 let roomInfo = json.roomInfo;
		    		 let chatList = json.chatList;
		    		 alert(roomInfo)
		    		 $(".chatRoom-name").text(roomInfo.room_name);
		    		 if(roomInfo.sender == "${loginMember.uid}"){
		    			 $(".chatRoom-receiver").html(roomInfo.receiver);
		    		 }
		    		 else{
		    			 $(".chatRoom-receiver").html(roomInfo.sender);
		    		 }
		    		 $(".roomId").text(roomId);
		    		 var chatListInfo = "";
		    		 for(let i=0;i<chatList.length;i++){
		    			 var chat = chatList[i];
		    			 //시간 자르기
		    			 var timestampString = chat.reg_date;

		    			// "T" 문자를 기준으로 문자열을 분할하고 두 번째 부분을 선택
		    			var timePart = timestampString.split("T")[1];

		    			// 시:분 부분만 선택
		    			var time = timePart.substring(0, 5);
		    			
		    			 if(chat.sender != "${loginMember.uid}"){
				    			 chatListInfo+=`<div class="chat ch1">
							    		            <div class="textbox">`+chat.message+`</div>
							    		            <div class="sender-time">`+time+`</div>`;
							   	if(chat.read_yn=='N'){
				    		      chatListInfo+=` <div class="sender-readCount">1</div>`;
							   		
							   	}
							   	chatListInfo+=`</div>`;
		    			 }	
		    			 else{
							  	chatListInfo += `<div class="chat ch2">
							    		            <div class="textbox">`+chat.message+`</div>
							    		            <div class="receiver-time">`+time+`</div>`
							   	if(chat.read_yn=='N'){
					    		   chatListInfo+=` <div class="receiver-readCount">1</div>`;
							   		
							   	}
							    	chatListInfo+=`</div>`;
		    				 
		    			 }
		    			$('.wrap').append(chatListInfo); 
		    		 }
		    		 
		    		 chatRoom.dialog("open");
		    	}
		    }); 
		});
		
		
		$("#createRoom").on("click", e =>{
			const param = {
				room_name : $("#roomName").val(),
				receiver : $("#receiver").val()
			};
			$.ajax({
				url:"/chat/createRoom",
				method: "POST",
				contentType: "application/json; charset=UTF-8",
				data: JSON.stringify(param),
				dataType:"json",
				success:function(json){
					 var roomListInfo = `<div class="card text-bg-info mb-3" style="max-width: 18rem;">
                         <div class="card-header" ><a href="/chat/enterRoom/`+json.room_id+`">`+json.room_id+`</a></div>
                         <div class="card-body">
                           <h5 class="card-title">`+json.room_name+`</h5>
                           <p class="card-text">`+json.receiver+`</p>
                         </div>
                       </div>`;
  					 $("#roomList").append(roomListInfo);
				}
				
			});
		});
		
		
		//메세지 보내기
		$("#sendMessage").on("click",e => {
			alert(" ? ");
			if(subscription == null) return;
			const message = $("#chatContent").val();//메시지 내용
			//메시지 보내기
			ws.send("/pub/chat/message",{},JSON.stringify({
															type:'TALK'
															,type_string:"TALK"
															,room_id:roomId
															,message:$("#messageBox").val()
															,sender:"${loginMember.uid}"
															,receiver:$(".chatRoom-receiver").text()
															}));
			//메시지 창 비우기
			$("#messageBox").val("");
		});
	</script>
</body>
</html>