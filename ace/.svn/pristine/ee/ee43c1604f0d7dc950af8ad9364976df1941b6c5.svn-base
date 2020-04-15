package com.jeefw.controller.planningmanagement;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.dbSource.DatabaseContextHolder;
@Controller
@RequestMapping("/planningmanagement/productDispatch")
public class ProductDispatchController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@RequestMapping("/getAllCompany")
	public void getAllCompany(HttpServletRequest request, HttpServletResponse response) throws IOException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String sqlstr = " select areaguid,areaname from tarea";
		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		writeJSON(response, list);
	}
}
