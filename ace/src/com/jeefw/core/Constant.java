package com.jeefw.core;

import java.util.Map;

//常量配置
public interface Constant {

	public static final String UPLOAD_PATH = "d:/ace/upload/fileList/";
	
	public static final String SESSION_SYS_USER = "SESSION_SYS_USER";

	public static final String JEEFW_DATA_SOURCE_BEAN_ID = "jeefwDataSource";
	
	public static final String AREA_GUIDS = "areaGuids";
	public static final String AREA_NAME = "areaName"; 
	
	public static final String DEFAULT_AREAGUID = "1941";
	public static final String DEFAULT_AREANAME = "大石庙经济适用房";
	
	
	public static final String LAST_QUERY_SQL = "controller_last_query_sql";
	/**
	 * 最后一次统计时间
	 */
	public static final String LAST_STATISTIC_DATE = "statisticsDate"; //statisticsDate
	/**
	 * 每日使用能源统计
	 */
	public static final String EVERYDAY_USE_ENERGY = "everyDayUseEnergyList";
	/**
	 * 主页第一个统计
	 */
	public static final String HEAD_STATISTIC = "headStatisticMap"; //Map<String, Object> headStatisticMap
	/**
	 * 最后一次统计的各小区表数据
	 */
	public static final String STATISTIC_EACH_AREA_METER_INFO = "statisticEachAreaMeterInfo";
	
	//数据表
	public static final String CHOOSE_TABLE_TIME = "shujubiaoshijian";
	
	/**
	 * init时
	 */
	//本季度各小区耗热量
	public static final String YEAR_AREA_USE_ENERGY = "benjiduxiaoquhaoreliang";
	//耗热量统计，小区，住户数，面积，日期，耗热量      统计当天的
	public static final String STATIC_USE_ENERGY_FOR_DAY = "tongjidangrihaoreliang";
	//最新日的进回水温度统计
	public static final String STATIC_INOUT_WATER = "tongjidangrijinhuishuiwendu";
}
