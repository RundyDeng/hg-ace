package com.jeefw.controller.searchData;

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

//换表数据查询
@Controller
@RequestMapping("/searchData/hisMeter")
public class HisMeterController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	@RequestMapping("/getHisMeter")
	public void getHisMeter(HttpServletRequest request, HttpServletResponse response) throws IOException {
		setSqlwhereContainWhere();
		//替换查询条件的字段
		setFiltersStr(getFilters().replace("\"field\":\"USERCODE\"", "\"field\":\"CLIENTNO\""));
//		String sql = "select distinct clientno as USERCODE,AREAGUID,areaname,doorno,doorname as FCODE,floorno,unitno,buildname"
//				+ " ,PROMETERID,PRODUSHU,TMODIFYMETER_METERID as METERID, DISHU, TMODIFYMETER_ddate as ddate,USERNAME from (" 
//				+ PubServiceImpl.headsqltest + " where tmm.PROMETERID is not null ) " + getSqlWhere();
		String sql="select * from(select distinct a.clientno as USERCODE,a.AREAGUID,a.areaname,a.doorno,a.doorname as FCODE,a.floorno,a.unitno,"
				+ "a.buildname ,PROMETERID,PRODUSHU, b. METERID, DISHU,  b.ddate,USERNAME from tmodifymeter b left join vareainfo a "
				+ "  on a.AREAGUID=b.areaguid and a.CLIENTNO=b.clientno )"+ getSqlWhere();
		if(StringUtils.isNoneBlank(getParm("sidx"))&&StringUtils.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list = baseDao.listSqlAndChangeToMap(sql, null);//TModifyMeter
		HttpSession session = request.getSession();
		session.setAttribute("HISMETER", getSqlWhere());
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		writeJSON(response, listView);
	}
	
	@RequestMapping("/operHisMeter")
	public void operHisMeter(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if("excel".equals(oper)){

			String areaguid = request.getParameter("areaguid");
			String  sqlwhere = (String) request.getSession().getAttribute("HISMETER");
			String flag = request.getParameter("flag");//是否测试
			if(org.apache.commons.lang3.StringUtils.isNotBlank(flag)){
				 Object count = baseDao.findBySqlList("select count(1) from ( select * from(select distinct a.clientno as USERCODE,a.AREAGUID,a.areaname,a.doorno,a.doorname as FCODE,"
				 		+ "a.floorno,a.unitno,a.buildname ,PROMETERID,PRODUSHU, b. METERID, DISHU,  b.ddate,USERNAME from tmodifymeter b left join vareainfo a"
				 		+ "  on a.AREAGUID=b.areaguid and a.CLIENTNO=b.clientno) "+sqlwhere+")", null).get(0);
				 if("0".equals(count.toString())){
					 writeJSON(response, 1);
					 return;
				 }else{
					 return;
				 }
			}

			String sql = "select clientno,door,USERNAME, PROMETERID,PRODUSHU,METERID,DISHU,DDATE from(select distinct a.areaguid,a.clientno,BUILDNAME||'-'||UNITNO||'单元'||FLOORNO||'层'||doorname as door,USERNAME,PROMETERID,"
					+ "round(PRODUSHU,2) as PRODUSHU,METERID,round(DISHU,2) as DISHU,DDATE  from tmodifymeter b left join vareainfo a on a.AREAGUID=b.areaguid "
					+ "and a.CLIENTNO=b.clientno order by b.ddate desc)"+sqlwhere;
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
            	String strTitles = "用户编码，门牌，记录人，换表前表号，换表前读数(KWH)，换表后表号，换表后读数(KWH)，换表时间";
            	sheet.setColumnWidth(1, 6000);
            	sheet.setColumnWidth(7, 7700);
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
						+ new String( "换表数据".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
