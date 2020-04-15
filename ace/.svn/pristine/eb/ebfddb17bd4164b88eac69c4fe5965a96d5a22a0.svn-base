package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TSYSPARAMS database table.
 * 
 */
@Entity
@Table(name="TSYSPARAMS")
@NamedQuery(name="Tsysparam.findAll", query="SELECT t FROM Tsysparam t")
public class Tsysparam implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal itemid;

	private String itemname;

	private String itemvalue;

	private String itemvaluetype;

	private BigDecimal typeid;

	private String typename;

	public Tsysparam() {
	}

	public BigDecimal getItemid() {
		return this.itemid;
	}

	public void setItemid(BigDecimal itemid) {
		this.itemid = itemid;
	}

	public String getItemname() {
		return this.itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemvalue() {
		return this.itemvalue;
	}

	public void setItemvalue(String itemvalue) {
		this.itemvalue = itemvalue;
	}

	public String getItemvaluetype() {
		return this.itemvaluetype;
	}

	public void setItemvaluetype(String itemvaluetype) {
		this.itemvaluetype = itemvaluetype;
	}

	public BigDecimal getTypeid() {
		return this.typeid;
	}

	public void setTypeid(BigDecimal typeid) {
		this.typeid = typeid;
	}

	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

}