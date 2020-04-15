package com.jeefw.controller.priceManage;

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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
//计量用户费用查询
@Controller
@RequestMapping("/priceMange/clientChargeContr")
public class ClientChargeController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	private double jcjg=5.7,jljg=0.142,mjjg=19;
	@RequestMapping("/getClientCharge")
	public void getClientCharge(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String areaguid= (String) request.getSession().getAttribute(AREA_GUIDS);
		Calendar c = Calendar.getInstance();
		String beginDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		c.add(Calendar.DATE, -7);
		String endDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		String sqlwhere = " where 1=1 ";
		if (StringUtils.isNotBlank(getParm("filters"))) {
			JSONObject jsonObject = JSONObject.fromObject(getParm("filters"));
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				String fieldName = result.getString("field");
				if(fieldName.equalsIgnoreCase("AreaGuid")&& StringUtils.isBlank(result.getString("data"))){
					
					sqlwhere += " and " + result.getString("field") + "=" + (String) request.getSession().getAttribute(AREA_GUIDS);
 				}else if(fieldName.equalsIgnoreCase("JCJG")&& StringUtils.isNotBlank(result.getString("data"))){
					jcjg=Double.parseDouble(result.getString("data"));
 				}else if(fieldName.equalsIgnoreCase("JLJG")&& StringUtils.isNotBlank(result.getString("data"))){
					jljg=Double.parseDouble(result.getString("data"));
 				}else if(fieldName.equalsIgnoreCase("MJJG")&& StringUtils.isNotBlank(result.getString("data"))){
					mjjg=Double.parseDouble(result.getString("data"));
 				}else if(fieldName.equalsIgnoreCase("ddate")){
					if(result.getString("op").equalsIgnoreCase("ge")){
							beginDay = result.getString("data");
					}
					if(result.getString("op").equalsIgnoreCase("le")){
							endDay = result.getString("data");
					}
				}else if(StringUtils.isNotBlank(result.getString("data"))){
					sqlwhere += " and " + fieldName + "=" + result.getString("data");
				}
				
			}
		}else{
			areaguid=(String) request.getSession().getAttribute(AREA_GUIDS);
			String areaguids = (String) request.getSession().getAttribute(AREA_GUIDS);
			if(org.apache.commons.lang3.StringUtils.isNoneBlank(areaguids)){
				sqlwhere += " and areaguid="+areaguids;
			}
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String currentDate = df.format(new Date());
			int month=cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DATE);
			if(month>=10 && day>=15){
				beginDay=cal.get(Calendar.YEAR)+"-10-15";
				endDay=currentDate;
			}else if(month<=4&& day<=15){
				beginDay=cal.get(Calendar.YEAR)-1+"-10-15";
				endDay=currentDate;
			}else{
				beginDay=cal.get(Calendar.YEAR)-1+"-10-15";
				endDay=cal.get(Calendar.YEAR)+"-04-15";
			}
			
		}
	
	
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			sqlwhere += " order by " + getParm("sidx") + " " +getParm("sord");
			
		}
		String sql="select areaname,bname,unitno,doorname ,clientno,clientname, meterno,mobphone,hotarea,case when isyestr=1 then '关' else '开' end sftr,to_char(mindate,'yyyy-MM-dd') as mindate,minnllj,to_char(maxdate,'yyyy-MM-dd') as maxdate,maxnllj,yl,"
				+ jcjg+" as jcjg,Round(hotarea*"+jcjg+",3) as jcrf,"+jljg+" as jljg,round(yl*"+jljg+",3) as jlrf,Round(yl*"+jljg+"+hotarea*"+jcjg+",3) as rfhj,"+mjjg+" as mjjg,case when isyestr=0 then round(hotarea*"+mjjg+",3) else 0 end as mjrf,"
				+ " case when isyestr=0 then round(hotarea*"+mjjg+"-(yl*"+jljg+"+hotarea*"+jcjg+"),3) else round((0-yl*"+jljg+"+hotarea*"+jcjg+"),3) end as tfe from(select b.areaguid,b.areaname,b.METERNO,b.BName,b.unitno,b.doorname ,"
				+ "b.CLIENTNO,e.clientname,e.mobphone,e.hotarea,e.isyestr,b.mindate,b.minnllj,b.maxdate,b.maxnllj, yl"
				+ " from  (select c.areaname,c.bname,c.unitno,c.doorname,c.clientno,c.areaguid,c.meterid as meterno,c.meternllj as maxnllj,c.ddate as maxdate,"
				+ "d.meternllj as minnllj,d.ddate as mindate,case when c.meternllj-d.meternllj<0 then 0 else c.meternllj-d.meternllj end  as yl"
				+ " from(select areaname,bname,unitno,doorname,clientno,areaguid,meterid,meternllj,ddate from vallareainfofailure where areaguid="+areaguid+" and autoid=1 and ddate between to_date('"+endDay+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and to_date('"+endDay+" 23:59:59','yyyy-MM-dd HH24:mi:ss'))c, "
				+ "(select areaguid,meterid,meternllj,ddate from vallareainfofailure where areaguid="+areaguid+" and autoid=1 and ddate between to_date('"+beginDay+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and to_date('"+beginDay+" 23:59:59','yyyy-MM-dd HH24:mi:ss'))d  where"
				+ " c.areaguid=d.areaguid and c.meterid=d.meterid)b inner join  tclient e on"
				+ " b.AREAGUID=e.areaguid and b.CLIENTNO=e.clientno )"+ sqlwhere;
		
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		
		HttpSession session = request.getSession();
		session.setAttribute("CLIENTCHARGE", sqlwhere);
		JqGridPageView view = new JqGridPageView();
		view.setMaxResults(getShowRows());
		view.setRows(list);
		view.setRecords(baseDao.countSql(sql));
		writeJSON(response, view);
	}
	
	@RequestMapping("/updateClientCharge")
	public void updateClientCharge(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String date = getParm("date");
		String areaguid = (String) request.getSession().getAttribute(AREA_GUIDS);
		String  sqlwhere = (String) request.getSession().getAttribute("CLIENTCHARGE");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		/*Calendar c = Calendar.getInstance();
		String beginDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		c.add(Calendar.DATE, -7);
		String endDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		*/
		if("excel".equals(oper)){
			/*String headSql="select areaname,bname,unitno,doorname ,clientno,clientname, meterno,mobphone,hotarea,case when isyestr=1 then '关' else '开' end sftr,to_char(mindate,'yyyy-MM-dd') as mindate,minnllj,to_char(maxdate,'yyyy-MM-dd') as maxdate,maxnllj,yl,"
					+ jcjg+" as jcjg,Round(hotarea*"+jcjg+",3) as jcrf,"+jljg+" as jljg,round(yl*"+jljg+",3) as jlrf,Round(yl*"+jljg+"+hotarea*"+jcjg+",3) as rfhj,"+mjjg+" as mjjg,case when isyestr=0 then round(hotarea*"+mjjg+",3) else 0 end as mjrf,"
					+ " case when isyestr=0 then round(hotarea*"+mjjg+"-(yl*"+jljg+"+hotarea*"+jcjg+"),3) else round((0-yl*"+jljg+"+hotarea*"+jcjg+"),3) end as tfe from(select b.areaguid,b.areaname,b.METERNO,b.BName,b.unitno,b.doorname ,"
					+ "b.CLIENTNO,e.clientname,e.mobphone,e.hotarea,e.isyestr,b.mindate,b.minnllj,b.maxdate,b.maxnllj, yl"
					+ " from  (select c.areaname,c.bname,c.unitno,c.doorname,c.clientno,c.areaguid,c.meterid as meterno,c.meternllj as maxnllj,c.ddate as maxdate,"
					+ "d.meternllj as minnllj,d.ddate as mindate,case when c.meternllj-d.meternllj<0 then 0 else c.meternllj-d.meternllj end  as yl"
					+ " from(select areaname,bname,unitno,doorname,clientno,areaguid,meterid,meternllj,ddate from vallareainfofailure "
					+ "where areaguid="+areaguid+" and autoid=1 and to_date('"+getParm("date")+"','yyyy-mm-dd')<ddate and to_date('"+getParm("date")+"','yyyy-mm-dd')+1>ddate"+sqlwhere;
					 */
					//+" and to_date('"+getParm("date")+"','yyyy-mm-dd')<ddate and to_date('"+getParm("date")+"','yyyy-mm-dd')+1>ddate";
				//	+ "where areaguid='"+getParm("areaguid")+"' and to_char(ddate,'yyyy-MM-dd')='"+getParm("date")+"')c, "
				//	+ "(select areaguid,meterid,meternllj,ddate from vallareainfofailure where areaguid='"+getParm("areaguid")+"' and to_char(ddate,'yyyy-MM-dd')='"+getParm("date")+"')d  where"
				//	+ " c.areaguid=d.areaguid and c.meterid=d.meterid)b inner join (select * from tclient where areaguid='"+getParm("areaguid")+"')e on"
				//	+ " b.AREAGUID=e.areaguid and b.CLIENTNO=e.clientno )"+ sqlwhere+")";
			String sql="select areaname,bname,unitno,doorname ,clientno,clientname, meterno,mobphone,hotarea,case when isyestr=1 then '关' else '开' end sftr,to_char(mindate,'yyyy-MM-dd') as mindate,minnllj,to_char(maxdate,'yyyy-MM-dd') as maxdate,maxnllj,yl,"
					+ jcjg+" as jcjg,Round(hotarea*"+jcjg+",3) as jcrf,"+jljg+" as jljg,round(yl*"+jljg+",3) as jlrf,Round(yl*"+jljg+"+hotarea*"+jcjg+",3) as rfhj,"+mjjg+" as mjjg,case when isyestr=0 then round(hotarea*"+mjjg+",3) else 0 end as mjrf,"
					+ " case when isyestr=0 then round(hotarea*"+mjjg+"-(yl*"+jljg+"+hotarea*"+jcjg+"),3) else round((0-yl*"+jljg+"+hotarea*"+jcjg+"),3) end as tfe from(select b.areaguid,b.areaname,b.METERNO,b.BName,b.unitno,b.doorname ,"
					+ "b.CLIENTNO,e.clientname,e.mobphone,e.hotarea,e.isyestr,b.mindate,b.minnllj,b.maxdate,b.maxnllj, yl"
					+ " from  (select c.areaname,c.bname,c.unitno,c.doorname,c.clientno,c.areaguid,c.meterid as meterno,c.meternllj as maxnllj,c.ddate as maxdate,"
					+ "d.meternllj as minnllj,d.ddate as mindate,case when c.meternllj-d.meternllj<0 then 0 else c.meternllj-d.meternllj end  as yl"
					+ " from(select areaname,bname,unitno,doorname,clientno,areaguid,meterid,meternllj,ddate from vallareainfofailure where areaguid="+areaguid+" and autoid=1 and ddate between to_date('"+date2+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and to_date('"+date2+" 23:59:59','yyyy-MM-dd HH24:mi:ss'))c, "
					+ "(select areaguid,meterid,meternllj,ddate from vallareainfofailure where areaguid="+areaguid+" and autoid=1 and ddate between to_date('"+date1+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and to_date('"+date1+" 23:59:59','yyyy-MM-dd HH24:mi:ss'))d  where"
					+ " c.areaguid=d.areaguid and c.meterid=d.meterid)b inner join  tclient e on"
					+ " b.AREAGUID=e.areaguid and b.CLIENTNO=e.clientno )"+ sqlwhere;
			
			 if(StringUtils.isNotBlank(getParm("flag"))&&"1".equals(getParm("flag"))){
				Long count = baseDao.countSql(sql);
				if(count<1){
					writeJSON(response, 1);
				}
				return;
			 }
			
			 List list = baseDao.findBySql(sql);
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
	            	String strTitles = "小区名称，楼栋，单元，门牌，用户编码，用户姓名，表编号，联系电话，使用面积(㎡)，用热状态，起始日期，起始热量(KWH)，终止时间，"
	            			+ "终止热量(KWH)，耗热量(KWH)，基础价格(元/㎡)，基础热费(元)，计量价格(元/KWH)，计量热费(元)，热费合计(元)，面积价格(元/㎡)，面积热费(元)，退费额(元)";
	            	sheet.setColumnWidth(1, 5700);
	            	sheet.setColumnWidth(2, 5700);
	            	sheet.setColumnWidth(3, 7700);
	            	sheet.setColumnWidth(7, 5700);
	            	sheet.setColumnWidth(9, 7700);
	            	sheet.setColumnWidth(10, 7700);
	            	sheet.setColumnWidth(11, 7700);
	            	sheet.setColumnWidth(12, 7700);
	            	sheet.setColumnWidth(13, 7700);
	            	sheet.setColumnWidth(14, 7700);
	            	sheet.setColumnWidth(15, 7700);
	            	sheet.setColumnWidth(16, 7700);
	            	sheet.setColumnWidth(17, 7700);
	            	sheet.setColumnWidth(18, 7700);
	            	sheet.setColumnWidth(19, 7700);
	            	sheet.setColumnWidth(20, 7700);
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
							+ new String( "住户计量费用统计".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
