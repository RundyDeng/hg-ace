package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.google.common.util.concurrent.ExecutionError;
import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

@Controller
@RequestMapping("/dataanalysis/useheatindexanalysiscontr")
public class UseHeatIndexAnalysisController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	/**
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getuseheatindexanalysis")
	public void getUseHeatIndexAnalysis(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//小区编号
		String areaguid = getParm("areaguid");
		//楼栋号
		String buildno = getParm("buildno");
		//单元
		String unit = getParm("unit");
		//楼层
		String floor = getParm("floor");
		//门牌号
		String door = getParm("door");
		// 起始时间
		String date = getParm("date");

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);

		/*
		 * cal.add(Calendar.DATE, +5); String endDate =
		 * df.format(cal.getTime());
		 */

		System.out.println(
				"小区：" + areaguid + "  楼宇：" + buildno + " 单元：" + unit + " 楼层：" + floor + " 门牌：" + door + " 日期：" + date);

		String[] days = new String[6];

		days[0] = getParm("date");

		for (int i = 1; i < 6; i++) {
			cal.add(Calendar.DATE, +1);
			days[i] = df.format(cal.getTime());
		}
		cal.add(Calendar.DATE, -6);
		// 起始时间前一天
		String compareDay = df.format(cal.getTime());

		List<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
		
		//查询门牌,时间,平均温度,室外温度   通过小区编号，门牌号，时间查询
		//平均室温是从表tfminf中查的
		//室外温度是从表twendu中查的
		for (int i = 0; i < days.length; i++) {
			//System.out.println("=========日期=========：" + days[i]);
			String sql = "select doorno,面积,时间,平均室温,室外温度 "
					+ "from( select doorno,面积,时间,热能表编号 from vmeterinfo where 小区编号 =" + 1361 + " and doorno=" + 767882
					+ " and 时间='" + days[i] + "')a ,"
					+ "(select meterid,SUM(METERJSWD)/COUNT(mETERJSWD)平均室温 from tfminf where to_char(DDATE,'YYYY-MM-DD')='"
					+ days[i] + "' group by meterid)b,"
					+ "(select sum(swtemp)/count(swtemp)室外温度 from twendu where to_char(DDATE,'YYYY-MM-DD')='" + days[i]
					+ "')c " + "where a.热能表编号=b.meterid";
			List dateAndArea = baseDao.listSqlAndChangeToMap(sql, null);
			Gson gson = new Gson();
			String json = gson.toJson(dateAndArea);

			System.out.println("===" + json);
			
			JSONArray arr = JSONArray.parseArray(json);
			System.out.println("arr.size()==" + arr.size());
		
			HashMap<String, String> map = new HashMap<String, String>();
			if (arr != null && arr.size() > 0) {
				for (int j = 0; j < arr.size(); j++) {
					System.out.println("面积" + j + "= " + arr.getJSONObject(j).getString("面积"));
					
					map.put("date", arr.getJSONObject(j).getString("时间"));
					map.put("outdoor", arr.getJSONObject(j).getString("室外温度"));
					map.put("average", arr.getJSONObject(j).getString("平均室温"));
					map.put("area", arr.getJSONObject(j).getString("面积"));
					if(arr.getJSONObject(j).getString("DOORNO")==null){
						map.put("user", "---");
					}else{
						map.put("user", arr.getJSONObject(j).getString("DOORNO"));
					}
				}		
			}
			
			//如果day[i]  		没有查到结果，查询门牌，面积，
			if (arr.size() == 0) {
				sql="select doorno,面积,时间 from vmeterinfo where 小区编号="+ 1361 + " and doorno="+767882+" and 时间='"+days[i]+"'";
				 dateAndArea = baseDao.listSqlAndChangeToMap(sql, null);
				 gson = new Gson();
				 json = gson.toJson(dateAndArea);
				 arr = JSONArray.parseArray(json);
		
				System.out.println("查询面积" + json);
	
				if(arr.size()==0){
					System.out.println("查询面积arr.size()==0" );
					
					map.put("user", "---");//门牌号
					map.put("date", "---");//时间
					map.put("outdoor", "---");	//室外温度
					//map.put("outdoor", arr.getJSONObject(j).getString("室外温度"));	//室外温度
					map.put("average", "---");	//平均室温
					//map.put("average", arr.getJSONObject(j).getString("平均室温"));	//平均室温
					map.put("area", "---");	//面积
					
				}else{
					map.put("user", arr.getJSONObject(0).getString("DOORNO"));//门牌号
					map.put("date", arr.getJSONObject(0).getString("时间"));//时间
					map.put("outdoor", "---");	//室外温度
					map.put("average", "---");	//平均室温
					map.put("area", arr.getJSONObject(0).getString("面积"));	//面积
				}
			}
			data.add(map); 
		}
		
		// 小时热量
		String sql = "";
		for (int i = 0; i < days.length; i++) {
			if (i == 0) {
				// String sql ="select 累计热量 from vmeterinfo where 小区编号 ="+"1361
				// +" and doorno="+767882+" and 时间='2016-05-01'"; "  
				//累计热量是从表vmeterinfo中查的
				sql = "select (a.累计热量-b.累计热量)/24 小时热量 " + "from" + "(select 累计热量 from vmeterinfo where 小区编号  =" + 1361
						+ " and doorno=" + 767882 + " and 时间='" + days[i] + "')a,"
						+ "(select 累计热量 from vmeterinfo where 小区编号  =1361 and doorno=767882 and 时间='" + compareDay
						+ "')b";
			} else {
				sql = "select (a.累计热量-b.累计热量)/24 小时热量 from" + "(select 累计热量 from vmeterinfo where 小区编号  =" + 1361
						+ " and doorno=" + 767882 + " and 时间='" + days[i] + "')a,"
						+ "(select 累计热量 from vmeterinfo where 小区编号  =1361 and doorno=767882 and 时间='" + days[i - 1]
						+ "')b";
			}
				
			System.out.println("小时热量sql" +sql);

			
			List dayHeat = baseDao.listSqlAndChangeToMap(sql, null);
			Gson gson = new Gson();
			String json = gson.toJson(dayHeat);
			System.out.println("======= " + gson.toJson(dayHeat) + "  ==========");
			JSONArray arr = JSONArray.parseArray(json);
			
			HashMap<String, String> map = data.get(i);
			if(arr.size()==0){
				map.put("hourheat","---");//小时热量
				map.put("heatindex", "---");//热指标
			}else{
				map.put("hourheat",arr.getJSONObject(0).getString("小时热量"));//小时热量
				try{
					map.put("heatindex", Double.parseDouble(arr.getJSONObject(0).getString("小时热量"))*1000/Double.parseDouble(map.get("area"))+"");//热指标
				}catch(Exception e){
					map.put("heatindex", "---");//热指标

				}		
			}

//			if (arr != null && arr.size() > 0) {
//				for (int j = 0; j < arr.size(); j++) {
//					HashMap<String, String> map = data.get(i);
//					
//					 //数据为空的情况
//					if(arr.getJSONObject(j).getString("小时热量") ==null){
//						
//					}
//					
//					
//					map.put("hourheat",arr.getJSONObject(j).getString("小时热量"));//小时热量
//					map.put("heatindex", Double.parseDouble(arr.getJSONObject(j).getString("小时热量"))*1000/Double.parseDouble(map.get("area"))+"");//热指标
//				}
//
//				// map.put("hourheat",arr.getJSONObject(j).getString("小时热量"));//小时热量
//			}
			
//			if(arr.size()==0){
//				
//				map.put("hourheat","---");//小时热量
//				map.put("heatindex", "---");//热指标
//			}
		}

		for (int i = 0; i < data.size(); i++) {
			HashMap<String, String> map = data.get(i); // System.out.println("小时热量："+map.get("hourheat"));
														
			System.out.println("热指标：" + map.get("heatindex"));
			System.out.println("data:" + i);
			System.out.println("用户：" + map.get("user"));
			System.out.println("日期" + map.get("date"));

			System.out.println("室外温度：" + map.get("outdoor"));
			System.out.println("平均室温：" + map.get("average"));
			System.out.println("面积：" + map.get("area"));
			System.out.println("小时热量：" + map.get("hourheat"));

		}

		// 室外温度
		String[] outdoorArea = new String[6];
		// 平均室温
		String[] averageTemp = new String[6];
		// 小时热量
		String[] hourHeat = new String[6];
		// 热指标
		String[] heatIndicator = new String[6];

		/*
		 * Random rand = new Random(); for(int i= 0 ;i <outdoorArea.length ;
		 * i++){ outdoorArea[i] = String.format("%.1f", rand.nextFloat()*10);
		 * averageTemp[i] = String.format("%.1f", 20 + rand.nextInt(10) +
		 * rand.nextFloat()); hourHeat[i] = String.format("%.1f",
		 * rand.nextFloat()*10); heatIndicator[i] = String.format("%d", 40 +
		 * rand.nextInt(10)); }
		 * System.out.println("室外面积"+Arrays.toString(outdoorArea)
		 * +"平均室温"+Arrays.toString(averageTemp)
		 * +"小时热量"+Arrays.toString(hourHeat)
		 * +"热指标"+Arrays.toString(heatIndicator));
		 */

		// String sql = "select case when (instr(c.楼栋号,'栋')>0) then c.楼栋号 else
		// (c.楼栋号||'栋') end as 楼栋号,c.平均进水温度,c.平均回水温度,c.平均温差,d.户数,d.buildno"
		// //"select c.楼栋号 as buildno,c.平均进水温度 as avgInTemp,c.平均回水温度 as
		// avgBackTemp,c.平均温差 as avgTmpDistance ,d.户数 as doorTotle "
		// +"\n from( "
		// +"\n select 楼栋号,Round(avg(进水温度),2)as 平均进水温度,Round(avg(回水温度),2)as
		// 平均回水温度,Round(avg(温差),2)as 平均温差 "
		// +"\n from( "
		// +"\n SELECT MeterJSWD AS 进水温度, MeterHSWD AS 回水温度, MeterWC AS 温差,
		// TM.DDate AS 时间, tm.AreaGuid AS 小区编号 "
		// +"\n ,Ta.AreaName AS 小区名称,AutoID AS 抄表批次,tb.BuildName AS 楼栋号 "
		// +"\n from TMeter TM "
		// +"\n inner join TDoor_Meter tdm "
		// +"\n on tdm.MeterNo = tm.MeterID and tdm.AreaGuid = tm.AreaGuid "
		// +"\n left join TDoor td "
		// +"\n on td.DoorNo=tdm.DoorNo "
		// +"\n left join TBuild tb "
		// +"\n on tb.AreaGuid = tm.AreaGuid and td.BuildNo = tb.BuildNo "
		// +"\n left join TArea Ta "
		// +"\n on Ta.AreaGuid = TM.AreaGuid "
		// +"\n ) VMeterInfo "
		// +"\n where 小区编号='"+areaguid+"' and
		// to_char(时间,'YYYY-MM-DD')='"+date+"' "
		// //+" where 小区编号='"+areaguid+"' and
		// to_char(时间,'YYYY-MM-DD')='"+"2016-03-24"+"' "
		// +"\n and 抄表批次=1 and 进水温度<100 group by 楼栋号 "
		// +"\n ) c "
		// +"\n left join ( select areaguid,buildno,bname as
		// buildname,count(clientno) as 户数 from vclientinfo whre "
		// +"\n areaguid="+areaguid+" group by areaguid,buildno,bname ) d "
		// +"\n on d.BuildName=c.楼栋号 "
		// +"\n order by to_number(REGEXP_REPLACE (楼栋号, '[^0-9]+', '')) asc";

		// 查询 用户编号，面积，日期
		/*
		 * String sql = "select customid,面积,时间  " + "from vmeterinfo " +
		 * "where 小区编号=" +areaguid+ " and doorno=" + door +" and 时间>=" + "'"
		 * +date+"'" + " and 时间 <=" +"'" +endDate +"'" + " order by 时间 asc";
		 * System.out.println("sql====="+sql); List dateAndArea=
		 * baseDao.listSqlAndChangeToMap(sql, null);
		 * 
		 * Gson gson = new Gson(); String json = gson.toJson(dateAndArea);
		 * 
		 * System.out.println("======= " + gson.toJson(dateAndArea) +
		 * "  ==========");
		 * 
		 * List<HashMap<String ,String >> data = new ArrayList<HashMap<String
		 * ,String>>(); JSONArray arr = JSONArray.parseArray(json);
		 * 
		 * for(int i = 0 ; i< arr.size() ; i++){ HashMap<String ,String > map =
		 * new HashMap<String ,String >();
		 * map.put("user",arr.getJSONObject(i).getString("CUSTOMID"));
		 * map.put("date",arr.getJSONObject(i).getString("时间"));
		 * map.put("outdoor", outdoorArea[i]);//室外温度
		 * map.put("area",arr.getJSONObject(i).getString("面积"));
		 * map.put("average",averageTemp[i]);//平均室温
		 * map.put("hourheat",hourHeat[i]);//小时热量
		 * map.put("heatindex",heatIndicator[i]);//热指标
		 * 
		 * data.add(map); }
		 * 
		 * Gson gson2 = new Gson(); System.out.println("======= " +
		 * gson2.toJson(data) + "  ==========");
		 */

		writeJSON(response, data);
	}
}
