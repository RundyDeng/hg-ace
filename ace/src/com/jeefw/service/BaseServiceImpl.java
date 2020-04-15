package com.jeefw.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.springframework.stereotype.Service;

import com.jeefw.dao.IBaseDao;

@Service
public class BaseServiceImpl implements IBaseService {
	
	@Resource
	private IBaseDao baseDao;
	
	public void setBaseDao(IBaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public <T> void saveOrUpdate(T obj) {
		baseDao.saveOrUpdate(obj);
	}

	public <T> void update(T obj) {
		baseDao.update(obj);
	}

	public <T> void save(T obj) {
		baseDao.save(obj);
	}

	public <T> void delete(T obj) {
		baseDao.delete(obj);
	}


	@Override
	public <T> T only(Class<T> c, Serializable id) {
		return (T) baseDao.only(c, id);
	}

	@Override
	public List<Map> listSqlAndChangeToMap(String sql, List<Object> params) {
		// TODO Auto-generated method stub
		return (List<Map>)baseDao.listSqlAndChangeToMap(sql, params);
	}
	
	@Override
	public Long countSqlByObj(String sql, Object... param){
		return baseDao.countSql(sql, param);
	}

	@Override
	public <T> Map<String, Object> objectToMapViaFields(T o) throws Exception {
		return baseDao.objectToMapViaFields(o);
	}
	
	
	@Override
	public Boolean execuSql(String sql,  List<Object> params){
		return baseDao.execuSql(sql, params);
	}

	@Override
	public Long countSql(String sql, List<Object> params) {
		// TODO Auto-generated method stub
		return baseDao.countSql(sql, params);
	}

	@Override
	public Session getCurrentSession() {
		// TODO Auto-generated method stub
		return baseDao.getHibCurrentSession();
	}


	
	

}
