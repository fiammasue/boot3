package com.project.boot.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.project.boot.dto.MailInfo;
import com.project.boot.dto.Member;

@Service
public class MailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@Async
	public void sendMail(Member sendMember,Member receiveMember,MailInfo sendMessage ) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper  messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			//답변 작성자
			messageHelper.setFrom(sendMember.getEmail(),sendMember.getName());
			messageHelper.setSubject(sendMessage.getSubject());
			//게시글 작성자
			messageHelper.setTo(receiveMember.getEmail());
			messageHelper.setText(sendMessage.getBody(),true);
			mailSender.send(message);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
