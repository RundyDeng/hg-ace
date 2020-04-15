package com.jeefw.controller.warningmanage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jeefw.model.haskey.Warringsparmset;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.warningmanage.SetFaultParamForWarnService;

import core.support.JqGridPageView;

@Controller
@RequestMapping("/warningmanage/FaultStatiscontr")
public class FaultStatisticsController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSvr;
	//故障统计
		@RequestMapping("/getwarninginfo")
		public void getWarningInfo(HttpServletRequest resquest,HttpServletResponse response) throws IOException{
			
			String day= baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') as day from tmeter_tmp").get(0).toString();
			String sql = "select b.areaname as 小区名称,concat(concat(concat(b.Buildname,'-'),concat(b.unitno,'-')),b.doorname) as 门牌 ,b.CLIENTNO,a.meterid, "
					+" case when a.METERGL>c.METERSSLLMAX then '瞬时流量过高,' when a.METERGL<c.meterssllmin then '瞬时流量过低,' end"
					+ " || "
					+" case when a.MeterJSWD>c.JSWDMAX then '供水温度过高,' when a.MeterJSWD<c.jswdmin then '供水温度过低,' end"
					+ " || "
					+" case when a.MeterHSWD>c.HSWDMAX then '回水温度过高,' when a.MeterHSWD<c.hswdmin then '回水温度过低,' end"
					+ " || "
					+" case when a.MeterWC>c.WCMAX then '温差过高,' when a.MeterWC<c.wcmin then '温差过低,' end as 异常情况,"
					+" Round(a.meternllj,2) as 累计热量, Round(a.METERTJ,2) as 累计流量,Round(a.METERGL,2) as 瞬时流量, "
					+" Round(a.METERJSWD,2) as 供水温度， Round(a.METERHSWD,2) as 回水温度,Round(a.MeterWC,2) as 温差,to_char(a.Ddate,'YYYY-MM-DD') as 抄表时间 "
					+" from tmeter a ,vareainfo b,warringsparmset c ,tclient d"
					+" where (to_char(a.DDate,'YYYY-MM-DD')='"+day+"' and a.meterid=b.meterno and a.areaguid=b.areaguid ) "
					+" and  (a. METERGL>c.METERSSLLMAX or a. METERGL<c.meterssllmin"
					+ " or  a.MeterJSWD>c.JSWDMAX or a.MeterJSWD<c.jswdmin"
					+ " or  a.MeterHSWD>c.HSWDMAX or a.MeterHSWD<c.hswdmin"
					+ " or  a.MeterWC>c.WCMAX or a.MeterWC<c.wcmin ) and ( a.areaguid =d.areaguid and d.clientno=b.clientno and d.isyestr=0)"
					+ " order by b.CLIENTNO";

			List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
			setPreviousExcelSql(sql);  //20180316
			JqGridPageView view = new JqGridPageView();
			view.setCurrentPage(getCurrentPage());
			view.setRows(list);
			view.setMaxResults(getShowRows());
			view.setRecords(baseDao.countSql(sql));
			writeJSON(response, view);
		}
		//导出 20180316
		@RequestMapping("/updateFaultStatistics")
		public void updateBaseInfoSearch(HttpServletRequest request , HttpServletResponse response){
			String oper = getParm("oper");
			if("excel".equals(oper)){
				String previousSql = getPreviousExcelSql();
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
	            	String strTitles = "小区名称，地址，用户编号，表号，异常情况，累计热量，累计流量，瞬时流量，进水温度，回水温度，温差，抄表时间";
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
							 +new String( "故障统计情况".getBytes("gb2312"), "ISO8859-1" )+ ".xls");
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
