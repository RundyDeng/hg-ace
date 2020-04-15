package com.jeefw.dao.home.impl;

import org.springframework.stereotype.Repository;

import com.jeefw.dao.home.CustomerHomeBtnDao;
import com.jeefw.model.haskey.CustomerHomeBtn;

import core.dao.BaseDao;

@Repository
public class CustomerHomeBtnImpl extends BaseDao<CustomerHomeBtn> implements CustomerHomeBtnDao {
	public CustomerHomeBtnImpl() {
		super(CustomerHomeBtn.class);
	}

}
