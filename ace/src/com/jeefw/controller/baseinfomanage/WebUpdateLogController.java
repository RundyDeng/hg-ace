package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;

@Controller
@RequestMapping(value = "/baseinfomanage/webupdatelog")
public class WebUpdateLogController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	@RequestMapping(value = "/getyearinfo")
	public void getyearinfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String sqlstr = " select distinct CONCAT(to_char(DDate,'yyyy'),'年') as 年份  from UPDATELOG  order by 年份  desc";
		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		writeJSON(response, list);
	}
	@RequestMapping(value = "/getloginfo")
	public void getloginfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String year=request.getParameter("Year").substring(0, 4);
		String sqlstr = "select TITLE,CONTENT,REMARK,to_char(DDate,'yyyy') as 年,"
				      + "to_char(DDate,'MM')||'月'||to_char(DDate,'DD')||'日' as 日期 "
				      + "from UPDATELOG	where YEAR=" + Integer.parseInt(year) + " order by DDATE desc";

		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		writeJSON(response, list);
	}
}
