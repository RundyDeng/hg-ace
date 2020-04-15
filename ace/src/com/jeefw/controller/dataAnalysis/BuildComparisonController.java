package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/dataanalysis/buildcomparisoncontr")
public class BuildComparisonController extends IbaseController{
	private int pagesize = 11;
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getbuildcomparison")
	public void getBuildComparison(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String areaguid = getParm("areaguid");
		String buildno = getParm("buildno");
		String areaguid2 = getParm("areaguid2");
		String buildno2 = getParm("buildno2");
		String startDate = getParm("startdate");
		String endDate = getParm("enddate");
		
		String sql="select a.areaguid,a.buildno,a.bname as buildname,a.CLIENTNO as client_totle,b.reliang as build_energy,a.area,round(b.reliang/(case when a.area=0 then 1 else a.area end),2) as build_average_enerty"
				+ " from(select AREAGUID,BUILDNO,BName,count(CLIENTNO) as CLIENTNO,sum(hotarea) as area from vclientinfo where  AREAGUID="+areaguid+"  and buildno="+buildno+"  group by  AREAGUID,BUILDNO,BName) a left join (select "
				+ " areaguid,buildno,sum(reliang) as reliang from tmeter_day where AREAGUID="+areaguid+"  and buildno="+buildno+" and ddate between to_date('"+startDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') and  to_date('"+endDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')"
				+ " group by areaguid,buildno )b on a.AREAGUID=b.areaguid and a.buildno=b.buildno union all  select a.areaguid,a.buildno,a.bname as buildname,a.CLIENTNO as client_totle,b.reliang as build_energy,"
				+ " a.area,round(b.reliang/(case when a.area=0 then 1 else a.area end),2) as build_average_enerty from(select AREAGUID,BUILDNO,BName,count(CLIENTNO) as CLIENTNO,sum(hotarea) as area from vclientinfo where  areaguid="+areaguid2+" and "
				+ " buildno="+buildno2+" group by  AREAGUID,BUILDNO,BName) a left join (select areaguid,buildno,sum(reliang) as reliang from tmeter_day where AREAGUID="+areaguid2+"  and buildno="+buildno2+"  and ddate between to_date('"+startDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')"
				+ "  and  to_date('"+endDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')group by areaguid,buildno )b on a.AREAGUID=b.areaguid and a.buildno=b.buildno";
	 	List list = baseDao.listSqlAndChangeToMap(sql, null);
	 	writeJSON(response, list);
	}
	
}
