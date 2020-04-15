package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TUSERA database table.
 * 
 */
@Entity
@NamedQuery(name="Tusera.findAll", query="SELECT t FROM Tusera t")
public class Tusera implements Serializable {
	private static final long serialVersionUID = 1L;

	private String auth;

	private BigDecimal coued;

	private BigDecimal status;

	private String uname;

	private BigDecimal usecou;

	public Tusera() {
	}

	public String getAuth() {
		return this.auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public BigDecimal getCoued() {
		return this.coued;
	}

	public void setCoued(BigDecimal coued) {
		this.coued = coued;
	}

	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public String getUname() {
		return this.uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public BigDecimal getUsecou() {
		return this.usecou;
	}

	public void setUsecou(BigDecimal usecou) {
		this.usecou = usecou;
	}

}