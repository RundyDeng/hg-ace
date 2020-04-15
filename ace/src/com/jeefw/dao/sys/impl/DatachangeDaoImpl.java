package com.jeefw.dao.sys.impl;
import org.springframework.stereotype.Repository;
import com.jeefw.dao.sys.DatachangeDao;
import com.jeefw.model.sys.ExmineApprove;
import core.dao.BaseDao;

/**
 * 数据持久层的实现类
 * 
 */
@Repository
public class DatachangeDaoImpl extends BaseDao<ExmineApprove> implements DatachangeDao {

	public DatachangeDaoImpl() {
		super(ExmineApprove.class);
	}
	
	//测试使用
	/*public List<Object[]> Datachange(String OrderNo) {
		Query query = this.getSession().createSQLQuery(
				"select * from datachange");
		Query q = query.setParameter(0, OrderNo);
		System.out.println("Oaaaaaaaaaa:"+q);
		return query.list();
	}*/

}
