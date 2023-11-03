package com.project.boot.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.boot.dto.AttachFile;
import com.project.boot.service.AttachService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class AttachController {
	private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	@Autowired
	private AttachService attachService;
	
	@RequestMapping("/attach/download.do")
	public void downloadFile(@RequestParam("fileNo") int fileNo , HttpServletResponse response) throws Exception{
		OutputStream out = response.getOutputStream();
		
		AttachFile attach = attachService.getAttachOne(fileNo);
		String contentType = attach.getContent_type(); //image/png
		String[] sp = contentType.split("/");
		String extendName = sp[1];//png//파일 확장자
		
		
		if(contentType.startsWith("image")) {
			if(attach != null) {
				//실제 폴더 저장 파일명
				String realName = attach.getFile_name_real();
				//이미지 저장 위치
				File image = new File(CURR_IMAGE_REPO_PATH + "\\"+ realName);
				//업로드한 파일명
				String originName = attach.getFile_name_org();
				
				//이미지가 존재 할 경우에만 파일 스트림에 넣어줘
				if(image.exists()) {
					//썸네일 이미지 생성
					Thumbnails.of(image).size(50, 50).outputFormat(extendName).toOutputStream(out);
				}else {
					return;
				}
				byte[] buffer = new byte[1024*8];
				out.write(buffer);
				out.close();
			}
		}else {
			//실제 폴더 저장 파일명
			String realName = attach.getFile_name_real();
			//파일 저장 위치
			File file = new File(CURR_IMAGE_REPO_PATH + "\\"+ realName);
			
			
			String originName = attach.getFile_name_org();
			originName = URLEncoder.encode(originName, "UTF-8");
			//다운로드 할 때 헤더 설정
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Content-disposition", "attachment; fileName="+originName);
			response.setContentLength((int)attach.getLength());
			response.setContentType(attach.getContent_type());
			
			
			//파일을 바이너리로 바꿔서 담아 놓고 responseOutputStream에 담아서 보낸다.
			FileInputStream input = new FileInputStream(file);
			
			//outputStream에 8k씩 전달
	        byte[] buffer = new byte[1024*8];
	        
	        while(true) {
	        	int count = input.read(buffer);
	        	if(count<0)break;
	        	out.write(buffer,0,count);
	        }
	        input.close();
	        out.close();
			
		}
		
		
		out.close();
		
		
	}
	
}
