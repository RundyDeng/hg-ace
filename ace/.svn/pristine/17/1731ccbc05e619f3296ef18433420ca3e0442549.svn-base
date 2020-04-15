package com.jeefw.dao;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.SessionFactoryUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.jeefw.model.common.Tarea;

import core.util.MathUtils;
import oracle.jdbc.OracleTypes;

@Repository("baseDao")
public class BaseDaoImpl<T> implements IBaseDao<T> {

	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public void save(T o) {
		this.getCurrentSession().save(o);
	}

	public void delete(T o) {
		this.getCurrentSession().delete(o);
	}

	public void update(T o) {
		this.getCurrentSession().update(o);
	}

	public void saveOrUpdate(T o) {
		this.getCurrentSession().saveOrUpdate(o);
	}

	public void merge(T o) {
		this.getCurrentSession().merge(o);
	}

	public void evict(T o) {
		getCurrentSession().evict(o);
	}

	@Override
	public void clear() {
		getCurrentSession().clear();
		getCurrentSession().flush();
	}

	public List<T> find(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.list();
	}

	public List<T> find(String hql, Object... param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.list();
	}

	public List<T> find(String hql, Map<String, Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (Map.Entry<String, Object> entry : param.entrySet()) {
				if (entry.getValue() instanceof Collection) {
					q.setParameterList(entry.getKey(), (Collection) entry.getValue());
				} else {
					q.setParameter(entry.getKey(), entry.getValue());
				}
			}
		}
		return q.list();
	}

	public List<T> find(String hql, int page, int rows, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public List<T> find(String hql, int page, int rows, Object... param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public List<T> find(String hql, int page, int rows, Map<String, Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (Map.Entry<String, Object> entry : param.entrySet()) {
				if (entry.getValue() instanceof Collection) {
					q.setParameterList(entry.getKey(), (Collection) entry.getValue());
				} else {
					q.setParameter(entry.getKey(), entry.getValue());
				}
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public T only(Class<T> c, Serializable id) {
		return (T) this.getCurrentSession().get(c, id);
	}

	@Transactional
	public T only(String hql, Object... param) {
		List l = this.find(hql, param);
		if (l != null && l.size() > 0) {
			return (T) l.get(0);
		}
		return null;
	}

	@Transactional
	public T onlyBySQL(String sql, List<Object> param) {
		List l = this.findBySqlList(sql, param);
		if (l != null && l.size() > 0) {
			return (T) l.get(0);
		}
		return null;
	}

	@Transactional
	public T only(String hql, List<Object> param) {
		List l = this.find(hql, param);
		if (l != null && l.size() > 0) {
			return (T) l.get(0);
		}
		return null;
	}

	public Long count(String hql, Object... param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return (Long) q.uniqueResult();
	}

	public Long count(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return (Long) q.uniqueResult();
	}

	public Long count(String hql, Map<String, Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (Map.Entry<String, Object> entry : param.entrySet()) {
				if (entry.getValue() instanceof Collection) {
					q.setParameterList(entry.getKey(), (Collection) entry.getValue());
				} else {
					q.setParameter(entry.getKey(), entry.getValue());
				}
			}
		}
		return (Long) q.uniqueResult();
	}

	public Integer executeHql(String hql) {
		Query q = this.getCurrentSession().createQuery(hql);
		return q.executeUpdate();
	}

	public Integer executeHql(String hql, Object... param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.executeUpdate();
	}

	public Integer executeHql(String hql, List<Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.executeUpdate();
	}

	public Integer executeHql(String hql, Map<String, Object> param) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (Map.Entry<String, Object> entry : param.entrySet()) {
				if (entry.getValue() instanceof Collection) {
					q.setParameterList(entry.getKey(), (Collection) entry.getValue());
				} else {
					q.setParameter(entry.getKey(), entry.getValue());
				}
			}
		}
		return q.executeUpdate();
	}

	public List<T> findSql(String sql, Class<T> cls, List<Object> param) {
		SQLQuery q = this.getCurrentSession().createSQLQuery(sql);
		q.addEntity(cls);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.list();
	}

	public Long countSql(String sql, List<Object> param) {
		if (StringUtils.isBlank(sql))
			return 0L;
		sql = " select count(1) from (" + sql + ") as total";
		Query q = this.getCurrentSession().createSQLQuery(sql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return Long.parseLong(String.valueOf(q.uniqueResult()));
	}

	public Long countSql(String sql, Object... param) {
		if (StringUtils.isBlank(sql))
			return 0L;
		sql = " select count(1) from (" + sql + ") ";
		// sql = " select count(1) from ("+sql+") as total";
		Query q = this.getCurrentSession().createSQLQuery(sql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return Long.parseLong(String.valueOf(q.uniqueResult()));
	}

	public T onlyAndLock(Class<T> c, Serializable id) {
		return (T) this.getCurrentSession().get(c, id, LockOptions.UPGRADE);
	}

	public T onlyAndLock(Class<T> c, Serializable id, LockOptions opt) {
		return (T) this.getCurrentSession().get(c, id, LockOptions.UPGRADE);
	}

	@Override
	public List<T> findBySql(String sql, Object... param) {
		SQLQuery q = this.getCurrentSession().createSQLQuery(sql);
		if (param != null && param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				q.setParameter(i, param[i]);
			}
		}
		return q.list();
	}

	@Override
	public List<T> findBySqlList(String sql, List<Object> param) {
		SQLQuery q = this.getCurrentSession().createSQLQuery(sql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.list();
	}

	public List<T> findBySql(String sql, int page, int rows, List<Object> param) {
		Query q = this.getCurrentSession().createSQLQuery(sql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	public void deleteByBatch(List<T> list) {
		Iterator customers = list.iterator();
		while (customers.hasNext()) {
			T o = (T) customers.next();
			getCurrentSession().delete(o);
			getCurrentSession().flush();
			getCurrentSession().evict(o);
		}
	}

	public void addByBatch(T ssc) {
		getCurrentSession().saveOrUpdate(ssc);
		getCurrentSession().flush();
		getCurrentSession().clear();
	}

	@Override
	public boolean execuSql(String sql, List<Object> param) {
		boolean bool = false;
		try {
			Query q = this.getCurrentSession().createSQLQuery(sql);
			if (param != null && param.size() > 0) {
				for (int i = 0; i < param.size(); i++) {
					q.setParameter(i, param.get(i));
				}
			}
			/* 坑！！
			 * sql 是在前边 debug参数也都正确，只是执行到executeUpdate感觉就是线程进入阻塞状态停住了
				已经解决，程序无问题。原因：plsqldevelop中对当前表做了DML操作，未提交事务。
			 */
			q.executeUpdate();
			bool = true;
		} catch (HibernateException e) {
			bool = false;
		}
		return bool;
	}

	public Map<String, Object> objectToMapViaFields(T o) throws Exception {
		Map<String, Object> resMap = new HashMap<String, Object>();
		Field[] declaredFields = o.getClass().getDeclaredFields();
		for (Field field : declaredFields) {
			field.setAccessible(true);
			// 过滤内容为空的
			if (field.get(o) == null) {
				continue;
			}
			resMap.put(field.getName(), field.get(o));
		}
		return resMap;
	}

	// 调用存储过程
	public Map<String, Object> listByStoredProcedureName(String tableName,String sqlwhere,int pageSize,int currentPage,String orderField,int orderNO) {
		ResultSet rs = null;
		Connection conn = null;
		CallableStatement query = null;
		List bsrList = new ArrayList();
		try {
			conn = SessionFactoryUtils.getDataSource(sessionFactory).getConnection();
			query = conn.prepareCall("{Call db_oper.return_dataset(?,?,?,?,?,?,?,?)}");
			
			//输入参数
			query.setString(1, tableName);// 表名
			query.setString(2, sqlwhere);// 条件不用加where
			query.setInt(3, pageSize);// 每页显示记录数
			query.setInt(4, currentPage);// 当前页
			query.setString(5, orderField);// 排序字段
			query.setInt(6, orderNO);// 排序方式 0,升序，1降序
			//输出参数
			query.registerOutParameter(7, OracleTypes.INTEGER);// 总记录数
			query.registerOutParameter(8, OracleTypes.CURSOR);//记录
			
			/*//这样报错，以后再看吧
			query.setString("@mTableName", "VALLAREAINFOFAILURE");// 表名
			query.setString("@mTerm", null);// 条件不用加where
			query.setInt("@mPageSize", 5);// 每页显示记录数
			query.setInt("@mPageIndex", 2);// 当前页
			query.setString("@mOrderField", null);// 排序字段
			query.setInt("@mOrderStyle", 0);// 排序方式 0,升序，1降序

			query.registerOutParameter("@mTotalRecords", OracleTypes.INTEGER);// 总记录数
			query.registerOutParameter("@mDateSet", OracleTypes.CURSOR);//记录
*/			
			
			//如果第一个结果是 ResultSet 对象，则返回 true；如果第一个结果是更新计数或者没有结果，则返回 false
			//System.out.println(query.execute());
			query.execute();
			int records = (int)query.getObject(7);//
			
			Map<String, Object> data = new HashMap<String,Object>();
			data.put("count", records);	
			rs = (ResultSet)query.getObject(8);

			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			List<Map<Object, Object>> list = null;
			if(columnCount>0){
				list = new ArrayList<Map<Object, Object>>();
				while(rs!=null && rs.next()){
					
					Map<Object, Object> rowMap = new HashMap<Object, Object>();
					for (int i = 1; i < columnCount; i++) {
						rowMap.put(metaData.getColumnName(i), rs.getObject(i));
					}
					list.add(rowMap);
				}
				data.put("rows", list);
				/*Gson gs = new Gson();
				gs.toJson(list);
				System.out.println(list);*/
				//System.out.println("pageSize:"+list.size()+"    一共有："+records);
			}
			conn.close();
			return data;
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			
		}
		return null;
		/*
		 * Session session = this.getCurrentSession();
		 * 
		 * Query query =
		 * session.createSQLQuery(procedureName).setResultTransformer(
		 * Transformers.ALIAS_TO_ENTITY_MAP); query.setString(1,
		 * "VALLAREAINFOFAILURE");//表名 query.setString(2, "");//条件不用加where
		 * query.setString(3, "2");//每页显示记录数 query.setString(4, "");//当前页
		 * query.setString(5, "");//排序字段 query.setString(6, "");//排序方式 0,升序，1降序
		 * query.setString(7, "");//总记录数 query.setString(8, "");//记录
		 */ /*
			 * query.setString("sFields", "*"); query.setString("mDateSet", "");
			 */
		
	}

	public int getUint16(int i){ return i & 0x0000ffff; }
	
	public List<Map> listSqlAndChangeToMap(final String sql, List<Object> param) {
		try {
			Query query = this.getCurrentSession().createSQLQuery(sql)
					.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
			if (param != null && param.size() > 0) {
				for (int i = 0; i < param.size(); i++) {
					query.setParameter(i, param.get(i));
				}
			}
			return query.list();
		} catch (RuntimeException e) {
			throw e;
		}
	}

	@Override
	public List<Map> listSqlPageAndChangeToMap(String sql, int page, int rows, List<Object> param) {
		try {
			Query query = this.getCurrentSession().createSQLQuery(sql)
					.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
			if (param != null && param.size() > 0) {
				for (int i = 0; i < param.size(); i++) {
					query.setParameter(i, param.get(i));
				}
			}
			return query.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
		} catch (RuntimeException e) {
			throw e;
		}
	}

	@Override
	public Session getHibCurrentSession() {
		// TODO Auto-generated method stub
		return getCurrentSession();
	}

	@Override
	public Integer getIntNextTableId(String tablename, String field) {
		String sql = "select max(" + field + ") from " + tablename ;
		List list = findBySqlList(sql, null);
		int tableId = MathUtils.getBigDecimal(list.get(0)).intValue() + 1;
		return tableId;
	}
	
	
}
