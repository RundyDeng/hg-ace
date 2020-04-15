package com.jeefw.controller.collectorAlarm;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.sun.org.apache.xpath.internal.operations.And;
import core.service.Service;
import core.support.JqGridPageView;
import core.util.RequestObj;
import core.util.StringUtilsForController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/collectorAlarm/setCollectCycleContrl")
public class setCollectCycleController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService todayDataService;
	@Resource
	private PubService pubSvr;
	
	@RequestMapping(value="/getOffLineSearch", method = {RequestMethod.POST,RequestMethod.GET})
	public void getWarningSearch(HttpServletRequest request, HttpServletResponse response) throws IOException{
		/*String filters = request.getParameter("filters");
		String sql = "";		 	
		String sqlwhere = " where 1 = 1 ";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null")) {
					sqlwhere += " and " + result.getString("field") + "='" + result.getString("data")+"'";
				}
			}
		}
	    sql = "select * from VOFFLINE "+sqlwhere;
		Long count = baseDao.countSql(sql);
		if(StringUtilsForController.isNotBlank(getParm("sidx"))&&StringUtilsForController.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list =  baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("offLineAlerm", sqlwhere);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);
		writeJSON(response, listView); */
	}
	
	
	
/*	@RequestMapping("/updateOffLineSearch")//导出
	public void updateBaseInfoSearch(HttpServletRequest request , HttpServletResponse response){
		String oper = getParm("oper");
		if("excel".equals(oper)){
			String  sqlwhere = (String) request.getSession().getAttribute("offLineAlerm");
			String excSql  = "select areaname,DADDRESS,GPRSID,ISYES,zxdate from VOFFLINE "+sqlwhere+" order by areaname,DADDRESS ";  
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
            	String strTitles = "小区名称，安装位置，设备DTU号，是否在线，最后一次在线时间";
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
						 +new String( "集中器在线情况".getBytes("gb2312"), "ISO8859-1" )+ ".xls");
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
	}*/
	
}
