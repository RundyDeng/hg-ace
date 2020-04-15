package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/dataanalysis/builddatastatiscontr")
public class BuildDataStatisController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getbuilddatastatis")
	public void getBuildDataStatis(HttpServletRequest request,HttpServletResponse response) throws IOException, ParseException{
		String areaguid = getParm("areaguid");
		String startDate = getParm("startdate");
		String endDate = getParm("enddate");
//		String sql = "select sum(each_client_totle.eachtotal) as build_energy,each_client_totle.buildname "
//					+"\n ,each_client_totle.buildno,count(each_client_totle.clientno) as client_totle "
//					+"\n ,sum(each_client_totle.hotarea) as build_area "
//					+"\n ,case sum(each_client_totle.hotarea) when 0 then -1 else sum(each_client_totle.eachtotal)/sum(each_client_totle.hotarea) end as build_average_enerty "
//					+"\n from "
//					+"\n ( "
//					+"\n select max(m.MeterNLLJ)-min(m.MeterNLLJ) as eachtotal,m.meterid,b.buildno,b.buildname,c.clientno,c.hotarea "
//					+"\n from tbuild b "
//					+"\n inner join tdoor d "
//					+"\n on b.buildno = d.buildno "
//					+"\n inner join tdoor_meter d_m "
//					+"\n on d_m.doorno = d.doorno "
//					+"\n inner join tclient c "
//					+"\n on c.clientno = d_m.clientno "
//					+"\n inner join tmeter m "
//					+"\n on m.meterid = d_m.meterno "
//					+"\n where b.areaguid = "+areaguid+" and c.areaguid = "+areaguid+" and m.areaguid = "+areaguid+" and d_m.areaguid = "+areaguid
//					+"\n and m.ddate between to_date('"+startDate+"','yyyy-MM-dd') and to_date('"+endDate+"','yyyy-MM-dd')+1 and m.autoid=1"
//					+"\n group by b.buildno,b.buildname,m.meterid,c.clientno,c.hotarea "
//					+"\n ) each_client_totle "
//					+"\n group by each_client_totle.buildno,each_client_totle.buildname "
//					+"\n order by regexp_substr(each_client_totle.buildname,'\\D',1,1,'i'),to_number(regexp_replace(each_client_totle.buildname,'\\D','')) ";
		/*String sql="select a.areaguid,a.buildno,a.bname as buildname,a.CLIENTNO as client_totle,b.reliang as build_energy,a.area,round(b.reliang/(case when a.area=0 then 1 else a.area end),2) as build_average_enerty from(select AREAGUID,BUILDNO,BName,count(CLIENTNO) as CLIENTNO,sum(hotarea) as area from vclientinfo where "
				+ "areaguid="+areaguid+" group by  AREAGUID,BUILDNO,BName) a left join (select areaguid,buildno,sum(reliang) as reliang from tmeter_day where AREAGUID="+areaguid+" and"
				+ " ddate between to_date('"+startDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') and  to_date('"+endDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss')group by areaguid,buildno )b"
				+ " on a.AREAGUID=b.areaguid and a.buildno=b.buildno  order by to_number(REGEXP_REPLACE (a.bname,  '[^0-9]+',  '')) asc";*/
		String sql = "select a.areaguid,a.buildno,case when (instr(a.bname,'栋')>0) then a.bname else (a.bname||'栋') end as buildname,a.CLIENTNO as client_totle, "
					+" b.reliang as build_energy,a.area,round(b.reliang/(case when a.area=0 then 1 else a.area end),2) as build_average_enerty "
					+" from( "
					+" select AREAGUID,BUILDNO,BName,count(CLIENTNO) as CLIENTNO,sum(hotarea) as area "
					+" from vclientinfo "
					+" where areaguid="+areaguid+" and buildno is not null "
					+" group by AREAGUID,BUILDNO,BName "
					+" ) a "
					+" left join "
					+" ( "
					+" select areaguid,buildno,sum(reliang) as reliang "
					+" from tmeter_day "
					+" where AREAGUID="+areaguid+" and ddate "
					+" between to_date('"+startDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') "
					+" and to_date('"+endDate+" 00:00:00','yyyy-MM-dd HH24:Mi:ss') "
					+" group by areaguid,buildno "
					+" ) b "
					+" on a.AREAGUID=b.areaguid and a.buildno=b.buildno "
					+"order by to_number(REGEXP_REPLACE (a.bname, '[^0-9]+', '')) asc";
		printRequestParam();
		List list = baseDao.listSqlAndChangeToMap(sql, null);
	 	writeJSON(response, list);
	}
}





