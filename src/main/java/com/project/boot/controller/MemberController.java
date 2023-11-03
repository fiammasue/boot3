package com.project.boot.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.dto.Board;
import com.project.boot.dto.Member;
import com.project.boot.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
//	//회원가입 동의서 
//	@RequestMapping("/member/agreeForm.do")
//	public String agreeForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		return "member/agreeForm";
//	}
//	//회원가입
//	@RequestMapping("/member/insertForm.do")
//	public String insertForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		return "member/insertForm";
//	}
//	//로그인폼
//	@RequestMapping("/member/loginForm.do")
//	public String loginForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		return "member/loginForm";
//	}
//	//아이디찾기 폼
//	@RequestMapping("/member/uidFindForm.do")
//	public String uidFindForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		return "member/uidFindForm";
//	}
//	//아이디찾기 폼
//	@RequestMapping("/member/pwdFindForm.do")
//	public String pwdFindForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		return "member/pwdFindForm";
//	}
//	//회원삭제 폼
//	@RequestMapping("/member/removeForm.do")
//	public String removeForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		return "member/removeForm";
//	}
	@ResponseBody
	@RequestMapping(value = "/member/isExistUid.do", method = RequestMethod.POST)
	public Map<String, Object> isExistUid(@RequestBody Member member,HttpServletRequest request, HttpServletResponse response) throws Exception  {
		Map<String, Object> map = new HashMap<>();
		if(memberService.isExistUid(member.getUid())) {
			map.put("status", true);
			map.put("message", "아이디가 사용불가능합니다.");
		}else {
			map.put("status", false);
			map.put("message", "아이디가 사용가능합니다.");
			
		}
		
		return map;
	}
	
	//admin으로 옮겼음
	@RequestMapping("/member/AllMemberShow.do")
	public String AllMemberShow(@ModelAttribute("member") Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("result", memberService.getMemberList(member));
		return "member/allMemberShow";
	}
	
	
	@RequestMapping(value={"/main/Index.do","/"})
	public String Index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginMember");
		Map<String, Object> result = memberService.index(member);
//		JSONObject jsonObject = 
		
		if(member!=null) {
			
			request.setAttribute("equalsAdmin", result.get("equalsAdmin"));
		}
		request.setAttribute("boardList", result.get("boardList"));
		request.setAttribute("noticeList", result.get("noticeList"));
		
		
		return "index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/AjaxIndex.do",method = RequestMethod.POST)
	public Board AjaxIndex(@RequestBody Member member , HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		Board boardTemp = memberService.viewBoard(member);
		
		return boardTemp;
	}

	
	@ResponseBody
	@RequestMapping("/member/InsertMember.do")
	public Map<String, Object> InsertMember(@RequestBody Member member,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = memberService.insertMember(member);
		return map;
	}
	
	

	
	@ResponseBody
	@GetMapping(value = "/member/LoginMember.do")
	public Map<String, Object> LoginMember(
			@RequestParam(value = "status", required = false ) boolean status,
			@RequestParam(value = "message", required = false ) String message,
			HttpSession session) throws Exception {
		System.out.println("message -> "+message);
//		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<>();
		map.put("status", status);
		map.put("message", message);
		
		
//		Map<String, Object> map = memberService.loginMember(member);
//		if(map.get("loginMember")!=null) {
//			session.setAttribute("loginMember", map.get("loginMember"));
//		}
		return map;
	}
	
	@ResponseBody
	@GetMapping("/member/LogoutMember.do")
	public Map<String, Object> LogoutMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<>();
//		session.invalidate();
		map.put("message", "로그아웃되었습니다.");
		map.put("status",true);
		return map;
	}

	@ResponseBody
	@RequestMapping("/member/PwdFind.do")
	public Map<String, Object> PwdFind(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("member - > "+member);
		Map<String, Object> map = memberService.pwdFind(member);
		return map;
	}

	@ResponseBody
	@RequestMapping("/member/RemoveMember.do")
	public Map<String, Object> RemoveMember(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		member.setUid(loginMember.getUid());
		Map<String, Object> map = memberService.removeMember(member);
		if((boolean)map.get("status")) {
			session.invalidate();
			
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/member/ReviseMember.do")
	public Map<String, Object> ReviseMember(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Map<String, Object> map = memberService.reviseMember(member);
		Member loginMember = (Member)map.get("loginMember");
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			
		}
		return map;
	}
	
	
//	@RequestMapping("/member/ReviseForm.do")
//	public String ReviseForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//		return "member/reviseForm";
//	}
	
	@ResponseBody
	@RequestMapping("/member/UidFind.do")
	public Map<String, Object> UidFind(@RequestBody Member member,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = memberService.uidFind(member);
		
		
		return map;
	}
	
	
//	@RequestMapping("/member/View.do")
//	public String View(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		return "member/view";
//	}
	
	//admin페이지로 옮겼음
	@ResponseBody
	@RequestMapping("/member/DeleteMembers.do")
	public Map<String, Object> DeleteMembers(@RequestBody Member member,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<>();
		boolean status = memberService.deleteMembers(member);
		
		
		if(status == true) {
			map.put("memberList", memberService.getMemberList2(member) );
			map.put("status", true);
			map.put("message","선택한 회원정보가 삭제되었습니다.");
			
		}else {
			map.put("status", false);
			map.put("message","다시시도해주세요");
		}
		
		return map;
	}
	
}
