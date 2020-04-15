package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TGPRS database table.
 * 
 */
@Entity
@Table(name="TGPRS")
@NamedQuery(name="Tgpr.findAll", query="SELECT t FROM Tgpr t")
public class Tgpr implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long gprsno;

	private BigDecimal areaguid;

	private BigDecimal commtype;

	private String gprsid;

	public Tgpr() {
	}

	public long getGprsno() {
		return this.gprsno;
	}

	public void setGprsno(long gprsno) {
		this.gprsno = gprsno;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public BigDecimal getCommtype() {
		return this.commtype;
	}

	public void setCommtype(BigDecimal commtype) {
		this.commtype = commtype;
	}

	public String getGprsid() {
		return this.gprsid;
	}

	public void setGprsid(String gprsid) {
		this.gprsid = gprsid;
	}

}