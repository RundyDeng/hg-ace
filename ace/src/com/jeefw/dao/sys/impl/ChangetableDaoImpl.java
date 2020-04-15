package com.jeefw.dao.sys.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.jeefw.dao.sys.ChangetableDao;
import com.jeefw.model.sys.Changetable;

import core.dao.BaseDao;

/**
 * 数据持久层的实现类
 * 
 */
@Repository
public class ChangetableDaoImpl extends BaseDao<Changetable> implements ChangetableDao {

	public ChangetableDaoImpl() {
		super(Changetable.class);
	}
	
	public List<Object[]> changetable(String chId) {
		Query query = this.getSession().createSQLQuery(
				"select * from t");
		query.setParameter(0, chId);
		return query.list();
	}

}
