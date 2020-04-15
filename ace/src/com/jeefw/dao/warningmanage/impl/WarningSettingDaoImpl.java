package com.jeefw.dao.warningmanage.impl;

import org.springframework.stereotype.Repository;

import com.jeefw.dao.warningmanage.WarningSettingDao;
import com.jeefw.model.haskey.Tfailurecode;

import core.dao.BaseDao;

@Repository
public class WarningSettingDaoImpl extends BaseDao<Tfailurecode> implements WarningSettingDao{

	public WarningSettingDaoImpl() {
		super(Tfailurecode.class);
	}

}
