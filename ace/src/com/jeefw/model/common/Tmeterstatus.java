package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TMETERSTATUS database table.
 * 
 */
@Entity
@NamedQuery(name="Tmeterstatus.findAll", query="SELECT t FROM Tmeterstatus t")
public class Tmeterstatus implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private BigDecimal metertype;

	private BigDecimal msid;

	private String msname;

	public Tmeterstatus() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getMetertype() {
		return this.metertype;
	}

	public void setMetertype(BigDecimal metertype) {
		this.metertype = metertype;
	}

	public BigDecimal getMsid() {
		return this.msid;
	}

	public void setMsid(BigDecimal msid) {
		this.msid = msid;
	}

	public String getMsname() {
		return this.msname;
	}

	public void setMsname(String msname) {
		this.msname = msname;
	}

}