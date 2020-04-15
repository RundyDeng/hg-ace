package com.jeefw.controller.baseinfomanage;

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
@RequestMapping("/baseinfomanage/areaSearch")
public class AreaSearchController extends IbaseController{
	private int pagesize = 20;
	private String preDate=null;
	
	@Resource
	private IBaseDao baseDao;
	
/*	@RequestMapping("/getStatistic")
	public void getStatistic(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, Object> map = new HashMap<String, Object>() ;
		String date = getParm("date");
		String areaName = getParm("areaname");
		
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date d = df.parse(date);
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);
			cal.add(Calendar.DATE, -1);
			String preDate = df.format(cal.getTime());
			System.out.println(preDate);
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		
		
		System.out.println("data:" + date +" areaname:"+areaName);
		
		boolean flag = false;
		// 各小区表信息统计
		String eachAreaMeterInfoSql = "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
									+" from Tarea a "
									+" left join FACTORYSECTIONINFO b "
									+" on a.FACTORYNO=b.SECTIONID "
									+" left join ENERGYFACTORY c "
									+" on c.FACTORYID=b.FACTORYID "
									+" inner join TGZTJ t "
									+" on t.areaguid=a.areaguid "
									+" where 1=1 ";
		
		if(StringUtils.isNotBlank(date)){
			eachAreaMeterInfoSql += " and t.ddate>to_date('" + date + "','yyyy-mm-dd hh24:mi:ss') and t.ddate<to_date('" + date + " 23:59:59','yyyy-mm-dd hh24:mi:ss')  ";
			flag = true;
		}
		if(StringUtils.isNotBlank(areaName)&&!"null".equals(areaName)){
			eachAreaMeterInfoSql += " and a.areaname='"+areaName+"' ";
			flag = true;
		}
		eachAreaMeterInfoSql+=" order by NLSSORT(AREANAME, 'NLS_SORT=SCHINESE_PINYIN_M')";
		if(flag!=true){
			
		}
		int page = 0;
		if(StringUtils.isBlank(getParm("page")))
			page = 1;
		else
			page = Integer.valueOf(getParm("page"));
		List eachAreaMeterInfo = baseDao.listSqlPageAndChangeToMap(eachAreaMeterInfoSql, page, pagesize, null);
		long total = baseDao.countSql(eachAreaMeterInfoSql);
		long pageNumber = (total + pagesize - 1)/pagesize;
		map.put("data", eachAreaMeterInfo);
		map.put("pageCount", pageNumber);
		writeJSON(response, map);

	}*/
	
	@RequestMapping("/getStatistic")
	public void getStatistic(HttpServletRequest request,HttpServletResponse response)throws IOException {
		
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();
		String date = getParm("date");
		String areaNo = getParm("areaNo");
		
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
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
				
		System.out.println("data:" + date +" areaNo:"+areaNo);
		
		String sql = "select a.用户编码 ,a.面积,a.设备状态,(a.meternlljgj-b.meternlljgj)累计热量 "
				+ "from (select 用户编码 ,面积,设备状态,meternlljgj  "
					+ "from vmeterinfo where 小区编号="+areaNo+" and 时间="+"'"+preDate+"'"+")a,"
					+ "(select 用户编码 ,面积,设备状态,meternlljgj  from vmeterinfo where 小区编号="+ areaNo+" and 时间="+"'"+date+"'"+ ")b "
				+ "where a.用户编码 = b.用户编码";
		
		System.out.println(sql);
		
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		System.out.println(json);
		
		JSONArray arr = JSONArray.parseArray(json);	
		for(int i=0 ; i<arr.size() ;i++){
			Map<String, String> map = new HashMap<String, String>() ;
			map.put("userno", arr.getJSONObject(i).getString("用户编码"));
			map.put("area", arr.getJSONObject(i).getString("面积"));
			if(arr.getJSONObject(i).getString("设备状态")==null){
				map.put("devicestatuts", "");
			}else{
				map.put("devicestatuts", arr.getJSONObject(i).getString("设备状态"));
			}
			map.put("totalheat", arr.getJSONObject(i).getString("累计热量"));
			data.add(map);
		}
		
		for (int i = 0; i < data.size(); i++) {
			Map<String, String> map = data.get(i);
			for (Map.Entry<String, String> entry : map.entrySet()) {
				System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
			}
		}
		
		writeJSON(response, data);
	}
	
	
	@RequestMapping("/updateStatistic")
	public void updateStatistic(HttpServletRequest request,HttpServletResponse response){
		
	}
	

	
}
