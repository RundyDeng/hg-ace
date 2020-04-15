package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.baseinfomanage.ChangeMeterService;
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.support.JqGridPageView;
@Controller
@RequestMapping("/baseinfomanage/changemeter")
public class ChangeMeterController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	
	@Resource
	private ChangeMeterService changeMeterSvr;
	
	@RequestMapping("/getChangeMeter")
	public void getChangeMeter(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		setSqlwhereContainWhere();
		//setFiltersStr(getFilters().replace("\"field\":\"BUILDNO\"", "\"field\":\"BUILDCODE\""));
//		String sql = "select distinct clientno as USERCODE,AREAGUID,areaname,doorno,doorname as FCODE,floorno,unitno,buildname"
//				+ " ,PROMETERID,PRODUSHU,TMODIFYMETER_METERID as METERID, DISHU, TMODIFYMETER_ddate as ddate,USERNAME from (" 
//				+ PubServiceImpl.headsqltest2 + " where tmm.PROMETERID is not null ) " + getSqlWhere();
		
		String sql = "select distinct  Clientno as USERCODE,AREAGUID,areaname,doorno, FCODE,floorno,unitno,"
				+ "buildname,PROMETERID,PRODUSHU, METERID,DDATE, DISHU,BUILDNO,USERNAME "
				+ "from (select a.*,b.areaname,b.doorno,b.doorname as FCODE,b.floorno,"
				+ "b.unitno,b.buildname,b.BUILDNO  from TMODIFYMETER a left join "
				+ "vareainfo b on a.areaguid=b.AREAGUID and a.CLIENTNO=b.CLIENTNO)"+getSqlWhere()+" order by ddate desc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);//TModifyMeter
		JqGridPageView listView = new JqGridPageView();
		listView.setRows(list);
		writeJSON(response, listView);
	}
	
	@RequestMapping("/noJqgirdEdit")
	public void noJqgirdEdit(HttpServletRequest request,HttpServletResponse response) throws IOException, ParseException{
		boolean flag = false;
//		if(!changeMeterSvr.checkHaveRecord(getParm("prometerid"))){//不存在原有记录  --->
//			String addSql = "insert into TModifyMeter (areaguid,prometerid,produshu,meterid,dishu,clientno,username,DEVICETYPE,DDATE,SHOUFEIDATE) values "
//					+ " (" + getParm("areaguid") + ","+ getParm("prometerid") +"," +getParm("produshu")+","
//					+ getParm("meterid") +","+getParm("dishu") +","+getParm("clientno") +",'"+getLoginName()+ "', 0,sysdate,sysdate)" ;
//			flag= baseDao.execuSql(addSql, null);	
//			
//		}else{
//			String editSql = "update TModifyMeter set  meterid="+ getParm("meterid") +",dishu="+getParm("dishu") 
//			 +",username='"+getLoginName()+ "',ddate = sysdate where prometerid="+getParm("prometerid") ;
//			flag = baseDao.execuSql(editSql, null);
//		}
//		
//		String updateSql = "update tdoor_meter set meterno ="+getParm("clientno") + " where clientno='"+getParm("clientno")+"'";
//		flag = flag&&baseDao.execuSql(updateSql, null);
		Calendar a=Calendar.getInstance();
		int year =a.get(Calendar.YEAR);
        int years = 0;
        String sdate="";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfn = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date nowdate=new java.util.Date(); 
        String nowda=sdfn.format(nowdate);
        if(a.get(Calendar.MONTH)>10){
        	years = year;
        	sdate=year+"-10-15";
        }else if(a.get(Calendar.MONTH)>4 &&a.get(Calendar.MONTH)<10){
        	years = year;
        	sdate=year+"-04-15";
        }else{
        	years=years-1;
        	sdate=year+"-10-15";
        }
        String sqls = "select * from VALLAREAINFOFAILURE where clientno='" + getParm("clientno") + "' and DDate between to_date('"+sdate+" 00:00:00','YYYY-MM-DD hh24:mi:ss') and  to_date('" + sdate + " 23:59:59','YYYY-MM-DD hh24:mi:ss')   order by CUSTOMID,ddate";
        double meternjll = 0;
        List<Map> list=baseDao.listSqlAndChangeToMap(sqls, null);
        if(list.size()>0){
        	meternjll=Double.parseDouble(list.get(0).get("METERNLLJ").toString());
        } else{
            meternjll = 0;
        }
        double yl = 0;
        if (Double.parseDouble(getParm("produshu")) - meternjll > 0)
        {
            yl = Double.parseDouble(getParm("produshu")) - meternjll;
        }
        else
        {
            yl = 0;
        }
        //取出设备表中对应的此条记录值
        String sqlstrsb = "SELECT * FROM TDevice where AreaGuid=" + getParm("areaguid") + " and DeviceTypeNO=0 and MeterNo=" + getParm("prometerid") + "  order by DeviceNo asc";
        List<Map> dtList = baseDao.listSqlAndChangeToMap(sqlstrsb, null);
        int iDEVICENO = 0, iGPRSNO = 0, iPOOLNO = 0, iCHANNELNO = 0, iDEVICEADDRESS = 0;
        String sDEVICETYPENAME = "";
        if (dtList.size() > 0)
        {
            iDEVICENO =Integer.parseInt(dtList.get(0).get("DEVICENO").toString());
            iGPRSNO = Integer.parseInt(dtList.get(0).get("GPRSNO").toString());
            iPOOLNO = Integer.parseInt(dtList.get(0).get("POOLNO").toString());
            iCHANNELNO = Integer.parseInt(dtList.get(0).get("CHANNELNO").toString());
            sDEVICETYPENAME = dtList.get(0).get("DEVICETYPENAME").toString();
            iDEVICEADDRESS = Integer.parseInt(dtList.get(0).get("DEVICEADDRESS").toString());
        }
        String sqlstrploor = "SELECT * FROM TPool where PoolNO=" + iPOOLNO + " order by PoolAddr asc";
        List<Map> drList1 = baseDao.listSqlAndChangeToMap(sqlstrploor, null);
        long lPoolAddr = Integer.parseInt(drList1.get(0).get("POOLADDR").toString());
        String sClientNo = getParm("clientno");
        int iDeviceTypeChildNo=Integer.parseInt(getParm("biaoleixin"));
        String xinmeterno = getParm("meterid");
        String xinnjll = getParm("dishu");
        //添加表序列一列
        flag = changeMeterSvr.UpdateMeterNoFromAll(iDEVICENO, iGPRSNO, iDeviceTypeChildNo, iPOOLNO, lPoolAddr, iCHANNELNO, sDEVICETYPENAME, iDEVICEADDRESS, xinmeterno, getParm("prometerid"), 0, Integer.parseInt(getParm("areaguid")),  Double.parseDouble(getParm("produshu")),Double.parseDouble(xinnjll), sClientNo, getLoginName());
        if (flag){
        	  //像TGAIBIANTMETER表中插入一条新的记录
        	String sql = "insert into TGAIBIANTMETER values(" + Integer.parseInt(getParm("areaguid")) + ",'" + getParm("prometerid") + "','" + getParm("produshu") + "','" + xinmeterno + "','" + xinnjll + "',to_date('" + nowda + "','yyyy-mm-dd hh24:mi:ss'),'" + yl + "'," + 1 + ",'" + getParm("clientno") + "')";
        	 baseDao.execuSql(sql, null);
            String remark = "旧表换新表!";
            //同时要像 tmodifymeter 插入一条新的记录
            String insqltotmodif = "insert into TMODIFYMETER (AREAGUID,METERID,DEVICETYPE,PRODUSHU,DISHU,DDATE,SHOUFEIDATE,PROMETERID,CLIENTNO,USERNAME,REMARK) values(" + Integer.parseInt(getParm("areaguid")) + ",'" + xinmeterno + "',0," + Double.parseDouble(getParm("produshu")) + "," + Double.parseDouble(xinnjll) + ",to_date('" +nowda  + "','yyyy-mm-dd hh24:mi:ss'),to_date('2014-11-05','yyyy-mm-dd'),'" + getParm("prometerid") + "','" + sClientNo + "','" + getLoginName() + "','" + remark + "')";
            baseDao.execuSql(insqltotmodif, null);
            
        }
		writeJSON(response, flag);
	}
	
	@RequestMapping("/operChangeMeter")
	public void operChangeMeter(HttpServletRequest request,HttpServletResponse response){
		String oper = getParm("oper");
		printRequestParam();
		if("del".equals(oper)){
			
		}else if("excel".equals(oper)){
			
		}else if("add".equals(oper)){
			
		}else if("edit".equals(oper)){
			String editSql = "update TModifyMeter set  meterid="+ getParm("METERID") +",dishu="+getParm("DISHU") 
			 +",username='"+getLoginName()+ "' where prometerid="+getParm("PROMETERID") ;
			baseDao.execuSql(editSql, null);
		}
	}
}
