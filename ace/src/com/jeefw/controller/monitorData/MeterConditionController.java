package com.jeefw.controller.monitorData;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
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
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("/monitordata/meterconditioncontr")
public class MeterConditionController extends IbaseController{
	@Resource
	private PubService todayDataService;
	@Resource
	private IBaseDao baseDao;
	private int autoid=1;
	@RequestMapping("/getmetercondition")
	public void getMeterCondition(HttpServletRequest request,HttpServletResponse response) throws IOException{
		//String filters = request.getParameter("filters");
		String filters = getFilters()
				.replace("\"field\":\"BUILDNO\"", "\"field\":\"bcode\"")
				.replace("\"field\":\"UNITNO\"", "\"field\":\"ucode\"")
				.replace("\"field\":\"USERCODE\"", "\"field\":\"CLIENTNO\"");
		String sqlwhere = " where 1=1";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null")) {
					if(result.getString("field").equals("AUTOID")){
						autoid=Integer.parseInt(result.getString("data"));
					}else{
					sqlwhere+=" and v." + result.getString("field")+"="+result.getString("data");
					}
				}
				if(result.getString("op").equals("cn") && StringUtils.isNotBlank(result.getString("data"))){
					sqlwhere+=" and v." + result.getString("field")+" like '%"+result.getString("data")+"%'";
				 }
				/*if(result.getString("field").equalsIgnoreCase("AREAGUID")&& StringUtils.isBlank(result.getString("data"))){//解决没有选择小区名称查询所有数据情况
					sqlwhere += " and " + result.getString("field") + "='" + getSessionAreaGuids()+"'";
				}*/
			}
		}else{//首次进来的设定.。或者。.无条件进入时
			sqlwhere += " and v.areaguid =" + getSessionAreaGuids();
		}

		 String sql = "select v.UserCode as clientno,v.uname,v.address,v.bname||'-'||v.UCODE||'-'||v.FCODE as menpai,v.meterno,v.isstop "
					+" ,case when m.meterid is null then '未抄表' else "
					+" (case when s.ID is null then '正常' else s.msname end) "
					+" end as msname "
					+" ,nvl(round(m.MeterNLLJ,2),0) MeterNLLJ,nvl(round(m.MeterTJ,2),0) MeterTJ,nvl(round(m.MeterLS,2),0) MeterLS"
					+" ,nvl(round(m.MeterGL,2),0) MeterGL,nvl(round(m.MeterJSWD,2),0) MeterJSWD"
					+" ,nvl(round(m.MeterHSWD,2),0) MeterHSWD,nvl(round(m.MeterWC,2),0) MeterWC,nvl(m.CountHour,0) CountHour "
					+" ,nvl(m.ddate,sysdate) ddate"
					+" ," + autoid + " as autoid "  //--抄表批次之前前台获取
					+" ,v.remark "
					+" from vdeviceinfoen v "
					+" left join ( "
					+" select m.* from "+switchOnTimeTableByName("tmeter")+" m "
					//+" where to_char(m.ddate,'YYYY-MM-DD')=to_char(to_date('2017/10/13 2:23:08','yyyy-MM-dd HH24:mi:ss'),'YYYY-MM-DD') "
					//正式用就开启下面这行，并注释上面一行
					+" where to_char(m.ddate,'YYYY-MM-DD')=to_char(sysdate,'YYYY-MM-DD') " 
					+" and m.autoid =" + autoid
					+" ) m "
					+" on m.meterid = v.METERNO and v.AREAGUID = m.areaguid "
					+" left join TSYSSTATUS s "
					+" on s.metertype = v.DEVICETYPECHILDNO and s.msid = m.sysstatus " + sqlwhere +" order by bcode,ucode,floorno,fcode asc";
		
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("MeterCondition", sqlwhere);  
		JqGridPageView view = new JqGridPageView();
		view.setMaxResults(getShowRows());
		view.setRows(list);
		view.setRecords(baseDao.countSql(sql));//总共记录
		writeJSON(response, view);
		
		
	}
	
	@RequestMapping("/updatemetercondition")
	public void updateMeterCondition(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String id =  getParm("id");
		String oper = getParm("oper");
		if("edit".equals(oper)){
			String editSql = "update tdevice set remark='" + getParm("REMARK") 
							+ "' where meterno =" + getParm("METERNO");
			if(StringUtils.isNotBlank(getParm("areaguid"))&&!"undefined".equalsIgnoreCase(getParm("areaguid"))){
				editSql += " and areaguid = " + getParm("areaguid");
			}else{
				editSql += " and areaguid = " + getSessionAreaGuids();
			}
			boolean flag = baseDao.execuSql(editSql, null);
			if(flag==true){
				writeJSON(response, "修改成功！");
			}
 		}else if("excel".equalsIgnoreCase(oper)){
 			 String  sqlwhere = (String) request.getSession().getAttribute("MeterCondition");
			String previousSql ="select v.UserCode as clientno,v.uname,v.address,v.bname||'-'||v.UCODE||'-'||v.FCODE as menpai,v.meterno,v.isstop "
					+" ,case when m.meterid is null then '未抄表' else "
					+" (case when s.ID is null then '正常' else s.msname end) "
					+" end as msname "
					+" ,nvl(round(m.MeterNLLJ,2),0) MeterNLLJ,nvl(round(m.MeterTJ,2),0) MeterTJ,nvl(round(m.MeterLS,2),0) MeterLS"
					+" ,nvl(round(m.MeterGL,2),0) MeterGL,nvl(round(m.MeterJSWD,2),0) MeterJSWD"
					+" ,nvl(round(m.MeterHSWD,2),0) MeterHSWD,nvl(round(m.MeterWC,2),0) MeterWC,nvl(m.CountHour,0) CountHour "
					+" ,nvl(m.ddate,sysdate) ddate"
					+" ," + autoid + " as autoid "  //--抄表批次之前前台获取
					+" ,v.remark "
					+" from vdeviceinfoen v "
					+" left join ( "
					+" select m.* from "+switchOnTimeTableByName("tmeter")+" m "
					//+" where to_char(m.ddate,'YYYY-MM-DD')=to_char(to_date('2017/7/13 2:23:08','yyyy-MM-dd HH24:mi:ss'),'YYYY-MM-DD') "
					//正式用就开启下面这行，并注释上面一行
					+" where to_char(m.ddate,'YYYY-MM-DD')=to_char(sysdate,'YYYY-MM-DD') " 
					+" and m.autoid =" + autoid
					+" ) m "
					+" on m.meterid = v.METERNO and v.AREAGUID = m.areaguid "
					+" left join TSYSSTATUS s "
					+" on s.metertype = v.DEVICETYPECHILDNO and s.msid = m.sysstatus " + sqlwhere;
		 
			String flag = getParm("flag");
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
			
			List list = baseDao.findBySqlList(previousSql, null);

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
            	String excelTitle = "用户编码，住户，地址，门牌，热表号，用热状态，热表状态，累计热量，累计流量，瞬时流量，瞬时热量，进水温度，回水温度，温差，时数，抄表时间，批次，问题说明";
            	sheet.setColumnWidth(0, 8500);
            	sheet.setColumnWidth(14, 9000);
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
			String areaname = "表运行状况备注";
			if(StringUtils.isNotBlank(getParm("areaguid")))
				 areaname = todayDataService.getAreanameById(getParm("areaguid"))+"表运行状况备注";
			areaname = areaname.replaceAll(" ", "");
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
}
