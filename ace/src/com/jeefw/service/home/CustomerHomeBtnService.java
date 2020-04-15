package com.jeefw.service.home;

import com.jeefw.model.haskey.CustomerHomeBtn;

import core.service.Service;

public interface CustomerHomeBtnService extends Service<CustomerHomeBtn> {
	//当前用户自定义按钮的最大序列
	long userMaxSeq(long userId);
}
