package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TWENDU database table.
 * 
 */
@Entity
@NamedQuery(name="Twendu.findAll", query="SELECT t FROM Twendu t")
public class Twendu implements Serializable {
	private static final long serialVersionUID = 1L;

	private String areaname;

	private String ddate;

	private String qjwendu;

	private BigDecimal swwendu;

	public Twendu() {
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public String getDdate() {
		return this.ddate;
	}

	public void setDdate(String ddate) {
		this.ddate = ddate;
	}

	public String getQjwendu() {
		return this.qjwendu;
	}

	public void setQjwendu(String qjwendu) {
		this.qjwendu = qjwendu;
	}

	public BigDecimal getSwwendu() {
		return this.swwendu;
	}

	public void setSwwendu(BigDecimal swwendu) {
		this.swwendu = swwendu;
	}

}