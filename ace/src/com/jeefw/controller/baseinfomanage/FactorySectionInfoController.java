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
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;

@Controller
@RequestMapping("/baseinfomanage/FactorySectionInfo")
public class FactorySectionInfoController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	/**
	 * 查找换热站信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getallfactorysection")
	public void getallfactorysection(HttpServletRequest request , HttpServletResponse response) throws IOException{
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
		session.setAttribute("FactorySectionSqlWhere", Sqlwhere);
		String sql = "select FACTORYNAME,SECTIONID,SECTIONNAME,SECTIONPHOTO,YEARS, BDATE, ADATE from FACTORYSECTIONINFO, ENERGYFACTORY  "+Sqlwhere+" and energyfactory.factoryid=FACTORYSECTIONINFO.factoryid order by SECTIONID asc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		writeJSON(response, list);
    }
	/**
	 * 增加、修改、删除、导出EXCEL操作
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/operatefactorysectioninfo")
	public void operatefactorysectioninfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		String sectionname=getParm("SECTIONNAME");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String bz="";
		boolean flag=false;
		if(oper.equals("del")){
			 String delSql = "delete from FACTORYSECTIONINFO where SECTIONID =" + getParm("id");
			 String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除换热站信息','删除换热站信息','"+delSql+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
				//flag=baseDao.execuSql(delSql, null);
				if(flag==true){
					bz="成功";
				}
				else{
					bz="失败";
				}
			
				flag=pubSer.adduserlog(sysUser.getUserName(),"换热站删除", bz);
		}else if(oper.equals("add")){
			 String sql = "select * from FACTORYSECTIONINFO where  SECTIONNAME='"+getParm("SECTIONNAME")+"'";
			 List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
			 if (list.size()>0) {
					System.out.println("换热站名称出现重复，请重新输入！");
					
					return;
				} else {
					
					String addSql = "insert into FACTORYSECTIONINFO values("+getParm("FACTORYNAME")+",FACTORYSECTIONINFO_seq.nextval,''" + getParm("SECTIONNAME") + "'',''.'',''" +getParm("YEARS") +"'',to_date(''"+getParm("BDATE")+"'',''yyyy-MM-dd''),to_date(''"+getParm("ADATE")+"'',''yyyy-MM-dd''))";
				    String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加换热站信息','添加换热站信息','"+addSql+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
					flag = pubSer.executeBatchSql(scsql);
					//flag=baseDao.execuSql(addSql, null);
                    if(flag==true){
    					bz="成功";
    				}
    				else{
    					bz="失败";
    				}
    			
    				flag=pubSer.adduserlog(sysUser.getUserName(),"换热站添加", bz);
				}
		}else if(oper.equals("edit")){
			Map<String, Object> result = new HashMap<String, Object>();
			
			String setwhere="";
			if(StringUtils.isBlank(sectionname)){
					
						System.out.println("换热站名称不能为空");
						return;
			}else{
			
				setwhere="FACTORYID="+getParm("FACTORYNAME")+",SECTIONNAME=''"+sectionname+"'',";
			  }
			
			 setwhere+="YEARS=''"+getParm("YEARS")+"'',BDATE=to_date(''"+getParm("BDATE")+"'',''yyyy-MM-dd''),ADATE=to_date(''"+getParm("ADATE")+"'',''yyyy-MM-dd'')";
			String updatesection = "update FACTORYSECTIONINFO set "+setwhere
					+ "  where SECTIONID="+getParm("SECTIONID") ;
			  String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改换热站信息','修改换热站信息','"+updatesection+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
		   // flag = pubSer.executeBatchSql(updatesection);
			
			if(flag==true){
				bz="成功";
			}
			else{
				bz="失败";
			}
				
			flag=pubSer.adduserlog(sysUser.getUserName(),"换热站修改", bz);
			System.out.println(flag);
		
		}else if(oper.equals("excel")){
			 String title=getParm("title");
			    String  sqlwhere = (String) request.getSession().getAttribute("FactorySectionSqlWhere");
			    String sql = "select FACTORYNAME,SECTIONID,SECTIONNAME,SECTIONPHOTO,YEARS, to_char(BDATE,'yyyy-MM-dd') as BDATE, to_char(ADATE,'yyyy-MM-dd') as ADATE from FACTORYSECTIONINFO, ENERGYFACTORY  "+sqlwhere+" and energyfactory.factoryid=FACTORYSECTIONINFO.factoryid order by SECTIONID asc";
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
	            	String strTitles = "分公司名称，换热站编号，换热站名称，换热站图片，供热年份，起始日期，结束日期";
	            	
	            	sheet.setColumnWidth(2, 7000);
	            	sheet.setColumnWidth(5, 9000);
	            	sheet.setColumnWidth(6, 9000);
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
		}
		
	}
	/**
	 * 填充分公司名称选择框的选项
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getFactorySelectList")
	public void getFactorySelectList(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String sqlwhere="select * from EnergyFactory";
		List<Map> list = baseDao.listSqlAndChangeToMap(sqlwhere, null);
	    StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		for (int i = 0; i < list.size(); i++) {
			 Map  result = (HashMap)list.get(i);
			builder.append("<option value='" + result.get("FACTORYID") + "'>" + result.get("FACTORYNAME")+ "</option>");
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}
}
