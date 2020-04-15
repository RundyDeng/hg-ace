package com.jeefw.dao;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.resource.cci.ResultSet;

import org.hibernate.LockOptions;
import org.hibernate.Session;


public interface IBaseDao<T> {
	/**
	 * 保存一个对象
	 * 
	 * @param o
	 *            对象
	 */
	public void save(T o);

	/**
	 * 清除缓存 持久对象变成脱管对象
	 */
	public void evict(T o);
	
	/**
	 * 
	 * @param o 参数说明：
	 * 方法说明：清除缓存
	 */
	public void clear();

	/**
	 * 更新一个对象
	 * 
	 * @param o
	 *            对象
	 */
	public void update(T o);

	/**
	 * 保存或更新对象
	 * 
	 * @param o
	 *            对象
	 */
	public void saveOrUpdate(T o);

	/**
	 * 合并一个对象
	 * 
	 * @param o
	 *            对象
	 */
	public void merge(T o);

	/**
	 * 删除一个对象
	 * 
	 * @param o
	 *            对象
	 */
	public void delete(T o);

	/**
	 * 查找对象集合
	 * 
	 * @param hql
	 * @param param
	 * @return List<T>
	 */
	public List<T> find(String hql, Object... param);

	/**
	 * 查找对象集合
	 * 
	 * @param hql
	 * @param param
	 * @return List<T>
	 */
	public List<T> find(String hql, List<Object> param);

	/**
	 * 
	 * @param hql
	 * @param param
	 * @return 参数说明： 方法说明：查找对象集合,带分页，可输入一个带Collection型的参数，需要指定名称
	 */
	public List<T> find(String hql, Map<String, Object> param);

	/**
	 * 查找对象集合,带分页
	 * 
	 * @param hql
	 * @param page
	 *            当前页
	 * @param rows
	 *            每页显示记录数
	 * @param param
	 * @return 分页后的List<T>
	 */
	public List<T> find(String hql, int page, int rows, List<Object> param);

	/**
	 * 查找对象集合,带分页
	 * 
	 * @param hql
	 * @param page
	 *            当前页
	 * @param rows
	 *            每页显示记录数
	 * @param param
	 * @return 分页后的List<T>
	 */
	public List<T> find(String hql, int page, int rows, Object... param);

	/**
	 * 查找对象集合,带分页，可输入一个带Collection型的参数，需要指定名称
	 * 
	 * @param hql
	 * @param page
	 * @param rows
	 * @param param
	 * @param listName
	 * @param list
	 * @return
	 */
	public List<T> find(String hql, int page, int rows,
			Map<String, Object> param);

	/**
	 * 获得一个对象
	 * 
	 * @param c
	 *            对象类型
	 * @param id
	 * @return Object
	 */
	public T only(Class<T> c, Serializable id);

	/**
	 * 获得一个对象
	 * 
	 * @param hql
	 * @param param
	 * @return Object
	 */
	public T only(String hql, Object... param);

	/**
	 * 获得一个对象
	 * 
	 * @param hql
	 * @param param
	 * @return Object
	 */
	public T only(String hql, List<Object> param);

	/**
	 * id查询，并锁定数据
	 * @param c
	 * @param id
	 * @return
	 */
	public T onlyAndLock(Class<T> c, Serializable id);

	/**
	 * id查询，并锁定数据
	 * @param c
	 * @param id
	 * @param opt
	 * @return
	 */
	public T onlyAndLock(Class<T> c, Serializable id, LockOptions opt);

	/**
	 * select count(*) from 类
	 * 
	 * @param hql
	 * @param param
	 * @return Long
	 */
	public Long count(String hql, Object... param);

	/**
	 * select count(*) from 类
	 * 
	 * @param hql
	 * @param param
	 * @return Long
	 */
	public Long count(String hql, List<Object> param);

	/**
	 * 记录条数，带in (?)的查询条件
	 * 
	 * @param hql
	 * @param param
	 * @param listName
	 * @param list
	 * @return
	 */
	public Long count(String hql, Map<String, Object> param);
	

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @return 相应数目
	 */
	public Integer executeHql(String hql);

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Integer executeHql(String hql, Object... param);

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Integer executeHql(String hql, List<Object> param);

	/**
	 * 执行HQL语句,带in (?)的查询条件
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Integer executeHql(String hql, Map<String, Object> param);

	/**
	 * SQL查询语句
	 * 
	 * @param sql
	 * @param cls
	 * @param param
	 * @return
	 */
	public List<T> findSql(String sql, Class<T> cls, List<Object> param);

	
	public List<T> findBySql(String sql,Object... param);
	
	/**

	 * @param hql
	 * @return 参数说明：
	 * 方法说明：批量删除
	 */
	public void deleteByBatch(List<T> list);
	
	/**

	 * 参数：@param sql
	 * 参数：@param param
	 * 参数：@return 
	 * 方法说明：
	 */
	public List<T> findBySqlList(String sql,List<Object> param) ;

	/**
	 * 
	 * 参数：@param hql
	 * 参数：@param page
	 * 参数：@param rows
	 * 参数：@param param
	 * 参数：@return 
	 * 方法说明：sql语句分页
	 */
	public List<T> findBySql(String sql, int page, int rows, List<Object> param);
	
	/**
	 *
	 * 参数：@param sql
	 * 参数：@param param
	 * 参数：@return 
	 * 方法说明：通过参数得到一条记录
	 * 使用SQL
	 */
	public T onlyBySQL(String sql, List<Object> param) ;
	
	/**

	 * 参数：@param o 
	 * 方法说明：批量新增
	 */
	public void addByBatch(T o);
	
	/**
	 * @param SQL
	 * @param params
	 * @return boolean
	 * 方法说明：通过执行SQL，放回boolean
	 */
	public boolean execuSql(String sql, List<Object> params);
	
	/**

	 * @param o
	 * @return
	 * @throws Exception 
	 * 通过getDeclaredFields 的方式复制属性值 
     *  getDeclaredFields方式不会返回父类的属性 
	 */
	 public Map<String,Object> objectToMapViaFields(T o) throws Exception ;
	 
	 /**
	  * @param sql
	  * @param page
	  * @param rows
	  * @param param
	  * @return 
	  * 说明：分页方法，返回map类型
	  * list通过数据库字段名称取值
	  */
	 public List <Map> listSqlPageAndChangeToMap(final String sql,int page, int rows, List<Object> param);
	
	 /**
	  * 
	  * @param sql
	  * @param param
	  * @return 
	  * 说明：按条件查询并转换成map
	  */
	 public List <Map> listSqlAndChangeToMap(final String sql,List<Object> param);
	
	 /**
	  * 存储过程调用
	  * @param tableName   表名
	  * @param sqlwhere    条件不用加where
	  * @param pageSize    每页显示记录数
	  * @param currentPage 当前页
	  * @param orderField  排序字段
	  * @param orderNO     排序方式 0,升序，1降序
	  * @return
	  */
	 public Map<String, Object> listByStoredProcedureName(String tableName,String sqlwhere,int pageSize,int currentPage,String orderField,int orderNO);
	 /**
	  * 
	  * @param sql
	  * @param param
	  * @return 
	  */
	 public Long countSql(String sql, List<Object> param);
	 
	 /**
	  * 
	  * @param sql
	  * @param obj
	  * @return 

	  */
	 public Long countSql(String sql, Object...obj);
	 
	 /**
	  * 
	  * @return 
	  * 获取hibernate当前session
	  */
	 public Session getHibCurrentSession();
	 
	 /**
	  * 
	  * @param tablename表名
	  * @param filedKey表中的主键
	  * @return 新记录的主键  int类型
	  */
	 public Integer getIntNextTableId(String tablename,String field);
	
	 
}
