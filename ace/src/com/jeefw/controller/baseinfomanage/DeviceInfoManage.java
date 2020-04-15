package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;
import core.util.RequestObj;
import core.util.StringUtilsForController;

@Controller
@RequestMapping("/baseinfomanage/deviceinfomanage")
public class DeviceInfoManage extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	
	@RequestMapping("/getdeviceinfo")
	public void getDeviceInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		setSqlwhereNoWhere();
		String sqlwhere = " where";
		String sql = "";
		setFiltersStr(getFilters()
				//.replace("\"field\":\"AREAGUID\"", "\"field\":\"GPRSID\"")
				.replace("\"field\":\"GPRSID\"", "\"field\":\"AREAGUID\""));
		if(getFilters().contains("\"field\":\"AREAGUID\",\"op\":\"eq\",\"data\":\"\"")){
			sql = "select id,dtype,dcode,daddress,dremark,AreaGuid,GPRSID,AreaName from TDEVICEINFO "+sqlwhere + getSqlWhere() + " order by AreaGuid,dCODE";
		}else{
			sql = "select id,dtype,dcode,daddress,dremark,AreaGuid,GPRSID,AreaName from TDEVICEINFO order by AreaGuid,dCODE";
		}
		
	//	String sql = "select id,dtype,dcode,daddress,dremark,AreaGuid,GPRSID,AreaName from TDEVICEINFO "+sqlwhere + getSqlWhere() + " order by AreaGuid,dCODE";
		if(StringUtilsForController.isNotBlank(getParm("sidx"))&&StringUtilsForController.isNotBlank(getParm("sord"))){
			sql += " order by " + getParm("sidx") + " " +getParm("sord");
		}
		List list =  baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		HttpSession session = request.getSession();
		session.setAttribute("DeviceInfoManage", getSqlWhere());
		Long count = baseDao.countSql(sql);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);
		writeJSON(response, listView);
	
	}

	@RequestMapping("/operdeviceinfo")
	public void operDeviceInfo(HttpServletRequest request, HttpServletResponse response) throws UnknownHostException {
		printRequestParam();
		String oper = getParm("oper");
		boolean flag=false;
	    Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		String bz="";
		String scsql="";
		if (oper.equals("del")) {
			String delSql = "delete TDEVICEINFO where id =" + getParm("id");
			String SQLstring="select AreaName,GPRSID from TDEVICEINFO where id = " + getParm("id");
			List<Map> list= baseDao.listSqlAndChangeToMap(SQLstring, null);
			scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除设备信息','删除小区："+list.get(0).get("AREANAME").toString()+"的"+list.get(0).get("GPRSID").toString()+" 的设备信息','"+delSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="删除提交成功，待审核!";
				}
				else{
					bz="删除提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"删除"+list.get(0).get("AREANAME").toString()+" 的"+list.get(0).get("GPRSID").toString()+"设备信息", bz);
			System.out.println(flag);
			//baseDao.execuSql(delSql, null);
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition", "attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (oper.equals("add")){
			int newTableId = baseDao.getIntNextTableId("TDEVICEINFO", "ID");

			if (newTableId == 0) {

			} else {
				String rsql = "select areaname from tarea where areaguid = " + getParm("AREANAME"); 
				List list = baseDao.findBySqlList(rsql, null);
				String areaname = (String)list.get(0);
				
				String addSql = "insert into TDEVICEINFO values(" + newTableId + ",'" + getParm("DTYPE") + "'" + ",'"
						+ getParm("DCODE") + "'" + ",'" + getParm("DADDRESS") + "'" + ",'" + getParm("DREMARK") + "'" + ",'"
						+ getParm("AREANAME") + "'" + ",'" + getParm("GPRSID") + "'" + ",'" + areaname + "')";
			
				scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加设备信息','添加小区："+areaname+"的"+getParm("GPRSID")+" 的设备信息','"+addSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				
				flag = pubSer.executeBatchSql(scsql);
				 if(flag==true){
						bz="添加提交成功，待审核!";
					}
					else{
						bz="添加提交失败!";
					}
				    
				  flag=pubSer.adduserlog(sysUser.getUserName(),"添加"+areaname+"的"+getParm("GPRSID")+" 设备信息", bz);
				System.out.println(flag);
				baseDao.execuSql(addSql, null);

			}

		} else if (oper.equals("edit")) {
			String rsql = "select areaname from tarea where areaguid = " + getParm("AREANAME"); 
			String tdeviceinfo="";
			String updateSql="";
			List list1 = baseDao.findBySqlList(rsql, null);
			String areaname = (String)list1.get(0);
			/*String updateSql1 = "update TDEVICEINFO set DTYPE ='" + getParm("DTYPE") + "',"
					+ " DCODE = '" + getParm("DCODE") + "',"
					+ " DADDRESS ='" + getParm("DADDRESS") + "',"
					+"  GPRSID ='" + getParm("GPRSID") + "'," //20171030
					+ " DREMARK = '" + getParm("DREMARK") + "',"
					+ " AREAGUID = '" + getParm("AREANAME") + "',"
					+ " AREANAME = '" + areaname + "'"
					+ " where ID = " + getParm("ID");*/
			String SQLstring="select dtype,dcode,daddress,dremark,AreaGuid,GPRSID,AreaName from TDEVICEINFO where id = " + getParm("ID");
			List<Map> list= baseDao.listSqlAndChangeToMap(SQLstring, null);
			 String remark="修改设备信息:";
			 if(!pubSer.compare(getParm("DTYPE"), String.valueOf(list.get(0).get("DTYPE")))){
				 remark+="设备型号:"+getParm("DTYPE")+";";
				 tdeviceinfo+=" DTYPE = ''" + getParm("DTYPE") + "'' ,";
			 }
			 if(!pubSer.compare(getParm("DCODE"), String.valueOf(list.get(0).get("DCODE")))){
				 remark+="设备编号:"+getParm("DCODE")+";";
				 tdeviceinfo+=" DCODE = ''" + getParm("DCODE") + "'' ,";
			 }
			 if(!pubSer.compare(getParm("DADDRESS"), String.valueOf(list.get(0).get("DADDRESS")))){
				 remark+="安装位置:"+getParm("DADDRESS")+";";
				 tdeviceinfo+=" DADDRESS = ''" + getParm("DADDRESS") + "'' ,";
			 }
			 if(!pubSer.compare(getParm("GPRSID"), String.valueOf(list.get(0).get("GPRSID")))){
				 remark+="GPRS编号:"+getParm("GPRSID")+";";
				 tdeviceinfo+=" GPRSID = ''" + getParm("GPRSID") + "'' ,";
			 }
			 if(!pubSer.compare(getParm("DREMARK"), String.valueOf(list.get(0).get("DREMARK")))){
				 remark+="备注:"+getParm("DREMARK")+";";
				 tdeviceinfo+=" DREMARK = ''" + getParm("DREMARK") + "'' ,";
			 }
			 if(!pubSer.compare(getParm("AREANAME"), String.valueOf(list.get(0).get("AREAGUID")))){
				 remark+="小区编号:"+getParm("AREAGUID")+";";
				 tdeviceinfo+=" AREAGUID = ''" + getParm("AREANAME") + "'' ,";
			 }
			 if(!pubSer.compare(areaname, String.valueOf(list.get(0).get("AREANAME")))){
				 remark+="小区名称:"+areaname+";";
				 tdeviceinfo+=" AREANAME = ''" + areaname + "'' ,";
			 }
			 if(tdeviceinfo.length()>0){
				 tdeviceinfo=tdeviceinfo.substring(0, tdeviceinfo.length()-1);
				 updateSql=" update TDEVICEINFO set "+tdeviceinfo+" where  ID=" + getParm("ID");
				 }
			 scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改表故障信息','"+remark+"','"+updateSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="修改提交成功，待审核!";
				}
				else{
					bz="修改提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"修改设备ID编号为:"+getParm("ID")+"的信息", bz);
			  System.out.println(flag);
			
		}
	}

}
