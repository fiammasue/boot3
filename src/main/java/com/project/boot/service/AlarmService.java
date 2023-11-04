package com.project.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.AlarmDAO;
import com.project.boot.dto.Alarm;

@Service
public class AlarmService {
	
	@Autowired
	private AlarmDAO alarmDAO;
	
	public int insertAlarm(Alarm alarm) {
		return alarmDAO.insertAlarm(alarm);
		
	}
	public List<Alarm> selectByReceiver(Alarm alarm){
		return alarmDAO.selectByReceiver(alarm);
	}
	public int updateReadYn(Alarm alarm) {
		return alarmDAO.updateReadYn(alarm);
	}
}
