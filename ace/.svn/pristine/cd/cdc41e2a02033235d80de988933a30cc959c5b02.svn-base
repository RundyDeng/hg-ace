package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TPOOL database table.
 * 
 */
@Entity
@NamedQuery(name="Tpool.findAll", query="SELECT t FROM Tpool t")
public class Tpool implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long poolno;

	private BigDecimal areaguid;

	private BigDecimal companyid;

	private BigDecimal gprsno;

	private BigDecimal pooladdr;

	private String poolfixlocation;

	private BigDecimal poolstatus;

	private String pooltime;

	public Tpool() {
	}

	public long getPoolno() {
		return this.poolno;
	}

	public void setPoolno(long poolno) {
		this.poolno = poolno;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public BigDecimal getCompanyid() {
		return this.companyid;
	}

	public void setCompanyid(BigDecimal companyid) {
		this.companyid = companyid;
	}

	public BigDecimal getGprsno() {
		return this.gprsno;
	}

	public void setGprsno(BigDecimal gprsno) {
		this.gprsno = gprsno;
	}

	public BigDecimal getPooladdr() {
		return this.pooladdr;
	}

	public void setPooladdr(BigDecimal pooladdr) {
		this.pooladdr = pooladdr;
	}

	public String getPoolfixlocation() {
		return this.poolfixlocation;
	}

	public void setPoolfixlocation(String poolfixlocation) {
		this.poolfixlocation = poolfixlocation;
	}

	public BigDecimal getPoolstatus() {
		return this.poolstatus;
	}

	public void setPoolstatus(BigDecimal poolstatus) {
		this.poolstatus = poolstatus;
	}

	public String getPooltime() {
		return this.pooltime;
	}

	public void setPooltime(String pooltime) {
		this.pooltime = pooltime;
	}

}