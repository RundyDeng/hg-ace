package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TSMSINFO database table.
 * 
 */
@Entity
@NamedQuery(name="Tsmsinfo.findAll", query="SELECT t FROM Tsmsinfo t")
public class Tsmsinfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String name;

	private BigDecimal phone;

	private String reakinfo;

	public Tsmsinfo() {
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