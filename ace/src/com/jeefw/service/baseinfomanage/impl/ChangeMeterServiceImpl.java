package com.jeefw.service.baseinfomanage.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.IBaseDao;
import com.jeefw.service.baseinfomanage.ChangeMeterService;

@Service
public class ChangeMeterServiceImpl implements ChangeMeterService{
	@Resource
	private IBaseDao baseDao;
	
	@Override
	public boolean checkHaveRecord(String meterno) {
		
		String sql = "select 1 from TModifyMeter where prometerid=" + meterno;
		List list = baseDao.findBySqlList(sql, null);
		if(list.size()==0)
			return false;
		
		return true;
	}

	@Override
	public boolean UpdateMeterNoFromAll(int iDEVICENO, int iGPRSNO,
			int iDeviceTypeChildNo, int iPOOLNO, long lPoolAddr,
			int iCHANNELNO, String sDEVICETYPENAME, int iDEVICEADDRESS,
			String sNewMeterNo, String sOldMeterNo, int iMeterType,
			int iAreaGuid, double fYONGLIANG, double fDISHU, String sClientNo,
			String m_LogName) {
		 boolean flag = false;
         //设备表，设备属性表，关联关系表
         String sSql1 = " update tdevice set meterno = " + sNewMeterNo + ",devicenumber = " + sNewMeterNo + ",DeviceTypeChildNo=" + iDeviceTypeChildNo + "  where meterno = " + sOldMeterNo + " and devicetypeno = " + iMeterType + " and areaguid = " + iAreaGuid;
         try
         {
        	 flag=baseDao.execuSql(sSql1,null);
         }
         catch (Exception e)
         {

             return false;
         }

         String sql2 = " update tdeviceproperty set meterno = '" + sNewMeterNo + "' where meterno = '" + sOldMeterNo + "' and devicetypeno = " + iMeterType + " and areaguid = " + iAreaGuid;
         try
         {
        	 flag=baseDao.execuSql(sql2,null);
         }
         catch (Exception e)
         {

             return false;
         }

         String sql3 = " update tdoor_meter set meterno = " + sNewMeterNo + " where meterno = " + sOldMeterNo + " and metertype = " + iMeterType + " and areaguid = " + iAreaGuid;
         try
         {
        	 flag=baseDao.execuSql(sql3,null);
         }
         catch (Exception e)
         {

             return false;
         }
         String sql4 = " update tclient set meterid = '" + sNewMeterNo + "' where meterid = '" + sOldMeterNo + "' and areaguid = " + iAreaGuid;
         try
         {
        	 flag=baseDao.execuSql(sql4,null);
         }
         catch (Exception e)
         {

             return false;
         }
         String sql6 = " insert into TCHANGEMETER (DEVICENO,AREAGUID,GPRSNO,POOLNO,CHANNELNO,DEVICETYPENAME,DEVICETYPENO,DEVICEADDRESS,DEVICENUMBER,METERNO,UPLOADFLAG) values(" + iDEVICENO + "," + iAreaGuid + "," + iGPRSNO + "," + iPOOLNO + "," + iCHANNELNO + ",'" + sDEVICETYPENAME + "'," + iMeterType + "," + iDEVICEADDRESS + ",'" + sNewMeterNo + "','" + sNewMeterNo + "',0)";
         try
         {
        	 flag=baseDao.execuSql(sql6,null);
         }
         catch (Exception e)
         {
             return false;
         }
         return flag;
	}

	@Override
	public boolean UpdateMeterNoFromAll3(String sNewMeterNo,String sOldMeterNo, int iMeterType, int iAreaGuid, String sClientNo) {
		   //设备表，设备属性表，关联关系表
		String sqlstr = " update TCLIENT set MeterID = '" + sNewMeterNo + "' where ClientNo = '" + sClientNo + "' and areaguid = " + iAreaGuid;
        boolean flag=false;
        try
        { 
        	flag=baseDao.execuSql(sqlstr,null);
        }
        catch (Exception e)
        {
            return flag;
        }
        return flag;
	}

	@Override
	public boolean UpdateMeterNoFromAll2(String sNewMeterNo,
			String sOldMeterNo, int iMeterType, int iAreaGuid, String sClientNo) {
		  boolean flag=false;
          String sqlstr = "update tdoor_meter set meterno = '" + sNewMeterNo + "' where ClientNo = '" + sClientNo + "' and areaguid = " + iAreaGuid;
          try
          {
        	  flag=baseDao.execuSql(sqlstr,null);
          }
          catch (Exception e)
          {
              return flag;
          }
          return flag;
	}

	@Override
	public boolean UpdateMeterNoFromAll4(int iDEVICENO, int iGPRSNO,
			int childMeterType, int iPOOLNO, long lPoolAddr, int iCHANNELNO,
			String sDEVICETYPENAME, int iDEVICEADDRESS, String sNewMeterNo,
			String sOldMeterNo, int iMeterType, int iAreaGuid,
			String sClientNo, String DevicesNo) {
		  boolean flag=false;
          String sqlstr = "update tdevice set meterno = '" + sOldMeterNo + "',devicenumber = '" + sOldMeterNo + "',DeviceTypeChildNo=" + childMeterType + "   where DeviceNo = '" + DevicesNo + "' and areaguid = " + iAreaGuid;
          try
          {
        	  flag=baseDao.execuSql(sqlstr,null);
          }
          catch (Exception e) 
          {
              return flag;
          }

          String sqlstr2 = "insert into TCHANGEMETER (DEVICENO,AREAGUID,GPRSNO,POOLNO,CHANNELNO,DEVICETYPENAME,DEVICETYPENO,DEVICEADDRESS,DEVICENUMBER,METERNO,UPLOADFLAG) values(" + iDEVICENO + "," + iAreaGuid + "," + iGPRSNO + "," + iPOOLNO + "," + iCHANNELNO + ",'" + sDEVICETYPENAME + "'," + iMeterType + "," + iDEVICEADDRESS + ",'" + sNewMeterNo + "','" + sNewMeterNo + "',0) ";
          try
          {
        	  flag=baseDao.execuSql(sqlstr2,null);
          }
          catch (Exception e)
          {
              return flag;
          }
          return flag;
	}

}
