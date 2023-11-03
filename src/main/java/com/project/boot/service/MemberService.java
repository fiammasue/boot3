package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.boot.dao.BoardDAO;
import com.project.boot.dao.MemberDAO;
import com.project.boot.dao.NoticeDAO;
import com.project.boot.dto.Board;
import com.project.boot.dto.Member;


@Service
public class MemberService implements UserDetailsService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private NoticeDAO noticeDAO;
	@Autowired
	private NoticeService noticeService;

	
	public Map<String, Object> insertMember(Member member) {
		Map<String, Object> params = new HashMap<>();
		params.put("member", member);
		memberDAO.addMember(params);
		int result = (int)params.get("p_result");
		
		Map<String, Object> map = new HashMap<>();
		
		if(result>0) {
			map.put("status", true);
			map.put("message", "회원가입이 성공되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", "아이디 중복으로 회원가입이 실패했습니다.");
		}
		return map;
	}
	
	
	
	//login하는 거
	public Map<String, Object> loginMember(Member member) {
		Map<String, Object> map = new HashMap<>();
		
		Member temp = new Member();
		
		if(!isExistUid(member.getUid())) {
			map.put("status", false);
			map.put("message", "아이디가 존재하지 않습니다.");		
		}
    	else{
    		//아이디와 일치하는 회원정보를 가져옴
    		temp = getMember(member.getUid());
    		//비밀번호가 일치하는지 확인
    		if(temp.isPwd(member.getPwd())){
    			//로그인한 정보를 세션에 저장해서 로그인을 유지한다.
    			map.put("message", "로그인 되었습니다.");
    			map.put("loginMember", temp);
    			map.put("status", true);
    		}
    		else{
    			map.put("status", false);
    			map.put("message", "비밀번호가 일치하지 않습니다.");
    		}
    	}
		
		return map; 
	}
	//비밀번호 찾기
	public Map<String, Object> pwdFind(Member member) {
		Map<String, Object> map = new HashMap<>();
		//아이디에 해당하는 사람이 존재하면 회원 가져오기
    	if(isExistUid(member.getUid())){
    		Member temp = getMember(member.getUid());
    		//가저온 회원의 이름과 폰번호 정보가 일치하면 비밀번호를 변경한다.
    		if(temp.isNamePhone(member)){
    			temp.setPwd(member.getPwd());
    			//비밀번호가 바뀐 회원의 정보를 DB에 업데이트한다.
    			updateMember(temp);
    			 
    			//비밀번호 변경완료 메세지 전달
    			map.put("message", "비밀번호가 변경되었습니다.");
    		}else{
    			map.put("message","본인인증에 실패했습니다.");
    		}
    	}else{
    		map.put("message","아이디가 존재하지 않습니다.");
    	}
		
		return map;
	}
	//회원 탈퇴
	public Map<String, Object> removeMember(Member member) {
		Map<String, Object> map = new HashMap<>();
		//관리자 아이디는 삭제 불가
    	if(!isExistUid("root")){
    		map.put("message", "관리자 아이디는 삭제 불가능합니다.");
    		map.put("status",true);
    	}
    	else{
    		//아이디에 해당하는 회원 가져오기
    		Member temp = getMember(member.getUid());
    		//비밀번호가 일치하면 회원삭제
    		if(temp.isPwd(member.getPwd())){
    			removeMember(member.getUid());
    			//로그인한 회원 session정보 삭제
//    			session.invalidate();
    			//완료되었음을 알림
    			map.put("message", "회원정보를 삭제하였습니다.");
    			map.put("status",true);

    		}
    		else{
    			map.put("message", "회원정보와 비밀번호가 일치하지 않습니다.");
    			map.put("status",false);
    		}
    	}
		return map;
	}
	//회원정보 수정
	public Map<String, Object> reviseMember(Member member) {
		Map<String, Object> map = new HashMap<>();
		//Member member = new Member(uid,name,pwd,age,phone,address,gender);
    	Member temp = getMember(member.getUid());
    	//빈칸이면 수정 안하기
    	if(!member.getPwd().isEmpty()){
    		temp.setPwd(member.getPwd());
    	}
    	if(!member.getName().isEmpty()){
    		temp.setName(member.getName());
    	}
    	if(!member.getAge().isEmpty()){
    		temp.setAge(member.getAge());
    	}
    	if(!member.getPhone().isEmpty()){
    		temp.setPhone(member.getPhone());
    	}
    	if(!member.getAddress().isEmpty()){
    		temp.setAddress(member.getAddress());
    	}
    	if(!member.getGender().isEmpty()){
    		temp.setGender(member.getGender());
    	}
    	if(!member.getEmail().isEmpty()){
    		temp.setEmail(member.getEmail());
    	}
    	boolean result = updateMember(temp);
    	if(result ==true) {
    		map.put("message","회원정보 수정이 완료되었습니다.");
    		map.put("loginMember", temp);
    		
    	}else {
    		map.put("message","다시시도해주세요");
    	}

    	return map;
	}
	public Map<String, Object> uidFind(Member member) {
		Map<String, Object> map = new HashMap<>();
		//Optional로 나온 회원정보 받아오기
    	Optional<Member> userInfo = findIDMember(member.getName(),member.getPhone());
    	//값이 존재하지 않으면
    	if(!userInfo.isPresent()){
    		map.put("message", "회원가입 정보가 없습니다.");
    	}else{
    		Member temp = userInfo.get();
    		map.put("message", "회원님의 아이디는 "+temp.getUid());
    	}
    	return map;
	}
	//////////////////////
	// 아이디 존재여부확인
	public boolean isExistUid(String uid) {
		Map<String, Object> params = new HashMap<>();
		params.put("uid",uid);
		memberDAO.isExistUid(params);
		String result = (String) params.get("p_result");
		return result.equals("true");
	}
	
	///////////////
	//DB에서 해당객체 찾아오기
	public Member getMember(String uid) {
		Map<String, Object> params = new HashMap<>();
		params.put("uid", uid);
		memberDAO.getMember(params);
		List<Member> member = (List<Member>)(params.get("v_cursor"));
		return member.get(0);
	}

	////////////////
	//DB에 멤버 추가
//	public void addMember(Member newMember) {
//		memberDAO.addMember(newMember);
//	}

	

	///////////////
	//회원삭제
	public void removeMember(String uid) {
		 memberDAO.removeMember(uid);
	}

	/////////////
	//이름,번호가 일치하는 멤버 찾기
	public Optional<Member> findIDMember(String name, String phone) {
		Map<String, Object> params = new HashMap<>();
		params.put("name",name);
		params.put("phone", phone);
		
		memberDAO.findIDMember(params);
		
		List<Member> list = (List<Member>)params.get("v_cursor");
		Member member = list.get(0);
		
		return Optional.ofNullable(member);
	}

	///////////////
	//멤버 전체출력을 위해 Map전달
	public Map<String, Object> getMemberList(Member member) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("searchTitle",member.getSearchTitle());
		memberDAO.getTotalCount(params);
		int count = (int)params.get("p_cnt");
		
		member.setTotalCount(count);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("member", member);
		
		params = new HashMap<>();
		params.put("searchTitle",member.getSearchTitle());
		params.put("startNo", member.getStartNo());
		params.put("endNo", member.getEndNo());
		memberDAO.getMemberList(params);
		List<Member> list = (List<Member>)params.get("v_cursor");
		result.put("memberList", list);
		
		return result;
	}
	//return형을 boolean으로해서 수정이 되면 페이지를 redirect 되게 하고 싶다.
	public boolean updateMember(Member member) {
		Map<String, Object> params = new HashMap<>();
		params.put("member",member);
		memberDAO.updateMember(params);
		return true;
	}



	public Map<String,Object> index(Member member) {
//		JSONObject jsonObject = new JSONObject();
		Map<String, Object> result = new HashMap<>();
		if(member != null)
			result.put("equalsAdmin",member.isAdmin());
		result.put("boardList", boardDAO.getTop5BoardList("게시판"));
		result.put("noticeList", noticeService.getTop5BoardList("공지사항"));
		
		
		
		return result;
		
	}
//	public boolean deleteMembers(Member member) {
//		return memberDAO.deleteMembers(member);
//		
//	}
	public boolean deleteMembers(Member member) {
		return memberDAO.deleteMembers(member.getMembers());
		
	}
	public List<Member> getMemberList2(Member member){
		Map<String, Object> params = new HashMap<>();
		params.put("searchTitle",member.getSearchTitle());
		params.put("startNo", member.getEndNo()-member.getDeleteCount()+1);
		params.put("endNo", member.getEndNo());
		
		memberDAO.getMemberList2(params);
		
		List<Member> list = (List<Member>)params.get("v_cursor");
		
		return list;
	}
	public Board viewBoard(Member member) {
		Board board = boardDAO.getBoard(member.getBoardid());
		return board;
	}



	@Override
	public UserDetails loadUserByUsername(String uid) throws UsernameNotFoundException {
			System.out.println("email = > "+ uid);
		Member member = getMember(uid);
		
		if (member == null) throw new UsernameNotFoundException("Not Found account.");
		System.out.println("member - > "+ member);
		
		return member;
	}
}
