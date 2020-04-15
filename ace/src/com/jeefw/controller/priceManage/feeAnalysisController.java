package com.jeefw.controller.priceManage;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
//退补费分析
@Controller
@RequestMapping("/priceMange/feeAnalysis")
public class feeAnalysisController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	@RequestMapping(value = "/getfeedata")
	public void getfeedata(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String areaguid=request.getParameter("areaguid");
		//小区最近三个供暖季数据
		String sqlstr = "select * from(select 1 as 序号,a.years as 年份,count(*) as 户数1,sum(BZ) as 面积1,sum(jlje) as 应收费金额1,sum(jlrl) as 总热量1,abs(sum(yjfse)-sum(sjfse)) as 退补费金额1,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热1,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标1 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2013-2014' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl>b.pjrl group by a.years)m, "
                      +" (select count(*) as 户数2,sum(BZ) as 面积2,sum(jlje) as 应收费金额2,sum(jlrl) as 总热量2,abs(sum(yjfse)-sum(sjfse)) as 退补费金额2,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热2,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标2 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2013-2014' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl<b.pjrl"
                      +" group by a.years )n union all "
                      +" select * from(select 2 as 序号,a.years as 年份,count(*) as 户数1,sum(BZ) as 面积1,sum(jlje) as 应收费金额1,sum(jlrl) as 总热量1,abs(sum(yjfse)-sum(sjfse)) as 退补费金额1,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热1,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标1 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2014-2015' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl>b.pjrl group by a.years)m, "
                      +" (select count(*) as 户数2,sum(BZ) as 面积2,sum(jlje) as 应收费金额2,sum(jlrl) as 总热量2,abs(sum(yjfse)-sum(sjfse)) as 退补费金额2,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热2,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标2 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2014-2015' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl<b.pjrl"
                      +" group by a.years )n union all "
                      +" select * from(select 3 as 序号,a.years as 年份,count(*) as 户数1,sum(BZ) as 面积1,sum(jlje) as 应收费金额1,sum(jlrl) as 总热量1,abs(sum(yjfse)-sum(sjfse)) as 退补费金额1,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热1,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标1 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2015-2016' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl>b.pjrl group by a.years)m, "
                      +" (select count(*) as 户数2,sum(BZ) as 面积2,sum(jlje) as 应收费金额2,sum(jlrl) as 总热量2,abs(sum(yjfse)-sum(sjfse)) as 退补费金额2,"
                      +" Round(((sum(jlrl)/1000)*3.6)/(case when sum(BZ)=0 then 1 else sum(BZ) end),2) as 耗热2,Round(sum(jlrl)/((case when sum(BZ)=0 then 1 else sum(BZ) end)*3.6),2) as 耗热指标2 from tshoufei a,( "
                      +" select areaguid,years,round(avg(jlrl),2) as pjrl from tshoufei where  years='2015-2016' group by areaguid,years)b "
                      +" where a.areaguid=b.areaguid and a.areaguid="+areaguid+" and a.years=b.years and a.jlrl<b.pjrl"
                      +" group by a.years )n ";
		List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
		writeJSON(response, list);
	}
}
