package com.jeefw.controller.baseinfomanage;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.baseinfomanage.ChangeMeterService;
import com.jeefw.service.pub.PubService;
@Controller
@RequestMapping("/baseinfomanage/betweenMeterChangeContr")
public class BetweenMeterChangeController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSvr;
	@Resource
	private ChangeMeterService changeMeterSvr;
	@RequestMapping("/getBetweenMeterChange")
	public void getBetweenMeterChange(HttpServletRequest request,HttpServletResponse response){
		
	}
	
	@RequestMapping("/updateBetweenMeterChange")
	public void updateBetweenMeterChange(HttpServletRequest request,HttpServletResponse response) throws IOException{
		printRequestParam();
//		String updateSql1 = "update TDoor_Meter set meterno = "+getParm("doorno_up") +" where doorno="+getParm("doorno_up");
//		String updateSql2 = "update TDoor_Meter set meterno = "+getParm("doorno_down") +" where doorno="+getParm("doorno_down");
//		boolean flag = pubSvr.executeBatchSql(updateSql1,updateSql2);
		boolean flag=false;
		String sSql = " select CLIENTNO from TDOOR_METER  where AREAGUID = " + Integer.parseInt(getParm("community").toString()) + " and  METERNO ='" + getParm("comMeterSeq1") + "'";
		List<Map>list1=baseDao.listSqlAndChangeToMap(sSql, null);
		String sql="select count(*) from TCLIENT where 1=1 and ClientNo='"+list1.get(0).get("CLIENTNO").toString()+"'";
		List<Map> listclient=baseDao.listSqlAndChangeToMap(sql, null);
		
		String sSql2 = " select CLIENTNO from TDOOR_METER  where AREAGUID = " + Integer.parseInt(getParm("community2").toString()) + " and  METERNO ='" + getParm("comMeterSeq2") + "'";
		List<Map>list2=baseDao.listSqlAndChangeToMap(sSql2, null);
		String sql2="select count(*) from TCLIENT where 1=1 and ClientNo='"+list2.get(0).get("CLIENTNO").toString()+"'";
		List<Map> listclient2=baseDao.listSqlAndChangeToMap(sql2, null);
		if(listclient.size()==1 && listclient2.size()==1){
		changeMeterSvr.UpdateMeterNoFromAll3(getParm("meterno_up"), getParm("comMeterSeq1"), 0,  Integer.parseInt(getParm("community").toString()),list1.get(0).get("CLIENTNO").toString() );
		changeMeterSvr.UpdateMeterNoFromAll3(getParm("meterno_down"), getParm("comMeterSeq2"), 0,  Integer.parseInt(getParm("community2").toString()),list2.get(0).get("CLIENTNO").toString() );
		}
		changeMeterSvr.UpdateMeterNoFromAll2(getParm("meterno_up"), getParm("comMeterSeq1"), 0,  Integer.parseInt(getParm("community").toString()), list1.get(0).get("CLIENTNO").toString());
		changeMeterSvr.UpdateMeterNoFromAll2(getParm("meterno_down"), getParm("comMeterSeq2"), 0,  Integer.parseInt(getParm("community2").toString()), list2.get(0).get("CLIENTNO").toString());
		//取表底数
		String smeterdatesql = "select MAX(MeterNLLJ) as meternllj from tmeter where AreaGuid='" + getParm("community").toString() + "' and MeterID='" + getParm("comMeterSeq1").toString() + "' ";
        double smeterdata = 0.0;  
        List<Map> meternll=baseDao.listSqlAndChangeToMap(smeterdatesql, null);
        if(meternll.size()>0){
        smeterdata=Double.parseDouble(meternll.get(0).get("METERNLLJ").toString());
        }else{
        smeterdata=0;	
        }
        String smeterdatesql1 = "select MAX(MeterNLLJ) as meternllj from tmeter where AreaGuid='" + getParm("community2").toString() + "' and MeterID='" + getParm("comMeterSeq2").toString() + "' ";
        double smeterdata1 = 0.0;
        List<Map> meternll2=baseDao.listSqlAndChangeToMap(smeterdatesql1, null);
        if(meternll2.size()>0){
        	smeterdata1=Double.parseDouble(meternll2.get(0).get("METERNLLJ").toString());
            }else{
            smeterdata1=0;	
            }
		String dt1="select * from tdevice where AreaGuid=" + Integer.parseInt(getParm("community").toString()) + " and  METERNO='" + getParm("comMeterSeq1").toString() + "'";
		List<Map> listdev=baseDao.listSqlAndChangeToMap(dt1, null);
		String dt2="select * from tdevice where AreaGuid=" + Integer.parseInt(getParm("community2").toString()) + " and  METERNO='" + getParm("comMeterSeq2").toString() + "'";
		List<Map> listdev2=baseDao.listSqlAndChangeToMap(dt2, null);
	    int iDEVICENO = 0, iGPRSNO = 0, iPOOLNO = 0, iCHANNELNO = 0, iDEVICEADDRESS = 0;
        String sDEVICETYPENAME = "";
		if(listdev.size()>0 && listdev2.size()>0){
			 iDEVICENO = Integer.parseInt(listdev.get(0).get("DEVICENO").toString());
             iGPRSNO = Integer.parseInt(listdev.get(0).get("GPRSNO").toString());
             iPOOLNO = Integer.parseInt(listdev.get(0).get("POOLNO").toString());
             iCHANNELNO = Integer.parseInt(listdev.get(0).get("CHANNELNO").toString());
             sDEVICETYPENAME = "热能表";
             iDEVICEADDRESS = Integer.parseInt(listdev.get(0).get("DEVICEADDRESS").toString());
             String sqlpool = "SELECT * FROM TPool where PoolNo="+Integer.parseInt(listdev.get(0).get("POOLNO").toString());
             List<Map> dtpool=baseDao.listSqlAndChangeToMap(sqlpool, null);
             long lPoolAddr =Long.parseLong(dtpool.get(0).get("POOLADDR").toString());
             //获取表品牌类型 
             int childMeterType = Integer.parseInt(getParm("ddlBiaoLeiXing"));
             
             int iDEVICENO1 = Integer.parseInt(listdev2.get(0).get("DEVICENO").toString());
             int iGPRSNO1 =Integer.parseInt(listdev.get(0).get("GPRSNO").toString());
             int iPOOLNO1 = Integer.parseInt(listdev.get(0).get("POOLNO").toString());
             int iCHANNELNO1 = Integer.parseInt(listdev.get(0).get("CHANNELNO").toString());
             String sDEVICETYPENAME1 = "热能表";//dtList.Rows[0]["DeviceTypeName"].ToString();
             int iDEVICEADDRESS1 = Integer.parseInt(listdev2.get(0).get("DEVICEADDRESS").toString());
             String sqlpool2 = "SELECT * FROM TPool where PoolNo="+Integer.parseInt(listdev2.get(0).get("POOLNO").toString());
             List<Map> dtpool2=baseDao.listSqlAndChangeToMap(sqlpool2, null);
             long lPoolAddr1 = Long.parseLong(dtpool2.get(0).get("POOLADDR").toString());
             //获取表品牌类型 
             int childMeterType1 = Integer.parseInt(getParm("ddlBiaoLeiXing2"));
             flag=changeMeterSvr.UpdateMeterNoFromAll4(iDEVICENO, iGPRSNO, childMeterType, iPOOLNO, lPoolAddr, iCHANNELNO, sDEVICETYPENAME, iDEVICEADDRESS, getParm("meterno_up"), getParm("meterno_up"), 0, Integer.parseInt(getParm("community").toString()), list1.get(0).get("CLIENTNO").toString(), String.valueOf(iDEVICENO));
             flag=flag&&changeMeterSvr.UpdateMeterNoFromAll4(iDEVICENO1, iGPRSNO1, childMeterType1, iPOOLNO1, lPoolAddr1, iCHANNELNO1, sDEVICETYPENAME1, iDEVICEADDRESS1, getParm("meterno_down"), getParm("meterno_down"), 0, Integer.parseInt(getParm("community2").toString()), list2.get(0).get("CLIENTNO").toString(), String.valueOf(iDEVICENO1));
             //获取换表的基础信息
             String info1="select * from vareainfo where areaguid="+Integer.parseInt(getParm("community").toString())+" and meterno='"+getParm("comMeterSeq1")+"'";
             List<Map> infol1=baseDao.listSqlAndChangeToMap(info1, null);
             String info2="select * from vareainfo where areaguid="+Integer.parseInt(getParm("community2").toString())+" and meterno='"+getParm("comMeterSeq2")+"'";
             List<Map> infol2=baseDao.listSqlAndChangeToMap(info2, null);
             String address1 =  infol1.get(0).get("AREANAME").toString()+"-"+ infol1.get(0).get("BNAME").toString() + "-" + infol1.get(0).get("UNITNO").toString() + "-" + infol1.get(0).get("DOORNAME").toString();
             String address2 =infol2.get(0).get("AREANAME").toString()+"-"+ infol2.get(0).get("BNAME").toString() + "-" + infol2.get(0).get("UNITNO").toString() + "-" + infol2.get(0).get("DOORNAME").toString();
             String remark = "";
             if (flag){
             SimpleDateFormat sdfn = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
             java.util.Date nowdate=new java.util.Date(); 
             String nowda=sdfn.format(nowdate);
             remark = address1 + "与" + address2 + "表号互换！";
             String sqlstrr = "insert into TMODIFYMETER (AREAGUID,METERID,DEVICETYPE,PRODUSHU,DISHU,DDATE,SHOUFEIDATE,PROMETERID,CLIENTNO,USERNAME,REMARK) values(" + Integer.parseInt(getParm("community").toString()) + ",'" + getParm("meterno_up").toString() + "',0 ," + smeterdata + "," + smeterdata1 + ",to_date('" + nowda + "','yyyy-mm-dd hh24:mi:ss'),to_date('2014-11-05','yyyy-mm-dd'),'" + getParm("comMeterSeq1").toString() + "','" + list1.get(0).get("CLIENTNO").toString() + "','" + getLoginName() + "','" + remark + "') ";
             flag=flag&& baseDao.execuSql(sqlstrr, null);
             }
		}
		writeJSON(response, flag);
	}
	
}
