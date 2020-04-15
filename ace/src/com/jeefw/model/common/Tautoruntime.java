package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TAUTORUNTIME database table.
 * 
 */
@Entity
@NamedQuery(name="Tautoruntime.findAll", query="SELECT t FROM Tautoruntime t")
public class Tautoruntime implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private BigDecimal ahour;

	private BigDecimal amin;

	private String aname;

	private BigDecimal qidong;

	public Tautoruntime() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAhour() {
		return this.ahour;
	}

	public void setAhour(BigDecimal ahour) {
		this.ahour = ahour;
	}

	public BigDecimal getAmin() {
		return this.amin;
	}

	public void setAmin(BigDecimal amin) {
		this.amin = amin;
	}

	public String getAname() {
		return this.aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public BigDecimal getQidong() {
		return this.qidong;
	}

	public void setQidong(BigDecimal qidong) {
		this.qidong = qidong;
	}

}