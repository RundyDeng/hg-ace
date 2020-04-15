package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the ENERGYFACTORY database table.
 * 
 */
@Entity
@NamedQuery(name="Energyfactory.findAll", query="SELECT e FROM Energyfactory e")
public class Energyfactory implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal factoryid;

	private String factoryinfo;

	private String factoryname;

	public Energyfactory() {
	}

	public BigDecimal getFactoryid() {
		return this.factoryid;
	}

	public void setFactoryid(BigDecimal factoryid) {
		this.factoryid = factoryid;
	}

	public String getFactoryinfo() {
		return this.factoryinfo;
	}

	public void setFactoryinfo(String factoryinfo) {
		this.factoryinfo = factoryinfo;
	}

	public String getFactoryname() {
		return this.factoryname;
	}

	public void setFactoryname(String factoryname) {
		this.factoryname = factoryname;
	}

}