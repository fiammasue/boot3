package com.project.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.Alarm;

@Mapper
public interface AlarmDAO {
	//알람을 DB에 전달
	//멤버테이블과 연관 ***
	public int insertAlarm(Alarm alarm);
	//로그인 유저의 알람을 검색
	public List<Alarm> selectByReceiver(Alarm alarm);
	//유저가 알람을 확인하면 모두 확인으로 읽음 여부를 변경한다.
	//멤버 테이블과 연관 **
	public int updateReadYn(Alarm alarm);
	
}
