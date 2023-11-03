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
			//입장하면 접속자 수를 하나 늘린다. sender는 필요없을것
			ws.send("/pub/chat/message", {}
	        , JSON.stringify({type:'ENTER',room_id:$("#room_id").text(), sender : sender}));			
		},error => {
			alert("error "+error);
		});
		
		//메시지를 입력하고 엔터를 눌렀다면 전송가자!!
		$("#sendMessage").on("click",e =>{

				if(subscription == null) return;
				const message = $("#chatContent").val();//메시지 내용
				//메시지 보내기
				ws.send("/pub/chat/message",{},JSON.stringify({
																type:'TALK'
																,room_id:$("#room_id").text()
																,message:$("#chatContent").val()
																,sender:sender
																}));
				//메시지 창 비우기
				$("#chatContent").val("");
		});
		
		//받아온 메시지 처리 -> 구독할때 등록해준다.
		const recvMessage = recv => {
			var chatListInfo = `<span class="badge rounded-pill text-bg-warning">`+recv.message+`</span>`
			$("#chatList").append(chatListInfo);
		}
		
		//페이지를 나가거나 브라우저를 끄면 실행되는 이벤트
		$(window).on("beforeunload", e => {
			unsubscribe();
		});
		
		//연결 해제
		const unsubscribe = () => {
			//나 퇴장할꺼다 메세지를 전달해서 방의 연결자수를 줄인다.
			ws.send("<c:url value='/pub/chat/message'/>", {}
	        , JSON.stringify({type:'LEAVE',room_id:$("#room_id").text(), sender : sender}));
			//구독 해제
			if(subscription != null){
				subscription.unsubscribe();
				subscription = null;
			}
			//stomp 연결종료
			ws.disconnect(() => {
				console.log("stomp 연결 종료")
			}, {});
		}
		
	</script>
</body>
</html>