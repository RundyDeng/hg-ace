package com.jeefw.controller.warningmanage;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.Warringsparmset;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.warningmanage.SetFaultParamForWarnService;

import core.support.JqGridPageView;

@Controller
@RequestMapping("/warningmanage/searchfaultparamwarncontr")
public class SearchFaultParamWarnController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSvr;
	@RequestMapping("/getsearchfaultpara")
	public void getsSearchFaultPara(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String warnPara = getParm("warnpara");//METERGL瞬时流量   MeterJSWD  MeterJSWD  MeterJSWD
		String sqlWhereL = "";
		if("METERGL".equalsIgnoreCase(warnPara)) sqlWhereL = "and (a. METERls>c.METERSSLLMAX or a. METERls<c.METERSSLLMIN)";
		if("MeterJSWD".equalsIgnoreCase(warnPara)) sqlWhereL = "and (a.MeterJSWD>c.JSWDMAX or a.MeterJSWD<c.JSWDMIN)";
		if("MeterHSWD".equalsIgnoreCase(warnPara)) sqlWhereL = "and (a.MeterHSWD>c.HSWDMAX or a.MeterHSWD<c.HSWDMIN)";
		if("MeterWC".equalsIgnoreCase(warnPara)) sqlWhereL = "and (a.MeterWC>c.WCMAX or  a.MeterWC<c.wcmin)";
		String sql = "select b.areaname as 小区名称,concat(concat(concat(b.Buildname,'-'),concat(b.unitno,'-')),b.doorname) as 门牌 , "
					+" Round(a.meternllj,2) as 累计热量,Round(a.metergl,2)as 瞬时热量, Round(a.METERTJ,2) as 累计流量,Round(a.METERls,2) as 瞬时流量, "
					+" Round(a.METERJSWD,2) as 供水温度， Round(a.METERHSWD,2) as 回水温度,Round(a.MeterWC,2) as 温差,to_char(a.Ddate,'YYYY-MM-DD') as 抄表时间 "
					+" from tmeter a ,vareainfo b,warringsparmset c "
					+" where to_char(DDate,'YYYY-MM-DD')='" + getParm("date") + "' and b.areaguid='" + getParm("areaguid") + "'"
					+" and a.meterid=b.meterno and a.areaguid=b.areaguid " + sqlWhereL  + " order by b.CLIENTNO";
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		JqGridPageView jqgridView = new JqGridPageView();
		jqgridView.setRows(list);
		jqgridView.setCurrentPage(getCurrentPage());
		jqgridView.setMaxResults(getShowRows());
		jqgridView.setRecords(baseDao.countSql(sql));
		writeJSON(response, jqgridView);
	}
	
	@RequestMapping("/getsearchfaultdeviceorenergy")
	public void getsSearchFaultDeviceOrEnergy(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String warnType = getParm("warntype");
		String areaguid = getParm("areaguid");
		String areaName = pubSvr.getAreanameById(areaguid);
		String date = getParm("date");
		String sql = "";
		if("2".equals(warnType)){
			//采集设备异常报警
			sql = "select m.areaname as 小区名称,m.buildname as 楼栋名称,m.pooladdr as 设备号码 "
				+" from ( "
				+" select distinct e.areaname,d.buildname,c.pooladdr,c.poolno "
				+" from ( "
				+" select areaguid, pooladdr,poolno "
				+" from tpool "
				+" where poolno not in( "
				+" select distinct b.poolno "
				+" from tmeter a,tpool b "
				+" where to_char(a.DDate,'YYYY-MM-DD')='"+date+"'and a.areaguid=b.areaguid "
				+" ) "
				+" order by poolno "
				+" )c, "
				+" ( "
				+" select distinct a.areaguid,a.poolno,d.buildname "
				+" from tdevice a "
				+" inner join tdoor_meter b "
				+" on a.Meterno=b.meterno and a.areaguid=b.areaguid "
				+" inner join tdoor c "
				+" on c.doorno=b.doorno "
				+" inner join tbuild d "
				+" on d.areaguid=a.areaguid and d.buildno=c.Buildno "
				+" ) d, "
				+" tarea e "
				+" where c.poolno=d.POOLNO and c.areaguid=e.areaguid "
				+" )m where m.AREANAME='"+areaName+"' ";
		}else{
			//非法用热异常报警
//			sql = "select d.*,m.metergl as 瞬时流量,m.ddate as 抄表时间 "
//				+" from ( "
//				+" select b.areaname as 小区名称,c.buildname as 楼栋名称,a.unitno as 单元号码,a.doorno "
//				+" ,a.doorname as 房间号码,a.isyestr as 是否停热,a.clientname as 户主姓名,a.mobphone as 联系电话 "
//				+" from tclient a "
//				+" inner join tarea b "
//				+" on a.areaguid=b.areaguid "
//				+" inner join tbuild c "
//				+" on c.buildno=a.buildno "
//				+" )d "
//				+" inner join tdoor_meter e "
//				+" on e.doorno=d.doorno "
//				+" inner join tmeter m "
//				+" on m.meterid=e.meterno "
//				+" where m.metergl>0 and d.是否停热!=1 "  //停热
//				//+" and to_char(m.DDate,'YYYY-MM-DD')='"+date+"' "
//				+ " and to_char(m.DDate,'YYYY-MM-DD')= '2017-10-02' "
//				+" and d.小区名称='"+areaName+"'";
			sql="select a.areaname as 小区名称,a.bname||'-'||a.unitno||'-'||a.doorname as 门牌,b.pooladdr as 集中器地址,b.mbusid as 通道号,b.meterid as 表号, case when c.isyestr=1 then '已停热' else '未停热' end as 是否停热,round(b.metergl,2) as 瞬时热量,round(b.meternllj,2) as 累计热量,round(b.meterls,2) as 瞬时流量,round(b.metertj,2) as 累计流量 ,to_char(b.ddate,'yyyy-MM-dd') as 抄表时间  from vareainfo a inner join tmeter b on a.AREAGUID=b.areaguid "
					+ "and a.meterno=b.meterid left join tclient c on c.areaguid=a.AREAGUID and a.CLIENTNO=c.clientno "
					+ " where a.areaguid="+areaguid+" and c.isyestr=1 and b.meterls>0.01 and b.ddate between to_date('"+date+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')"
					+ " and to_date('"+date+" 23:59:59','yyyy-MM-dd HH24:Mi:ss')";
		}
		
		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		JqGridPageView jqgridView = new JqGridPageView();
		jqgridView.setRows(list);
		jqgridView.setCurrentPage(getCurrentPage());
		jqgridView.setMaxResults(getShowRows());
		jqgridView.setRecords(baseDao.countSql(sql));
		writeJSON(response, jqgridView);
	}

}
