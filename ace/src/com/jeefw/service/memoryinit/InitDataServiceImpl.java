package com.jeefw.service.memoryinit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.core.Constant;
import com.jeefw.dao.IBaseDao;

@Service
public class InitDataServiceImpl implements InitDataService{
	@Resource
	private IBaseDao baseDao;  
    private static Map<String,Object> statisticMap = new HashMap<String,Object>();  
    
    public void initData(){  
        if(statisticMap.isEmpty()){
        	System.out.println("init statisticServceImp:memoryinit");
        	//最近一次的统计时间
        	String statisticsDate = baseDao.findBySqlList("select to_char(max(ddate),'yyyy-MM-dd') as statisticsdate from tgztj", null).get(0).toString();
    		/*String sql = "select distinct  AREAGUID,TOTZHSUM,TOTCBSUM,ZCSUM,GZSUM,WFYSUM,WCBSUM,DDATE from tgztj "
    				+ " where ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss')";*/
    		System.out.println("每日抄表时间："+statisticsDate);
    		//统计信息
    		String sql = "select sum(totzhsum) as totzhsum,sum(totcbsum) as totcbsum,sum(zcsum) as zcsum,sum(gzsum) as gzsum,"
    				+ " sum(wfysum) as wfysum,sum(wcbsum) as wcsum,count(1) as areaSum from tgztj"
    				+ " where ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss')";
    		Map<String, Object> headStatisticMap = (Map<String, Object>) baseDao.listSqlAndChangeToMap(sql, null).get(0);	
    		
    		//每日用量统计
    		String everyDayUserEnergySql ="with t1 as "
    									+" ( "
    									+" select sysdate-level+1 d from dual connect by level<=7 order by d "
    									+" ) "
    									+" select to_char(t1.d,'yyyy-mm-dd') as day, nvl(Round(sum(t2.meternllj),1),0) as userEnergy "
    									+" "
    									+" from t1 "
    									+" left join tmeter t2 "
    									+" on t2.meternllj !=null and to_char(t1.d,'yyyy-Mm-dd')=to_char(t2.ddate,'yyyy-MM-dd') "
    									+" group by t1.d order by t1.d ";
    		List everyDayUserEnergyList = baseDao.listSqlAndChangeToMap(everyDayUserEnergySql,null);
    		
    		//各小区表信息统计
    		String eachAreaMeterInfoSql = "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
    									+" from Tarea a "
    									+" left join FACTORYSECTIONINFO b "
    									+" on a.FACTORYNO=b.SECTIONID "
    									+" left join ENERGYFACTORY c "
    									+" on c.FACTORYID=b.FACTORYID "
    									+" inner join TGZTJ t "
    									+" on t.areaguid=a.areaguid "
    									+" where t.ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss') ";
    		List eachAreaMeterInfo = baseDao.listSqlAndChangeToMap(eachAreaMeterInfoSql, null);
        	
            List regionList = baseDao.listSqlAndChangeToMap(sql, null);  
            statisticMap.put(Constant.LAST_STATISTIC_DATE, statisticsDate);
            statisticMap.put(Constant.EVERYDAY_USE_ENERGY, everyDayUserEnergyList);
            statisticMap.put(Constant.HEAD_STATISTIC, headStatisticMap);
            statisticMap.put(Constant.STATISTIC_EACH_AREA_METER_INFO, eachAreaMeterInfo);
        }  
    }  
      
    public static Map<String,Object> getAllStatisticMap(){  
        return statisticMap;  
    }  
      
    /**
     * 
     * @param key
     * @return
     */
    public static Object getObjectByKey(String key) {  
        return statisticMap.get(key);  
    }  
  
    public static void setRegionMap(Map<String, Object> statisticMap) {  
        InitDataServiceImpl.statisticMap = statisticMap;  
    }  
}
