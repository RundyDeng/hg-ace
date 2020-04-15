package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.ChangetableDao;
import com.jeefw.model.sys.Changetable;
import com.jeefw.service.sys.ChangetableService;

import core.service.BaseService;

/**
 * 业务逻辑层的实现
 * 
 */
@Service
public class ChangetableServiceImpl extends BaseService<Changetable> implements ChangetableService {
	@Resource
	private ChangetableDao ChangetableDao;

	@Resource
	public void setChangetableDao(ChangetableDao ChangetableDao) {
		this.ChangetableDao = ChangetableDao;
		this.dao = ChangetableDao;
	}

	/*public List<Changetable> queryChangetableWithSubList(List<Changetable> resultList) {
		List<Changetable> ChangetableList = new ArrayList<Changetable>();
		for (Changetable entity : resultList) {
			Changetable Changetable = new Changetable();
			Changetable.setFlowname(entity.getFlowname());
			Changetable.setFlows(entity.getFlows());
			Changetable.setOpertor(entity.getOpertor());
			ChangetableList.add(Changetable);
		}
		return ChangetableList;
	}*/

	@Override
	public List<Changetable> queryChangetable(List<Changetable> resultList) {
		return null;
	}


}
