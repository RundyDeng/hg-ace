package com.jeefw.controller.baseinfomanage;

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
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;
@Controller
@RequestMapping("/baseinfomanage/meterFaultInfoContr")
public class MeterFaultInfoController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService changemeter;
	@Resource
	private PubService pubSer;
	//获取热表品牌----------
	@RequestMapping("/getMeterFaultInfo")
	public void getMeterbrand(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select * from tdevicechildtype";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		JqGridPageView view = new JqGridPageView();
		view.setRecords(list.size());
		view.setRows(list);
		writeJSON(response, view);
	}
	@RequestMapping("/getMeterFaultByMeterType")
	public void getMeterFaultByMeterType(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String devicechildtypeno = getParm("DEVICECHILDTYPENO");//表类型编号
		String sql = "select * from TSYSSTATUS where metertype = " +devicechildtypeno;
		List list = baseDao.listSqlAndChangeToMap(sql, null);

		writeJSON(response, list);
	}
	
	
	@RequestMapping("/operMeterFaultInfo")
	public void operMeterFaultInfo(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String id = getParm("DEVICECHILDTYPEGUID");
		boolean flag=false;
	    Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		String bz="";
		String scsql="";
		System.out.println(oper+":"+id);
		if("add".equals(oper)){

			int newTableId = baseDao.getIntNextTableId("TDEVICECHILDTYPE", "DEVICECHILDTYPEGUID");
			String addSql = "insert into TDEVICECHILDTYPE(DEVICECHILDTYPEGUID,DEVICECHILDTYPENAME,SMEMO,DEVICECHILDTYPENO) values ("
					+ newTableId+",''"+getParm("DEVICECHILDTYPENAME")+"'',''"+getParm("SMEMO")+"'',"+getParm("DEVICECHILDTYPENO")
					+")";
			scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加热表故障信息','添加 热表"+getParm("DEVICECHILDTYPENAME")+"故障信息','"+addSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="添加提交成功，待审核!";
				}
				else{
					bz="添加提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"添加热表 故障信息", bz);
			System.out.println(flag);
			//baseDao.execuSql(addSql, null);
		}
		if("del".equals(oper)){
			String delSql = "delete tdevicechildtype where devicechildtypeguid="+getParm("id") ;
			scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除热表故障信息','删除热表故障信息','"+delSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="删除提交成功，待审核!";
				}
				else{
					bz="删除提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"删除热表 故障信息", bz);
			System.out.println(flag);
			//baseDao.execuSql(delSql, null);
		}
		/*if("edit".equals(oper)){
			String updateSql = "update tdevicechildtype set DEVICECHILDTYPENAME='"+getParm("DEVICECHILDTYPENAME")
					+ "',DEVICECHILDTYPENO="+getParm("DEVICECHILDTYPENO")+",SMEMO='"+getParm("SMEMO")
					+ "' where DEVICECHILDTYPEGUID="+getParm("DEVICECHILDTYPEGUID");
			baseDao.execuSql(updateSql, null);
					*/
		if("edit".equals(oper)){
			String updateSql = "update tdevicechildtype set DEVICECHILDTYPENAME=''"+getParm("DEVICECHILDTYPENAME")
			+ "'',ManuFacturer=''"+getParm("MANUFACTURER")+ "'',FaliureCS=''"+getParm("FALIURECS")+ "'',DEVICECHILDTYPENO="+getParm("DEVICECHILDTYPENO")+",SMEMO=''"+getParm("SMEMO")
					+ "'' where DEVICECHILDTYPEGUID="+getParm("DEVICECHILDTYPEGUID");
			scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改热表故障信息','修改热表故障信息','"+updateSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="修改提交成功，待审核!";
				}
				else{
					bz="修改提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"删除热表 故障信息", bz);
			System.out.println(flag);
			//baseDao.execuSql(updateSql, null);
		}
		if("excel".equals(oper)){
			//String sql = "select DEVICECHILDTYPENAME,DEVICECHILDTYPENO,SMEMO from tdevicechildtype";
			String sql = "select DEVICECHILDTYPENAME,ManuFacturer,DEVICECHILDTYPENO,FaliureCS,SMEMO from tdevicechildtype";
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
            	String strTitles = "热表品牌，表型号，表类型，故障参数，备注信息";
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
						+ new String( "热表故障信息".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
