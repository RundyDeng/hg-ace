package com.jeefw.service.warningmanage.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.warningmanage.SetFaultParamForWarnDao;
import com.jeefw.model.haskey.Warringsparmset;
import com.jeefw.service.warningmanage.SetFaultParamForWarnService;

import core.service.BaseService;
@Service
public class SetFaultParamForWarnServiceImpl extends BaseService<Warringsparmset> implements SetFaultParamForWarnService {
	private SetFaultParamForWarnDao faultParamForWarnDao;
	@Resource
	public void setDao(SetFaultParamForWarnDao dao){
		this.dao = dao;
		this.faultParamForWarnDao = dao;
	}
}
