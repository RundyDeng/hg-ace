package com.jeefw.controller.monitorData;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

//住户运行曲线
@Controller
@RequestMapping("/monitorData/clientChartsContr")
public class ClientChartsController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getClientChartsByFiledName")
	public void getClientChartsByFiledName(HttpServletRequest request,HttpServletResponse response) throws IOException{
		printRequestParam();
		String sql = "SELECT t.DDATE,round(t." + getParm("filedName") + ",2) as " + getParm("filedName")
				   	+ " from "+switchOnTimeTableByName("tmeter")+" t,vareainfo v"
				   	+ " where t.areaguid = v.AREAGUID and t.meterid = v.METERNO"
				   	+ " and t.ddate between TO_DATE('" + getParm("beginDate") + "','yyyy-MM-dd')"
				    + " and TO_DATE('" + getParm("endDate") + "','yyyy-MM-dd')+1";
		if(StringUtils.isNotBlank(getParm("clientno"))){
			sql += " and v.clientno='" + getParm("clientno") +"'";
		}else{
			sql += " and v.areaguid ='"+getParm("areaguid")+ "' and v.doorno=" + getParm("doorno")+" ";
		//	+ "' and v.buildno='"+getParm("buildno")+ "' and v.unitno= '" + getParm("unitno") + "' and v.floorno='" + getParm("floorno")+ "' and v.doorno='" + getParm("doorno")+"'";
				
				
		}
		
		//只显示一条- -
	/*	if(StringUtils.isNotBlank(getParm("meterid"))){
			sql += " and t.meterid = " + getParm("meterid");
			
		}else if(StringUtils.isNotBlank(getParm("clientno"))){
			sql += " and t.meterid=(select min(meterno) from tdoor_meter where clientno = '" + getParm("clientno") + "') ";
		}else{
			sql += " and t.meterid=(select min(meterno) from tdoor_meter where areaguid = "+getParm("areaguid") + " and doorno = " +getParm("doorno") +" ) ";
		}*/
		sql += " order by t.ddate";
		
		List list = baseDao.findBySqlList(sql, null);
		
		String str = "";
		for (int i = 0; i < list.size(); i++) {
			str += "\n";
			Object[] obj = (Object[])list.get(i);
			str += obj[0].toString()+","+obj[1].toString();
		}
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().write(str);
		
	}
	//获取弹窗hightchart图形
	@RequestMapping("/getClientChartsByFiled")
	public void getClientChartsByFiled(HttpServletRequest request,HttpServletResponse response) throws Exception{
		printRequestParam();
		List<Map> list=null;
	    String beginDates = getParm("beginDate");
	    String endDates = getParm("endDate");
	    String meterno = getParm("meterno");
	    String clientno= getParm("clientno");
	    String sql1 = " select meterid from tmeter";
	    String sql2 = "select clientno from vareainfo;";
	    String sqlwhere =" SELECT to_char(ddate,'yyyy-MM-dd ') as ddate,round(t.MeterNLLJ,2) as MeterNLLJ,round(t.MeterTJ,2) as MeterTJ,round(t.MeterGL,2) as MeterGL,round(t.MeterLS,2) as MeterLS,round(t.MeterJSWD,2) as MeterJSWD,round(t.MeterHSWD,2) as MeterHSWD,round(t.MeterWC,2) as MeterWC from tmeter t,"
    	   		+ "vareainfo v where t.areaguid = v.AREAGUID and t.meterid = v.METERNO "
    	   		+ "and t.ddate between TO_DATE('" + beginDates + " ','yyyy-MM-dd') and TO_DATE('" + endDates + "','yyyy-MM-dd')+1 and v.meterno='" + meterno + "'  order by t.ddate "; //and v.clientno='" + clientno + "'
    	 
	    list=baseDao.listSqlAndChangeToMap(sqlwhere, null);
 		Gson gson = new Gson();  
 		//将JSON串返回  
 		PrintWriter out = response.getWriter();  
 		out.print(gson.toJson(list));  
 		out.flush();  
 		out.close();
	}
}
