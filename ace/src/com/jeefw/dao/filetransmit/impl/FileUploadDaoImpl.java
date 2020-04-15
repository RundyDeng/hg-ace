package com.jeefw.dao.filetransmit.impl;

import org.springframework.stereotype.Repository;

import com.jeefw.dao.filetransmit.FileUploadDao;
import com.jeefw.model.haskey.FileLists;

import core.dao.BaseDao;

@Repository
public class FileUploadDaoImpl extends BaseDao<FileLists> implements FileUploadDao {

	public FileUploadDaoImpl() {
		super(FileLists.class);
	}

}
