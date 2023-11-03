package com.project.boot.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.boot.dto.AttachFile;
import com.project.boot.dto.Board;
import com.project.boot.dto.MailInfo;
import com.project.boot.dto.Member;
import com.project.boot.service.AttachService;
import com.project.boot.service.BoardService;
import com.project.boot.service.MailService;
import com.project.boot.service.MemberService;
import com.project.boot.service.ReplyService;


@Controller
@EnableAsync
public class BoardController {
	private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private AttachService attachService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	
	//리스트 전체 출력페이지 이동
	@RequestMapping("/board/AllBoard.do")
	public String AllBoard(Board board ,HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		//boardtype도 setBoardtype으로 해서 넘겨야겠다 어차피 매개변수로 board받아오니가
		//Board board = new Board();
		board.setBoardtype("게시판");
		Map<String, Object> result = boardService.getBoardPageList(board);
		//request.setAttribute("boardList", boardList);
		request.setAttribute("result", result);
		
		boolean isAdmin = boardService.isAdmin(loginMember);
		request.setAttribute("isAdmin", isAdmin);
		
		
		return "board/allBoard";
	}
	
	//게시글 삭제 // 일반사용자가 삭제시 사용
	@ResponseBody
	@RequestMapping(value = "/board/DeleteBoard.do", method = RequestMethod.POST)
	public Map<String,Object> DeleteBoard(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<>();
		
		Board temp = boardService.getBoard(board.getBoardid());
		if(board.getMemberid()==""||!board.getMemberid().equals(temp.getMemberid())) {
			map.put("message", "게시글은 작성자만 삭제할수있습니다.");
			map.put("status", false);
			return map;
		}
		
		board.setAttachList(attachService.getAttachList(board.getBoardid()));
		
		
		
		
		boolean status = boardService.deleteBoard(board);
		
		if(status) {
			attachService.deleteAttachFile(board.getAttachList());
			
			map.put("status", status);
			map.put("message", "게시글이 삭제되었습니다.");
			
		}
		else {
			map.put("status", status);
			map.put("message", "다시 시도해 주세요");
			
		}
		return map;
	}
	
	//관리자 페이지로 옮김
	//게시글 삭제 //관리자가 삭제시 사용
	@ResponseBody
	@RequestMapping(value = "/board/AjaxDeleteBoard.do", method = RequestMethod.POST)
	public Map<String,Object> AjaxDeleteBoard(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<>();
		
		//삭제를위해 boardid만 가져옴
		boolean result  = boardService.deleteBoard(board);
		
		if(result) {
			map.put("status", result);
			map.put("message", "게시글이 삭제되었습니다.");
			
		}else {
			map.put("status", result);
			map.put("message", "다시 시도해 주세요");
		}
		return map;
	}
	//관리자페이지로 옮김
	//선택한 게시글 삭제
	@ResponseBody
	@RequestMapping(value = "/board/DeleteSelectPage.do", method = RequestMethod.POST)
	public Map<String,Object> DeleteSelectPage(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<>();
		
		boolean status = boardService.deleteBoards(board.getBoards());
		if(status) {
			
			map.put("message", "선택한 게시글이 삭제되었습니다.");
			map.put("status", status);
		}
		else {
			map.put("message", "다시시도해주세요");
			map.put("status", status);
		}
		return map;
	}
	//게시글 작성
	@ResponseBody
	@RequestMapping(value = "/board/InsertBoard.do", method = RequestMethod.POST)
	public Map<String,Object> InsertBoard(Board board	
			,MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		
		Map<String,Object> map = new HashMap<>();
		if(board.getMemberid()=="") {
			map.put("message", "로그인 후 이용해 주세요");
			map.put("status", false);
			return map;
		}
		
		Map<String,Object> names = new HashMap<>();
		
		Enumeration enumer = multipartRequest.getParameterNames();
		
		while(enumer.hasMoreElements()) {
			String name = (String)enumer.nextElement();
			Object value = multipartRequest.getParameter(name);
			
			names.put(name,value);
		}
		
		board.setAttachList(fileProcess(multipartRequest));
		
		
		
		//이거는 첨부파일 작성할때 사용한다.
		int boardid = boardService.insertBoard(board);
		
		//이부분은 첨부파일을 등록한 후에 반환되는 값으로 변경되어야할 것같다
		if(boardid>0) {
			map.put("message", "게시글작성이 완료되었습니다.");
			map.put("status", true);
			
		}else {
			map.put("message", "다시 시도해주세요");
			map.put("status", false);
		}
		//jsonObject.put("result", result);
		return map;
	}
	//파일 저장
	public List<AttachFile> fileProcess(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<AttachFile> fileList = new ArrayList<>();
		
		Iterator<String> iter = multipartRequest.getFileNames();
		
		Calendar now = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("\\YY\\MM\\dd");
		
		while(iter.hasNext()) {
			String fileName = iter.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			
			String fileNameOrg = mFile.getOriginalFilename();
			
			String realFolder = format.format(now.getTime());
			
			File file= new File(CURR_IMAGE_REPO_PATH + realFolder);
			
			if(!file.exists()) {
				file.mkdirs();
			}
			String fileNameReal = UUID.randomUUID().toString();
			
			mFile.transferTo(new File(file,fileNameReal));
			
			fileList.add(
					AttachFile.builder()
					.file_name_org(fileNameOrg)
					.file_name_real(realFolder + "\\" +fileNameReal)
					.length(mFile.getSize())
					.content_type(mFile.getContentType())
					.build()
					);
			
			
		}
		
		return fileList;
	}
	

	
	//게시글  답변 작성
	@ResponseBody
	@RequestMapping(value = "/board/InsertBoardReply.do", method = RequestMethod.POST)
	public Map<String,Object> InsertBoardReply(Board board
			,MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		HttpSession session = multipartRequest.getSession();
		Map<String,Object> map = new HashMap<>();
		if(board.getMemberid()=="") {
			map.put("message", "로그인 후 이용해 주세요");
			map.put("status", false);
			return map;
		}
		Map<String,Object> names = new HashMap<>();
		
		Enumeration enumer = multipartRequest.getParameterNames();
		
		while(enumer.hasMoreElements()) {
			String name = (String)enumer.nextElement();
			Object value = multipartRequest.getParameter(name);
			
			names.put(name,value);
		}
		
		board.setAttachList(fileProcess(multipartRequest));
		
		
		
		int pid = (int)session.getAttribute("boardid");
		board.setPid(pid);
		
		//이거는 첨부파일 작성할때 사용한다.
		int boardid = boardService.insertBoardReply(board);
		
		
		
		if(boardid>0) {
			Board receiveBoard =  boardService.getBoard(pid);
			Board sendBoard = boardService.getBoard(boardid);
			Member sendMember = (Member)session.getAttribute("loginMember");
			Member receiveMember = memberService.getMember(receiveBoard.getMemberid());
			MailInfo sendMessage = MailInfo.builder()
											.subject("[I love Yeonsu] "+receiveBoard.getMemberid()+"님, "+receiveBoard.getTitle()+"에 답변이 달렸습니다.")
											.body(getBody(sendBoard))
											.build();
			mailService.sendMail(sendMember,receiveMember,sendMessage);
			map.put("message", "답글작성이 완료되었습니다.");
			map.put("status", true);
			
		}else {
			map.put("message", "다시 시도해 주세요");
			map.put("status", false);
		}
		return map;
	}
	public String getBody(Board board) {
		StringBuilder sb = new StringBuilder();
		
		sb.append("<html lang=\"kr\">");
		sb.append(" <h1>답변이 달렸습니다.</h1>");
		sb.append(" <table class=\"post\" style=\"width:50%;border-collapse:collapse;margin-top:15px;\"><tbody id=\"view-table\" style=\"width:500px;padding:20px;\">");
		sb.append(" <tr> <th style=\"background-color:#d36f12b3;color:#fff;padding:10px;border:1px solid #ddd;\">제목</th>");
		sb.append("<td colspan=\"5\" id=\"board-title\">"+board.getTitle()+"</td></tr>");
		sb.append(" <tr>");
		sb.append("<th style=\"background-color:#d36f12b3;color:#fff;padding:10px;border:1px solid #ddd;\">작성자</th>");
		sb.append("<td id=\"board-memberid\" style=\"padding:10px;border:1px solid #ddd;\">"+board.getMemberid()+"</td>");
		sb.append("<th style=\"background-color:#d36f12b3;color:#fff;padding:10px;border:1px solid #ddd;\">작성날짜</th>");
		sb.append("<td id=\"board-regdate\" style=\"padding:10px;border:1px solid #ddd;\">"+board.getRegdate()+"</td>");
		sb.append("<th style=\"background-color:#d36f12b3;color:#fff;padding:10px;border:1px solid #ddd;\">조회수</th>");
		sb.append("<td id=\"board-hit\" style=\"padding:10px;border:1px solid #ddd;\">"+ board.getHit()+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append(" <th style=\"background-color:#d36f12b3;color:#fff;padding:10px;border:1px solid #ddd;\">내용</th>");
		sb.append(" <td colspan=\"5\" style=\"padding:10px;border:1px solid #ddd;\"><textarea id=\"board-contents\" cols=\"60\" rows=\"10\" readonly>"+board.getContents()+"</textarea></td>");
		sb.append("</tr>");
		sb.append(" </tbody>");
		sb.append("</table>");
		sb.append("<a href=\"http://localhost:8090/legacy/board/AllBoard.do\">게시판 바로가기</a>");
		sb.append("</body>");
		sb.append("</html>");
		
		
		return sb.toString();
	}
	//게시글 수정
	@ResponseBody
	@RequestMapping(value = "/board/ReviseBoard.do", method = RequestMethod.POST)
	public Map<String,Object> ReviseBoard(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		int boardid = (int)session.getAttribute("boardid");
		Board temp = boardService.getBoard(boardid);
		if(board.getMemberid()==""||!board.getMemberid().equals(temp.getMemberid())) {
			map.put("message", "작성자만 수정할 수 있습니다.");
			map.put("status", false);
		}else {
			boardService.updateBoard(boardid,board);
			map.put("message", "게시글을 수정하였습니다.");
			map.put("status", true);
			
			
		}
		return map;
	}
	//게시글 수정 폼 띄우기 전에 로그인 사용자가 관리자인지 확인!!
	@ResponseBody
	@RequestMapping(value = "/board/ReviseBoardForm.do", method = RequestMethod.POST)
	public Map<String,Object> ReviseBoardForm(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<>();
		
		Board temp = boardService.getBoard(board.getBoardid());
		if(board.getMemberid()!=""&&board.getMemberid().equals(temp.getMemberid())) {
			map.put("status", true);
			return map;
		}else {
			map.put("message", "작성자만 글을 수정할 수 있습니다.");
			map.put("status", false);
			
		}
		
		
		return map;
	}
	//게시글 상세보기
	@ResponseBody
	@RequestMapping(value = "/board/ViewOneBoard.do", method = RequestMethod.POST)
	public Map<String, Object> ViewOneBoard(@RequestBody Board board,HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Map<String, Object> result = new HashMap<>();
		Member loginMember = (Member)session.getAttribute("loginMember");
		Board temp = boardService.getBoard(board.getBoardid());
		
//		loginMember.getUid();
		boardService.hitUpdate(board.getBoardid());
		//수정할때 boardid가필요하다..
		session.setAttribute("boardid", board.getBoardid());
		result.put("board",temp);
		result.put("replyList",replyService.getReplyList(board.getBoardid()));
		result.put("attachList",attachService.getAttachList(board.getBoardid()));
		if(loginMember!=null) {
			result.put("loginMember",loginMember.getUid());
			
		}
		return result;
	}
	
	
}
