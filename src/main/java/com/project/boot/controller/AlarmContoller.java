package com.project.boot.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.project.boot.dto.Alarm;
import com.project.boot.service.AlarmService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AlarmContoller {
	private final AlarmService alarmService;
	private final SimpMessageSendingOperations messagingTemplate;
	

}
