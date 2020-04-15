package com.jeefw.service.sys;

import java.util.List;

import com.jeefw.model.sys.Changetable;

import core.service.Service;

/**
 * 业务逻辑层的接口
 * 
 */
public interface ChangetableService extends Service<Changetable> {

	List<Changetable> queryChangetable (List<Changetable> resultList);

	

}
