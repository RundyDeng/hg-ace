package com.jeefw.controller.baseinfomanage;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.FileLists;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.support.JqGridPageView;
import core.util.MathUtils;

@Controller
@RequestMapping("/baseinfomanage/clientinfo")
public class ClientInfoController extends IbaseController {
	
	@Resource
	private IBaseDao baseDao;
	
	@Resource
	private PubService pubSer;
	
	@RequestMapping("/getClientInfo")
	public void getClientInfo(HttpServletRequest request ,HttpServletResponse response) throws IOException{
		/*String areaids = getSessionAreaGuids();*/
		/*String sql = "select areaguid,areaname,AREACODE,AREAPLACE,LINKMAN,TELEPHONE,IMAGEMAP,IMAGEMAP2,  "
				+ " SECTIONNAME,FACTORYNAME "
				+ " from ("+ PubServiceImpl.headsql + ")" + getSqlWhere() +" order by "+getOrderField() + " " + getOrderKind();
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);*/
		setSqlwhereNoWhere();
		Map<String, Object> mapList = baseDao.listByStoredProcedureName("VCLIENTINFO",getSqlWhere()
				, getShowRows(), getCurrentPage(), getOrderField(),getOrderKindOnInt());
		
		HttpSession session = request.getSession();
		session.setAttribute("CLIENTINFO", getSqlWhere());
		Long count = Long.valueOf((int) mapList.get("count"));
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows((List) mapList.get("rows"));
		listView.setRecords(count);
		writeJSON(response, listView);
		
	}
	
	//显示客户详细信息
	@RequestMapping("/clientDetail")
	public String clientDetail(HttpServletRequest request,HttpServletResponse response){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(new Date());
		String clientId = getParm("CLIENTID");
		if(StringUtils.isNotBlank(clientId)){
			String sql = "select * from VCLIENTINFO where clientno = (select clientno from tclient where clientid = "+ clientId +")";
			String rsql = "select * from ("+PubServiceImpl.headsqltest+") where clientno = (select clientno from tclient where clientid = "+ clientId +")";
			//20171123
			String srl = "select round(MeterNLLJ,2) as MeterNLLJ,DDATE from VALLAREAINFOFAILURE where clientno = (select clientno from tclient where clientid ="+ clientId +") and ddate between TO_DATE('2017-11-01 ','yyyy-MM-dd') and TO_DATE('2017-11-01','yyyy-MM-dd')+1";   
			String erl = "select round(MeterNLLJ,2) as MeterNLLJ,DDATE from VALLAREAINFOFAILURE where clientno = (select clientno from tclient where clientid ="+ clientId +") and ddate between TO_DATE('"+ today +"','yyyy-MM-dd') and TO_DATE('"+ today +"','yyyy-MM-dd')+1";
		//	String erl = "select round(MeterNLLJ,2) as MeterNLLJ,DDATE from VALLAREAINFOFAILURE where clientno = (select clientno from tclient where clientid ="+ clientId +") and ddate between TO_DATE('2017-11-23','yyyy-MM-dd') and TO_DATE('2017-11-23','yyyy-MM-dd')+1";
			
			List slist = baseDao.listSqlAndChangeToMap(srl, null);
			List elist = baseDao.listSqlAndChangeToMap(erl, null);
			
			List rlist = baseDao.listSqlAndChangeToMap(rsql, null);
			List list = baseDao.listSqlAndChangeToMap(sql, null);
			List priceTypeList = baseDao.listSqlAndChangeToMap("select * from tclientcat", null);
			request.setAttribute("obj1", slist.get(0));
			request.setAttribute("obj3", elist.get(0));
			request.setAttribute("obj2", rlist.get(0));
			request.setAttribute("obj", list.get(0));
			request.setAttribute("priceTypeList", priceTypeList);
		}
		return "back/baseinfomanage/clientdetail";
	}
	
	//显示客户详细信息
		@RequestMapping("/clientDetailByClientNO")
		public String clientDetailByClientNO(HttpServletRequest request,HttpServletResponse response){
			String clientno = getParm("clientno");
			if(StringUtils.isNotBlank(clientno)){
				String sql = "select * from VCLIENTINFO where clientno ="+clientno;
				String rsql = "select * from ("+PubServiceImpl.headsqltest+") where clientno ="+clientno;
				List rlist = baseDao.listSqlAndChangeToMap(rsql, null);
				List list = baseDao.listSqlAndChangeToMap(sql, null);
				List priceTypeList = baseDao.listSqlAndChangeToMap("select * from tclientcat", null);
				request.setAttribute("obj2", rlist.get(0));
				request.setAttribute("obj", list.get(0));
				request.setAttribute("priceTypeList", priceTypeList);
			}
			return "back/baseinfomanage/clientdetail";
		}
	
	
	//显示客户换表记录--主键查找
		@RequestMapping("/changeMeterHistory")
		public String changeMeterHistory(HttpServletRequest request,HttpServletResponse response){
			String clientId = getParm("CLIENTID");
			String sql = "select  clientno as USERCODE,AREAGUID,areaname,doorno,doorname as FCODE,floorno,unitno"
					+ " ,PROMETERID,PRODUSHU,TMODIFYMETER_METERID as METERID, DISHU, TMODIFYMETER_ddate as ddate,USERNAME from (" 
					+ PubServiceImpl.headsqltest + " where tmm.PROMETERID is not null ) "
					+ "where clientno = (select clientno from tclient where clientid = "+clientId+")";
			List list = baseDao.listSqlAndChangeToMap(sql, null);
			request.setAttribute("list", list);
			return "back/baseinfomanage/changeMeterHistory";
		}
		//显示客户换表记录--CLIENTNO查找
		@RequestMapping("/changeMeterHistoryClientNO")
		public String changeMeterHistoryClientNO(HttpServletRequest request,HttpServletResponse response){
			String clientNO = getParm("CLIENTNO");
			String sql = "select  clientno as USERCODE,AREAGUID,areaname,doorno,doorname as FCODE,floorno,unitno"
					+ " ,PROMETERID,PRODUSHU,TMODIFYMETER_METERID as METERID, DISHU, TMODIFYMETER_ddate as ddate,USERNAME from (" 
					+ PubServiceImpl.headsqltest + " where tmm.PROMETERID is not null ) "
					+ "where clientno = '"+clientNO+"'";
			List list = baseDao.listSqlAndChangeToMap(sql, null);
			String rsql ="select clientId from tclient where clientno='"+clientNO+"'";
			List<Map> rlist = baseDao.listSqlAndChangeToMap(rsql, null);
			if(rlist.size()>0){
			int clientid = MathUtils.getBigDecimal(rlist.get(0).get("CLIENTID")).intValue();
			request.setAttribute("CLIENTID", clientid);
			request.setAttribute("list", list);
			
			}
			return "back/baseinfomanage/changeMeterHistory";
		}
	
	// 操作删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operClientInfo", method = { RequestMethod.POST, RequestMethod.GET })
	public void operClientInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		printRequestParam();
		String oper = request.getParameter("oper");
		String clientId = request.getParameter("CLIENTID");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		if (oper.equals("del")) {
			
		} else if (oper.equals("excel")) {
			String areaguid = request.getParameter("areaguid");
			String areaname = baseDao.findBySql("select areaname from tarea where areaguid="+areaguid).get(0).toString();
			String  sqlwhere = (String) request.getSession().getAttribute("CLIENTINFO");	
			String sql = "select AREANAME, MENPAI,CLIENTNO,METERNO,CLIENTNAME,MOBPHONE,ADDRESS,HOTAREA, UAREA,CLIENTCAT,position,meterxish,PRICE"
                    +" from (select AREANAME, MENPAI,CLIENTNO,METERNO,CLIENTNAME,MOBPHONE,ADDRESS,HOTAREA,UAREA,CLIENTCAT,position,meterxish,PRICE,a.areaguid,buildno,unitno,floorno,doorno"
					+ " from VCLIENTINFO a left join tarea b on a.areaguid=b.areaguid  order by Buildno,unitno,doorname asc)"+sqlwhere;
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
            	String strTitles = "小区名称，门牌，用户编号，表号，姓名，电话，地址，建筑面积，使用面积，住户类型，位置 ，系数， 计量单价";
            	sheet.setColumnWidth(2, 6700);
            	sheet.setColumnWidth(6, 7700);
            	//sheet.setColumnWidth(6, 7700);
            	
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
				//FileInputStream fis = new FileInputStream("E:/user.xsl");
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
                wb.write(baos);
                response.addHeader("Content-Disposition", "attachment;filename="
						+ new String( (areaname+"小区住户信息").getBytes("gb2312"), "ISO8859-1" ) + ".xls");
             //   OutputStream out1= new BufferedOutputStream(response.getOutputStream());
                response.setContentType("application/vnd.ms-excel");
                response.setContentLength(baos.size());
               ServletOutputStream out1 = response.getOutputStream();
                baos.writeTo(out1);
                out1.flush();
                out1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		} else if (oper.equals("edit")) {
			    boolean flag=false;
				String clientNo = pubSer.getClientNoByClientId(Integer.valueOf(clientId));
                String sqlwhere="select * from vclientinfo where  clientno='"+clientNo+"'";
                List<Map> list= baseDao.listSqlAndChangeToMap(sqlwhere, null);
                String tclient="";
				String tClientproperty="";

				if(!request.getParameter("CLIENTNO").equals(clientNo)){//修改了clientNo
						if(pubSer.checkClientNo(getParm("CLIENTNO"))){
							System.out.println("clientno重复");
							return;
						}
						String sqltdoormeter = "update tdoor_meter set clientno='" + getParm("CLIENTNO") + "' where  areaguid=" + getParm("AREAGUID") + " and meterno='"+list.get(0).get("METERNO").toString()+"'";
						flag=pubSer.executeBatchSql(sqltdoormeter);
				}
				 String bz="";
				 String remark="修改住户编码"+clientNo+"信息：";
				 if(!pubSer.compare(getParm("CLIENTNO"), String.valueOf(list.get(0).get("CLIENTNO")))){
					 remark+="住户编号:"+getParm("CLIENTNO")+";";
					 tclient+=" CLIENTNO = ''" + getParm("CLIENTNO") + "'' ,";
					 tClientproperty+=" CLIENTNO=" + getParm("CLIENTNO")+",";
				 }
				 if(!pubSer.compare(getParm("CLIENTNAME"), String.valueOf(list.get(0).get("CLIENTNAME")))){
					 remark+="住户姓名:"+getParm("CLIENTNAME")+";";
					 tclient+=" CLIENTNAME = ''" + getParm("CLIENTNAME") + "'' ,";
				 }
				 if(!pubSer.compare(getParm("MOBPHONE"), String.valueOf(list.get(0).get("MOBPHONE")))){
					 remark+="固定电话:"+getParm("MOBPHONE")+";";
					 tclient+=" MOBPHONE = ''" + getParm("MOBPHONE") + "'' ,";
				 }
				
				 if(!pubSer.compare(getParm("HOTAREA"),String.valueOf(list.get(0).get("HOTAREA")))){
					 remark+="建筑面积:"+getParm("HOTAREA")+";";
					 tclient+=" HOTAREA = ''" + getParm("HOTAREA") + "'' ,";
				 }
				 if(!pubSer.compare(getParm("SFTR"), String.valueOf(list.get(0).get("ISYESTR")))){
					 remark+="是否停热:"+getParm("SFTR")+";";
					 tclient+=" ISYESTR = ''" + getParm("SFTR") + "'' ,";
				 }
				 if(!pubSer.compare(getParm("POSITION"), String.valueOf(list.get(0).get("METERXISH")))){
					 remark+="位置:"+getParm("POSITION")+";";
					 tclient+=" METERXISH = ''" + getParm("POSITION") + "'' ,";
					 
				 }
				 if(!pubSer.compare(getParm("ISYESJL"), String.valueOf(list.get(0).get("ISYESJL")))){
					 remark+="是否签约:"+getParm("ISYESJL")+";";
					 tclient+=" ISYESJL = ''" + getParm("ISYESJL") + "'' ,";
				 }
				 if(!pubSer.compare(getParm("CLIENTCAT"), String.valueOf(list.get(0).get("CLIENTCATID")))){
					 remark+="住户类型:"+getParm("CLIENTCAT")+";";
					 tClientproperty+=" CLIENTCATID=" + getParm("CLIENTCAT")+",";
				 }
				 if(!pubSer.compare(getParm("UAREA"), String.valueOf(list.get(0).get("UAREA")))){
					 remark+="使用面积:"+getParm("UAREA")+";";
					 tClientproperty+=" UAREA=" + getParm("UAREA")+",";
				 }
				 String sqlTclient ="";
				 String sqltClientproperty="";
				 if(tclient.length()>0){
				 tclient=tclient.substring(0,tclient.length() - 1);
				 sqlTclient = "update tclient set "+tclient+" where CLIENTID=''" + clientId+"''";
				 }
				 if(tClientproperty.length()>0){
				 tClientproperty=tClientproperty.substring(0, tClientproperty.length()-1);
				 sqltClientproperty=" update TCLIENTPROPERTY set "+tClientproperty+" where  CLIENTNO=''" + clientNo+"''";
				 }
				 String sql="";
				 if(sqlTclient.length()>0){
					 sql+=sqlTclient+";";
				 }
				 if(sqltClientproperty.length()>0){
					 sql+=sqltClientproperty+";";
				 }
				 Date now = new Date(); 
				 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				 String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改住户信息','"+remark+"','"+sql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				 if(flag==true){
 					bz="修改提交成功，待审核!";
 				}
 				else{
 					bz="修改提交失败!";
 				}
 			    
 				flag=pubSer.adduserlog(sysUser.getUserName(),"修改住户编号"+clientNo+"的信息", bz);
				System.out.println(flag);

			
				writeJSON(response, flag);
					
		}
	
	}
	
	
}
