package com.project.boot.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.AttachFileDAO;
import com.project.boot.dto.AttachFile;

@Service
public class AttachService {
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	@Autowired
	private AttachFileDAO attachFileDAO;
	
	
	public List<AttachFile> getAttachList(int boardid){
		AttachFile attach = new AttachFile();
		attach.setBoardId(boardid);;
		return attachFileDAO.selectFileList(attach);
	}
	public List<AttachFile> getAttachList(String[] boards){
		AttachFile attach = new AttachFile();
		attach.setBoards(boards);
		return attachFileDAO.selectFileListBoards(attach);
	}

	public AttachFile getAttachOne(int fileNo){
		AttachFile attach = new AttachFile();
		attach.setFileNo(fileNo);
		return attachFileDAO.selectFileOne(attach);
	}
	public void deleteAttachFile(List<AttachFile> fileList) {
		
		for(AttachFile attach : fileList) {
			File file = new File(CURR_IMAGE_REPO_PATH + attach.getFile_name_real());
			if(file.exists()) {
				file.delete();
			}
		}
		
	}
}
