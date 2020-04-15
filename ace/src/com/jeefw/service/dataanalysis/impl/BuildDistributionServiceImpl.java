package com.jeefw.service.dataanalysis.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.IBaseDao;
import com.jeefw.service.dataanalysis.BuildDistributionService;

import core.util.RequestObj;

@Service
public class BuildDistributionServiceImpl implements BuildDistributionService{
	@Resource
	private IBaseDao baseDao;
	
	public List<Map> getBuildDistribution(String areaguid,String buildno){
		String near = baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') from "+RequestObj.switchOnTimeTableByName("tmeter")+" where areaguid = "+areaguid).get(0).toString();
		String sql = "select d.doorno,d.doorname,d.unitno,d.floorno,c.clientno,c.clientname,c.isyestr,c.hotarea,m.meterid,m.MeterNLLJ,m.metertj "
				+",'"+near+"' as newest "
				+" from tdoor d "
				+" inner join tdoor_meter d_m "
				+" on d.doorno = d_m.doorno "
				+" inner join tclient c "
				+" on c.clientno = d_m.clientno and d_m.areaguid = c.areaguid "
				+" inner join "+RequestObj.switchOnTimeTableByName("tmeter")+" m "
				+" on m.meterid = d_m.meterno and m.areaguid = d_m.areaguid "
				+" where d.buildno = " + buildno + " and d_m.areaguid = " + areaguid + " and AUTOID=1 "
				//+ "and to_char(m.ddate, 'YYYY-MM-DD')=to_char(sysdate, 'YYYY-MM-DD')"
				+ " and m.ddate between to_date('"+near+" 00:00:00','yyyy-MM-dd hh24:mi:ss') and  to_date('"+near+" 23:59:59','yyyy-MM-dd hh24:mi:ss')"
				;
		List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		
		return list;
	}

}
