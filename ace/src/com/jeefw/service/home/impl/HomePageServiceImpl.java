package com.jeefw.service.home.impl;

import com.jeefw.dao.IBaseDao;
import com.jeefw.service.home.HomePageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class HomePageServiceImpl implements HomePageService {
	@Resource
	private IBaseDao baseDao;

	@Override
	public List listAreaUseEnergy() {
		Calendar now = Calendar.getInstance(); 
		Date d = new Date();  
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		now.setTime(d);
		String dates="";
		String datee="";
	    if((now.get(Calendar.MONTH) + 1)>=11 || (now.get(Calendar.MONTH) + 1)<4){
	    	dates=now.get(Calendar.YEAR)-1+"-11-01";  //20180108 年份-1
	    	now.set(Calendar.DATE, now.get(Calendar.DATE) - 1);
	    //	datee=sdf.format(now.getTime());  //20180110
	    	datee=baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') as day from tmeter_day").get(0).toString();
			
	    }else{
	    	dates=now.get(Calendar.YEAR)-1+"-11-01";
	    	datee=now.get(Calendar.YEAR)+"-04-30";//2018330-->04-30
	    }
	    String gSql="select a.areaguid,a.areaguidname as  \"name\", case when (re1-re2)<0 then 0 else Round(re1-re2,2) end as \"y\" from"
	    		   +" (select areaguid,areaguidname,sum(reliang) as re2 from tmeter_day where to_char(ddate,'yyyy-MM-dd') ='"+dates+"' group by areaguid,areaguidname )a , "
	               +" (select areaguid,areaguidname,sum(reliang) as re1 from tmeter_day where to_char(ddate,'yyyy-MM-dd') ='"+datee+"' group by areaguid,areaguidname )b  where  a.areaguid=b.areaguid  order by  re1-re2 desc";
		List list = baseDao.listSqlAndChangeToMap(gSql, null);
		return list;

	}
	
	@Override
	public List areaUseEnergyForDay() { 
		String sql = "select m.areaguid,m.areaguidname as areaname,count(m.customerid) as customer,nvl(sum(m.area),0) as area,to_char(m.ddate,'yyyy-MM-dd') as ddate,round(sum(m.reliang),2) as area_energy"
				+ " from tmeter_day m"
				+ " where m.ddate  = (select max(ddate) from tmeter_day)"
				+ " group by m.areaguid,m.areaguidname,m.ddate"
				+ " order by area_energy desc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		return list;

	}

	@Override
	public List inOutWarterByDay() {
		
		String day= baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') as day from tmeter_tmp").get(0).toString();
		String sql = "select '"+day+"' as day,Round(avg(TM.MeterJSWD),2)as 平均进水温度,Round(avg(TM.MeterHSWD),2)as 平均回水温度,Round(avg(TM.MeterWC),2)as 平均温差 , TM.AreaGuid as 小区编号 "
					+" ,(select areaname from tarea where areaguid = tm.areaguid) as 小区名,count(tc.clientno) as 住户数,sum(tc.hotarea) as 供热面积,c.factoryname as 能源公司,b.sectionname 换热站"
					+" from tmeter_tmp TM "
					+" inner join TDoor_Meter tdm "
					+" on tdm.MeterNo = tm.MeterID and tdm.AreaGuid = tm.AreaGuid "
					+" inner join TArea Ta "
					+" on Ta.AreaGuid = TM.AreaGuid "
					+" inner join tclient tc "
					+" on tc.areaguid = tdm.areaguid and tc.clientno = tdm.clientno "
					+" left join FACTORYSECTIONINFO b "
					+" on ta.FACTORYNO = b.sectionid "
					+" left join ENERGYFACTORY c "
					+" on c.FACTORYID = b.FACTORYID "
					+" where to_char(tm.ddate,'YYYY-MM-DD')='" + day + "' "
					+" and tm.autoid=1 and tm.MeterJSWD<100 and tm.sysstatus<>'1'" //20171225 添加and tm.sysstatus<>1
					+" group by tm.areaguid,c.factoryname,b.sectionname";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		
		return list;
	}
	
}
