package com.project.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.MessageDAO;
import com.project.boot.dto.Message;

@Service
public class MessageService {
	
	@Autowired
	private MessageDAO messageDAO;
	
	public Message insertMessage(Message message) {
		messageDAO.insertMessage(message);
		System.out.println("메세지를 insert하고 반환된 값 : " +message);
		return message;
	}
	public List<Message> selectMessageList(String room_id){
		Message message = new Message();
		message.setRoom_id(room_id);
		
		return messageDAO.selectMessageList(message);
	}
}
