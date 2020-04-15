package com.jeefw.controller.monitorData;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
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
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.support.JqGridPageView;
import core.util.RequestObj;

@Controller
@RequestMapping("/monitorData/todayFaultDataContr")
public class TodayFaultDataController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getTodayFaultData")
	public void getTodayFault(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String sql = "";
		setSqlwhereContainWhere();
		setFiltersStr(getFilters()
				.replace("\"field\":\"DEVICECHILDTYPENO\"", "\"field\":\"DEVICETYPECHILDNO\"")
				.replace("\"field\":\"MSNAME\"", "\"field\":\"SYSSTATUS\""));
		if(getFilters().contains("\"field\":\"SYSSTATUS\",\"op\":\"eq\",\"data\":\"\"")){//即没有设定查询的参数时显示错误
			//全部故障的情况下就是 and SYSSTATUS!=0
			sql = "select* from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+ getSqlWhere() + ") where msname!='正常'";
		}else{
			sql = "select* from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+ getSqlWhere() + ") where msname!='正常'";
			
			//	sql = "select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" " + getSqlWhere();
		}
		
	 	Long count = baseDao.countSql(sql);
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list =  baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("TodayFaultData", getSqlWhere());
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);//总共记录
		writeJSON(response, listView);
	}
	
	@RequestMapping("/updateTodayFaultData")
	public void updateTodayFault(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String id = getParm("id");
		if("excel".equals(oper)){
		
			String date = request.getParameter("date");
			String  sqlwhere = (String) request.getSession().getAttribute("TodayFaultData");
			String flag = request.getParameter("flag");//是否测试
			if(org.apache.commons.lang3.StringUtils.isNotBlank(flag)){
				 Object count = baseDao.findBySqlList("select count(1) from (select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+"  "+sqlwhere+" ) where msname!='正常'", null).get(0);
				 if("0".equals(count.toString())){
					 writeJSON(response, 1);
					 return;
				 }else{
					 return;
				 }
			}
			
			
			String sql = "select CLIENTNO,AREANAME, BNAME||'-'||UNITNO||'-'||DOORNAME as menpai,METERID,MSNAME,round(METERGL,2) as ssrl,round(METERNLLJ,2) as ljrl,round(METERLS,2)as ssll,round(METERTJ,2) as ljll,round(METERJSWD,2) as jswd"
					+ ",round(METERHSWD,2) as hswd,round(METERWC,2) as wc,COUNTHOUR,AUTOID,DDATE from (select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "
					+ sqlwhere+") where msname!='正常' and rownum < 65536 order by customid";
			//response.setContentType("application/msexcel;charset=UTF-8");
			List list = baseDao.findBySqlList(sql, null);
			
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
            	String strTitles = "用户编号，小区名称，门牌，热表号，热表状态，瞬时热量(kw)，累计热量(kwh)，瞬时流量(t/h)，累计流量(t)，"
            			+ "进水温度(℃)，回水温度(℃)，温差(℃)，时数，抄表批次，日期";
            	sheet.setColumnWidth(3, 9800);
            	sheet.setColumnWidth(5, 7700);
            	sheet.setColumnWidth(6, 7700);
            	sheet.setColumnWidth(7, 7700);
            	sheet.setColumnWidth(8, 7700);
            	sheet.setColumnWidth(9, 7700);
            	sheet.setColumnWidth(10, 7700);
            	sheet.setColumnWidth(4, 7700);
            	sheet.setColumnWidth(13, 9000);
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
						+ new String( "当日故障数据查询".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
	}
	
}
