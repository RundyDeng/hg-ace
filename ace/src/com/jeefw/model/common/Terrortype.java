package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TERRORTYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Terrortype.findAll", query="SELECT t FROM Terrortype t")
public class Terrortype implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal errorguid;

	private String errorname;

	private BigDecimal errortype;

	public Terrortype() {
	}

	public BigDecimal getErrorguid() {
		return this.errorguid;
	}

	public void setErrorguid(BigDecimal errorguid) {
		this.errorguid = errorguid;
	}

	public String getErrorname() {
		return this.errorname;
	}

	public void setErrorname(String errorname) {
		this.errorname = errorname;
	}

	public BigDecimal getErrortype() {
		return this.errortype;
	}

	public void setErrortype(BigDecimal errortype) {
		this.errortype = errortype;
	}

}