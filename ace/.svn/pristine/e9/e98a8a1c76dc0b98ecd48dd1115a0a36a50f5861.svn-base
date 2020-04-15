package com.jeefw.service.baseinfomanage;

public interface ChangeMeterService {
	/**检查是否存在记录
	 * @param meterno
	 * @return  true存在记录
	 */
	public boolean checkHaveRecord(String meterno);
	/**
	 * 换表的一系列操作
	 * @param iDEVICENO
	 * @param iGPRSNO
	 * @param iDeviceTypeChildNo
	 * @param iPOOLNO
	 * @param lPoolAddr
	 * @param iCHANNELNO
	 * @param sDEVICETYPENAME
	 * @param iDEVICEADDRESS
	 * @param sNewMeterNo
	 * @param sOldMeterNo
	 * @param iMeterType
	 * @param iAreaGuid
	 * @param fYONGLIANG
	 * @param fDISHU
	 * @param sClientNo
	 * @param m_LogName
	 * @return
	 */
	public boolean UpdateMeterNoFromAll(int iDEVICENO, int iGPRSNO, int iDeviceTypeChildNo, int iPOOLNO, long lPoolAddr, int iCHANNELNO, String sDEVICETYPENAME, int iDEVICEADDRESS, String sNewMeterNo, String sOldMeterNo, int iMeterType, int iAreaGuid, double fYONGLIANG, double fDISHU, String sClientNo, String m_LogName);
   /**
    * 修改住户信息表
    * @param sNewMeterNo
    * @param sOldMeterNo
    * @param iMeterType
    * @param iAreaGuid
    * @param sClientNo
    * @return
    */
	public boolean UpdateMeterNoFromAll3(String sNewMeterNo, String sOldMeterNo, int iMeterType, int iAreaGuid, String sClientNo);
	/**
	 * 修改中间表tdoor_meter
	 * @param sNewMeterNo
	 * @param sOldMeterNo
	 * @param iMeterType
	 * @param iAreaGuid
	 * @param sClientNo
	 * @return
	 */
	public boolean UpdateMeterNoFromAll2(String sNewMeterNo, String sOldMeterNo, int iMeterType, int iAreaGuid, String sClientNo);
	/**
	 * 修改设备信息表tdevice
	 * @param iDEVICENO
	 * @param iGPRSNO
	 * @param childMeterType
	 * @param iPOOLNO
	 * @param lPoolAddr
	 * @param iCHANNELNO
	 * @param sDEVICETYPENAME
	 * @param iDEVICEADDRESS
	 * @param sNewMeterNo
	 * @param sOldMeterNo
	 * @param iMeterType
	 * @param iAreaGuid
	 * @param sClientNo
	 * @param DevicesNo
	 * @return
	 */
	public boolean UpdateMeterNoFromAll4(int iDEVICENO, int iGPRSNO, int childMeterType, int iPOOLNO, long lPoolAddr, int iCHANNELNO, String sDEVICETYPENAME, int iDEVICEADDRESS, String sNewMeterNo, String sOldMeterNo, int iMeterType, int iAreaGuid, String sClientNo, String DevicesNo);
}
