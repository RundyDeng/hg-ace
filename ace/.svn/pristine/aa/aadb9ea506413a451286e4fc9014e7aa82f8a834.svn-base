package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the REG database table.
 * 
 */
@Entity
@NamedQuery(name="Reg.findAll", query="SELECT r FROM Reg r")
public class Reg implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String regid;

	private String regseriers;

	private BigDecimal status;

	public Reg() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public String getRegid() {
		return this.regid;
	}

	public void setRegid(String regid) {
		this.regid = regid;
	}

	public String getRegseriers() {
		return this.regseriers;
	}

	public void setRegseriers(String regseriers) {
		this.regseriers = regseriers;
	}

	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

}