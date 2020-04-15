package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

@Controller
@RequestMapping("/dataanalysis/heatSeasonanalysiscontr")
public class HeatSeasonAnalysisController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	float section1, section2, section3, section4, section5, section6, section7, section8, section9, section10,
			section11, section12, section13, section14, section15, section16, section17, section18, section19,
			section20, section21;

	int count1, count2, count3, count4, count5, count6, count7, count8, count9, count10, count11, count12, count13,
			count14, count15, count16, count17, count18, count19, count20, count21;

	float[] section;
	float[] section_a;
	
	@RequestMapping("/getheatSeasonanalysis")
	public void getHeatSeasonAnalysis(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String areaguid = getParm("areaguid");
			
		String date = getParm("date");
		String start_date=(Integer.parseInt(date)-1)+"-10-15";
		date= date+"-04-15";
		
		String date2 = getParm("date2");
		String start_date2=(Integer.parseInt(date2)-1)+"-10-15";
		date2= date2+"-04-15";
				
		//System.out.println(
	//			"==========" + "小区：" + areaguid + "  开始时间：" +start_date+ "---"+ date  + "  结束时间：" + start_date2+"---"+date2   +"===========");
		
		section = new float[21];
		int[] count= new int[21];

		String sql = "select c.doorno ,case when 面积=0 then 0 else round(MeterNLLJGJ/面积,2) end as expend "
				+ "from (select a.doorno,a.面积,abs(a.MeterNLLJGJ-b.MeterNLLJGJ) as MeterNLLJGJ "
				+ "from(select doorno,面积,max(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间=" + "'" + date + "'" + " group by doorno, 面积)a ,"
				+ "(select doorno,面积,min(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + start_date + "'" + " group by doorno , 面积 )b "
				+ "where a.doorno=b.doorno order by doorno)c order by c.doorno";

	//	System.out.println("=======" + sql + "=======");

		List list = baseDao.listSqlAndChangeToMap(sql, null);

		Gson gson = new Gson();
		String json = gson.toJson(list);
	//	System.out.println("======= " + gson.toJson(list) + "  ==========");

		String maxAndMinExpend = "select max(d.expend)as max,min(d.expend)as min "
				+ "from (select c.doorno , c.面积 ,MeterNLLJGJ,case when 面积=0 then 0 else round(MeterNLLJGJ/面积,2) end as expend "
				+ "from (select a.doorno,a.面积,abs(a.MeterNLLJGJ-b.MeterNLLJGJ) as MeterNLLJGJ "
				+ "from(select doorno,面积,max(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + date + "'" + " group by doorno, 面积)a ,"
				+ "(select doorno,面积,min(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + start_date + "'" + " group by doorno, 面积 )b "
				+ "where a.doorno=b.doorno order by doorno)c order by c.doorno)d";

	//	System.out.print("==第一个===" + maxAndMinExpend + "\n");
		List list2 = baseDao.listSqlAndChangeToMap(maxAndMinExpend, null);

		Gson gson2 = new Gson();
		String json2 = gson2.toJson(list2);

//		System.out.print("===第一个==" + gson2.toJson(list2) + "========" + "\n");

		JSONArray arr2 = JSONArray.parseArray(json2);
		float min = 0f;
		float max = 0f;
		for (int j = 0; j < arr2.size(); j++) {	
			min = arr2.getJSONObject(j).getFloatValue("MIN");
			max = arr2.getJSONObject(j).getFloatValue("MAX");		
			//System.out.print("max: "+max + " min:"+min);
		}

		for (int i = 0; i < section.length; i++) {
			section[i] = min + (max - min) *( i+1) / 21;
		}

		JSONArray arr = JSONArray.parseArray(json);
		float expend = 0f;

		List<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
		for (int i = 0; i < arr.size(); i++) {
	//		System.out.println(i + " " + arr.getJSONObject(i).get("EXPEND"));
			expend = arr.getJSONObject(i).getFloatValue("EXPEND");

			if (expend <= section[0]) {
				count[0] += 1;
			}

			if (section[0] < expend && expend <= section[1]) {
				count[1] += 1;
			}

			if (section[1] < expend && expend <= section[2]) {
				count[2] += 1;
			}

			if (section[2] < expend && expend <= section[3]) {
				count[3] += 1;
			}

			if (section[3] < expend && expend <= section[4]) {
				count[4] += 1;
			}

			if (section[4] < expend && expend <= section[5]) {
				count[5] += 1;
			}

			if (section[5] < expend && expend <= section[6]) {
				count[6] += 1;
			}
			if (section[6] < expend && expend <= section[7]) {
				count[7] += 1;
			}

			if (section[7] < expend && expend <= section[8]) {
				count[8] += 1;
			}
			if (section[8] < expend && expend <= section[9]) {
				count[9] += 1;
			}

			if (section[9] < expend && expend <= section[10]) {
				count[10] += 1;
			}

			if (section[10] < expend && expend <= section[11]) {
				count[11] += 1;
			}

			if (section[11] < expend && expend <= section[12]) {
				count[12] += 1;
			}

			if (section[12] < expend && expend <= section[13]) {
				count[13] += 1;
			}
			if (section[13] < expend && expend <= section[14]) {
				count[14] += 1;
			}
			if (section[14] < expend && expend <= section[15]) {
				count[15] += 1;
			}

			if (section[15] < expend && expend <= section[16]) {
				count[16] += 1;
			}
			if (section[16] < expend && expend <= section[17]) {
				count[17] += 1;
			}

			if (section[17] < expend && expend <= section[18]) {
				count[18] += 1;
			}
			if (section[18] < expend && expend <= section[19]) {
				count[19] += 1;
			}
			if (section[19] < expend && expend <= section[20]) {
				count[20] += 1;
			}
		}

	/*	System.out.println(Arrays.toString(count));
		System.out.println(Arrays.toString(section));*/
		
		String[]  strCount = new String[21];
		String[]  strSection = new String[21];
		for(int i = 0 ; i<count.length ; i++){
			strCount[i] = String.format("%d", count[i]);
		}
		
		for(int i = 0 ; i< section.length ; i++){
			strSection[i] = String.format("%.2f", section[i]);	
		}
		
		for(int i= 0 ; i<strCount.length ; i++){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("section", strSection[i]);
			map.put("count", strCount[i]);
			data.add(map);
		}
		
		//==========================================
		
		section_a = new float[21];
		int[] count_a = new int[21];
		
		String sql2 = "select c.doorno ,case when 面积=0 then 0 else round(MeterNLLJGJ/面积,2) end as expend "
				+ "from (select a.doorno,a.面积,abs(a.MeterNLLJGJ-b.MeterNLLJGJ) as MeterNLLJGJ "
				+ "from(select doorno,面积,max(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间=" + "'" + date2 + "'" + " group by doorno, 面积)a ,"
				+ "(select doorno,面积,min(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + start_date2 + "'" + " group by doorno , 面积 )b "
				+ "where a.doorno=b.doorno order by doorno)c order by c.doorno";
		
	//	System.out.println("===第二个===" + sql2 + "=======");

		List list_a = baseDao.listSqlAndChangeToMap(sql2, null);

		Gson gson_a = new Gson();
		String json_a = gson_a.toJson(list_a);
	//	System.out.print("===第二个==" + json_a + "======" + "\n");

		String maxAndMinExpend_two = "select max(d.expend)as max,min(d.expend)as min "
				+ "from (select c.doorno , c.面积 ,MeterNLLJGJ,case when 面积=0 then 0 else round(MeterNLLJGJ/面积,2) end as expend "
				+ "from (select a.doorno,a.面积,abs(a.MeterNLLJGJ-b.MeterNLLJGJ) as MeterNLLJGJ "
				+ "from(select doorno,面积,max(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + date2 + "'" + " group by doorno, 面积)a ,"
				+ "(select doorno,面积,min(MeterNLLJGJ) MeterNLLJGJ " + "from vmeterinfo " + "where 小区编号=" + areaguid
				+ " and 时间= " + "'" + start_date2 + "'" + " group by doorno, 面积 )b "
				+ "where a.doorno=b.doorno order by doorno)c order by c.doorno)d";
		
	//	System.out.println("===第二个===" + maxAndMinExpend_two + "=======");
		List list_b = baseDao.listSqlAndChangeToMap(maxAndMinExpend_two, null);
		
		Gson gson_b = new Gson();
		String json_b = gson_b.toJson(list_b);

	//	System.out.print("===第二个== " + json_b + "====" + "\n");
		
		JSONArray arr_a = JSONArray.parseArray(json_b);
		float min_a = 0f;
		float max_a = 0f;
		for (int j = 0; j < arr_a.size(); j++) {
			System.out.print(j + " " + arr_a.getJSONObject(j).get("SECTION"));
			min_a = arr_a.getJSONObject(j).getFloatValue("MIN");
			max_a = arr_a.getJSONObject(j).getFloatValue("MAX");	
		}
		System.out.print( "\n");
		System.out.print("max: "+max_a + " min:"+min_a + "\n");

		for (int i = 0; i < section_a.length; i++) {
			section_a[i] = min_a + (max_a - min_a) * (i+1) / 21;
		}
		
		JSONArray arr_b = JSONArray.parseArray(json_a);
		
		float expend_a = 0f;
		
		for (int i = 0; i < arr_b.size(); i++) {
			System.out.print(i + " " + arr_b.getJSONObject(i).get("EXPEND"));
			expend_a = arr_b.getJSONObject(i).getFloatValue("EXPEND");

			if (expend_a <= section_a[0]) {
				count_a[0] += 1;
			}

			if (section_a[0] < expend_a && expend_a <= section_a[1]) {
				count_a[1] += 1;
			}

			if (section_a[1] < expend_a && expend_a <= section_a[2]) {
				count_a[2] += 1;
			}

			if (section_a[2] < expend_a && expend_a <= section_a[3]) {
				count_a[3] += 1;
			}

			if (section_a[3] < expend_a && expend_a <= section_a[4]) {
				count_a[4] += 1;
			}

			if (section_a[4] < expend_a && expend_a <= section_a[5]) {
				count_a[5] += 1;
			}

			if (section_a[5] < expend_a && expend_a <= section_a[6]) {
				count_a[6] += 1;
			}
			if (section_a[6] < expend_a && expend_a <= section_a[7]) {
				count_a[7] += 1;
			}

			if (section_a[7] < expend_a && expend_a <= section_a[8]) {
				count_a[8] += 1;
			}
			if (section_a[8] < expend_a && expend_a <= section_a[9]) {
				count_a[9] += 1;
			}

			if (section_a[9] < expend_a && expend_a <= section_a[10]) {
				count_a[10] += 1;
			}

			if (section_a[10] < expend_a && expend_a <= section_a[11]) {
				count_a[11] += 1;
			}

			if (section_a[11] < expend_a && expend_a <= section_a[12]) {
				count_a[12] += 1;
			}

			if (section_a[12] < expend_a && expend_a <= section_a[13]) {
				count_a[13] += 1;
			}
			if (section_a[13] < expend_a && expend_a <= section_a[14]) {
				count_a[14] += 1;
			}
			if (section_a[14] < expend_a && expend_a <= section_a[15]) {
				count_a[15] += 1;
			}

			if (section_a[15] < expend_a && expend_a <= section_a[16]) {
				count_a[16] += 1;
			}
			if (section_a[16] < expend_a && expend_a <= section_a[17]) {
				count_a[17] += 1;
			}

			if (section_a[17] < expend_a && expend_a <= section_a[18]) {
				count_a[18] += 1;
			}
			if (section_a[18] < expend_a && expend_a <= section_a[19]) {
				count_a[19] += 1;
			}
			if (section_a[19] < expend_a && expend_a <= section_a[20]) {
				count_a[20] += 1;
			}
		}
		
		String[]  strCount_a = new String[21];
		String[]  strSection_a = new String[21];
		for(int i = 0 ; i<count_a.length ; i++){
			strCount_a[i] = String.format("%d", count_a[i]);
		}
		
		for(int i = 0 ; i< strSection_a.length ; i++){
			strSection_a[i] = String.format("%.2f", section_a[i]);	
		}
		
		System.out.print("第二个："+Arrays.toString(strCount_a) +"\n");
		System.out.print("第二个："+Arrays.toString(strSection_a) + "\n");
		
		for(int i= 0 ; i<strCount_a.length ; i++){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("section", strSection_a[i]);
			map.put("count", strCount_a[i]);
			data.add(map);
		}
		
		for(int i= 0 ; i<data.size() ;i++){
			HashMap<String, String> map  = data.get(i);
			for(Map.Entry<String, String> entry : map.entrySet()){
				System.out.print("结果："+i + "键：   " +entry.getKey() + "值：" +entry.getValue());
			}
		}
		
		writeJSON(response, data);
	}
}
