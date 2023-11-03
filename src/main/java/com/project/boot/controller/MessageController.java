package com.project.boot.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.project.boot.dto.Message;
import com.project.boot.service.MessageService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MessageController {
	
	private final MessageService messageService;
	private final SimpMessageSendingOperations messagingTemplate;
	
	@MessageMapping("/chat/message")
	public void message(Message message) {
		//메세지를
		messageService.insertMessage(message);
		System.out.println("수신한 message : "+message);
		messagingTemplate.convertAndSend("/sub/chat/room/"+message.getRoom_id(),message);
	}

}
