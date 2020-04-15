package com.jeefw.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.base.Objects;
import com.jeefw.model.sys.param.ChangetableParameter;

/**
 * 实体类
 */
@Entity
@Table(name = "changetable")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Changetable extends ChangetableParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2847988368314678488L;
	@Id
	@GeneratedValue
	
	@Column(name = "Flowname")
	private String Flowname;
	@Column(name = "Flows")
	private String Flows;
	@Column(name = "Opertor")
	private String Opertor;
	
	
	public String getFlowname() {
		return Flowname;
	}
	public void setFlowname(String flowname) {
		Flowname = flowname;
	}
	public String getFlows() {
		return Flows;
	}
	public void setFlows(String flows) {
		Flows = flows;
	}
	public String getOpertor() {
		return Opertor;
	}
	public void setOpertor(String opertor) {
		Opertor = opertor;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((Flowname == null) ? 0 : Flowname.hashCode());
		result = prime * result + ((Flows == null) ? 0 : Flows.hashCode());
		result = prime * result + ((Opertor == null) ? 0 : Opertor.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Changetable other = (Changetable) obj;
		if (Flowname == null) {
			if (other.Flowname != null)
				return false;
		} else if (!Flowname.equals(other.Flowname))
			return false;
		if (Flows == null) {
			if (other.Flows != null)
				return false;
		} else if (!Flows.equals(other.Flows))
			return false;
		if (Opertor == null) {
			if (other.Opertor != null)
				return false;
		} else if (!Opertor.equals(other.Opertor))
			return false;
		return true;
	}
	
	
	
	

}
