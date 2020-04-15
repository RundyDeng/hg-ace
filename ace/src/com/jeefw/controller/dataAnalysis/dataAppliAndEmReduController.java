package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

@Controller
@RequestMapping("/dataAnalysis/dataAppliAndEmRedu")
public class dataAppliAndEmReduController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	@RequestMapping("/getcaiNuananalysis")
	public void getCaiNuanAnalysis(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String date = getParm("date");
		String date2 = getParm("date2");

		/*
		 * String sql =
		 * "select case when (instr(c.楼栋号,'栋')>0) then c.楼栋号 else (c.楼栋号||'栋') end as 楼栋号,c.平均进水温度,c.平均回水温度,c.平均温差,d.户数,d.buildno"
		 * //"select c.楼栋号 as buildno,c.平均进水温度 as avgInTemp,c.平均回水温度 as avgBackTemp,c.平均温差 as avgTmpDistance ,d.户数 as doorTotle "
		 * +"\n from( "
		 * +"\n select 楼栋号,Round(avg(进水温度),2)as 平均进水温度,Round(avg(回水温度),2)as 平均回水温度,Round(avg(温差),2)as 平均温差 "
		 * +"\n from( "
		 * +"\n SELECT MeterJSWD AS 进水温度, MeterHSWD AS 回水温度, MeterWC AS 温差, TM.DDate AS 时间, tm.AreaGuid AS 小区编号 "
		 * +"\n ,Ta.AreaName AS 小区名称,AutoID AS 抄表批次,tb.BuildName AS 楼栋号 "
		 * +"\n from TMeter TM " +"\n inner join TDoor_Meter tdm "
		 * +"\n on tdm.MeterNo = tm.MeterID and tdm.AreaGuid = tm.AreaGuid "
		 * +"\n left join TDoor td " +"\n on td.DoorNo=tdm.DoorNo "
		 * +"\n left join TBuild tb "
		 * +"\n on tb.AreaGuid = tm.AreaGuid and td.BuildNo = tb.BuildNo "
		 * +"\n left join TArea Ta " +"\n on Ta.AreaGuid = TM.AreaGuid "
		 * +"\n ) VMeterInfo "
		 * +"\n where 小区编号='"+areaguid+"' and to_char(时间,'YYYY-MM-DD')='"
		 * +date+"' "
		 * //+" where 小区编号='"+areaguid+"' and to_char(时间,'YYYY-MM-DD')='"
		 * +"2016-03-24"+"' " +"\n and 抄表批次=1 and 进水温度<100 group by 楼栋号 "
		 * +"\n ) c "
		 * +"\n left join ( select areaguid,buildno,bname as buildname,count(clientno) as 户数  from vclientinfo where "
		 * +"\n areaguid="+areaguid+" group by areaguid,buildno,bname  ) d "
		 * +"\n on d.BuildName=c.楼栋号 "
		 * +"\n order by to_number(REGEXP_REPLACE (楼栋号,  '[^0-9]+',  '')) asc";
		 * System.out.println(sql); List list =
		 * baseDao.listSqlAndChangeToMap(sql, null);
		 */

		/*
		 * var data = [{"month":
		 * "11月","data1":461.8,"data2":401.5,"percent":-15.01}, {"month":
		 * "12月","data1":746.9,"data2":606.6,"percent":-23.12}, {"month":
		 * "1月","data1":688.9,"data2":769.5,"percent":10.47}, {"month":
		 * "2月","data1":527.8,"data2":574.3,"percent":8.1}, {"month":
		 * "3月","data1":339.4,"data2":369.6,"percent":8.18}, {"month":
		 * "合计","data1":2764.8,"data2":2721.5,"percent":-1.59}];
		 */
		// 时间段一2016-2017
		String section = String.format("%d-%d", Integer.parseInt(date) - 1, Integer.parseInt(date));
		// 时间二
		String section2 = String.format("%d-%d", Integer.parseInt(date2) - 1, Integer.parseInt(date2));

		List<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();

		Random rand = new Random();
		float[] data1 = new float[6];
		float[] data2 = new float[6];
		float[] percent = new float[6];
		String[] month = new String[6];
		String[] sqlmonth = new String[5];



		String[] dateTemp = new String[5];
		String[] dateTemp2 = new String[5];
		dateTemp[0] = Integer.parseInt(date) - 1 + "-" + "11";
		dateTemp[1] = Integer.parseInt(date) - 1 + "-" + "12";
		dateTemp[2] = date + "-" + "01";
		dateTemp[3] = date + "-" + "02";
		dateTemp[4] = date + "-" + "03";

		dateTemp2[0] = Integer.parseInt(date2) - 1 + "-" + "11";
		dateTemp2[1] = Integer.parseInt(date2) - 1 + "-" + "12";
		dateTemp2[2] = date2 + "-" + "01";
		dateTemp2[3] = date2 + "-" + "02";
		dateTemp2[4] = date2 + "-" + "03";
		/*
		 * for(int i = 0 ; i< 6 ; i++){ data1[i] = 300 + rand.nextFloat()+
		 * rand.nextInt(300); data2[i] = 300 + rand.nextFloat()+
		 * rand.nextInt(300); percent[i] = (data2[i] - data1[i])/data2[i]; }
		 */

		// 用于表格显式
		month[0] = "11月";
		month[1] = "12月";
		month[2] = "1月";
		month[3] = "2月";
		month[4] = "3月";
		month[5] = "合计";

		String sql = "";
		String sql2 = "";
		for (int i = 0; i < dateTemp2.length; i++) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("month", month[i]);
		
			// 时间段一 月份数据
			sql = "select sum(度日数)度日数 from(select (sum(swtemp)/count(swtemp)-18)度日数 from twendu where to_char(DDATE,'YYYY-MM')='"
					+ dateTemp[i] + "' group by to_char(DDATE,'YYYY-MM-DD'))";
			List dateAndArea = baseDao.listSqlAndChangeToMap(sql, null);
			Gson gson = new Gson();
			String json = gson.toJson(dateAndArea);

			System.out.println("===" + json);
			JSONArray arr = JSONArray.parseArray(json);

			// 时间段二 月份数据
			sql2 = "select sum(度日数)度日数 from(select (sum(swtemp)/count(swtemp)-18)度日数 from twendu where to_char(DDATE,'YYYY-MM')='"
					+ dateTemp2[i] + "' group by to_char(DDATE,'YYYY-MM-DD'))";
			List dateAndArea2 = baseDao.listSqlAndChangeToMap(sql2, null);
			Gson gson2 = new Gson();
			String json2 = gson2.toJson(dateAndArea2);

			System.out.println("===" + json2);
			JSONArray arr2 = JSONArray.parseArray(json2);		
			System.out.println("arr大小" + arr2.size());

			if (null == arr.getJSONObject(0).getString("度日数")) {
				map.put("data1", "---");
			} else {
				map.put("data1", arr.getJSONObject(0).getString("度日数"));
			}

			if (null == arr2.getJSONObject(0).getString("度日数")) {
				map.put("data2", "---");
			} else {
				map.put("data2", arr2.getJSONObject(0).getString("度日数"));
			}

			try {
				float per = (Float.parseFloat(arr2.getJSONObject(0).getString("度日数"))
						- Float.parseFloat(arr.getJSONObject(0).getString("度日数"))
								/ Float.parseFloat(arr2.getJSONObject(0).getString("度日数")));
				per = (Float.parseFloat(arr2.getJSONObject(0).getString("度日数"))
						- Float.parseFloat(arr.getJSONObject(0).getString("度日数")))
						/ Float.parseFloat(arr2.getJSONObject(0).getString("度日数"));

				map.put("percent", String.format("%.2f%%", per * 100));
			} catch (Exception e) {
				map.put("percent", "---");
			}

			data.add(map);
		}

		System.out.println(Arrays.toString(data1));
		System.out.println(Arrays.toString(data2));
		System.out.println(Arrays.toString(month));
		System.out.println(Arrays.toString(percent));

		// for(int i= 0 ;i < month.length ; i++){
		// HashMap<String,String> map = new HashMap<String,String>();
		// map.put("month", month[i]);
		// map.put("data1", String.format("%.1f", data1[i]));
		// map.put("data2", String.format("%.1f", data2[i]));
		// map.put("percent", String.format("%.2f%%", percent[i]*100));
		// data.add(map);
		// }

		/*
		 * HashMap<String ,String > hashmap =new HashMap<String ,String >();
		 * hashmap.put("hello", "world"); hashmap.put("hello2", "world2");
		 * data.add(hashmap);
		 */

		for (int i = 0; i < data.size(); i++) {
			HashMap<String, String> map = data.get(i);
			for (Map.Entry<String, String> entry : map.entrySet()) {
				System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
			}
		}

		writeJSON(response, data);

		// writeJSON(response, data);
	}
}
