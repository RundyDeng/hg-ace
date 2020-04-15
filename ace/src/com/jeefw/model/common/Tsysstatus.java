package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TSYSSTATUS database table.
 * 
 */
@Entity
@NamedQuery(name="Tsysstatus.findAll", query="SELECT t FROM Tsysstatus t")
public class Tsysstatus implements Serializable {
	private static final long serialVersionUID = 1L;

	private String failurecondition;

	private String failurename;

	private BigDecimal id;

	private BigDecimal metertype;

	private String msid;

	private String msname;

	@Column(name="\"TYPE\"")
	private BigDecimal type;

	public Tsysstatus() {
	}

	public String getFailurecondition() {
		return this.failurecondition;
	}

	public void setFailurecondition(String failurecondition) {
		this.failurecondition = failurecondition;
	}

	public String getFailurename() {
		return this.failurename;
	}

	public void setFailurename(String failurename) {
		this.failurename = failurename;
	}

	public BigDecimal getId() {
		return this.id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public BigDecimal getMetertype() {
		return this.metertype;
	}

	public void setMetertype(BigDecimal metertype) {
		this.metertype = metertype;
	}

	public String getMsid() {
		return this.msid;
	}

	public void setMsid(String msid) {
		this.msid = msid;
	}

	public String getMsname() {
		return this.msname;
	}

	public void setMsname(String msname) {
		this.msname = msname;
	}

	public BigDecimal getType() {
		return this.type;
	}

	public void setType(BigDecimal type) {
		this.type = type;
	}

}