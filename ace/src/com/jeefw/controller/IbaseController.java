package com.jeefw.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.gson.Gson;
import com.jeefw.core.Constant;
import com.jeefw.core.JavaEEFrameworkBaseController;
import com.jeefw.model.sys.SysUser;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
 
public abstract class IbaseController extends JavaEEFrameworkBaseController implements Constant{
	private String sqlwhere = " where 1 = 1 ";
	private String whereFilter = "";
	
	public void setSqlwhereContainWhere() {
		this.sqlwhere = " where 1 = 1 ";
	}
	public void setSqlwhereNoWhere() {
		this.sqlwhere = " 1 = 1 ";
	}

	public void setSqlwhereEmpty(){
		this.sqlwhere = "";
	}
	
	public String getParm(String para){
		String result = getRequest().getParameter(para);
		if(StringUtils.isBlank(result))
			return "";
		return result;
	}

	public String getdata(String para){
		if(StringUtils.isBlank(para))
			return "";
		return para;
	}
	
	/**
	 * 判断请求参数是否为空
	 * @return true空，，，false不为空
	 */
	public boolean isBlankToParm(String para){
		String result = getRequest().getParameter(para);
		if(StringUtils.isBlank(result))
			return true;
		return false;
	}
	public void printObj(Object obj){
		Gson gs = new Gson();
		System.out.println(gs.toJson(obj));
	}

	private HttpServletRequest getRequest(){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	
	
	public String getSessionAreaGuids(){
	 	String areaguids = (String) getRequest().getSession().getAttribute(AREA_GUIDS);
		if(StringUtils.isNotBlank(areaguids)){
			return areaguids;
		}else{
			getRequest().getSession().setAttribute(AREA_GUIDS, DEFAULT_AREAGUID);
			getRequest().getSession().setAttribute(AREA_NAME, DEFAULT_AREANAME);
			return DEFAULT_AREAGUID;
		}
	}
	
	
	public void setDefualtArea(String areaguid,String areaname){
		System.out.println("============================"+areaguid+"+++++++"+areaname);
		getRequest().getSession().setAttribute(AREA_GUIDS, areaguid);
		getRequest().getSession().setAttribute(AREA_NAME, areaname);
	}
	
	/**
	 * @return 最后一次查询的SQL
	 * 该SQL保存在用户的SESSION里，
	   如果请求的地址是以为sysuser/xxxx  结尾的（既跳转页面），则清空此session的这个SQL
	 */
	public String getPreviousExcelSql(){
	 	String sql = (String)getRequest().getSession().getAttribute(LAST_QUERY_SQL);
	 	return sql;
	}
	
	/**
	 * 保存控制器查询的SQL用以下次使用，如用于  导出EXCEL
	 * @param saveSql
	 */
	public void setPreviousExcelSql(String saveSql){
		getRequest().getSession().setAttribute(LAST_QUERY_SQL, saveSql);
	}
	
	/**
	 * @return需要显示第几页
	 */
	public Integer getCurrentPage(){
		return Integer.valueOf(getRequest().getParameter("page"));
	}
	/**
	 * @return每页需要显示的页数
	 */
	public Integer getShowRows(){
		return Integer.valueOf(getRequest().getParameter("rows"));
	}
	/**
	 * @return排序字段
	 */
	public String getOrderField(){
		return getRequest().getParameter("sidx");
	}
	/**
	 * @return排序方式  asc 或 desc
	 */
	public String getOrderKind(){
		return getRequest().getParameter("sord");
	}
	
	/**
	 * 
	 * @return0升序，1降序
	 */
	public Integer getOrderKindOnInt(){
		if("asc".equals(getOrderKind()))
			return 0;
		return 1;
	}
	
	/**
	 * 修改filter 的参数
	 */
	public String setFiltersStr(String ...filterStr){
		whereFilter = "";
		if(filterStr.length==0){
			whereFilter = getRequest().getParameter("filters");
		}else{
			whereFilter = filterStr[0];
		}
		return whereFilter;
	}
	
	/**
	 * @return查询条件  JSON格式
	 */
	public String getFilters(){
		if(StringUtils.isBlank(whereFilter)){
			if(getRequest().getParameter("filters")==null){
				return "";						
			}
			return getRequest().getParameter("filters");
		}
		return whereFilter;
	}
	
	/**
	 * 根据filters的条件拼成where sql 
	 * @return   sql  where部分
	 */
	public String getSqlWhere(){
		String filters = getFilters();
/*		String areaguid = (String)getRequest().getAttribute(AREA_GUIDS);
		if(org.apache.commons.lang3.StringUtils.isBlank(areaguid))
			sqlwhere += "and areaguid = 1841 ";
		else
			sqlwhere += " and areaguid in ("+areaguid+") ";*/
		
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("op").equals("eq") && StringUtils.isNotBlank(result.getString("data"))
						&& !result.getString("op").equals("null") && !result.getString("data").equals("undefined")) {
					if(result.getString("field").equalsIgnoreCase("DDATE")){
						sqlwhere += " and " + result.getString("field") + " between to_date('" + result.getString("data") + " 00:00:00','yyyy-MM-dd HH24:Mi:ss') and to_date('" + result.getString("data") + " 23:59:59','yyyy-MM-dd HH24:Mi:ss')";
						
					}else
						sqlwhere += " and " + result.getString("field") + "='" + result.getString("data")+"'";
				}else{
					if(result.getString("field").equalsIgnoreCase("AREAGUID")&& StringUtils.isBlank(result.getString("data"))){//解决没有选择小区名称查询所有数据情况
						sqlwhere += " and " + result.getString("field") + "='" + getSessionAreaGuids()+"'";
					}
					if(result.getString("field").equalsIgnoreCase("AUTOID")&& StringUtils.isBlank(result.getString("data"))){//解决没有选择小区名称查询所有数据情况
						sqlwhere += " and " + result.getString("field") + "=1";
					}
				}
				
				if (result.getString("op").equals("ge") && !"".equals(result.getString("data"))) {//大于等于
					sqlwhere += " and " + result.getString("field") + ">=" + "to_date('" + result.getString("data") + "','yyyy/MM/dd') ";
				}
				if (result.getString("op").equals("le") && !"".equals(result.getString("data"))) {//小等于
					sqlwhere += " and " + result.getString("field") + "<=" + "to_date('" + result.getString("data") + "','yyyy/MM/dd') ";
				}
				
				if (result.getString("op").equals("cn")) {//包含
					
				}
			}

			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				
			} else {
				
			}
		}else{//首次进来的设定.。或者。.无条件进入时
			String urlName = getRequest().getRequestURI();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String currentDate = df.format(new Date());
			String areaids = getSessionAreaGuids();
			sqlwhere += " and areaguid =" + areaids;
			if(urlName.contains("getClientInfo") || urlName.contains("changemeter")){
				
				
			}
			if(urlName.contains("getTodayData")||urlName.contains("getTodayFaultData")||urlName.contains("getNoReadMeter")){//设定为当天
				sqlwhere += " and DDATE between to_date('"+currentDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') and to_date('"+currentDate+" 23:59:59','yyyy-MM-dd HH24:Mi:ss') and autoid=1";
			}
			if(urlName.contains("getHisFault")||urlName.contains("getHisdata")){//设定为7天内的
				sqlwhere += " and to_date('"+currentDate+"','yyyy/MM/dd')+1 > DDATE and to_date('"+currentDate+"','yyyy/mm/dd')-7 < DDATE and autoid=1";
			}
			
			
		}
		String returnSqlWhere = sqlwhere;
		System.out.println(sqlwhere);
		sqlwhere = " where 1 = 1 ";
		whereFilter = "";//还需要清空一查询规则
		return returnSqlWhere;
	}
	
	/**
	 * 打印请求里的所有参数
	 */
	public void printRequestParam(){
		
		Map<String, String[]> map = getRequest().getParameterMap();
		Set<String> keys = map.keySet();
		Gson gs = new Gson();
		
		for (String string : keys) {
			String str = gs.toJson(map.get(string));
			System.out.println(string+":"+str);
		}
	}
	
	/**
	 * @return得到登录用户名
	 */
	public String getLoginName(){
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		SysUser user = (SysUser)session.getAttribute(SESSION_SYS_USER);
		return user.getUserName();
	}
	
	/**
	 * 从请求里获取非page的参数拼成sql
	 * @return
	 */
	public String getSqlWhereByRequestParaMap(){
		Map<String, String[]> paramMap = getRequest().getParameterMap();
		String where = " where 1=1 ";
		Set<String> keys = paramMap.keySet();
		 for (String string : keys) {
			if(!"page".equalsIgnoreCase(string)){
				if("ddate".equalsIgnoreCase(string)){//日期（仅仅一个日期）
					where += " and ddate between to_date('"+paramMap.get(string)[0]+"','yyyy-mm-dd') and to_date('" 
							+ paramMap.get(string)[0] + "','yyyy-mm-dd')+1 ";
				}else{
					where += " and " + string + "='" +paramMap.get(string)[0] + "'";
				}			
			}
				
			
		}
		return where;
	}
	
	//返回数据表名
	public String switchOnTimeTableByName(String tableName){
		String tableTime = "";
		Object ob = getRequest().getSession().getAttribute(CHOOSE_TABLE_TIME);
		if(ob != null && org.apache.commons.lang3.StringUtils.isNotBlank(ob.toString()))
			tableTime = ob.toString();
		String resultName = tableName + tableTime;
		return resultName;
	}
}
