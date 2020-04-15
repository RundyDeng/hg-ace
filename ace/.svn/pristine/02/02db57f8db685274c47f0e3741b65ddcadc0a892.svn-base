package com.jeefw.service.warningmanage.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.warningmanage.WarningSettingDao;
import com.jeefw.model.haskey.Tfailurecode;
import com.jeefw.service.warningmanage.WarningSettingService;

import core.service.BaseService;

@Service
public class WarningSettingServiceImpl extends BaseService<Tfailurecode> implements WarningSettingService {
	private WarningSettingDao warningSettingDao;
	@Resource
	public void setDao(WarningSettingDao dao){
		this.dao = dao;
		this.warningSettingDao = dao;
	}
}
