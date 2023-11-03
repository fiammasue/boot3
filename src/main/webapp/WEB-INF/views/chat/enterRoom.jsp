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
	<label id="room_id">${room_id }</label>
	
	<div>
		<div id="chatList" style="float:right;">
			<c:forEach var="message" items="${chatList }">
				<span class="badge rounded-pill text-bg-warning">${message.message }</span>
			</c:forEach>
		</div>
	
		<input type="text" id="chatContent" style="width:50%;float:right;"/>
		<button type="button" id="sendMessage" style="float:right;">전송</button>
	</div>
	<script type="text/javascript">
		//웹소켓 연결
		const sock = new SockJS("/ws-stomp");
		const ws = Stomp.over(sock);
		var subscription = null;
		const sender = "${loginMember.uid}";
		console.log("sender ",sender);
		
		//웹소켓 구독
		ws.connect({},function(frame){
			subscription = ws.subscribe("/sub/chat/room/${room_id}"
					,message => {//구독한곳에서 메시지가 오면
						const recv = JSON.parse(message.body);//메시지 파싱
						recvMessage(recv);
					}, {sender:sender});//보내는 사람을 등록할필요가 있나?
							
		},error => {
			alert("error "+error);
		});
		
		//메시지를 입력하고 엔터를 눌렀다면 전송가자!!
		$("#sendMessage").on("click",e =>{

				if(subscription == null) return;
				const message = $("#chatContent").val();//메시지 내용
				//메시지 보내기
				ws.send("/pub/chat/message",{},JSON.stringify({
																room_id:$("#room_id").text()
																,message:$("#chatContent").val()
																,sender:sender
																}));
				//메시지 창 비우기
				$("#chatContent").val("");
		});
		
		
		const recvMessage = recv => {
			var chatListInfo = `<span class="badge rounded-pill text-bg-warning">`+recv.message+`</span>`
			$("#chatList").append(chatListInfo);
		}
		
	</script>
</body>
</html>