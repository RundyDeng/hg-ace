package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/dataAnalysis/baseInfoCountContr")
public class BaseInfoCountController extends IbaseController {
	private int pagesize = 20;
	private String preDate = null;

	@Resource
	private IBaseDao baseDao;

	/*
	 * @RequestMapping("/getStatistic") public void
	 * getStatistic(HttpServletRequest request,HttpServletResponse response)
	 * throws IOException{ Map<String, Object> map = new HashMap<String,
	 * Object>() ; String date = getParm("date"); String areaName =
	 * getParm("areaname"); System.out.println("date:" + date + " areaName:"
	 * +areaName);
	 * 
	 * boolean flag = false; // 各小区表信息统计 String eachAreaMeterInfoSql =
	 * "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
	 * +" from Tarea a " +" left join FACTORYSECTIONINFO b " +
	 * " on a.FACTORYNO=b.SECTIONID " +" left join ENERGYFACTORY c " +
	 * " on c.FACTORYID=b.FACTORYID " +" inner join TGZTJ t " +
	 * " on t.areaguid=a.areaguid " +" where 1=1 ";
	 * 
	 * if(StringUtils.isNotBlank(date)){ eachAreaMeterInfoSql +=
	 * " and t.ddate>to_date('" + date +
	 * "','yyyy-mm-dd hh24:mi:ss') and t.ddate<to_date('" + date +
	 * " 23:59:59','yyyy-mm-dd hh24:mi:ss')  "; flag = true; }
	 * if(StringUtils.isNotBlank(areaName)&&!"null".equals(areaName)){
	 * eachAreaMeterInfoSql += " and a.areaname='"+areaName+"' "; flag = true; }
	 * eachAreaMeterInfoSql+=
	 * " order by NLSSORT(AREANAME, 'NLS_SORT=SCHINESE_PINYIN_M')";
	 * if(flag!=true){
	 * 
	 * } int page = 0; if(StringUtils.isBlank(getParm("page"))) page = 1; else
	 * page = Integer.valueOf(getParm("page"));
	 * 
	 * 
	 * System.out.println("eachAreaMeterInfoSql:"+eachAreaMeterInfoSql);
	 * 
	 * List eachAreaMeterInfo =
	 * baseDao.listSqlPageAndChangeToMap(eachAreaMeterInfoSql, page, pagesize,
	 * null); long total = baseDao.countSql(eachAreaMeterInfoSql); long
	 * pageNumber = (total + pagesize - 1)/pagesize; map.put("data",
	 * eachAreaMeterInfo); map.put("pageCount", pageNumber); writeJSON(response,
	 * map);
	 * 
	 * }
	 */

	/*
	 * @RequestMapping("/getStatistic") public void
	 * getStatistic(HttpServletRequest request,HttpServletResponse response)
	 * throws IOException{ Map<String, Object> map = new HashMap<String,
	 * Object>() ; String date = getParm("date"); String areaNo =
	 * getParm("areaNo");
	 * 
	 * String position = getParm("position"); String brand = getParm("brand");
	 * 
	 * System.out.println("日期："+date + "\t小区" + areaNo + "\t位置:"+position +
	 * "\t厂家:"+brand);
	 * 
	 * SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); try { Date d =
	 * df.parse(date); Calendar cal = Calendar.getInstance(); cal.setTime(d);
	 * cal.add(Calendar.DATE, -1); preDate = df.format(cal.getTime());
	 * System.out.println(preDate); } catch (ParseException e) {
	 * e.printStackTrace(); }
	 * 
	 * 
	 * boolean flag = false; // 各小区表信息统计 String eachAreaMeterInfoSql =
	 * "select a.用户编码 ,a.面积,a.设备状态,(a.meternlljgj-b.meternlljgj)累计热量 " + "from "
	 * + "(select 用户编码 ,面积,设备状态,meternlljgj " + "from vmeterinfo where 小区编号="
	 * +areaNo+ " and 时间=" + "'" + preDate+"'" + ")a," +
	 * "(select 用户编码 ,面积,设备状态,meternlljgj  " + "from vmeterinfo where 小区编号="
	 * +areaNo+ " and 时间= " + "'" + date+"'" + ")b " + "where a.用户编码 = b.用户编码 ";
	 * 
	 * String eachAreaMeterInfoSql =
	 * "select a.用户编码 ,a.面积,a.设备状态,(a.meternlljgj-b.meternlljgj)累计热量 " + "from "
	 * + "(select 用户编码 ,面积,设备状态,meternlljgj " + "from vmeterinfo where 小区编号="
	 * +areaNo+ " and 时间=" + "'" + preDate+"'" + ")a," +
	 * "(select 用户编码 ,面积,设备状态,meternlljgj  " + "from vmeterinfo where 小区编号="
	 * +areaNo+ " and 时间= " + "'" + date+"'" + ")b " + "where a.用户编码 = b.用户编码 ";
	 * 
	 * if(StringUtils.isNotBlank(date)){ eachAreaMeterInfoSql +=
	 * " and t.ddate>to_date('" + date +
	 * "','yyyy-mm-dd hh24:mi:ss') and t.ddate<to_date('" + date +
	 * " 23:59:59','yyyy-mm-dd hh24:mi:ss')  "; flag = true; }
	 * if(StringUtils.isNotBlank(areaName)&&!"null".equals(areaName)){
	 * eachAreaMeterInfoSql += " and a.areaname='"+areaName+"' "; flag = true; }
	 * eachAreaMeterInfoSql+=
	 * " order by NLSSORT(AREANAME, 'NLS_SORT=SCHINESE_PINYIN_M')";
	 * if(flag!=true){
	 * 
	 * } int page = 0; if(StringUtils.isBlank(getParm("page"))) page = 1; else
	 * page = Integer.valueOf(getParm("page"));
	 * 
	 * 
	 * System.out.println("eachAreaMeterInfoSql:"+eachAreaMeterInfoSql);
	 * 
	 * List eachAreaMeterInfo =
	 * baseDao.listSqlPageAndChangeToMap(eachAreaMeterInfoSql, page, pagesize,
	 * null);
	 * 
	 * System.out.println("hello" );
	 * 
	 * 
	 * long total = baseDao.countSql(eachAreaMeterInfoSql); long pageNumber =
	 * (total + pagesize - 1)/pagesize; map.put("data", eachAreaMeterInfo);
	 * map.put("pageCount", pageNumber); writeJSON(response, map);
	 * 
	 * }
	 */

	@RequestMapping("/getBaseInfoCount")
	public void getBaseInfoCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String date = getParm("date");
		String areaNo = getParm("areaNo");

		String position = getParm("position");
		String brand = getParm("brand");
		
		System.out.println("日期：" + date + "\t小区" + areaNo + "\t位置:" + position + "\t厂家:" + brand);

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date d = df.parse(date);
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);
			cal.add(Calendar.DATE, -1);
			preDate = df.format(cal.getTime());
			System.out.println(preDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		String sql = "";
		//没有选择房间位置，选择厂家 ok
		if (position.equals("null") && !brand.equals("null")) {
			sql="select a.meters,b.status,a.hotarea,c.reliang from(select count(热能表编号)meters,sum(面积)hotarea from vmeterinfo where 小区编号="+areaNo+" and devicechildtypeno = "+brand+" and 抄表批次=1 and 时间='"+date+"' )a,(select count(热能表编号)status from vmeterinfo where 小区编号= "+areaNo+" and devicechildtypeno ="+ brand+" and 抄表批次=1 and 时间='"+date+"' and 设备状态!='正常')b,(select sum(round(reliang,2))reliang from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))c";
				
		}
		//选择了房间位置，没有选择厂家ok
		if (!position.equals("null") && brand.equals("null")) {
	
			sql="select meters,status,hotarea,reliang from (select count(meterno)meters,sum(hotarea)hotarea from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+"),(select count(meterno)status from(select areaguid , meterno  from vclientinfo where vclientinfo.areaguid ="+ areaNo+" and  meterxishid=1 )a,(select areaguid,meterid from tmeter_day where areaguid ="+areaNo+" and status!='正常' and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))b where a.areaguid=b.areaguid and a.meterno = b.meterid),(select sum(round(reliang,2))reliang from(select areaguid,meterno from vclientinfo where vclientinfo.areaguid ="+ areaNo+" and  meterxishid="+position+" )a,(select areaguid,meterid ,reliang from tmeter_day where areaguid ="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))b where a.areaguid=b.areaguid and a.meterno = b.meterid)";
		}
		//没有选择房间位置，厂家 ok
		if (position.equals("null") && brand.equals("null")) {

			sql="select meters,status,hotarea,reliang from (select count(meterno)meters ,sum(hotarea)hotarea from vclientinfo where areaguid="+areaNo+" ),(select sum(round(reliang,2))reliang from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')),(select count(meterid)status from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') and status!='正常')";
		}
		//选择房间位置，选择厂家ok
		if (!position.equals("null") && !brand.equals("null")) {

			//sql="select b.meters,a.status,b.hotarea,c.reliang from(select count(meterno)status from (select 小区编号,热能表编号,设备状态,devicechildtypeno from vmeterinfo where 小区编号="+areaNo+" and 时间='"+date+"' and 设备状态!='正常' and 抄表批次=1  and devicechildtypeno="+brand+")a,(select areaguid, meterno,meterxishid from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+")b where a.小区编号=b.areaguid and a.热能表编号=b.meterno)a,(select count(meterno)meters,sum(面积)hotarea from (select 小区编号,热能表编号,设备状态, 面积,devicechildtypeno from vmeterinfo where 小区编号="+areaNo+" and 时间='"+date+"' and 抄表批次=1 and devicechildtypeno="+brand+")a,(select areaguid, meterno,meterxishid from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+")b where a.小区编号=b.areaguid and a.热能表编号=b.meterno)b,(select sum(reliang)reliang from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))c";	
			sql="select * from(select count(meterno)meters,sum(hotarea)hotarea from(select 小区编号,热能表编号 from vmeterinfo where 小区编号="+areaNo+" and 时间='"+date+"' and 抄表批次=1  and devicechildtypeno="+brand+")a,(select areaguid,meterno,hotarea from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+")b where a.小区编号=b.areaguid and a.热能表编号=b.meterno),(select count(meterno)status from(select 小区编号,热能表编号 from vmeterinfo where 小区编号="+areaNo+" and 时间='"+date+"' and 设备状态='错误' and 抄表批次=1 and devicechildtypeno="+brand+")a,(select areaguid,meterno,hotarea from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+")b where a.小区编号=b.areaguid and a.热能表编号=b.meterno),(select sum(round(reliang,2))reliang from(select areaguid,meterno,hotarea from(select 小区编号,热能表编号 from vmeterinfo where 小区编号="+areaNo+" and 时间='"+date+"' and 抄表批次=1  and devicechildtypeno="+brand+")a,(select areaguid,meterno,hotarea from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+")b where a.小区编号=b.areaguid and a.热能表编号=b.meterno)c ,(select areaguid,meterid,reliang from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))d where c.areaguid=d.areaguid and c.meterno =d.meterid)";
		}

		System.out.println("sql:" + sql);
		
		List dateAndArea = baseDao.listSqlAndChangeToMap(sql, null);
		Gson gson = new Gson();
		String json = gson.toJson(dateAndArea);
		JSONArray arr = JSONArray.parseArray(json);		
		
		System.out.println("arr= "+arr);
		
		HashMap<String, String> map = new HashMap<String, String>();
		String meters = arr.getJSONObject(0).getString("METERS");
		String status = arr.getJSONObject(0).getString("STATUS");	
		String hotarea = arr.getJSONObject(0).getString("HOTAREA");
		String reliang = arr.getJSONObject(0).getString("RELIANG");	
		
		if(meters==null ){
			map.put("meters", "没数据");
			System.out.println("没数据");
		}else{
			map.put("meters", meters);

		}
		if(status==null ){
			map.put("status","没数据");
			System.out.println("没数据");

		}else{
			map.put("status", status);

		}
		if(hotarea==null ){
			map.put("hotarea", "没数据");
			System.out.println("没数据");

		}else{
			map.put("hotarea", hotarea);

		}
		if(reliang==null){
			map.put("reliang","没数据");
			System.out.println("reliang没数据");

		}else{
			map.put("reliang", reliang);

		}
		writeJSON(response, map);
	}

	

}
