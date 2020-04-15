package com.jeefw.service.home.impl;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.IBaseDao;
import com.jeefw.dao.home.CustomerHomeBtnDao;
import com.jeefw.model.haskey.CustomerHomeBtn;
import com.jeefw.service.home.CustomerHomeBtnService;

import core.service.BaseService;
import core.util.MathUtils;

@Service
public class CustomerHomeBtnServiceImpl extends BaseService<CustomerHomeBtn> implements CustomerHomeBtnService {
	private CustomerHomeBtnDao chbDao;
	@Resource
	private IBaseDao baseDao;
	@Resource
	public void setCustomerHomeDao(CustomerHomeBtnDao chbDao){
		this.chbDao = chbDao;
		this.dao = chbDao;
	}

	@Override
	public long userMaxSeq(long userId) {
		Object object = baseDao.findBySql("select max(seq) from customer_home_btn where user_id = " + userId).get(0);
		if(object != null) return MathUtils.getBigDecimal(object).longValue();
		return 0;
	}

}
