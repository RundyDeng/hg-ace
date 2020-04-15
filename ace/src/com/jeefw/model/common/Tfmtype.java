package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TFMTYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Tfmtype.findAll", query="SELECT t FROM Tfmtype t")
public class Tfmtype implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal fmguid;

	private String fmname;

	private BigDecimal fmtype;

	public Tfmtype() {
	}

	public BigDecimal getFmguid() {
		return this.fmguid;
	}

	public void setFmguid(BigDecimal fmguid) {
		this.fmguid = fmguid;
	}

	public String getFmname() {
		return this.fmname;
	}

	public void setFmname(String fmname) {
		this.fmname = fmname;
	}

	public BigDecimal getFmtype() {
		return this.fmtype;
	}

	public void setFmtype(BigDecimal fmtype) {
		this.fmtype = fmtype;
	}

}