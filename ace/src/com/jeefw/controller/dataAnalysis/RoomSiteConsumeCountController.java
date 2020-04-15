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
@RequestMapping("/dataAnalysis/roomSiteConsumeCountContr")
public class RoomSiteConsumeCountController extends IbaseController {
	private int pagesize = 20;
	private String preDate = null;

	@Resource
	private IBaseDao baseDao;

	@RequestMapping("/getRoomSiteConsumeCount")
	public void getRoomLocationConsumeCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String date = getParm("date");
		String areaNo = getParm("areaNo");

		String position = getParm("position");
		String brand = getParm("brand");
		

		System.out.println("小区" + areaNo + "\t位置:" + position );
		
		System.out.println("日期：" + date + "\t小区" + areaNo + "\t位置:" + position + "\t厂家:" + brand);
		
		//6个月份	11月 、 12月 、1月 、2月、3月、4月	
		String section[] = new String[6];
		
		section[0]=Integer.parseInt(date)+"-01";
		section[1]=Integer.parseInt(date)+"-02";
		section[2]=Integer.parseInt(date)+"-03";
		section[3]=Integer.parseInt(date)+"-04";
		section[4]=Integer.parseInt(date)-1+"-11";
		section[5]=Integer.parseInt(date)-1+"-12";
		
		//6个月的用热天数
		String hotDays[] = new String[6];
		//6个月室外平均温度
		String avgTemp[] = new String[6];
		
		String sql = "";	//查询面积、耗热量

		if(!"null".equals(position)){
			sql = "";			
		}
		
		
		//没有选择房间位置，选择厂家 ok
		if (position.equals("null") && !brand.equals("null")) {
			sql="select a.meters,b.status,a.hotarea,c.reliang from(select count(热能表编号)meters,sum(面积)hotarea from vmeterinfo where 小区编号="+areaNo+" and devicechildtypeno = "+brand+" and 抄表批次=1 and 时间='"+date+"' )a,(select count(热能表编号)status from vmeterinfo where 小区编号= "+areaNo+" and devicechildtypeno ="+ brand+" and 抄表批次=1 and 时间='"+date+"' and 设备状态!='正常')b,(select sum(reliang)reliang from tmeter_day where areaguid="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))c";
				
		}
		//选择了房间位置，没有选择厂家ok
		if (!position.equals("null") && brand.equals("null")) {
	
			sql="select meters,status,hotarea,reliang from (select count(meterno)meters,sum(hotarea)hotarea from vclientinfo where areaguid="+areaNo+" and meterxishid="+position+"),(select count(meterno)status from(select areaguid , meterno  from vclientinfo where vclientinfo.areaguid ="+ areaNo+" and  meterxishid=1 )a,(select areaguid,meterid from tmeter_day where areaguid ="+areaNo+" and status!='正常' and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))b where a.areaguid=b.areaguid and a.meterno = b.meterid),(select sum(reliang)reliang from(select areaguid,meterno from vclientinfo where vclientinfo.areaguid ="+ areaNo+" and  meterxishid="+position+" )a,(select areaguid,meterid ,reliang from tmeter_day where areaguid ="+areaNo+" and ddate=to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss'))b where a.areaguid=b.areaguid and a.meterno = b.meterid)";
		}
		//没有选择房间位置，选择了小区
		if (position.equals("null") && !areaNo.equals("null")) {

			sql= "select trunc(month01,2)month01,trunc(month02,2)month02,trunc(month03,2)month03 ,trunc(month04,2)month04,trunc(month11,2)month11 ,trunc(month12,2)month12 ,hotarea,site from ((select sum(reliang01)month01,sum(reliang02)month02,sum(reliang03)month03，sum(reliang04)month04，sum(reliang11)month11，sum(reliang12)month12 , c.meterxishid ,c.position site from "
					+ "(select  areaguid ,meterid,  decode(to_char(ddate,'mm'),'01',reliang,0) reliang01, "
					+ "decode(to_char(ddate,'mm'),'02',reliang,0) reliang02, "
					+ "decode(to_char(ddate,'mm'),'03',reliang,0) reliang03, "
					+ "decode(to_char(ddate,'mm'),'04',reliang,0) reliang04 "
					+ "from "
					+ "tmeter_day where to_char(ddate,'yyyy')='"+ date +"' and areaguid ="+areaNo+")a left join "
					+ "(select  areaguid ,meterid ,decode(to_char(ddate,'mm'),'11',reliang,0) reliang11, "
					+ "decode(to_char(ddate,'mm'),'12',reliang,0) reliang12 "
					+ "from "
					+ "tmeter_day where to_char(ddate,'yyyy')='"+(Integer.parseInt(date)-1)+"' and areaguid ="+areaNo+")b on a.areaguid = b.areaguid and a.meterid = b.meterid "
					+ "left join (select areaguid ,meterno ,meterxishid , position from vclientinfo )c "
					+ "on a.areaguid = c.areaguid and a.meterid = c.meterno group by  c.meterxishid , c.position))d left join "
					+ "(select sum(uarea)hotarea ,meterxishid from vclientinfo where areaguid="+areaNo+" group by meterxishid)e on d.meterxishid = e.meterxishid"; 
			
		}
		
		//选择房间位置，选择了小区
		if (!position.equals("null") && !areaNo.equals("null")) {
		
			sql="select trunc(month01,2)month01,trunc(month02,2)month02,trunc(month03,2)month03 ,trunc(month04,2)month04,trunc(month11,2)month11 ,trunc(month12,2)month12,hotarea,site  from ( " +
					"select sum(decode(to_char(ddate,'mm'),'01',b.reliang,0)) month01,  "+
					" sum(decode(to_char(ddate,'mm'),'02',b.reliang,0)) month02, " +
					" sum(decode(to_char(ddate,'mm'),'03',b.reliang,0)) month03, " +
					" sum(decode(to_char(ddate,'mm'),'04',b.reliang,0)) month04 " +
					" from " + 
					"(select * from (select tmeter_day.AREAGUID , tmeter_day.area , tmeter_day.reliang, tmeter_day.ddate ,vclientinfo.meterxishid from tmeter_day left join vclientinfo on tmeter_day.areaguid=vclientinfo.AREAGUID and tmeter_day.meterid = vclientinfo.meterno)a where a.AREAGUID=" + areaNo + " and a.meterxishid="+ position +")b  where to_char(b.ddate,'yyyy')='"+date+"')," +
					"(select  sum(decode(to_char(ddate,'mm'),'11',b.reliang,0)) month11, sum(decode(to_char(ddate,'mm'),'12',b.reliang,0)) month12 " +
					" from " + 
					"(select * from (select tmeter_day.AREAGUID , tmeter_day.area , tmeter_day.reliang, tmeter_day.ddate ,vclientinfo.meterxishid from tmeter_day left join vclientinfo on tmeter_day.areaguid=vclientinfo.AREAGUID and tmeter_day.meterid = vclientinfo.meterno)a where a.AREAGUID=" + areaNo + " and a.meterxishid="+ position +")b  where to_char(b.ddate,'yyyy')='"+(Integer.parseInt(date)-1)+"')," +
					"(select sum(hotarea)hotarea from vclientinfo where vclientinfo.areaguid = " + areaNo +" and vclientinfo.meterxishid=" + position +"),(select distinct vclientinfo.position site from vclientinfo where vclientinfo.METERXISHID="+ position +")";
				
		}

		System.out.println("sql:" + sql);
		
		List dateAndArea = baseDao.listSqlAndChangeToMap(sql, null);
		Gson gson = new Gson();
		String json = gson.toJson(dateAndArea);
		JSONArray arr = JSONArray.parseArray(json);		
		
		System.out.println("arr= "+arr);
		
		List<HashMap<String ,String >> list = new ArrayList<HashMap<String, String>>();
		List<HashMap<String ,String >> resList = new ArrayList<HashMap<String, String>>();
		
	/*	String meters = arr.getJSONObject(0).getString("METERS");
		String status = arr.getJSONObject(0).getString("STATUS");	
		String hotarea = arr.getJSONObject(0).getString("HOTAREA");
		String reliang = arr.getJSONObject(0).getString("RELIANG");	*/
		
		for(int i = 0 ; i< arr.size() ; i++){
			
			String site = arr.getJSONObject(i).getString("SITE");	
			String hotarea = arr.getJSONObject(i).getString("HOTAREA");
			String reliang01 = arr.getJSONObject(i).getString("MONTH01");	
			String reliang02 = arr.getJSONObject(i).getString("MONTH02");	
			String reliang03 = arr.getJSONObject(i).getString("MONTH03");	
			String reliang04 = arr.getJSONObject(i).getString("MONTH04");	
			String reliang11 = arr.getJSONObject(i).getString("MONTH11");	
			String reliang12 = arr.getJSONObject(i).getString("MONTH12");	
			
			if(hotarea ==null){
				hotarea="0";
			}
			if(reliang01 ==null){
				reliang01="0";
			}
			if(reliang02 ==null){
				reliang02="0";
			}
			if(reliang03 ==null){
				reliang03="0";
			}	
			if(reliang04 ==null){
				reliang04="0";
			}
			if(reliang11 ==null){
				reliang11="0";
			}
			if(reliang12 ==null){
				reliang12="0";
			}
			
			HashMap<String, String> map = new HashMap<String, String>();
			
			map.put("site", site);
			map.put("hotarea", hotarea);
			map.put("reliang01", reliang01);
			map.put("reliang02", reliang02);
			map.put("reliang03", reliang03);
			map.put("reliang04", reliang04);
			map.put("reliang11", reliang11);
			map.put("reliang12", reliang12);
			
			list.add(map);
		}
		
		//用热天数	室外平均温度
		JSONArray daysArr ; 
		JSONArray tempsArr ; 
		
		for(int i = 0 ; i< section.length ; i++){
			//用热天数
			String sql2= "select sum(days)days from (select (case when reliang = 0 then 0 else 1 end)days ,to_date(ddate , 'yyyy-mm-dd')ddate "
					+ "from(select to_char(ddate, 'YYYY-MM-DD')ddate, sum(reliang)reliang  "
					+ "from tmeter_day group by to_char(ddate, 'YYYY-MM-DD')))a where to_char(ddate, 'yyyy-mm')='" + section[i] + "'";
			
			//室外平均温度
			//String sql3= "select nvl(sum(swtemp)/count(swtemp) , 0) as avgswtemp from twendu where to_char(ddate, 'yyyy-mm-dd') = '" + section[i] + "'";
			String sql3= "select sum(swtemp)/count(swtemp) as avgswtemp from twendu where to_char(ddate, 'yyyy-mm-dd') = '" + section[i] + "'";

			
			List days = baseDao.listSqlAndChangeToMap(sql2, null);
			Gson daysGson = new Gson();
			String daysJson = daysGson.toJson(days);
			daysArr = JSONArray.parseArray(daysJson);	
			
			List temps = baseDao.listSqlAndChangeToMap(sql3, null);
			Gson tempsGson = new Gson();
			String tempsJson = daysGson.toJson(temps);
			tempsArr = JSONArray.parseArray(tempsJson);	
			
			String daysStr = daysArr.getJSONObject(0).getString("DAYS");
			
			String avgSwtemp = tempsArr.getJSONObject(0).getString("AVGSWTEMP");
			
			hotDays[i] = daysStr;
			avgTemp[i] = avgSwtemp;
			
			if(hotDays[i] ==null){
				hotDays[i]="0";
			}
			
			System.out.println("hotDays[i] " + i + "    " + hotDays[i]);
			
			System.out.println("avgTemp[i] " + i + "    " + avgTemp[i]);
				
			System.out.println("sql2 " + i + "  " + sql2 );
			System.out.println("sql3 " + i + "  " + sql3 );
		}
		 	
	
		for(int i= 0 ; i< list.size() ; i++){
			
			System.out.println("list.size() " + list.size());
			HashMap<String, String> map = list.get(i);
			String site = map.get("site");
			String hotarea = map.get("hotarea");
			String reliang01 = map.get("reliang01");
			String reliang02 = map.get("reliang02");
			String reliang03 = map.get("reliang03");
			String reliang04 = map.get("reliang04");
			String reliang11 = map.get("reliang11");	
			String reliang12 = map.get("reliang12");	
			
			float hotareaF= Float.parseFloat(hotarea);
			float re01= Float.parseFloat(reliang01);
			float re02= Float.parseFloat(reliang02);
			float re03= Float.parseFloat(reliang03);
			float re04= Float.parseFloat(reliang04);
			float re11= Float.parseFloat(reliang11);
			float re12= Float.parseFloat(reliang12);
			
			//累计耗热量
			float totalRe = re01 + re02 + re03 + re04 + re11 + re12;
		
			double hotKPI01=0;
			double hotKPI02 =0;
			double hotKPI03=0;
			double hotKPI04 =0;
			double hotKPI11=0;
			double hotKPI12 =0;
			//如果供热天数为0，或没有室外平均温度
			if(Integer.parseInt(hotDays[0]) ==0  || avgTemp[0] ==null){
				hotKPI01=0;
			}else{
			 hotKPI01 = re01/((18- Float.parseFloat(avgTemp[0]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[0])/3600;
			}
			
			if(Integer.parseInt(hotDays[1]) ==0 || avgTemp[1] ==null){
				hotKPI02=0;
			}else{
				 hotKPI02 = re02/((18- Float.parseFloat(avgTemp[1]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[1])/3600;
			}
			
			if(Integer.parseInt(hotDays[2]) ==0 || avgTemp[2] ==null){
				hotKPI03=0;
			}else{
				 hotKPI03 = re03/((18- Float.parseFloat(avgTemp[2]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[2])/3600;
			}
			
			if(Integer.parseInt(hotDays[3]) ==0 || avgTemp[3] ==null){
				hotKPI04=0;
			}else{
				 hotKPI04 = re04/((18- Float.parseFloat(avgTemp[3]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[3])/3600;
			}
			
			if(Integer.parseInt(hotDays[4]) ==0 || avgTemp[4] ==null){
				hotKPI11=0;
			}else{
				 hotKPI11 = re11/((18- Float.parseFloat(avgTemp[4]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[4])/3600;
			}
			
			if(Integer.parseInt(hotDays[5]) ==0 || avgTemp[5] ==null){
				hotKPI12=0;
			}else{
				 hotKPI12 = re12/((18- Float.parseFloat(avgTemp[5]))/(18+14))*3.6*1000000/24/hotareaF/Integer.parseInt(hotDays[5])/3600;
			}
			
			double hotKPI =hotKPI01 + hotKPI02 + hotKPI03 + hotKPI04 + hotKPI11 + hotKPI12;
			
			HashMap<String, String> allKPIMap = new HashMap<String, String>() ;
			allKPIMap.put("site" , site);
			allKPIMap.put("hotarea" , hotarea);
			allKPIMap.put("reliang01" , String.format("%.2f", re01));
			allKPIMap.put("reliang02" , String.format("%.2f", re02));
			allKPIMap.put("reliang03" , String.format("%.2f", re03));
			allKPIMap.put("reliang04" , String.format("%.2f", re04));
			allKPIMap.put("reliang11" , String.format("%.2f", re11));
			allKPIMap.put("reliang12" , String.format("%.2f", re12));
			
			allKPIMap.put("totalRe",  String.format("%.2f", totalRe));
			allKPIMap.put("hotKPI",   String.format("%.2f", hotKPI));
			
			allKPIMap.put("hotKPI01" ,  String.format("%.2f", hotKPI01));
			allKPIMap.put("hotKPI02" ,  String.format("%.2f", hotKPI02));
			allKPIMap.put("hotKPI03" ,  String.format("%.2f", hotKPI03));
			allKPIMap.put("hotKPI04" ,  String.format("%.2f", hotKPI04));
			allKPIMap.put("hotKPI11" ,  String.format("%.2f", hotKPI11));
			allKPIMap.put("hotKPI12" ,  String.format("%.2f", hotKPI12));
			
			resList.add(allKPIMap);		
		}
		
		writeJSON(response, resList);

	}

	
	@RequestMapping("/updateStatistic")
	public void updateStatistic(HttpServletRequest request, HttpServletResponse response) {

	}

	
}
