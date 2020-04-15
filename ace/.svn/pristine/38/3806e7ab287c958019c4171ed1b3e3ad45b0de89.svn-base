package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the FACTORYSECTIONINFO database table.
 * 
 */
@Entity
@NamedQuery(name="Factorysectioninfo.findAll", query="SELECT f FROM Factorysectioninfo f")
public class Factorysectioninfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Temporal(TemporalType.DATE)
	private Date adate;

	@Temporal(TemporalType.DATE)
	private Date bdate;

	private BigDecimal factoryid;

	private BigDecimal sectionid;

	private String sectionname;

	private String sectionphoto;

	@Column(name="\"YEARS\"")
	private String years;

	public Factorysectioninfo() {
	}

	public Date getAdate() {
		return this.adate;
	}

	public void setAdate(Date adate) {
		this.adate = adate;
	}

	public Date getBdate() {
		return this.bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}

	public BigDecimal getFactoryid() {
		return this.factoryid;
	}

	public void setFactoryid(BigDecimal factoryid) {
		this.factoryid = factoryid;
	}

	public BigDecimal getSectionid() {
		return this.sectionid;
	}

	public void setSectionid(BigDecimal sectionid) {
		this.sectionid = sectionid;
	}

	public String getSectionname() {
		return this.sectionname;
	}

	public void setSectionname(String sectionname) {
		this.sectionname = sectionname;
	}

	public String getSectionphoto() {
		return this.sectionphoto;
	}

	public void setSectionphoto(String sectionphoto) {
		this.sectionphoto = sectionphoto;
	}

	public String getYears() {
		return this.years;
	}

	public void setYears(String years) {
		this.years = years;
	}

}