package com.jeefw.controller.monitorData;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
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

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.support.JqGridPageView;
import core.util.RequestObj;

//未抄表数据查询
@Controller
@RequestMapping("/monitorData/noReadMeterContr")
public class NoReadMeterController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getNoReadMeter")
	public void getNoReadMeter(HttpServletRequest request,HttpServletResponse response) throws IOException{
		//sysstatus = '1' 未抄表   autoid = 1 第一次抄表  2就是第二次抄表
		
		String sql = "";
		setSqlwhereContainWhere();
		setFiltersStr(getFilters()
				.replace("\"field\":\"DEVICECHILDTYPENO\"", "\"field\":\"DEVICETYPECHILDNO\"")
				.replace("\"field\":\"MSNAME\"", "\"field\":\"SYSSTATUS\""));
		
		sql = "select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" " + getSqlWhere() + " and SYSSTATUS='1' ";
		
		Long count = baseDao.countSql(sql);
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list =  baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);
		writeJSON(response, listView);
	}
	@RequestMapping("/updateNoReadMeter")
	public void updateNoReadMeter(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String id = getParm("id");
		if("excel".equals(oper)){
			String headSql = "select  CLIENTNO,AREANAME,ADDRESS,METERID,POOLADDR,MBUSID,DDATE,AUTOID from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" where SYSSTATUS=1 and areaguid="+getParm("areaguid")
				+" and to_date('"+getParm("date")+"','yyyy-mm-dd')<ddate and to_date('"+getParm("date")+"','yyyy-mm-dd')+1>ddate";
			if("1".equals(getParm("flag"))){
				Long count = baseDao.countSql(headSql);
				if(count<1)
					writeJSON(response, 1);
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
	            	String strTitles = "用户编码，小区名称，地址，表编号，集中器地址，通道号，抄表日期，抄表批次";
	            	sheet.setColumnWidth(0, 6700);
	            	sheet.setColumnWidth(1, 5700);
	            	sheet.setColumnWidth(4, 7700);
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
                String areanameSql = "select areaname from tarea where areaguid ='" + getParm("areaguid") + "'";
	            String areaname = ((Map<String, String>)baseDao.listSqlAndChangeToMap(areanameSql, null).get(0)).get("AREANAME");
	            String excelName = areaname+getParm("date")+"未抄表数据";
	            //(Map<String, String>)
				try {
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
	                wb.write(baos);
	                response.addHeader("Content-Disposition", "attachment;filename="
							+ new String( excelName.getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
