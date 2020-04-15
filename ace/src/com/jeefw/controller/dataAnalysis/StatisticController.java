package com.jeefw.controller.dataAnalysis;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
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

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/dataAnalysis/statisticContr")
public class StatisticController extends IbaseController{
	private int pagesize = 20;
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getStatistic")
	public void getStatistic(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, Object> map = new HashMap<String, Object>() ;
		String date = getParm("date");
		String areaName = getParm("areaname");
		boolean flag = false;
		// 各小区表信息统计 // select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME
		String eachAreaMeterInfoSql = "select c.FACTORYNAME ,b.SECTIONNAME,a.areaname,t.* "
									+" from Tarea a "
									+" left join FACTORYSECTIONINFO b "
									+" on a.FACTORYNO=b.SECTIONID "
									+" left join ENERGYFACTORY c "
									+" on c.FACTORYID=b.FACTORYID "
									+" inner join TGZTJ t "
									+" on t.areaguid=a.areaguid "
									+" where 1=1 ";
		
		
		if(StringUtils.isNotBlank(date)){//各小区统计信息eachAreaMeterInfo
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
		setPreviousExcelSql(eachAreaMeterInfoSql); //20180316
		long total = baseDao.countSql(eachAreaMeterInfoSql);
		long pageNumber = (total + pagesize - 1)/pagesize;
		
		map.put("data", eachAreaMeterInfo);
		map.put("pageCount", pageNumber);
		writeJSON(response, map);

	}
	//20180316 导出excel
	@RequestMapping("/updateStatistic")
	public void updateStatistic(HttpServletRequest request,HttpServletResponse response){
		String oper = getParm("oper");
		if("excel".equals(oper)){
			String previousSql = getPreviousExcelSql();
			/*String previousSql = "select c.FACTORYNAME ,b.SECTIONNAME,a.areaname,t.TOTZHSUM,t.TOTCBSUM,t.ZCSUM,t.WFYSUM,t.WCBSUM "
					+" from Tarea a "
					+" left join FACTORYSECTIONINFO b "
					+" on a.FACTORYNO=b.SECTIONID "
					+" left join ENERGYFACTORY c "
					+" on c.FACTORYID=b.FACTORYID "
					+" inner join TGZTJ t "
					+" on t.areaguid=a.areaguid "
					+" where 1=1 ";*/
			List list = baseDao.findBySqlList(previousSql,null);
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
            	String strTitles = "分公司，换热站，小区，小区编号，住户数，抄表数，正常数，故障数，无反应，未抄表，未抄表，日期";
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
						 +new String( "整体运行情况".getBytes("gb2312"), "ISO8859-1" )+ ".xls");
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
