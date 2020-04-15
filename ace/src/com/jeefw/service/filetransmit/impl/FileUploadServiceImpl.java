package com.jeefw.service.filetransmit.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.filetransmit.FileUploadDao;
import com.jeefw.model.haskey.FileLists;
import com.jeefw.service.filetransmit.FileUploadService;

import core.service.BaseService;

@Service
public class FileUploadServiceImpl extends BaseService<FileLists> implements FileUploadService {
	
	private FileUploadDao fileUploadDao;
	
	@Resource
	public void setAa(FileUploadDao fileUploadDao){
		this.fileUploadDao = fileUploadDao;
		this.dao = fileUploadDao;
	}

}
