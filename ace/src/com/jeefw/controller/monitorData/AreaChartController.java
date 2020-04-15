package com.jeefw.controller.monitorData;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

import core.util.MathUtils;

@RestController
@RequestMapping("/monitorData/areachartcontr")
public class AreaChartController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
	
	@RequestMapping("/getAreaChart")
	public void getAreaChart(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar flagCal = Calendar.getInstance();
		flagCal.add(Calendar.DAY_OF_MONTH, -3);
		Calendar cal = Calendar.getInstance();
		
		String sql = "SELECT cast(substr(ddate,1,10) as date) as dtime,sum(" + getParm("filedName") + ") as pars";
		String beginDate = getParm("beginDate");
		String endDate = getParm("endDate");
		/*Date begin = sdf.parse(beginDate);
		Date end = sdf.parse(endDate);*/
		if(flagCal.before(sdf.parse(beginDate))&&flagCal.before(sdf.parse(endDate))){
			sql += " from tmeter_tmp where 1=1";
		}else{
			sql += " from "+switchOnTimeTableByName("tmeter")+" where 1=1"
				+ " and ddate between TO_DATE('" + getParm("beginDate") + "','yyyy-MM-dd')" + " and TO_DATE('"
				+ getParm("endDate") + "','yyyy-MM-dd')+1";
		}
		
		sql +=  " and areaguid = " + getParm("areaguid") 
			+ " group by substr(ddate,1,10) "
			+ " order by cast(substr(ddate,1,10) as date) ";
				
		List list = baseDao.findBySqlList(sql, null);
		String str = "";
		double sum = 0;
		double previous = 0;
		for (int i = 0; i < list.size(); i++) {
			str += "\n";
			Object[] obj = (Object[]) list.get(i);
			if(StringUtils.isBlank(obj[1].toString()))
				continue;
			
			double no = MathUtils.getBigDecimal(obj[1].toString()).doubleValue();
			if(previous>no && i!=0){
				str += obj[0].toString() + "," + previous;
			}else{
				str += obj[0].toString() + "," + obj[1].toString();
				previous = Double.valueOf(obj[1].toString());
			}
		}
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().write(str);
	}
}
