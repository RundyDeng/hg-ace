package com.jeefw.service.filetransmit.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.filetransmit.FileManageDao;
import com.jeefw.model.haskey.FileLists;
import com.jeefw.service.filetransmit.FileManageService;

import core.service.BaseService;

@Service
public class FileManageServiceImpl extends BaseService<FileLists> implements FileManageService{
	private FileManageDao fileManageDao;
	
	@Resource
	public void setFileManageDao(FileManageDao fileManageDao){
		this.fileManageDao = fileManageDao;
		this.dao = fileManageDao;
	}
}
