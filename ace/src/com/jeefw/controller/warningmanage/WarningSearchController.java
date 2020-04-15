package com.jeefw.controller.warningmanage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMethod;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.Tfailurecode;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.warningmanage.WarningSettingService;

import core.support.JqGridPageView;
import core.util.RequestObj;
import core.util.StringUtilsForController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/warningmanage/warningsearchcontr")
public class WarningSearchController extends IbaseController {
	@Resource
	private IBaseDao<Tfailurecode>  baseDao;
	@Resource
	private WarningSettingService warningSettringSvr;
	@Resource
	private PubService pubSvr;
	@Resource
	private PubService todayDataService;
	private String gjzt = "";
	@RequestMapping("/getHisFault")
	public void getHisFault(HttpServletRequest request,HttpServletResponse response) throws IOException{
			
		String sql = "";
		setSqlwhereContainWhere();
		setFiltersStr(getFilters()
				.replace("\"field\":\"DEVICECHILDTYPENO\"", "\"field\":\"DEVICETYPECHILDNO\"")
				.replace("\"field\":\"MSNAME\"", "\"field\":\"SYSSTATUS\""));
		if(getFilters().contains("\"field\":\"SYSSTATUS\",\"op\":\"eq\",\"data\":\"\"")){//即没有设定查询的参数时显示错误
			sql = "select* from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+ getSqlWhere() + ") where msname!='正常' and msname!='未抄表'　and msname!='终端无反应'";
		}else{
			sql = "select* from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+ getSqlWhere() + ") where msname!='正常'";
		}
		
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list =  baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("TodayFaultData", getSqlWhere());
		Long count = baseDao.countSql(sql);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);//总共记录
		writeJSON(response, listView);
		
	}
	@RequestMapping("/updateOffLineSearch")//导出
	public void updateBaseInfoSearch(HttpServletRequest request , HttpServletResponse response){
		String oper = getParm("oper");
		if("excel".equals(oper)){
			String  sqlwhere = (String) request.getSession().getAttribute("warningsearch");
			String excSql  =  "select AREANAME,CLIENTNO,DOORNO,METERID,SFTR,MSNAME,round(METERGL,2),round(METERNLLJ,2),round(METERLS,2),round(METERTJ,2),"
					+ "round(METERJSWD,2),round(METERHSWD,2),round(METERWC,2),COUNTHOUR,DDATE,AUTOID,REMARK "
					+ "from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+ getSqlWhere() + ") where msname!='正常' and msname!='未抄表'　and msname!='终端无反应'";
			
			List list = baseDao.findBySql(excSql);
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
            	String strTitles = "小区名称，用户编码，地址，表编号，用热状态，热表状态，瞬时热量(kw)，累计热量(kwh)，瞬时流量(t/h)，累计流量(t)，"
            			+ "进水温度(℃)，回水温度(℃)，温差(℃)，时数，抄表日期，抄表批次，问题说明";
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
						 +new String( "告警查询".getBytes("gb2312"), "ISO8859-1" )+ ".xls");
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
            
			
	
	/*@RequestMapping(value="/getwarningsearch", method = {RequestMethod.POST,RequestMethod.GET})
	public void getWarningSearch(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String filters = getParm("filters");
		filters = filters.replace("小区名称", "小区编号");
		String sqlwhere = "";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null") && !result.getString("data").equals("undefined")) {
					if(result.getString("field").equalsIgnoreCase("告警状态")){
						sqlwhere += " and " + result.getString("data");
					}else
						sqlwhere += " and " + result.getString("field") + "='" + result.getString("data")+"'";
				}
			}
		}else{
			//sqlwhere += " and 小区编号="+getSessionAreaGuids()+" and 时间=to_char(sysdate,'yyyy-MM-dd') ";
			setPreviousExcelSql("");
			JqGridPageView listView = new JqGridPageView();
			writeJSON(response, listView);
			return;
		}
		gjzt = getParm("gjzt");
		String sql = "select 小区名称," //'"+getParm("gjzt")+"' as 告警状态, "
					+" concat(concat(concat(楼栋号,'-'),concat(单元号,'-')),门牌号) as 门牌 , "
					+" round(累计热量,2) as 累计热量,round(累计流量,2) as 累计流量,round(瞬时热量,2) as 瞬时热量,"
					+" round(瞬时流量,2) as 瞬时流量,round(进水温度,2) as 进水温度,round(回水温度,2) as 回水温度, round(温差,2) as 温差,时数,时间 "
					+" from VMeterInfo "
					+" where 抄表批次=1 "
					+ sqlwhere + " order by customid";
					
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		setPreviousExcelSql(sql);
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		listView.setRecords(list.size());
		writeJSON(response, listView);
	}
	
	@RequestMapping("/updatewarningsearch")
	public void updateWarningSearch(HttpServletRequest resquest,HttpServletResponse response,Tfailurecode tFailurecodeModel) throws IOException{

		String id =  getParm("id");
		String oper = getParm("oper");
	//	String  sqlwhere = "";
		if("excel".equalsIgnoreCase(oper)){
		//	String  sqlwhere = (String) resquest.getSession().getAttribute("AreaName");
			String previousSql = getPreviousExcelSql();
			//String flag = getParm("flag");
			if("1".equals(flag)){
				if(StringUtils.isBlank(previousSql)){
					writeJSON(response, "请先选择查询条件!");
				}else{
					Long count = baseDao.countSql(previousSql);
					if(count<1){
						writeJSON(response, "没有记录！");
					}else{
						writeJSON(response, true);
					}
				}
				return ;
			}
			String excSql = "select 小区名称,'"+getParm("gjzt")+"' as 告警状态, "
					+" concat(concat(concat(楼栋号,'-'),concat(单元号,'-')),门牌号) as 门牌 , "
					+" round(累计热量,2) as 累计热量,round(累计流量,2) as 累计流量,round(瞬时热量,2) as 瞬时热量,"
					+" round(瞬时流量,2) as 瞬时流量,round(进水温度,2) as 进水温度,round(回水温度,2) as 回水温度, round(温差,2) as 温差,时数,时间 "
					+" from VMeterInfo "
					+" where 抄表批次=1 "
					+ sqlwhere + " order by customid";
			
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
            if(list.size()>0){//'告警状态',
            	
            	String excelTitle = "'小区名称','门牌','累计热量(kwh)','累计流量(t)','瞬时热量(kw)','瞬时流量(t/h)','进水温度(℃)','回水温度(℃)','温差(℃)','时数(h)','抄表时间'";
            	sheet.setColumnWidth(2, 7700);
            	setExcelTitleStr(excelTitle, wb , sheet);
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
			String areaname = "告警查询";
			if(StringUtils.isNotBlank(getParm("areaguid")))
				 areaname = pubSvr.getAreanameById(getParm("areaguid"));
			areaname = areaname.replaceAll(" ", "")+"("+gjzt+")";
			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
                wb.write(baos);
                response.addHeader("Content-Disposition", "attachment;filename="
						+ new String( areaname.getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
	
	*/
	
}
