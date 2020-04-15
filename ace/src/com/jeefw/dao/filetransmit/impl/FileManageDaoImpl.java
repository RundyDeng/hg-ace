package com.jeefw.dao.filetransmit.impl;

import org.springframework.stereotype.Repository;

import com.jeefw.dao.filetransmit.FileManageDao;
import com.jeefw.model.haskey.FileLists;

import core.dao.BaseDao;

@Repository
public class FileManageDaoImpl extends BaseDao<FileLists> implements FileManageDao{

	public FileManageDaoImpl() {
		super(FileLists.class);
	}

}
