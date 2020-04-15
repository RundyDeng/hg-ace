package com.jeefw.service.pub;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import core.dbSource.DataSource;

public interface PubService{

	public List queryList(String sql);
	public String getAreanameById(String id);
	
	public List getArea(Map<String, String[]> paramMap);
	public List getBuild(Map<String, String[]> paramMap);
	public List getUnitNO(Map<String, String[]> paramMap);
	public List getFloorNo(Map<String, String[]> paramMap);
	public List getDoorNo(Map<String, String[]> paramMap);
	public List getRemainInfo(Map<String, String[]> paramMap);//
	public List getChangeMeter(Map<String, String[]> paramMap);
	
	public Map<String, Object> getClientByClientId(int clientId);
	public String getClientNoByClientId(int clientId);
	
	//数据源切换测试
	@DataSource(name="DS2")  //切换为DS2数据源
	public void switchDBText();
	
	public List getHeatingStation(String factoryid);
	
	/**
	 * 检查clietnNO是否重复
	 * @param 	clientNo
	 * @return  true表示重复了
	 */
	public boolean checkClientNo(String clientNo);
	/**
	 * 批量执行sql
	 * @param strings
	 * @return
	 */
	public boolean executeBatchSql(String... strings);
	/**z
	 * 
	 * @param buildno  楼栋号
	 * @return 楼栋最大楼层，拥有单元，每单元层级最大用户数
	 */
	public Map<String, Object> getMaxFloorAndUnitAndMaxDoor(String buildno);
	//////////////////////////////////////////////////////////////////////////////
	
	
    /**
     * 功能：获取分公司信息
     * @param paramMap
     * @return
     */
    public List getFactory(Map<String, String[]> paramMap);
    /**
     * 功能：获取换热站信息
     * @param paramMap
     * @return
     */
    public List getSection(String factoryid);//
	
    public boolean adduserlog(String username,String oper,String bz)throws UnknownHostException;
    /**
     * 两个字符串比较
     * @param v1
     * @param v2
     * @return
     */
    public boolean compare(String v1, String v2);


}
