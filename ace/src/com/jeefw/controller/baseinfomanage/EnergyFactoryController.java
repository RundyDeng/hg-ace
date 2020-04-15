package com.jeefw.controller.baseinfomanage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jms.Session;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;


@Controller
@RequestMapping("/baseinfomanage/EnergyFactory")
public class EnergyFactoryController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
   
	/**
	 * 获取所有的分公司信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getallenergyfactory")
	public void getallEnergyFactoryInfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String filters = request.getParameter("filters");
		String Sqlwhere=" where 1=1";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null")) {
					Sqlwhere+=" and " + result.getString("field")+"="+result.getString("data");
				}
				if(result.getString("op").equals("cn") && StringUtils.isNotBlank(result.getString("data"))){
					Sqlwhere+=" and " + result.getString("field")+" like '%"+result.getString("data")+"%'";
				 }
				
				
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				
			} else {
				
			}
		}
		HttpSession session = request.getSession();
		session.setAttribute("EnergyFactorySqlWhere", Sqlwhere);
		String sql = "select * from ENERGYFACTORY "+Sqlwhere+" order by FACTORYID asc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		writeJSON(response, list);
	}
	/**
	 * 修改、删除、添加、导出EXCEL操作
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/operateenergyfactoryinfo")
	public void operateenergyfactoryinfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String factoryid=request.getParameter("FACTORYID");
		String factoryname=request.getParameter("FACTORYNAME");
		printRequestParam();
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String bz="";
		boolean flag=false;
		 if("edit".equals(oper)){
				
				Map<String, Object> result = new HashMap<String, Object>();
				
				String setwhere="";
				if(StringUtils.isBlank(factoryname)){
						
							System.out.println("分公司名称不能为空");
							return;
				}else{
					
					setwhere="FACTORYNAME=''"+factoryname+"'',";
				}
				setwhere+="FACTORYINFO=''"+getParm("FACTORYINFO")+"''";
				String updateTarea = "update ENERGYFACTORY set "+setwhere
						+ "  where FACTORYID="+factoryid ;
				
				//flag= pubSer.executeBatchSql(updateTarea);
				 
				 String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改分公司信息','修改分公司信息','"+updateTarea+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				if(flag==true){
					bz="成功";
				}
				else{
					bz="失败";
				}
			
				flag=pubSer.adduserlog(sysUser.getUserName(),"分公司修改", bz);
				
		 }else if(oper.equals("del")){
			 String delSql = "delete from ENERGYFACTORY where FACTORYID =" + getParm("id");
			 String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除分公司信息','删除分公司信息','"+delSql+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
				//flag=baseDao.execuSql(delSql, null);
				if(flag==true){
					bz="成功";
				}
				else{
					bz="失败";
				}
				flag=pubSer.adduserlog(sysUser.getUserName(),"分公司删除", "成功");
		 }else if(oper.equals("excel")){
			    String title=getParm("title");
			    String  sqlwhere = (String) request.getSession().getAttribute("EnergyFactorySqlWhere");
			    String sql = "select FACTORYID,FACTORYNAME,FACTORYINFO from ENERGYFACTORY"+sqlwhere;
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
	            	String strTitles = "编号，名称，说明";
	            	sheet.setColumnWidth(1, 7700);
	            	sheet.setColumnWidth(2, 9000);
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
							+  title+ ".xls");
	                response.setContentType("application/vnd.ms-excel");
	                response.setContentLength(baos.size());
	                
	                ServletOutputStream out1 = response.getOutputStream();
	                baos.writeTo(out1);
	                out1.flush();
	                out1.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			 
		 }else if (oper.equals("add")){
			 String sql = "select * from ENERGYFACTORY where  FACTORYNAME='"+getParm("FACTORYNAME")+"'";
			 List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
			// System.out.println("分公司list："+list);//list: 为空***************
			 if (list.size()>0) {
					System.out.println("分公司名称出现重复，请重新输入！");
					
					return;
				} else {
					
					String addSql = "insert into ENERGYFACTORY values(EnergyFactory_seq.nextval,''" + getParm("FACTORYNAME") + "'',''" +getParm("FACTORYINFO") +"'')";
					String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加分公司信息','添加分公司信息','"+addSql+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
					flag = pubSer.executeBatchSql(scsql);
					//flag=baseDao.execuSql(addSql, null);
                	if(flag==true){
    					bz="成功";
    				}
    				else{
    					bz="失败";
    					 
    				}
                    flag=pubSer.adduserlog(sysUser.getUserName(),"分公司修改", bz);
				}
		 }
	}
	
}
