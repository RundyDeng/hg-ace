package com.jeefw.controller.baseinfomanage;

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
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;

@Controller
@RequestMapping("/baseinfomanage/meterinfoController")
public class meterinfoController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService changemeter;
	@RequestMapping("/getmeterinfo")
	
	public void getmeterinfo(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select * from tdevicechildtype";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		JqGridPageView view = new JqGridPageView();
		view.setRecords(list.size());
		view.setRows(list);
		writeJSON(response, view);
	}
	@RequestMapping("/getMeterMeterType")
	public void getMeterMeterType(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String devicechildtypeno = getParm("DEVICECHILDTYPENO");//表类型编号
		String sql = "select * from tdevicechildtype where devicechildtypeno = " +devicechildtypeno;
		List list = baseDao.listSqlAndChangeToMap(sql, null);

		writeJSON(response, list);
	}
	
	@RequestMapping("/operMeterInfo")
	public void operMeterInfo(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String id = getParm("DEVICECHILDTYPEGUID");
		System.out.println("====================");
		System.out.println(oper+":"+id);
		if("add".equals(oper)){

			int newTableId = baseDao.getIntNextTableId("TDEVICECHILDTYPE", "DEVICECHILDTYPEGUID");
			String addSql = "insert into TDEVICECHILDTYPE(DEVICECHILDTYPEGUID,DEVICECHILDTYPENAME,ManuFacturer,FaliureCS,SMEMO,DEVICECHILDTYPENO) values ("
					+ newTableId+",'"+getParm("DEVICECHILDTYPENAME")+"','"+getParm("MANUFACTURER")+"','"+getParm("FALIURECS")+"','"+getParm("SMEMO")+"',"+getParm("DEVICECHILDTYPENO")
					+")";
			baseDao.execuSql(addSql, null);
		}
		if("del".equals(oper)){
			String delSql = "delete tdevicechildtype where devicechildtypeguid="+getParm("id") ;
			baseDao.execuSql(delSql, null);
		}
		/*if("edit".equals(oper)){
			String updateSql = "update tdevicechildtype set DEVICECHILDTYPENAME='"+getParm("DEVICECHILDTYPENAME")
			+ "',ManuFacturer='"+getParm("MANUFACTURER")+ "',FaliureCS='"+getParm("FALIURECS")+ "',DEVICECHILDTYPENO="+getParm("DEVICECHILDTYPENO")+",SMEMO='"+getParm("SMEMO")
					+ "' where DEVICECHILDTYPEGUID="+getParm("DEVICECHILDTYPEGUID");
			baseDao.execuSql(updateSql, null);*/
		
		if("edit".equals(oper)){
			String updateSql = "update tdevicechildtype set DEVICECHILDTYPENAME='"+getParm("DEVICECHILDTYPENAME")
					+ "',DEVICECHILDTYPENO="+getParm("DEVICECHILDTYPENO")+",SMEMO='"+getParm("SMEMO")
					+ "' where DEVICECHILDTYPEGUID="+getParm("DEVICECHILDTYPEGUID");
			baseDao.execuSql(updateSql, null);
					
		}
		if("excel".equals(oper)){
		//	String sql = "select DEVICECHILDTYPENAME,ManuFacturer,DEVICECHILDTYPENO,FaliureCS,SMEMO from tdevicechildtype";
			String sql = "select DEVICECHILDTYPENAME,DEVICECHILDTYPENO,SMEMO from tdevicechildtype";
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
            	String strTitles = "热表品牌，表型号，备注信息";//表类型，故障参数，
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
						+ new String( "热表信息".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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