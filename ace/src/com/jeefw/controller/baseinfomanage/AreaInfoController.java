package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.support.JqGridPageView;

@Controller
@RequestMapping(value = "/baseinfomanage/areainfo")
public class AreaInfoController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	@RequestMapping("/getareainfo")
	public void areaInfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String areaids = getSessionAreaGuids();
		String sql = "select distinct areaguid,areaname,AREACODE,AREAPLACE,LINKMAN,TELEPHONE, IMAGEMAP,IMAGEMAP2," //SMEMO
				+ " SECTIONNAME,FACTORYNAME "
				+ " from ("+ PubServiceImpl.headsql + ") ";
		if(StringUtils.isBlank(areaids)){
			sql += " where areaguid = 1841";
		}else{
			sql += " where areaguid in ("+areaids+")";
		}

		List list = baseDao.listSqlAndChangeToMap(sql, null);
		
		writeJSON(response, list);
	}

	/**
	 * 获取所有小区的基础信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getallareainfo")
	public void getallareainfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String filters = request.getParameter("filters");
		String Sqlwhere=" where 1=1";
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++){
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
		String sql = "select distinct AREAGUID,AREANAME,AREAPLACE,LINKMAN,TELEPHONE,"
				+ " SMEMO,SECTIONNAME,FACTORYNAME "
				+ " from  ("+ PubServiceImpl.headsql + ") "+Sqlwhere
		        +" order by " + getParm("sidx") + " " +getParm("sord");
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		Long count = baseDao.countSql(sql);
		JqGridPageView listView = new JqGridPageView();
		listView.setMaxResults(getShowRows());
		listView.setRows(list);
		listView.setRecords(count);
		writeJSON(response, listView);
	}
   /**
    * 功能：编辑小区基础信息
    * @param request
    * @param response
    * @throws IOException
    */
	@RequestMapping("/operateareainfo")
	public void operateareainfo(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String oper = getParm("oper");
		printRequestParam();
		 if("edit".equals(oper)){
			Map<String, Object> result = new HashMap<String, Object>();
			String areaname=request.getParameter("AREANAME");
			String areaguid=request.getParameter("AREAGUID");
			if(StringUtils.isBlank(areaname)){
						System.out.println("小区名称不能为空");
						return;
			}
			
			String updateTarea = "update TAREA set AREANAME = ''" + getParm("AREANAME")
					+ "'',  AREAPLACE = ''" + getParm("AREAPLACE") + "'' , LINKMAN=''" + getParm("LINKMAN")
					+ "'', TELEPHONE = ''" + getParm("TELEPHONE") + "'' , SMEMO = ''" + getParm("SMEMO")+ "'' ,  FACTORYNO = " + getParm("SECTIONNAME")
					+ "  where AREAGUID="+areaguid ;
			boolean flag=false;
			//boolean flag = pubSer.executeBatchSql(updateTarea);
			SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String bz="";
			if(flag==true){
				bz="成功";
			}
			else{
				bz="失败";
			}
			String scsql="insert into TAPPROVAL values(Approval_sequence.Nextval,'修改小区信息','修改小区信息','"+updateTarea+"',0,to_date('"+ df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'), '"+sysUser.getUserName()+"','')";
			flag = pubSer.executeBatchSql(scsql);	
			flag=pubSer.executeBatchSql("insert into TLOG values('"+sysUser.getUserName()+"','小区信息修改,ip为"+InetAddress.getLocalHost().getHostAddress()+"',to_date('"+df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'),'"+bz+"','操作')");
			System.out.println(flag);
		}
	}
	/**
	 * 功能：获取所有的换热站信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getSectionname")
	public void getSectionname(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String factoryid=request.getParameter("FACTORYID");
		
		List map = pubSer.getSection(factoryid);
		writeJSON(response, map);
		
	}
	/**
	 * 功能：获取所有的分公司信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getFactoryname")
	public void getFactoryname(HttpServletRequest request , HttpServletResponse response) throws IOException{
		Map<String, String[]> mapss = request.getParameterMap();
		List map = pubSer.getFactory(mapss);
		writeJSON(response, map);
		 /*String sql="select FACTORYID,FACTORYNAME from ENERGYFACTORY";
		   List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		   StringBuilder builder = new StringBuilder();
		   builder.append("<select><option value=''>-请选择-</option>");
			for (int i = 0; i < list.size(); i++) {
		     Map  result = (HashMap)list.get(i);
			 builder.append("<option value='" + result.get("FACTORYID") + "'>" + result.get("FACTORYNAME") + "</option>");
				
			}
			builder.append("</select>");
			writeJSON(response, builder.toString());*/
	}

}
