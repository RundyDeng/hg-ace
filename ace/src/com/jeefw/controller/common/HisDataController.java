package com.jeefw.controller.common;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jeefw.core.Constant;
import com.jeefw.core.JavaEEFrameworkBaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.Role;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;
import core.util.RequestObj;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sys/hisdata")
public class HisDataController extends JavaEEFrameworkBaseController implements Constant  {
	@Resource
	private PubService todayDataService;
	@Resource
	private IBaseDao baseDao;
	@RequestMapping(value = "/getHisdata", method = { RequestMethod.POST, RequestMethod.GET })
	public void getTodayData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer currentPage = Integer.valueOf(request.getParameter("page"));
		Integer pageSize = Integer.valueOf(request.getParameter("rows"));
		String orderField = request.getParameter("sidx");//排序的字段
		String sortedValue = request.getParameter("sord");//asc  or  desc
		int orderNO = 0;
		if("desc".equals(sortedValue)){
			orderNO = 1;
		}
		String filters = request.getParameter("filters");
		String sqlwhere = " 1 = 1 ";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null")) {
					sqlwhere += " and " + result.getString("field") + "='" + result.getString("data")+"'";//oracle不用区分是否需要''
				/*}else { //20180315
					if(result.getString("field").equalsIgnoreCase("AREAGUID")&& StringUtils.isBlank(result.getString("data"))){//解决没有选择小区名称查询所有数据情况
						sqlwhere += " and " + result.getString("field") + "='" + (String) request.getSession().getAttribute(AREA_GUIDS)+"'";
					}*/
					//20171218
				/*	if(result.getString("field").equalsIgnoreCase("AUTOID")&& StringUtils.isBlank(result.getString("data"))){//解决没有选择小区名称查询所有数据情况
						sqlwhere += " and " + result.getString("field") + "=1";
					}*/
				}
				if (result.getString("op").equals("ge") && !"".equals(result.getString("data"))) {//大于等于
					sqlwhere += " and " + result.getString("field") + ">=" + "to_date('" + result.getString("data") + "','yyyy/MM/dd') ";
				}
				if (result.getString("op").equals("le") && !"".equals(result.getString("data"))) {//小等于
					sqlwhere += " and " + result.getString("field") + "<=" + "to_date('" + result.getString("data") + "','yyyy/MM/dd') ";
				}
				if (result.getString("op").equals("cn")) {//包含
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
			} else {
			}
		}else{//首次进来。显示当天信息
			String areaguids = (String) request.getSession().getAttribute(AREA_GUIDS);
			if(StringUtils.isNotBlank(areaguids)){
				sqlwhere += " and areaguid="+areaguids;
			}
			Calendar c = Calendar.getInstance();
			String startdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
			c.add(Calendar.DATE, -7);
			String enddate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
			
			sqlwhere += " and DDATE between to_date('"+startdate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') and to_date('"+enddate+" 23:59:59','yyyy-MM-dd HH24:Mi:ss') ";
			
		}
		// 'METERID'='17130708'
		Map<String, Object> mapList = baseDao.listByStoredProcedureName(RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE"),sqlwhere, pageSize, currentPage, orderField,orderNO);
		//List list = baseDao.listSqlPageAndChangeToMap(sql, firstResult, maxResults, null); 奇怪oracle卡住rownum
		//List jlist = list.subList(firstResult, firstResult+maxResults);
		Long count = Long.valueOf((int) mapList.get("count"));
		HttpSession session = request.getSession();
		session.setAttribute("HISDATA", sqlwhere);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(pageSize);
		listView.setRows((List)mapList.get("rows"));
		listView.setRecords(count);//总共记录
		writeJSON(response, listView);
	}
	// 操作  删除、导出Excel、字段判断和保存
		@RequestMapping(value = "/operateHisData", method = { RequestMethod.POST, RequestMethod.GET })
		public void operateHisData(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String oper = request.getParameter("oper");
			String id = request.getParameter("id");
			if (oper.equals("del")) {
				String[] ids = id.split(",");
				
			} else if (oper.equals("excel")) {
				String date1 = request.getParameter("date1");
				String date2 = request.getParameter("date2");
				String areaguid = request.getParameter("areaguid");
				String  sqlwhere = (String) request.getSession().getAttribute("HISDATA");
				String flag = request.getParameter("flag");//是否测试
				if(org.apache.commons.lang3.StringUtils.isNotBlank(flag)){
					 Object count = baseDao.findBySqlList("select count(1) from "+ RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE") +" where "+sqlwhere , null).get(0);
					 if("0".equals(count.toString())){
						 writeJSON(response, 1);
						 return;
					 }else{
						 return;
					 }
				}
				String areaname = todayDataService.getAreanameById(areaguid)+date1+"到"+date2+"历史数据";
				areaname = areaname.replaceAll(" ", "");
				
				String sql = "select areaname,CLIENTNO,bname||'-'||unitno||'单元'||doorname as DOORNAME,POOLADDR,MBUSID,METERID,SFTR,MSNAME,round(METERGL,2),round(METERNLLJ,2)"
						+ ",round(METERLS,2),round(METERTJ,2),round(METERJSWD,2),round(METERHSWD,2),round(METERWC,2),COUNTHOUR,DDATE,AUTOID from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" where "
						+ sqlwhere+" and rownum < 65536 order by customid";
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
	            	String strTitles = "小区名称，用户编码，门牌，集中器地址，通道号，热表号，用热状态，热表状态，瞬时热量(kw)，累计热量(kwh)，瞬时流量(t/h)，累计流量(t)，"
	            			+ "进水温度(℃)，回水温度(℃)，温差(℃)，时数，日期，抄表批次";
	            	sheet.setColumnWidth(0, 5500);
	            	sheet.setColumnWidth(1, 7700);
	            	sheet.setColumnWidth(2, 6700);
	            	sheet.setColumnWidth(16, 9000);
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
				
			} else {
				
			}
		}
	
}
