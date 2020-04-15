package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.dbSource.DataSource;

@Controller
@RequestMapping(value="/baseinfomanage/setarea")
public class SetAreaController extends IbaseController {
	
	@Resource
	private PubService todayDataService;//这里面有一些基本的查询，以后再改到baseService里面去
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping(value = "/getArea")
	public void getArea(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List map = todayDataService.getArea(null);
		writeJSON(response, map);
	}
	
	@RequestMapping(value = "/bindArea")
	public void bindArea(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String areaguids = request.getParameter("areaguids");
		String areaname = todayDataService.getAreanameById(areaguids);
		request.getSession().setAttribute(AREA_GUIDS, areaguids);
		request.getSession().setAttribute(AREA_NAME, areaname);
		writeJSON(response, 1);
	}
	
//select
	
	//公司
	@RequestMapping(value = "/getEnergyFactory")
	public void getEnergyFactory(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List list = baseDao.listSqlAndChangeToMap("select c.FACTORYID,c.FACTORYNAME from EnergyFactory c", null);
		writeJSON(response, list);
	}
	

	//供热站  FACTORYSECTIONINFO
	@RequestMapping(value = "/getHeatingStation")
	public void getHeatingStation(HttpServletRequest request, HttpServletResponse response) throws IOException{
		todayDataService.switchDBText();
		List list = todayDataService.getHeatingStation(getParm("FACTORYID"));
		writeJSON(response, list);
	}
	
	
	
	//小区
	@RequestMapping(value = "/getResidenceCommunity")
	public void getResidenceCommunity(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String sql = "select distinct a.AREAGUID,a.areacode,a.areaname from (" + PubServiceImpl.headsql 
				+ ") a where a.AREAGUID is not null and  a.SECTIONID = " + getParm("SECTIONID");
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		writeJSON(response, list);
	}
	
	
}
