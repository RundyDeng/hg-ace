package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TSMSINFOLOG database table.
 * 
 */
@Entity
@NamedQuery(name="Tsmsinfolog.findAll", query="SELECT t FROM Tsmsinfolog t")
public class Tsmsinfolog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String fasongzhe;

	private String name;

	private BigDecimal phone;

	private String reakinfo;

	public Tsmsinfolog() {
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

	public String getFasongzhe() {
		return this.fasongzhe;
	}

	public void setFasongzhe(String fasongzhe) {
		this.fasongzhe = fasongzhe;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getPhone() {
		return this.phone;
	}

	public void setPhone(BigDecimal phone) {
		this.phone = phone;
	}

	public String getReakinfo() {
		return this.reakinfo;
	}

	public void setReakinfo(String reakinfo) {
		this.reakinfo = reakinfo;
	}

}