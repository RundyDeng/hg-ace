package com.jeefw.controller.planningmanagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.dbSource.DataSource;
import core.dbSource.DatabaseContextHolder;

@Controller
@RequestMapping("/planningmanagement/heatSourceMonitor")
public class HeatSourceMonitorController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	/**
	 * 查询热源最新一些数据
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getHeatSourceMonitor")
	public void getHeatSourceMonitor(HttpServletRequest request, HttpServletResponse response) throws IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String sqlstr ="  select a.mainareaname,gongrenengli ,to_char(b.ddate,'yyyy-MM-dd HH24:Mi:ss') as ddate,b.GW,b.HW,b.GY,"
				+ "b.HY,b.YGLL,b.SGLL,b.LLBL,b.YGRL,b.SGRL,b.RLBL ,b.DRLL,b.LJRL,"
				+ "tdoor_meter.buildno,tdoor_meter.meterno from TMainArea a left join"
				+ " THEATSOURCETODAY b on a.mainareaid = b.mainareaid inner join"
				+ " tbuild on tbuild.buildcode= a.companymianji inner join "
				+ "tdoor_meter on tdoor_meter.buildno=tbuild.buildno where "
				+ "tbuild.areaguid=446 and tdoor_meter.meterno!=8 order by COMPANYMIANJI";
		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		DatabaseContextHolder.clearCustomerType();//释放数据库连接
		map.put("data", list);
		writeJSON(response, map);
	}
	/**
	 * 查询热源曲线数据
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ParseException
	 */
	@RequestMapping("/getHeatSourceHistroy")
	public void getHeatSourceHistroy(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		List<Map> list=null;
		 //获取两个时间看看是否选择的同一年
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String staddates = getParm("startdate");
        Date dtime = format.parse(staddates);
        int years = dtime.getYear()+1900;
        int month = dtime.getMonth()+1;
        int days = dtime.getDate();
        String staddatesbi = years + "-10-15";
        Date detime = format.parse(staddatesbi);

        int stayears = 0;
        if (dtime.getTime()>detime.getTime())
        {
            stayears = years;
        }
        else
        {
            stayears = years - 1;
        }

        String enddates = getParm("enddate");
        Date edtime = format.parse(enddates);
        int eyears = edtime.getYear()+1900;
        String endatesbi = eyears + "-10-15";
        Date enddetime = format.parse(endatesbi);
        int endyears = 0;
        if (edtime.getTime()>enddetime.getTime())
        {
            endyears = edtime.getYear()+1900;
        }
        else
        {
            endyears = edtime.getYear()+1900 - 1;
        }

        String hours1 = getParm("hour1");
        String hours2 = getParm("hour2");
        if (endyears == stayears){

        String tablename = "THEATSOURCE" + endyears;
        String sql = "   tbuild.areaguid=446 and  b.DDATE between to_date('" + staddates + " " + hours1 + ":00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + enddates + " " + hours2 + ":59:29','yyyy-mm-dd hh24:mi:ss')  and meterno='" + getParm("meterno") + "' and tdoor_meter.buildno='" + getParm("buildno") + "' order by ddate";
        String sqlwhere = " select a.mainareaname,gongrenengli,to_char(b.ddate,'yyyy-MM-dd HH24') as ddate,b.GW,b.HW,b.GY,b.HY,b.YGLL,b.SGLL,b.LLBL,b.YGRL,b.SGRL,b.RLBL  ,b.DRLL,b.LJRL,tdoor_meter.buildno, tdoor_meter.meterno from TMainArea a left join " + tablename + " b on a.mainareaid = b.mainareaid   inner join tbuild  on tbuild.buildcode= a.companymianji inner join tdoor_meter on tdoor_meter.buildno=tbuild.buildno  where  " + sql;
        list=baseDao.listSqlAndChangeToMap(sqlwhere, null);
        DatabaseContextHolder.clearCustomerType();//释放数据库连接
        }
           //使用Google的Json工具  
      		Gson gson = new Gson();  
      		//将JSON串返回  
      		PrintWriter out = response.getWriter();  
      		out.print(gson.toJson(list));  
      		out.flush();  
      		out.close(); 
	}
	/**
	 * 查询热源历史数据
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ParseException 
	 */
	@RequestMapping("/getHeatSourceHistory")
	public void getHeatSourceHistory(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		Map<String, Object> map = new HashMap<String, Object>();
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String meterno=getParm("meterno");
		String buildno=getParm("buildno");
		String serdate=getParm("serdate");
		String type=getParm("type");
		 //分析看看查询数据时哪一年
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date dtime=format.parse(serdate);
        int years = dtime.getYear()+1900;
        int month = dtime.getMonth()+1;
        int days = dtime.getDate();;
        String edates = years + "-10-15";
        Date detime = format.parse(edates);

		int leixin = 5;
		String tablename = "TMETERQX";
        if ("hot".equals(type))
        {
            leixin = 5;
            tablename = "TMETERQX";
        }
        else if ("twater".equals(type))
        {
            leixin = 11;
            tablename = "telectri";
        }
        else
        {
            leixin = 10;
            tablename = "telectri";
        }
        
   
        if (dtime.getTime()>detime.getTime())
        {
            tablename += years;
        }
        else
        {
            tablename += years - 1;
        }
        String sql= "a.DDATE between to_date('" + serdate + " 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + serdate + " 23:59:29','yyyy-mm-dd hh24:mi:ss') "
        		+ " and b.meterno='"+meterno +"' and b.buildno='" + buildno + "'  and c.metertype=" + leixin + " order by ddate desc";
        String sqlstr="select a.areaguid,a.buildno,b.buildname,a.meterid, c.msname,to_char(a.ddate,'yyyy-MM-dd HH24:mi:ss') as ddate,a.meternllj,a.meternlrl,a.metersslj,a.meterssrl,a.meterjswd,a.meterhswd  from " + tablename + " a inner join vareainfo b on b.METERNO =a.meterid "
        		+ " and b.buildno=a.buildno inner join TMETERSTATUS c on c.Msid =a.devicestatus   where  " + sql;
		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		DatabaseContextHolder.clearCustomerType();//释放数据库连接
		map.put("data", list);
		writeJSON(response, map);
	}
}
