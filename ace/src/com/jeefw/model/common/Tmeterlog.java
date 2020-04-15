package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMETERLOG database table.
 * 
 */
@Entity
@NamedQuery(name="Tmeterlog.findAll", query="SELECT t FROM Tmeterlog t")
public class Tmeterlog implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	private BigDecimal autoid;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String gprs;

	@Column(name="\"LISTS\"")
	private String lists;

	private BigDecimal mbusid;

	private BigDecimal pooladdr;

	private String remark;

	private BigDecimal send;

	private BigDecimal sendcou;

	public Tmeterlog() {
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public BigDecimal getAutoid() {
		return this.autoid;
	}

	public void setAutoid(BigDecimal autoid) {
		this.autoid = autoid;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public String getGprs() {
		return this.gprs;
	}

	public void setGprs(String gprs) {
		this.gprs = gprs;
	}

	public String getLists() {
		return this.lists;
	}

	public void setLists(String lists) {
		this.lists = lists;
	}

	public BigDecimal getMbusid() {
		return this.mbusid;
	}

	public void setMbusid(BigDecimal mbusid) {
		this.mbusid = mbusid;
	}

	public BigDecimal getPooladdr() {
		return this.pooladdr;
	}

	public void setPooladdr(BigDecimal pooladdr) {
		this.pooladdr = pooladdr;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getSend() {
		return this.send;
	}

	public void setSend(BigDecimal send) {
		this.send = send;
	}

	public BigDecimal getSendcou() {
		return this.sendcou;
	}

	public void setSendcou(BigDecimal sendcou) {
		this.sendcou = sendcou;
	}

}