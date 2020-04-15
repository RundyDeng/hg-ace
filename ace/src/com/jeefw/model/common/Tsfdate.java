package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TSFDATE database table.
 * 
 */
@Entity
@NamedQuery(name="Tsfdate.findAll", query="SELECT t FROM Tsfdate t")
public class Tsfdate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Temporal(TemporalType.DATE)
	private Date adate;

	private BigDecimal areaguid;

	@Temporal(TemporalType.DATE)
	private Date bdate;

	@Column(name="\"YEARS\"")
	private BigDecimal years;

	public Tsfdate() {
	}

	public Date getAdate() {
		return this.adate;
	}

	public void setAdate(Date adate) {
		this.adate = adate;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public Date getBdate() {
		return this.bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}

	public BigDecimal getYears() {
		return this.years;
	}

	public void setYears(BigDecimal years) {
		this.years = years;
	}

}