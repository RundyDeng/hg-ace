/*package com.jeefw.controller.baseinfomanage;

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

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;
import core.support.JqGridPageView;

@Controller
@RequestMapping("/baseinfomanage/setmeterfailure")
public class SetMeterFailure extends IbaseController{
	@Resource
	private IBaseDao basedao;
	@Resource
	private PubService pubSer;
	@RequestMapping("/getmeterfailure")
	public void getMeterFailure(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select FailureID,FailureCode,FailureName,failurecondition,f.areaguid,areaname,areacode "
					+" from TFailureCode f "
					+" left join tarea a "
					+" on a.areaguid = f.areaguid"//;
					+" where f.areaguid = " +getSessionAreaGuids()
					+" order by f.areaguid";
		
		String sql = "select FailureID,FailureCode,f.FailureName,f.failurecondition,f.areaguid,areaname,areacode,FAILURESIGN " //f.devicechildtypename,
				+ " from TFailureCode f "
				+ "left join tarea a "
				+" on a.areaguid = f.areaguid"
				+" left join TSYSSTATUS n "
				+ "on n.msid=f.failurecode "
				+"and f.failurename= n.failurename "
				+ "and f.failurecondition=n.failurecondition"
				+" where f.areaguid = " +getSessionAreaGuids()
				+ " order by f.areaguid";
		
		List list = basedao.listSqlAndChangeToMap(sql, null);
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		listView.setRecords(list.size());
		writeJSON(response, listView);
	}
	
	@RequestMapping("/opermeterfailure")
	public void operMeterFailure(HttpServletRequest request,HttpServletResponse response) throws UnknownHostException{

		String oper = request.getParameter("oper");
		boolean flag=false;
	    Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		String bz="";
		String scsql="";
		if (oper.equals("del")) {
			String delSql = "delete TFailureCode where FAILUREID = " + getParm("id");
			String SQLstring="select FAILURENAME from TFailureCode where FAILUREID = " + getParm("id");
			List<Map> list= basedao.listSqlAndChangeToMap(SQLstring, null);
			scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除表故障信息','删除："+list.get(0).get("FAILURENAME").toString()+" 故障','"+delSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="删除提交成功，待审核!";
				}
				else{
					bz="删除提交失败!";
				}
			    
			  flag=pubSer.adduserlog(sysUser.getUserName(),"删除"+list.get(0).get("FAILURENAME").toString()+" 故障的信息", bz);
			System.out.println(flag);
			//basedao.execuSql(delSql, null);
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
		} else if (oper.equals("edit")) {
			if("".equals(getParm("FAILUREID"))){
				System.out.println("FAILUREID is empty");
			}else{
				
				String updateSql = "update TFailureCode set FailureCode=''" + getParm("FAILURECODE") + "'',"
						+ " FailureName = ''" + getParm("FAILURENAME") + "'',"
						+ " failurecondition =''" + getParm("FAILURECONDITION") + "'',"
						+ " areaguid = ''" + getParm("AREANAME") + "'',"
						+ " FAILURESIGN = ''"+ getParm("FAILURESIGN") + "''"     //2018122
						+ " where FAILUREID = " + getParm("FAILUREID");
				String SQLstring="select FAILURENAME from TFailureCode where FAILUREID = " + getParm("FAILUREID");
				List<Map> list= basedao.listSqlAndChangeToMap(SQLstring, null);
				scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改表故障信息','修改："+list.get(0).get("FAILURENAME").toString()+" 故障','"+updateSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				 if(flag==true){
						bz="修改提交成功，待审核!";
					}
					else{
						bz="修改提交失败!";
					}
				    
				  flag=pubSer.adduserlog(sysUser.getUserName(),"修改"+list.get(0).get("FAILURENAME").toString()+" 故障的信息", bz);
				System.out.println(flag);
				//basedao.execuSql(updateSql, null);
				
			}
		
		}else if (oper.equals("add")){
			int newTableId = basedao.getIntNextTableId("TFailureCode", "FAILUREID");
			if(newTableId == 0){
				
			}else{
				
				String addSql = "insert into TFailureCode(FAILUREID,FailureCode,FailureName,failurecondition,areaguid,FAILURESIGN) values "
						+ " ( " + newTableId + ",''" + getParm("FAILURECODE") + "'',''" + getParm("FAILURENAME") + "'',''"
						+ getParm("FAILURECONDITION") + "'',''" + getParm("AREANAME") + "'',''" + getParm("FAILURESIGN") + "'')";
				scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加表故障信息','添加："+getParm("FAILURENAME")+" 故障','"+addSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				 
				 if(flag==true){
						bz="添加提交成功，待审核!";
					}
					else{
						bz="添加提交失败!";
					}
				    
				  flag=pubSer.adduserlog(sysUser.getUserName(),"添加"+getParm("FAILURENAME")+" 故障的信息", bz);
				 System.out.println(flag);
				//basedao.execuSql(addSql, null);
				
				
			}
		
		}
	}
	
}

*/


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

import org.springframework.stereotype.Controller;
import org.springframework.test.annotation.Commit;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;

@Controller
@RequestMapping("/baseinfomanage/setmeterfailure")
public class SetMeterFailure extends IbaseController{
	@Resource
	private IBaseDao basedao;
	@Resource
	private PubService pubSer;
	@RequestMapping("/getmeterfailure")
	public void getMeterFailure(HttpServletRequest request,HttpServletResponse response) throws IOException{
		/*String sql = "";
		setSqlwhereContainWhere();
		setFiltersStr(getFilters()
				.replace("\"field\":\"METERTYPE\"", "\"field\":\"METERTYPE\"")
				.replace("\"field\":\"MSNAME\"", "\"field\":\"MSID\""));
		if(getFilters().contains("\"field\":\"METERTYPE\",\"op\":\"eq\",\"data\":\"\"")){//即没有设定查询的参数时显示错误
			
		 sql = "select id, devicechildtypeno,devicechildtypename,msid,msname, failurename,failurecondition,metertype " 
					+" from TSYSSTATUS a "
					+" left join TDEVICECHILDTYPE b "
					+" on b.devicechildtypeno=a.metertype"
					+" "+ getSqlWhere() 
					+" order by id desc"; 
		}else{*/
		String	sql="select id,devicechildtypeno,devicechildtypename,msname,msid,failurecondition " 
					+" from TSYSSTATUS a "
					+" left join TDEVICECHILDTYPE b "
					+" on b.devicechildtypeno=a.metertype"
					+" order by id desc";
	//	}
		List list = basedao.listSqlAndChangeToMap(sql, null);
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		listView.setRecords(list.size());
		writeJSON(response, listView);
	}
	
	@RequestMapping("/opermeterfailure")
	public void operMeterFailure(HttpServletRequest request,HttpServletResponse response) throws UnknownHostException{

		String oper = request.getParameter("oper");
		boolean flag=false;
	    Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
		String bz="";
		String scsql="";
		if (oper.equals("del")) {
			String delSql = "delete TSYSSTATUS where ID = " + getParm("id");
			String SQLstring="select MSNAME from TSYSSTATUS where ID = " + getParm("id");
			List<Map> list= basedao.listSqlAndChangeToMap(SQLstring, null);
			/*scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'删除表故障信息','删除："+list.get(0).get(" MSNAME").toString()+" 故障','"+delSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			 flag = pubSer.executeBatchSql(scsql);
			 if(flag==true){
					bz="删除提交成功，待审核!";
				}
				else{
					bz="删除提交失败!";
				}
			  flag=pubSer.adduserlog(sysUser.getUserName(),"删除"+list.get(0).get(" MSNAME").toString()+" 故障的信息", bz);
			System.out.println(flag);*/
			basedao.execuSql(delSql, null);
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition", "attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes());
				out.flush();
				out.close();
			} catch (Exception e){
				e.printStackTrace();
			}
		} else if (oper.equals("edit")) {
			if("".equals(getParm("ID"))){
				System.out.println("ID is empty");
			}else{
				
				String updateSql = "update TSYSSTATUS set METERTYPE='" + getParm("DEVICECHILDTYPENAME") + "',"
						+ " MSNAME = '" + getParm("MSNAME") + "',"
						+ " MSID ='" + getParm("MSID") + "',"
						+ " FAILURECONDITION = '" + getParm("FAILURECONDITION") + "'"
						+ " where ID ='" + getParm("ID")+"'";
			//	String SQLstring="select * from TSYSSTATUS where ID = '" + getParm("ID")+"'";
			/*	List<Map> list= basedao.listSqlAndChangeToMap(SQLstring, null);
				scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改表故障信息','修改："+list.get(0).get("FAILURENAME").toString()+" 故障','"+updateSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				 if(flag==true){
						bz="修改提交成功，待审核!";
					}
					else{
						bz="修改提交失败!";
					}
				    
				  flag=pubSer.adduserlog(sysUser.getUserName(),"修改"+list.get(0).get("FAILURENAME").toString()+" 故障的信息", bz);
				System.out.println(flag);*/
				basedao.execuSql(updateSql, null);
				
			}
		
		}else if (oper.equals("add")) {
			int newTableId = basedao.getIntNextTableId("TSYSSTATUS", "id");
			if(newTableId == 0){
				
			}else{
				
				String addSql = "insert into TSYSSTATUS(id,metertype,msname,msid,failurecondition) values " 
						+ " ( " + newTableId + "," + getParm( "DEVICECHILDTYPENAME") + ",'" + getParm("MSNAME") + "','"
						+ getParm("MSID") + "','" + getParm("FAILURECONDITION") + "')"; //,''" + getParm("AREANAME") + "''
				/*scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'添加表故障信息','添加："+getParm("MSNAME")+" 故障','"+addSql+"',0,to_date('"+ dateFormat.format(now)+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
				 flag = pubSer.executeBatchSql(scsql);
				 if(flag==true){
						bz="添加提交成功，待审核!";
					}
					else{
						bz="添加提交失败!";
					}
				  flag=pubSer.adduserlog(sysUser.getUserName(),"添加"+getParm("MSNAME")+" 故障的信息", bz);
				System.out.println(flag);*/
				basedao.execuSql(addSql, null);
				
			}
		
		}
	}
	
}




