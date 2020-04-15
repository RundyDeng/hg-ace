package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/dataAnalysis/useHeatDistributionContr")
public class UseHeatDistributionController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/get")
	public void get(HttpServletRequest request,HttpServletResponse response) throws IOException, ParseException{
		String sdate = getParm("sdate");
		String edate=getParm("edate");

		String sql = "select hotarea,RLYL   from(select c.clientno,c.hotarea,max(a.meternllj)-min(a.meternllj) as yl, "
				+ "Round(((max(a.meternllj)-min(a.meternllj))*0.0036)/ (case when c.hotarea=0 then 60 else c.hotarea end),3) as RLYL "
				+ "from tmeter a inner join tdoor_meter b on a.areaguid=b.areaguid and a.meterid=b.meterno"
				+ " inner join tclient c on c.areaguid=b.areaguid and b.clientno=c.clientno where"
				+ " a.areaguid="+getParm("areaguid")+" and a.ddate between to_date('"+sdate+"','yyyy-MM-dd')and "
				+ "to_date('"+edate+"','yyyy-MM-dd') and meternllj>0 group by c.clientno,c.hotarea "
				+ "order by RLYL)m where m.RLYL<1";
		
		List findBySql = baseDao.findBySql(sql);
		writeJSON(response, findBySql);
	}
}
