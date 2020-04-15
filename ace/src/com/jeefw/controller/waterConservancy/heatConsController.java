package com.jeefw.controller.waterConservancy;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.support.JqGridPageView;
import core.util.MathUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("/waterConservancy/heatConsContr")
public class heatConsController extends IbaseController {
	@Resource
	private IBaseDao baseDao ;
	
	@RequestMapping("/getheatConsContr")
	public void geteheatConsContr(HttpServletRequest request ,HttpServletResponse response) throws IOException{
		
		printRequestParam();
		Calendar c = Calendar.getInstance();
		String endDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		c.add(Calendar.DATE, -7);
		String beginDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		String rWhere = " where 1=1 ";
		if (StringUtils.isNotBlank(getParm("filters"))) {
			JSONObject jsonObject = JSONObject.fromObject(getParm("filters"));
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				String fieldName = result.getString("field");
				if(fieldName.equalsIgnoreCase("AreaGuid")&& StringUtils.isBlank(result.getString("data"))){
					rWhere += " and " + result.getString("field") + "=" + (String) request.getSession().getAttribute(AREA_GUIDS);
 				}else if(fieldName.equalsIgnoreCase("ddate")){
					if(result.getString("op").equalsIgnoreCase("ge")){
							beginDay = result.getString("data");
					}
					if(result.getString("op").equalsIgnoreCase("le")){
							endDay = result.getString("data");
					}
				}else if(StringUtils.isNotBlank(result.getString("data"))){
					rWhere += " and " + fieldName + "=" + result.getString("data");
				}
			}
		}else{
			String areaguids = (String) request.getSession().getAttribute(AREA_GUIDS);
			if(org.apache.commons.lang3.StringUtils.isNoneBlank(areaguids)){
				rWhere += " and areaguid="+areaguids;
			}
			
		}
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			rWhere += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		String areaguid=(String) request.getSession().getAttribute(AREA_GUIDS);
		
		String sql="select areaguid, areaname, buildno, unitno, analysisname, sumflow, sumheat,"
					+"sumarea, sumuser, analysistype, ddate, today, flow, countuser, sumharea,"
					+"heatmode, countcb from tanalysis ";
		
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("heatConsContr", rWhere);
		JqGridPageView view = new JqGridPageView();
		view.setMaxResults(getShowRows());
		view.setRows(list);
		view.setRecords(baseDao.countSql(sql));
		writeJSON(response, view);
	}
	

	//导出excel
	@RequestMapping("/updateheatConsContr")
	public void operheatConsContr(HttpServletRequest request ,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String id = getParm("id");
		String  sqlwhere = (String) request.getSession().getAttribute("heatConsContr");
		if("excel".equals(oper)){
			
			String headSql="select areaguid, areaname, buildno, unitno, analysisname, sumflow, sumheat,"
					+"sumarea, sumuser, analysistype, ddate, today, flow, countuser, sumharea,"
					+"heatmode, countcb from tanalysis ";
			
			 if(StringUtils.isNotBlank(getParm("flag"))&&"1".equals(getParm("flag"))){
				Long count = baseDao.countSql(headSql);
				if(count<1){
					writeJSON(response, 1);
				}
				return;
			 }
			
			 List list = baseDao.findBySql(headSql);
			
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
	            	String strTitles = "小区编号,小区名称,楼宇,单元,分析名,累计流量,累计热量（t）,总建筑面积(㎡),采样户数,分析类,数字日期,日期,实际流量(T/H),总用户,采暖建筑面积,采暖形式,抄表数";        
	            	sheet.setColumnWidth(1, 5700);
	            	sheet.setColumnWidth(3, 7700);
	            	sheet.setColumnWidth(5, 7700);
	            	sheet.setColumnWidth(6, 5700);
	            	sheet.setColumnWidth(7, 7700);
	            	sheet.setColumnWidth(8, 7700);
	            	sheet.setColumnWidth(9, 7700);
	            	sheet.setColumnWidth(10, 7700);
	            	sheet.setColumnWidth(11, 7700);
	            	sheet.setColumnWidth(12, 7700);
	            	sheet.setColumnWidth(13, 7700);
	            	sheet.setColumnWidth(14, 7700);
	            	sheet.setColumnWidth(15, 7700);
	            	sheet.setColumnWidth(16, 7700);
	            	sheet.setColumnWidth(17, 7700);
	            	
	            	setExcelTitleStr(strTitles, wb , sheet);

	            	for (int i = 0; i < list.size(); i++) {
	            //		String[] obj = rows[i].split("\t");//内容部分
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
	         // String fileTitle = URLDecoder.decode(getParm("title"), "UTF-8").replaceAll(" ", "");
				try {
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
	                wb.write(baos);
	                response.addHeader("Content-Disposition", "attachment;filename="
							+ new String( "热量分析表".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
	                response.setContentType("application/vnd.ms-excel");
	                response.setContentLength(baos.size());
	                
	                ServletOutputStream out1 = response.getOutputStream();
	                baos.writeTo(out1);
	                out1.flush();
	                out1.close();
				} catch (Exception e){
					e.printStackTrace();
				}
		}
	}
	//获取highcharts数据
/*	@RequestMapping("/getHeatConsChart")
	public void getHeatConsChart(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar flagCal = Calendar.getInstance();
		flagCal.add(Calendar.DAY_OF_MONTH, -3);
		Calendar cal = Calendar.getInstance();
		
		String sql = "SELECT cast(substr(ddate,1,10) as date) as dtime,sum(" + getParm("filedName") + ") as pars";
		String beginDate = getParm("beginDate");
		String endDate = getParm("endDate");
		Date begin = sdf.parse(beginDate);
		Date end = sdf.parse(endDate);
		if(flagCal.before(sdf.parse(beginDate))&&flagCal.before(sdf.parse(endDate))){
			sql += " from tmeter_tmp where 1=1";
		}else{
			sql += " from "+switchOnTimeTableByName("tmeter")+" where 1=1"
				+ " and ddate between TO_DATE('" + getParm("beginDate") + "','yyyy-MM-dd')" + " and TO_DATE('"
				+ getParm("endDate") + "','yyyy-MM-dd')+1";
		}
		
		sql +=  " and areaguid = " + getParm("areaguid") 
			+ " group by substr(ddate,1,10) "
			+ " order by cast(substr(ddate,1,10) as date) ";
				
		List list = baseDao.findBySqlList(sql, null);
		String str = "";
		double sum = 0;
		double previous = 0;
		for (int i = 0; i < list.size(); i++) {
			str += "\n";
			Object[] obj = (Object[]) list.get(i);
			if(StringUtils.isBlank(obj[1].toString()))
				continue;
			
			double no = MathUtils.getBigDecimal(obj[1].toString()).doubleValue();
			if(previous>no && i!=0){
				str += obj[0].toString() + "," + previous;
			}else{
				str += obj[0].toString() + "," + obj[1].toString();
				previous = Double.valueOf(obj[1].toString());
			}
		}
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().write(str);
	}*/
	
}
