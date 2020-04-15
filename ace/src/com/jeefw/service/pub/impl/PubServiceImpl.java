package com.jeefw.service.pub.impl;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.IBaseService;
import com.jeefw.service.pub.PubService;

import core.dbSource.DataSource;
import core.util.MathUtils;
import core.util.RequestObj;
@Service
public class PubServiceImpl implements PubService{
	private Map<String, String[]> paramMap = new HashMap<String, String[]>();

	public static final String headsql = "select a.AREAGUID,a.areacode,a.areaname,a.smemo,a.TELEPHONE,a.AREAPLACE,a.LINKMAN,a.IMAGEMAP,a.IMAGEMAP2"
			+"\n ,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
			+"\n ,tb.buildno,tb.buildcode,tb.buildname,tb.totalfloor,tb.totalunit "
			+"\n ,td.doorno,td.doorname,td.floorno,td.unitno "
			//+"\n ,tc.clientno,tc.clientname,tc.ISYESTR,tc.hotarea "
			+"\n from Tarea a "
			+"\n left join FACTORYSECTIONINFO b "
			+"\n\t on a.FACTORYNO = b.sectionid"
			+"\n left join ENERGYFACTORY c "
			+"\n\t on c.FACTORYID = b.FACTORYID "
			 
			+"\n left join TBuild tb "
			+"\n\t on tb.areaguid = a.areaguid "
			+"\n left join TDoor td "
			+"\n\t on td.buildno = tb.buildno "
			//+"\n inner join tdoor_meter d_m "
			//+"\n\t on d_m.doorno = d_m.doorno and d_m.areaguid = a.areaguid"
			//+"\n left join TCLIENT tc "
			//+"\n\t on tc.clientno = d_m.clientno  "
			;
	
	public static final String headsql_buckup = "\n select a.AREAGUID,a.areacode,a.areaname,a.smemo,a.TELEPHONE,a.AREAPLACE,a.LINKMAN,a.IMAGEMAP,a.IMAGEMAP2"
					+ "\n ,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
					+"\n ,tb.buildno,tb.buildcode,tb.buildname,tb.totalfloor,tb.totalunit "
					+"\n ,td.doorno,td.doorname,td.floorno,td.unitno "
					+"\n ,tc.clientno,tc.clientname,tc.ISYESTR,tc.hotarea,tc.meterid "
					
					//+" ,tmm.PROMETERID,tmm.PRODUSHU,tmm.METERID as TMODIFYMETER_METERID , tmm.DISHU, tmm.ddate as TMODIFYMETER_ddate,tmm.USERNAME"
					
					/*+" ,tm.pooladdr,tm.mbusid,tm.devicetype,tm.devicestatus "
					+" ,tm.meternllj,tm.metertj,tm.meterls,tm.metergl,tm.meterjswd,tm.meterhswd,tm.MeterNLLJGJ,tm.meterwc "
					+" ,tm.CountHour,tm.MeterSJ,tm.ddate,tm.autoid,tm.SysStatus "*/
					
					+"\n from ENERGYFACTORY c "
					+"\n left join FACTORYSECTIONINFO b "
					+"\n on c.FACTORYID = b.FACTORYID "
					+"\n left join Tarea a "
					+"\n on a.FACTORYNO = b.sectionid" 
					
					+"\n left join TBuild tb "
					+"\n on tb.areaguid = a.areaguid "
					+"\n left join TDoor td "
					+"\n on td.buildno = tb.buildno "
					+"\n left join TCLIENT tc "
					+"\n on tc.doorno = td.doorno "
					
					/*+" left join TModifyMeter tmm "
					+" on tmm.clientno = tc.clientno"*/
					
					/*+" left join tmeter tm "
					+" on tm.meterid = tc.meterid"*/;
	
	    //以下根据现有视图逻辑自己尝试联接所有表
		public static final String headsqltest = "select a.AREAGUID,a.areacode,a.areaname,a.TELEPHONE,a.AREAPLACE,a.LINKMAN,a.IMAGEMAP,a.IMAGEMAP2"
						+ ",b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
						+" ,tb.buildno,tb.buildcode,tb.buildname,tb.totalfloor,tb.totalunit "
						+" ,td.doorno,td.doorname,td.floorno,td.unitno "
						+" ,tc.clientno,tc.clientname,tc.ISYESTR,tc.hotarea,tc.meterid "
						
						+" ,t_m.meterno as TDoor_Meter_meterno"
						+" ,tmm.PROMETERID,tmm.PRODUSHU,tmm.METERID as TMODIFYMETER_METERID , tmm.DISHU, tmm.ddate as TMODIFYMETER_ddate,tmm.USERNAME"
						
						+" ,tm.pooladdr,tm.mbusid,tm.devicetype,tm.devicestatus "
						+" ,tm.meternllj,tm.metertj,tm.meterls,tm.metergl,tm.meterjswd,tm.meterhswd,tm.MeterNLLJGJ,tm.meterwc "
						+" ,tm.CountHour,tm.MeterSJ,tm.ddate,tm.autoid,tm.SysStatus "
						
						+" from ENERGYFACTORY c "
						+" left join FACTORYSECTIONINFO b "
						+" on c.FACTORYID = b.FACTORYID "
						+" left join Tarea a "
						+" on a.FACTORYNO = b.sectionid" 
						
						+" left join TBuild tb "
						+" on tb.areaguid = a.areaguid "
						
						+" left join TDoor td "
						+" on td.buildno = tb.buildno "
						+" left join TCLIENT tc "
						+" on tc.doorno = td.doorno "
						
						+" inner join TDoor_Meter t_m "
						//+" on t_m.ClientNo=tc.ClientNo and t_m.areaguid = a.areaguid"  //本来应该是用这个的，但是数据有问题先用下面那个吧
						+" on t_m.ClientNo=tc.ClientNo"
						+" left join TModifyMeter tmm"
						+" on tmm.clientno = tc.clientno"
						
						+" left join tmeter tm "
						+" on tm.meterid = tc.meterid";
		
		public static final String headsqltest2 = "select a.AREAGUID,a.areacode,a.areaname,a.TELEPHONE,a.AREAPLACE,a.LINKMAN,a.IMAGEMAP,a.IMAGEMAP2"
				+ ",b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
				+" ,tb.buildno,tb.buildcode,tb.buildname,tb.totalfloor,tb.totalunit "
				+" ,td.doorno,td.doorname,td.floorno,td.unitno "
				+" ,tc.clientno,tc.clientname,tc.ISYESTR,tc.hotarea,tc.meterid "
				
				+" ,t_m.meterno as TDoor_Meter_meterno"
				+" ,tmm.PROMETERID,tmm.PRODUSHU,tmm.METERID as TMODIFYMETER_METERID , tmm.DISHU, tmm.ddate as TMODIFYMETER_ddate,tmm.USERNAME"
				
				+" ,tm.pooladdr,tm.mbusid,tm.devicetype,tm.devicestatus "
				+" ,tm.meternllj,tm.metertj,tm.meterls,tm.metergl,tm.meterjswd,tm.meterhswd,tm.MeterNLLJGJ,tm.meterwc "
				+" ,tm.CountHour,tm.MeterSJ,tm.ddate,tm.autoid,tm.SysStatus "
				
				
				+ ",add_td.devicetypechildno"
				
				+" from ENERGYFACTORY c "
				+" left join FACTORYSECTIONINFO b "
				+" on c.FACTORYID = b.FACTORYID "
				+" left join Tarea a "
				+" on a.FACTORYNO = b.sectionid" 
				
				+" left join TBuild tb "
				+" on tb.areaguid = a.areaguid "
				
				+" left join TDoor td "
				+" on td.buildno = tb.buildno "
				+" left join TCLIENT tc "
				+" on tc.doorno = td.doorno "
				
				+" inner join TDoor_Meter t_m "
				//+" on t_m.ClientNo=tc.ClientNo and t_m.areaguid = a.areaguid"  //本来应该是用这个的，但是数据有问题先用下面那个吧
				+" on t_m.ClientNo=tc.ClientNo"
				+" left join TModifyMeter tmm"
				+" on tmm.clientno = tc.clientno"
				
				+" left join tmeter tm "
				+" on tm.meterid = tc.meterid"
				
				
				
				
				+ " left join tdevice add_td on add_td.meterno=t_m.meterno "
				+ " left join tdevicechildtype add_tct on add_tct.devicechildtypeno = add_td.devicetypechildno ";
		//获取抄表数据语句
		public static final String tmeterdata ="select vareainfo.AREANAME,vareainfo.clientno,vareainfo.buildno,vareainfo.BName,vareainfo.UNITNO,vareainfo.FLOORNO,vareainfo.DOORNO,vareainfo.DOORNAME,tmeter.AREAGUID,tmeter.POOLADDR,tmeter.MBUSID,"
	                                 +"tmeter.METERID,vareainfo.METERTYPE as DEVICETYPE,devicetypechildno ,tmeter.DEVICESTATUS,tmeter.METERNLLJ,tmeter.METERTJ,tmeter.METERLS,tmeter.METERGL,tmeter.METERJSWD,"
				                     +"tmeter.METERHSWD,tmeter.METERWC,tmeter.COUNTHOUR,tmeter.METERSJ,tmeter.DDATE,tmeter.AUTOID,tmeter.REMARK,tmeter.METERFM,tmeter.SYSSTATUS,tmeter.METERNLLJGJ, vareainfo.buildname||'栋'||vareainfo.unitno||'单元'||floorno||'层'||vareainfo.doorname||'号' as address,"
	                                 +"  case when TSYSSTATUS.MSNAME is null then '正常' else TSYSSTATUS.MSNAME end as MSNAME ,tdevice.customid, TDEVICECHILDTYPE.DEVICECHILDTYPENAME,tclient.isyesjl,case when tclient.isyesjl=0 then '未签约' else '已签约' end as sfqy,tclient.isyestr,case when tclient.isyestr=0 then '未停热'  when tclient.isyestr=1 then '已停热' when tclient.isyestr=2 then '拆网' when tclient.isyestr=3 then '部分停供' else '部分拆网' end as sftr,"
				                     +" tclient.sfjf,tclient.hotarea  from vareainfo left join tclient on vareainfo.AREAGUID=tclient.areaguid and vareainfo.CLIENTNO=tclient.clientno left  join tmeter on tmeter.areaguid=vareainfo.areaguid and tmeter.meterid=vareainfo.METERNO left join tdevice on tdevice.meterno=vareainfo.meterno and "
	                                 +" tdevice.areaguid=vareainfo.areaguid left join TSYSSTATUS on tmeter.sysstatus=TSYSSTATUS.MSID   and TSYSSTATUS.METERTYPE=tdevice.devicetypechildno left join TDEVICECHILDTYPE on TDEVICECHILDTYPE.DEVICECHILDTYPENO=tdevice.devicetypechildno ";
	@Resource
	private IBaseDao baseDao;
	@Resource
	private IBaseService baseSrv;
		
	public List queryList(String sql){
		//List<Map> maplist = baseDao.listsqlp.
		return null;
	}

	@Override
	public List getArea(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select distinct areaguid,areaname,AREACODE,AREAPLACE,LINKMAN,TELEPHONE,IMAGEMAP,IMAGEMAP2,  " //SMEMO
				+ " SECTIONNAME,FACTORYNAME "
				+ " from ("+ headsql + ")" + getSqlWhere() +" and areaguid is not null order by nlssort(areaname,'NLS_SORT=SCHINESE_PINYIN_M')";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	@Override
	public List getBuild(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select distinct buildname,buildno,buildcode,totalfloor,totalunit from ("+ headsql + ")" + getSqlWhere() + " and buildname is not null order by Length(BUILDCODE),BUILDCODE";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	@Override
	public List getUnitNO(Map<String, String[]> paramMap) {
		 
		this.paramMap = paramMap;
		String sql = "select distinct unitno ,unitno as ucode  from ("+ headsql + ")" + getSqlWhere() + " and unitno is not null order by unitno " ;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}
	
	//因为表数据问题，目前仅支持今日数据查询与历史数据查询模块
	private String getSqlWhere(){
		String where = "  where  1 = 1";
		if(paramMap == null)
			return where;
		Set<String> keys = paramMap.keySet();
		 for (String string : keys) {
			 if("UCODE".equals(string)){//今日
				 where += " and unitno = '" + paramMap.get(string)[0] + "' ";
			 }else if("FCODE".equals(string)){//今日
				 where += " and DOORNO = '" + paramMap.get(string)[0] + "' ";
			 }else{//历史
				 where += " and " + string + "='" +paramMap.get(string)[0] + "'";
			 }
			
		}
		 System.out.println(where);
		return where;
	}

	@Override
	public List getFloorNo(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select distinct floorno   from ("+ headsql + ")" + getSqlWhere() + " order by floorno " ;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	
	@Override
	public List getDoorNo(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select distinct DOORNO,DOORNAME as fcode   from ("+ headsql + ")" + getSqlWhere() + " order by DOORNAME " ;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}
	
	@Override
	public List getRemainInfo(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select * from ("+ headsqltest + ")" + getSqlWhere() ;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	@Override
	public Map<String, Object> getClientByClientId(int clientId) {
		String sql = "select * from TClient where CLIENTID=" + clientId;
		List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		if(list.size()>0)
			return (Map<String, Object>) list.get(0);
		return null;
	}

	@Override
	public String getClientNoByClientId(int clientId) {
		String sql = "select CLIENTNO from TClient where CLIENTID=" + clientId;
		List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		if(list.size()>0)
			return (String)list.get(0).get("CLIENTNO");
		return "";
	}
	/**
	 * 检查clietnNO是否重复
	 * @param 	clientNo
	 * @return  true表示重复了
	 */
	public boolean checkClientNo(String clientNo){
		String sql = "select count(1) as count from tclient where clientNO="+clientNo;
		List list = baseDao.findBySqlList(sql, null);
		BigDecimal count = (BigDecimal)list.get(0);
		BigDecimal zero = new BigDecimal(0);
		if(count.equals(zero))//查到0记录
			return false;
		System.out.println("已存在此clientno");
		return true;
	}

	@Transactional
	public boolean executeBatchSql(String... strings) {
		boolean flag = true;
		for (String string : strings) {
			flag = flag&&baseDao.execuSql(string, null);
		}
		return flag;
	}
	@Override
	 public List getFactory(Map<String, String[]> paramMap){
			this.paramMap = paramMap;
			String sql = "select FACTORYID,FACTORYNAME   from ENERGYFACTORY  order by FACTORYID " ;
			List list = baseDao.listSqlAndChangeToMap(sql, null);
			return list; 
	 }
	@Override
	 public List getSection(String factoryid){
			String sql = "select SECTIONID,SECTIONNAME   from FACTORYSECTIONINFO where FACTORYID='"+factoryid+"' order by SECTIONID " ;
			List list = baseDao.listSqlAndChangeToMap(sql, null);
			return list; 
	 }

	@Override
	public Map<String, Object> getMaxFloorAndUnitAndMaxDoor(String buildno) {
		String sql = "select max(d.floorno) as max_floorno,d.unitno,max(substr(regexp_replace(d.doorname,'\\D',''),-2)) as max_door "
					+" from tdoor d "
					+" where d.buildno = " + buildno
					+" group by d.unitno";
		List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> unitArray = new ArrayList<Map<String, Object>>();
		int maxFloor = 0;
		for (int i = 0; i < list.size(); i++) {
			Map obj = list.get(i);
			maxFloor = maxFloor>MathUtils.getBigDecimal(obj.get("MAX_FLOORNO")).intValue() ? maxFloor : MathUtils.getBigDecimal(obj.get("MAX_FLOORNO")).intValue();
			Map<String, Object> unitInofMap = new HashMap<String, Object>();
			unitInofMap.put("UNITNO", MathUtils.getBigDecimal(obj.get("UNITNO")).intValue());
			unitInofMap.put("MAXDOOR", MathUtils.getBigDecimal(obj.get("MAX_DOOR")).intValue());
			unitArray.add(unitInofMap);
		}
		map.put("maxFloor", maxFloor);
		map.put("unitInfo", unitArray);
		
		return map;
	}

	@Override
	public String getAreanameById(String id) {
		List obj = baseDao.findBySql("select areaname from tarea where areaguid="+id);
		if(obj.size()<1)
			return null;
		if(obj.size()>1){
			String[] strs = (String[])obj.get(0);
			return strs[0];
		}
	
		return (String)obj.get(0);
	} 
	public boolean adduserlog(String username,String oper,String bz) throws UnknownHostException{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String sql="insert into tlog values('"+username+"','"+oper+",IP为："+InetAddress.getLocalHost().getHostAddress()+"',to_date('"+df.format(new Date())+"','yyyy-MM-dd HH24:mi:ss'),'"+bz+"','操作')";
   	    boolean flag=baseDao.execuSql(sql, null);
   	    return flag;
	}

	@Override
	public List getChangeMeter(Map<String, String[]> paramMap) {
		this.paramMap = paramMap;
		String sql = "select *from(select a.CLIENTNO,a.METERNO as TDOOR_METER_METERNO, METERNLLJ as PRODUSHU,devicetypechildno from (select * from vareainfo "+getSqlWhere()+") a "
				+ "left join (select* from(select * from "+RequestObj.switchOnTimeTableByName("VALLAREAINFOFAILURE")+" "+getSqlWhere()+" order by ddate desc) where rownum=1 )b  on a.AREAGUID=b.AREAGUID and a.METERNO=b.METERID )" ;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	@Override
	public void switchDBText() {
		String tsql = "select * from tarea";
		List listSqlAndChangeToMap = baseDao.listSqlAndChangeToMap(tsql, null);
		Gson gson = new Gson();
		String json = gson.toJson(listSqlAndChangeToMap);
		System.out.println("=============================================");
		System.out.println(json);
	}

	@Override
	public List getHeatingStation(String factoryid) {
		String sql = "select distinct b.SECTIONID,b.SECTIONNAME from (" + PubServiceImpl.headsql 
				+ ")b where b.FACTORYID = " + factoryid;
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;
	}

	@Override
	public boolean compare(String v1, String v2) {
		  // v1不为空时：返回v1.equals(v2)
		  // v1为空时：A：v2不为空：返回v2.equals(v1)
		  //        B: 表示v1、v2都为null时，返回true
		   if("null".equals(v2)){
			   v2="";
		   }
		  return  v1!=null ? v1.equals(v2) : (v2 != null ? v2.equals(v1) : true);

	}


}
