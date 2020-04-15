package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TINFORMATIONTYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Tinformationtype.findAll", query="SELECT t FROM Tinformationtype t")
public class Tinformationtype implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal infid;

	private String infname;

	private BigDecimal inftype;

	public Tinformationtype() {
	}

	public BigDecimal getInfid() {
		return this.infid;
	}

	public void setInfid(BigDecimal infid) {
		this.infid = infid;
	}

	public String getInfname() {
		return this.infname;
	}

	public void setInfname(String infname) {
		this.infname = infname;
	}

	public BigDecimal getInftype() {
		return this.inftype;
	}

	public void setInftype(BigDecimal inftype) {
		this.inftype = inftype;
	}

}