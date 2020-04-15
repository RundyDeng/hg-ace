package com.jeefw.controller.warningmanage;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.Tfailurecode;
import com.jeefw.service.warningmanage.WarningSettingService;

import core.support.JqGridPageView;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/warningmanage/warningsettingcontr")
public class WarningSettingController extends IbaseController {
	@Resource
	private IBaseDao<Tfailurecode>  baseDao;

	@Resource
	private WarningSettingService warningSettringSvr;
	
	@RequestMapping("/checkfailurename")
	public void checkFailureName(HttpServletRequest request,HttpServletResponse response) throws IOException{
		if(getParm("currentvalue").equals(getParm("param"))){
			writeJSON(response, "{\"info\":\"当前故障名称\",\"status\":\"y\"}");
			return;
		}
		Tfailurecode obj = warningSettringSvr.getByProerties(getParm("name"),getParm("param"));
		if(obj==null)
			writeJSON(response, "{\"info\":\"验证成功，没有重复\",\"status\":\"y\"}");
		else
			writeJSON(response, "{\"info\":\"故障名称已存在\",\"status\":\"n\"}");
	}
	
	@RequestMapping("/checkfailurecode")
	public void checkFailureCode(HttpServletRequest request,HttpServletResponse response) throws IOException{
		if(getParm("currentvalue").equals(getParm("param"))){
			writeJSON(response, "{\"info\":\"当前故障代码\",\"status\":\"y\"}");
			return;
		}
		Tfailurecode obj = warningSettringSvr.getByProerties(getParm("name"),getParm("param"));
		if(obj==null)
			writeJSON(response, "{\"info\":\"验证成功，没有重复\",\"status\":\"y\"}");
		else
			writeJSON(response, "{\"info\":\"故障代码已存在\",\"status\":\"n\"}");
	}
	
	@RequestMapping("/getwarningsetting")
	public void getWarningSetting(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String areaguid = getSessionAreaGuids();
		if(StringUtils.isNotBlank(getParm("filters"))){
			JSONObject jsonObject = JSONObject.fromObject(getParm("filters"));
			JSONArray joa = (JSONArray)jsonObject.get("rules");
			Map map = (Map)joa.get(0); 
			String r = map.get("data").toString();
			if(org.apache.commons.lang3.StringUtils.isNotBlank(r))
				areaguid = r;
		}
		String sql = "select FailureID,FailureCode,FailureName,failurecondition,f.areaguid,areaname,areacode "
				+" from TFailureCode f "
				+" left join tarea a "
				+" on a.areaguid = f.areaguid"//;
				+" where f.areaguid = " +areaguid
				+" order by f.areaguid";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		listView.setRecords(list.size());
		writeJSON(response, listView);
	}
	@RequestMapping("/upadatewarningsetting")
	public void updateWarningSetting(HttpServletRequest resquest,HttpServletResponse response,Tfailurecode tFailurecodeModel) throws IOException{
		String oper = getParm("oper");
		String id_p = getParm("id");
		if("del".equals(oper)){
			BigDecimal id = new BigDecimal(id_p);
			boolean flag = warningSettringSvr.deleteByPK(id);
			if(flag){
				writeJSON(response, "{success:true}");
			}else{
				writeJSON(response, "{success:false}");
			}
		}else{
			//baseDao.saveOrUpdate(tFailurecodeModel);
			try {
				warningSettringSvr.merge(tFailurecodeModel);
			} catch (Exception e) {
				writeJSON(response, 0);
			}
			writeJSON(response, 1);
		}
	}
	
	@RequestMapping("/getid")
	@ResponseBody
	public int getTableId(HttpServletRequest request , HttpServletResponse response){
		return baseDao.getIntNextTableId("Tfailurecode", "failureid");
	}
}
