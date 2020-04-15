package com.jeefw.dao.baseinfomanage.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.hibernate5.SessionFactoryUtils;

import com.jeefw.dao.BaseDaoImpl;
import com.jeefw.dao.baseinfomanage.ClientInfoDao;

import core.dao.BaseDao;
import oracle.jdbc.OracleTypes;

public class ClientInfoDaoImp extends BaseDaoImpl implements ClientInfoDao{
	
	// 调用存储过程
		public Map<String, Object> listByProcedure(String sqlwhere,int pageSize,int currentPage,String orderField,int orderNO) {
			ResultSet rs = null;
			Connection conn = null;
			CallableStatement query = null;
			List bsrList = new ArrayList();
			try {
				conn = SessionFactoryUtils.getDataSource(getSessionFactory()).getConnection();
				query = conn.prepareCall("{Call db_oper.return_dataset(?,?,?,?,?,?,?,?)}");
				
				//输入参数
				query.setString(1, "VALLAREAINFOFAILURE");// 表名
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
				// TODO 自动生成的 catch 块
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
	
}
