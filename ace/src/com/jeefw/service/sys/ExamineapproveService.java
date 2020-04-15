package com.jeefw.service.sys;

import java.util.List;

import com.jeefw.dao.sys.ExamineapproveDao;

import core.service.Service;

/**
 * 业务逻辑层的接口
 * 
 */
public interface ExamineapproveService extends Service<ExamineapproveDao> {

	List<ExamineapproveDao> queryExamineapprove (List<ExamineapproveDao> resultList);

	

}
