package com.project.boot.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.project.boot.dto.Member;

@Mapper
public interface MemberDAO {
	String FILE_NAME = "c:\\temp\\member.db";
	Boolean isExistUid(Map<String, Object> params);
	int addMember(Map<String, Object> params);
	Member getMember(Map<String, Object> params);
	void removeMember(String uid);
	Optional<Member> findIDMember(Map<String, Object> params);
	
	//void loadFileMemberMap();
	//void saveFileMemberMap();
	boolean updateMember(Map<String, Object> params);
	////////////////////////
	//일반화필요 pageDAO로 이동 //service부분만 고치면돼
	Integer getTotalCount(Map<String, Object> params);
	List<Member> getMemberList(Map<String, Object> params);
	boolean deleteMembers(Member member);
	boolean deleteMembers(String[] members);
	public List<Member> getMemberList2(Map<String, Object> params);
}
