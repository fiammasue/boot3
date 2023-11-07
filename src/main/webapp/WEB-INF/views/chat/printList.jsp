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
	<script type="text/javascript">
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
		  	let roomId = $(this).data("roomid");
		  	alert(roomId);
		  	location.href = "/chat/enterRoom/"+roomId;
		  	ws.send("/pub/chat/message", {}
	        , JSON.stringify({type:'ENTER',room_id:roomId, sender : sender}));
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
	</script>
</body>
</html>