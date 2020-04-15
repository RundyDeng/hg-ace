package com.jeefw.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;


public interface IBaseService {
	/**
	 * 增加
	 * @param obj
	 * @return
	 */
	public <T> void saveOrUpdate(T obj);
	
	/**
	 * 修改
	 * @param obj
	 * @return
	 */
	public <T> void update(T obj);	
	
	/**
	 * 增加，修改
	 * @param obj
	 * @return
	 */
	public <T> void save(T obj);
	
	/**
	 * 删除
	 * @param obj
	 * @return
	 */
	public <T> void delete(T obj);	
	
	/**
	 * 加载
	 * @param obj
	 * @return
	 */
	public <T> T only(Class<T> c, Serializable id);
	
	
	public List<Map> listSqlAndChangeToMap(String sql,List<Object> params);
	
	public <T> Map<String,Object> objectToMapViaFields(T o) throws Exception ;
	
	public Long countSqlByObj(String sql, Object... param);
	
	public Long countSql(String sql, List<Object> params);
	
	public Boolean execuSql(String sql,List<Object> params);
	
	public Session getCurrentSession();
}
