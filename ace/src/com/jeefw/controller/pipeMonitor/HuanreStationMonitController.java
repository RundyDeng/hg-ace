package com.jeefw.controller.pipeMonitor;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.dbSource.DatabaseContextHolder;

@Controller
@RequestMapping("pipeMonitor/huanreStationMonitContr")
public class HuanreStationMonitController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	/**
	 * 获取所有分公司信息，用于填充分公司下拉框
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getarealist")
	public void getAreaList(HttpServletRequest request, HttpServletResponse response) throws IOException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String sql = "select areaguid,areaname from tarea order by to_number(telpeople)";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		DatabaseContextHolder.clearCustomerType();//释放数据库连接
		writeJSON(response, list);

	}
	/**
	 * 获取分公司下的所有换热站信息，用于填充换热站下拉框
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getbuildlist")
	public void getBuildList(HttpServletRequest request, HttpServletResponse response) throws IOException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String areaguid=getParm("areaguid");
		String sql = "select buildno,buildname from tbuild where areaguid="+areaguid+" order by nlssort(buildname,'NLS_SORT=SCHINESE_PINYIN_M')";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		DatabaseContextHolder.clearCustomerType();
		writeJSON(response, list);

	}
	/**
	 * 获取换热站编号和名称
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getareabuild")
	public void getareabuild(HttpServletRequest request, HttpServletResponse response) throws IOException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		String buildno=getParm("buildno");
		String sql = "select buildno,buildname from TBuild tb,tarea ta where ta.areaguid=tb.areaguid where buildno="+buildno+" order by  ta.areacode,nlssort(tb.buildname,'NLS_SORT=SCHINESE_PINYIN_M') ";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		DatabaseContextHolder.clearCustomerType();//释放数据库连接
		writeJSON(response, list);

	}
	/**
	 * 获取换热站最新一次抄表数据
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/gettmeterlist")
	public void gettmeterlist(HttpServletRequest request, HttpServletResponse response) throws IOException{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
		//分公司ID
		String areaguid=getParm("areaguid");
		//换热站id
		String buildno=getParm("buildno");
		//热表状态
		String msid=getParm("msid");
		//地址编码
		String addcode=getParm("addcode");
		String type=getParm("type");
		String sqlWhere="";
		String sql = "";
		if(!"9999".equals(areaguid) && areaguid!="")
		{
			sqlWhere+=" and b.areaguid = " + areaguid;
		}
		if(!"9999".equals(buildno) && buildno!="")
		{
			sqlWhere+=" and b.buildno = " + buildno;
		}
		if(msid!="" && !"-1".equals(msid))
		{
			sqlWhere+=" and c.msid = " + msid;
		}
		if(!"".equals(addcode))
		{
			sqlWhere+=" and ADDRESSNO like '%" + addcode + "%' ";
		}
        switch (type)
          {
              case "hot": sql = " select a.areaguid,a.buildno,a.remk,a.BUILDSDAN,a.BuildName,a.Address,a.ADDRESSNO,a.Grmj"
                         +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERSSLJ,b.METERNLLJ,b.METERSSRL,b.METERNLRL,b.METERJSWD,b.METERHSWD"
                         + " from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                         +"  left join TMPTODAY b on a.buildno = b.buildno"
                         +" inner join TMETERSTATUS c on b.Devicestatus = c.msid and c.metertype = 5 where 1=1 " + sqlWhere; break;
              case "electric": sql = " select a.areaguid,a.buildno,a.remk,a.BUILDSDAN,a.BuildName,a.Address,a.ADDRESSNO,a.Grmj"
                                     +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERNLLJ"
                                     +" from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                                     +" left join TELECTRITODAY b on a.buildno = b.buildno"
                                     +" inner join TMETERSTATUS  c on b.Devicestatus = c.msid and c.metertype = 10 "
                                     +" where b.DEVICETYPE  = 10 " + sqlWhere; break;
              case "water": sql = " select a.areaguid,a.buildno,a.remk,a.BUILDSDAN,a.BuildName,a.Address,a.ADDRESSNO,a.Grmj"
                                     +"   ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERNLLJ"
                                     +"  from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                                     +" left join TELECTRITODAY b on a.buildno = b.buildno"
                                     +" inner join TMETERSTATUS  c on b.Devicestatus = c.msid and c.metertype = 11 "
                                     +" where b.DEVICETYPE  = 11 " + sqlWhere; break;
              case "teamp": sql = " select a.areaguid,a.buildno,a.remk,a.BUILDSDAN,a.BuildName,a.Address,a.ADDRESSNO,a.Grmj,"
				            		+"  b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERSSLJ,b.METERNLLJ,"
				            		+"  b.METERSSRL,b.METERNLRL,b.METERJSWD,b.METERHSWD "
				            		+"  from Tbuild a left join tarea on tarea.areaguid=a.areaguid "
				            		+"  left join TMPTODAY b "
				            		+"  on a.buildno = b.buildno "
				            		+"  inner join TMETERSTATUS c "
				            		+"  on b.Devicestatus = c.msid and c.metertype = 10 " + sqlWhere; break;
              
              default: sql = " select a.areaguid,a.buildno,a.remk,a.BUILDSDAN,a.BuildName,a.Address,a.ADDRESSNO,a.Grmj"
                          +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERSSLJ,b.METERNLLJ,b.METERSSRL,b.METERNLRL,b.METERJSWD,b.METERHSWD"
                          +" from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                          +" left join TMPTODAY b on a.buildno = b.buildno"
                          +" inner join TMETERSTATUS c on b.Devicestatus = c.msid and c.metertype = 5 " + sqlWhere; break;
          }
          sql += " order by to_number(tarea.telpeople) ,nlssort(a.buildname,'NLS_SORT=SCHINESE_PINYIN_M')  ";
          List list = baseDao.listSqlAndChangeToMap(sql, null);
          DatabaseContextHolder.clearCustomerType();//释放数据库连接 
          //使用Google的Json工具  
    		Gson gson = new Gson();  
    		//将JSON串返回  
    		PrintWriter out = response.getWriter();  
    		out.print(gson.toJson(list));  
    		out.flush();  
    		out.close(); 

	}
	/**
	 * 获取换热站参数曲线数据
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ParseException 
	 */
	@RequestMapping("/gettmeterchart")
	public void gettmeterchart(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
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

    	   String tablename = "TMETERQX" + endyears;
    	   String subSql = " select " + tablename + ".BUILDNO," + tablename + ".ddate," + tablename + ".meterid,METERSSLJ,METERSSRL,METERJSWD,METERHSWD,round(10*METERLLDH / 24,4)  as meterpjll,round(1000*METERRLDH  / 24,4) as meterpjrl,meterjhzb,METERDAN as meterdrljrl,METERJHGR  from " + tablename ;
    	   String sql = "" + tablename + ".DDATE between to_date('" + staddates + " " + hours1 + ":00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + enddates + " " + hours2 + ":59:29','yyyy-mm-dd hh24:mi:ss')   and vareainfo.meterno='" + getParm("meterno") + "' and vareainfo.buildno='" + getParm("buildno") + "' order by " + tablename + ".ddate";
    	   String sqlwhere = "select  " + tablename + ".BUILDNO,to_char(" + tablename + ".ddate,'yyyy-MM-dd HH24') as ddate," + tablename + ".meterid,METERSSLJ,METERSSRL,METERJSWD,METERHSWD, meterpjll, meterpjrl,meterjhzb, meterdrljrl,METERJHGR from (" + subSql + ") " + tablename + " inner join vareainfo on vareainfo.METERNO =" + tablename + ".meterid  where  " + sql;
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
	 * 换热站抄表监测数据导出excel
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/exportoperlist")
	public void exportoperlist(HttpServletRequest request,HttpServletResponse response) throws Exception{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源          
		String title = getParm("title");
		String areaguid=getParm("areaguid");
		String buildno=getParm("buildno");
		String msid = getParm("msid");
		String areacode = getParm("areacode");
		String type=getParm("type");
		String sqlWhere="";
		String sql = "";
		if(!"9999".equals(areaguid) && areaguid!="")
		{
			sqlWhere+=" and b.areaguid = " + areaguid;
		}
		if(!"9999".equals(buildno) && buildno!="")
		{
			sqlWhere+=" and b.buildno = " + buildno;
		}
		if(msid!="" && !"-1".equals(msid))
		{
			sqlWhere+=" and c.msid = " + msid;
		}
		if(!"".equals(areacode))
		{
			sqlWhere+=" and ADDRESSNO like '%" + areacode + "%' ";
		}
	   String strTitles="";
        switch (type)
          {
              case "hot": sql = " select rownum,a.* from(select a.BUILDSDAN,a.BuildName,a.Address,a.Grmj"
                         +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERSSLJ,b.METERNLLJ,b.METERSSRL,b.METERNLRL,b.METERJSWD,b.METERHSWD"
                         + " from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                         +"  left join TMPTODAY b on a.buildno = b.buildno"
                         +" inner join TMETERSTATUS c on b.Devicestatus = c.msid and c.metertype = 5 where 1=1 " + sqlWhere; 
                        strTitles= "序号，分公司，名称，地址，供热面积(万平米)，热表编号，抄表时间，热表状态，瞬时流量(t/h)，累计流量(t)，瞬时热量(KW)，累计热量(MWH)，进水温度(℃)，回水温度(℃)";break;
              case "electric": sql = " select rownum,a.* from(select a.BUILDSDAN,a.BuildName,a.Address,a.Grmj"
                                     +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERNLLJ"
                                     +" from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                                     +" left join TELECTRITODAY b on a.buildno = b.buildno"
                                     +" inner join TMETERSTATUS  c on b.Devicestatus = c.msid and c.metertype = 10 "
                                     +" where b.DEVICETYPE  = 10 " + sqlWhere; 
               strTitles= "序号，分公司，名称，地址，供热面积(万平米)，热表编号，抄表时间，热表状态，累计电量(度)";break;
              case "water": sql = " select rownum,a.* from(select a.BUILDSDAN,a.BuildName,a.Address,a.Grmj"
                                     +"   ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERNLLJ"
                                     +"  from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                                     +" left join TELECTRITODAY b on a.buildno = b.buildno"
                                     +" inner join TMETERSTATUS  c on b.Devicestatus = c.msid and c.metertype = 11 "
                                     +" where b.DEVICETYPE  = 11 " + sqlWhere; 
              strTitles= "序号，分公司，名称，地址，供热面积(万平米)，热表编号，抄表时间，热表状态，累计水量(吨)";break;
              default: sql = " select rownum,a.* from(select a.BUILDSDAN,a.BuildName,a.Address,a.Grmj"
                          +" ,b.METERID,to_char(b.DDATE,'yyyy-MM-dd HH24:mi:ss') as ddate,c.msname,b.METERSSLJ,b.METERNLLJ,b.METERSSRL,b.METERNLRL,b.METERJSWD,b.METERHSWD"
                          +" from Tbuild a left join tarea on tarea.areaguid=a.areaguid"
                          +" left join TMPTODAY b on a.buildno = b.buildno"
                          +" inner join TMETERSTATUS c on b.Devicestatus = c.msid and c.metertype = 5 " + sqlWhere; 
              strTitles= "序号，分公司，名称，地址，供热面积(万平米)，热表编号，抄表时间，热表状态，瞬时流量(t/h)，累计流量(t)，瞬时热量(KW)，累计热量(MWH)，进水温度(℃)，回水温度(℃)";break;
          }
          sql += " order by to_number(tarea.telpeople) ,nlssort(a.buildname,'NLS_SORT=SCHINESE_PINYIN_M'))a ";
         
		List list = baseDao.findBySqlList(sql, null);

	    DatabaseContextHolder.clearCustomerType();//释放数据库连接
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("sheet1");
		sheet.setDefaultColumnWidth(15);
		HSSFCellStyle cellBorder = wb.createCellStyle();
	    cellBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    cellBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    cellBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    cellBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    cellBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
	    HSSFFont font = wb.createFont();
	    font.setFontName("仿宋_GB2312");
	    font.setFontHeightInPoints((short) 10);
	    cellBorder.setFont(font);
	    cellBorder.setWrapText(true);
	    HSSFRow row;
	    HSSFCell cell;
	     if(list.size()>0){
	           sheet.setColumnWidth(2, 7700);
	           sheet.setColumnWidth(3, 9000);
	           sheet.setColumnWidth(5, 7700);
	           sheet.setColumnWidth(6, 9000);
	           sheet.setColumnWidth(7, 7700);
	           sheet.setColumnWidth(9, 7700);
	           sheet.setColumnWidth(11, 7700);
	           setExcelTitleStr(strTitles, wb , sheet);

	           for (int i = 0; i < list.size(); i++) {
	            		
	               row = sheet.createRow(i+1);
	               row.setHeight((short)360);
	               Object[] os =  (Object[])list.get(i);
	    		   for (int j = 0; j < os.length; j++) {
	    				cell = row.createCell(j);
	    				if(os[j] == null){
	    					cell.setCellValue("");
	    					}else{
	    					cell.setCellValue(os[j].toString());
	    					}
	    					cell.setCellStyle(cellBorder);
	    					
	    				}
	    			}
	            }

				try {
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
	                wb.write(baos);
	                response.addHeader("Content-Disposition", "attachment;filename="
							+ title + ".xls");
	                response.setContentType("application/vnd.ms-excel");
	                response.setContentLength(baos.size());
	                
	                ServletOutputStream out1 = response.getOutputStream();
	                baos.writeTo(out1);
	                out1.flush();
	                out1.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
					
					
			}
	/**
	 * 获取换热站每天抄表热表历史数据
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/gethistorydata")
	public void getHistoryData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源     
		Map<String, Object> map = new HashMap<String, Object>();
		String meterno=getParm("meterno");
		String ddates =getParm("serdate");
		String buildno = getParm("buildno");
		String type = getParm("type");
         //分析看看查询数据时哪一年
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
         Date dtime=format.parse(ddates);
         int years = dtime.getYear()+1900 ;
         int month = dtime.getMonth()+1;
         int days = dtime.getDate();
         String edates = years + "-10-15";
         Date detime = format.parse(edates);
         int leixin = 5;
         String tablename = "TMETERQX"; 
         String sqlwhere="";
         String sql = "DDATE between to_date('" + ddates + " 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + ddates + " 23:59:29','yyyy-mm-dd hh24:mi:ss')  and meterno='" + meterno + "' and vareainfo.buildno='" + buildno + "'  and TMETERSTATUS.metertype=" + leixin + " order by ddate desc";
         if ("hot".equals(type))
         {
             leixin = 5;
             tablename = "TMETERQX";
             if (dtime.getTime()>detime.getTime())
             {
                 tablename += years;
             }
             else
             {
                 tablename += years - 1;
             }
             sqlwhere = "select " + tablename + ".meterid,vareainfo.buildname, msname,to_char("+tablename+".ddate,'yyyy-MM-dd HH24:mi:ss') as ddate, "+tablename+".METERSSLJ,"+tablename+".METERNLLJ,"+tablename+".METERSSRL,"+tablename+".METERNLRL,"+tablename+".METERJSWD,"+tablename+".METERHSWD from " + tablename + " inner join vareainfo on vareainfo.METERNO =" + tablename + ".meterid  and vareainfo.buildno=" + tablename + ".buildno inner join TMETERSTATUS on TMETERSTATUS.Msid =" + tablename + ".devicestatus   where  " + sql;
             
         }
         else if ("telectri".equals(type))
         {
             leixin = 11;
             tablename = "telectri";
             if (dtime.getTime()>detime.getTime())
             {
                 tablename += years;
             }
             else
             {
                 tablename += years - 1;
             }
             sqlwhere = "select " + tablename + ".meterid,vareainfo.buildname, msname,to_char("+tablename+".ddate,'yyyy-MM-dd HH24:mi:ss') as ddate, "+tablename+".meternllj from " + tablename + " inner join vareainfo on vareainfo.METERNO =" + tablename + ".meterid  and vareainfo.buildno=" + tablename + ".buildno inner join TMETERSTATUS on TMETERSTATUS.Msid =" + tablename + ".devicestatus   where  " + sql;

         }
         else
         {
             leixin = 10;
             tablename = "telectri";
             if (dtime.getTime()>detime.getTime())
             {
                 tablename += years;
             }
             else
             {
                 tablename += years - 1;
             }
             sqlwhere = "select " + tablename + ".meterid,vareainfo.buildname, msname,to_char("+tablename+".ddate,'yyyy-MM-dd HH24:mi:ss') as ddate, "+tablename+".meternllj from " + tablename + " inner join vareainfo on vareainfo.METERNO =" + tablename + ".meterid  and vareainfo.buildno=" + tablename + ".buildno inner join TMETERSTATUS on TMETERSTATUS.Msid =" + tablename + ".devicestatus   where  " + sql;

         }
        List list = baseDao.listSqlAndChangeToMap(sqlwhere, null);
 		DatabaseContextHolder.clearCustomerType();//释放数据库连接
 		map.put("data", list);
 		writeJSON(response, map);
	}
	/**
	 * 获取换热站每天抄表电表历史数据
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/getdbhistorydata")
	public void getdbhistorydata(HttpServletRequest request,HttpServletResponse response) throws Exception{
		DatabaseContextHolder.setCustomerType("DS2");//更换数据源    
		List<Map> list=null;
		String staddates = getParm("startdate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date dtime=format.parse(staddates);
        int years = dtime.getYear()+1900;
        @SuppressWarnings("deprecation")
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
        long intervalMilli = edtime.getTime() - dtime.getTime();
        int  date = (int) (intervalMilli / (24 * 60 * 60 * 1000));
        int endyears = 0;
        if (edtime.getTime()>enddetime.getTime())
         {
        	endyears = edtime.getYear()+1900;
         }
         else
         {
        	 endyears = edtime.getYear()+1900 - 1;
         }
        if (endyears == stayears)
        {
            String sql = "";
            String sqlwhere = "";
            String tablename = "telectri" + endyears;
            if (!"".equals(getParm("meterno")))
            {
                sql = "DDATE between to_date('" + staddates + " 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + enddates + " 23:59:29','yyyy-mm-dd hh24:mi:ss')  and vareainfo.buildno='" + getParm("buildno") + "' order by ddate";
                sqlwhere = "select meterday ,METERNLLJ,meterno,buildname,to_char(DDate,'yyyy-MM-dd') as ddate,msname  from " + tablename + " inner join vareainfo on vareainfo.METERNO =" + tablename + ".meterid and vareainfo.BUILDNO =" + tablename + ".BUILDNO and meterno='" + getParm("meterno") + "' inner join TMETERSTATUS c on " + tablename + ".Devicestatus = c.msid and c.metertype =10  where  " + sql;
            }
            else
            {
                sql = "DDATE between to_date('" + staddates + " 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('" + enddates + " 23:59:29','yyyy-mm-dd hh24:mi:ss')  and vareainfo.buildno='" + getParm("buildno") + "')group by to_char(ddate,'yyyy-mm-dd hh24') order by ddate";
                sqlwhere = "select sum(meterday) as meterday,sum(meternllj)as meternllj,to_char(ddate,'yyyy-mm-dd') as ddate from(select distinct "+tablename+".*   from " + tablename + " inner join vareainfo on   vareainfo.BUILDNO =" + tablename + ".BUILDNO   where  " + sql;
            }
           list=baseDao.listSqlAndChangeToMap(sqlwhere, null);
     	  
        }
        DatabaseContextHolder.clearCustomerType();//释放数据库连接
        Gson gson = new Gson();  
		   //将JSON串返回  
		   PrintWriter out = response.getWriter();  
		   out.print(gson.toJson(list));  
		   out.flush();  
		   out.close(); 
	}
}
