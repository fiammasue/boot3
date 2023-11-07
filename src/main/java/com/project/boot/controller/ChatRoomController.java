package com.project.boot.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.dto.ChatRoom;
import com.project.boot.dto.Member;
import com.project.boot.service.ChatRoomService;
import com.project.boot.service.MessageService;

@Controller
public class ChatRoomController {
	@Autowired
	private ChatRoomService chatRoomService;
	@Autowired
	private MessageService messageService;
	
	@RequestMapping("/chat/roomList")
	public String goToRoomList(HttpSession session , Model model, ChatRoom room) {
		Member member = (Member)session.getAttribute("loginMember");
		room.setUser_id(member.getUid());
		System.out.println("room");
		model.addAttribute("roomList", chatRoomService.selectRoomList(room));
		return "chat/printList";
	}
	
	@ResponseBody
	@RequestMapping("/chat/createRoom")
	public ChatRoom createRoom(HttpSession session, @RequestBody ChatRoom chatRoom) {
		Member member = (Member)session.getAttribute("loginMember");
		chatRoom.setSender(member.getName());
		chatRoomService.createRoom(chatRoom);
		return chatRoom;
	}
	@ResponseBody
	@RequestMapping("/chat/enterRoom/{room_id}")
	public Map<String,Object> goToEnterRoom( @PathVariable(value="room_id") String roomId) {
		System.out.println("roomInfo -> "+ chatRoomService.findRoomById(roomId));
		Map<String,Object> result = new HashMap<>();
		result.put("roomInfo", chatRoomService.findRoomById(roomId));
		result.put("chatList",messageService.selectMessageList(roomId));
		return result;
	}
	
	//이거 구독할때 사용하는 줄 알았는데 전혀아니네 이거 없어도 돌아감;;
	@GetMapping("/chat/room/{room_id}")
	@ResponseBody
	public ChatRoom roomInfo(@PathVariable(value="room_id") String roomId) {
		//구독 신청을 할때 
	System.out.println("구독하러옴");
		return chatRoomService.findRoomById(roomId);
	}
	
	//구독이 발생했을때 처리하는 어노테이션을 이용한 채팅방 입장과 퇴장시의 입장자수 관리
//	@SubscribeMapping("/chatroom/{roomId}")
//	public void subEventProcess() {
//		System.out.println("구독하려왔음");
//	}
	
	
}
