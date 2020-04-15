package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDOOR database table.
 * 
 */
@Entity
@NamedQuery(name="Tdoor.findAll", query="SELECT t FROM Tdoor t")
public class Tdoor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long doorno;

	private double area;

	private BigDecimal buildno;

	private String doorname;

	private BigDecimal floorno;

	private BigDecimal unitno;

	public Tdoor() {
	}

	public long getDoorno() {
		return this.doorno;
	}

	public void setDoorno(long doorno) {
		this.doorno = doorno;
	}

	public double getArea() {
		return this.area;
	}

	public void setArea(double area) {
		this.area = area;
	}

	public BigDecimal getBuildno() {
		return this.buildno;
	}

	public void setBuildno(BigDecimal buildno) {
		this.buildno = buildno;
	}

	public String getDoorname() {
		return this.doorname;
	}

	public void setDoorname(String doorname) {
		this.doorname = doorname;
	}

	public BigDecimal getFloorno() {
		return this.floorno;
	}

	public void setFloorno(BigDecimal floorno) {
		this.floorno = floorno;
	}

	public BigDecimal getUnitno() {
		return this.unitno;
	}

	public void setUnitno(BigDecimal unitno) {
		this.unitno = unitno;
	}

}