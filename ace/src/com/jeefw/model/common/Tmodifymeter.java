package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMODIFYMETER database table.
 * 
 */
@Entity
@NamedQuery(name="Tmodifymeter.findAll", query="SELECT t FROM Tmodifymeter t")
public class Tmodifymeter implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	private String clientno;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private BigDecimal devicetype;

	private double dishu;

	private String meterid;

	private double produshu;

	private String prometerid;

	@Temporal(TemporalType.DATE)
	private Date shoufeidate;

	private String username;

	public Tmodifymeter() {
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public BigDecimal getDevicetype() {
		return this.devicetype;
	}

	public void setDevicetype(BigDecimal devicetype) {
		this.devicetype = devicetype;
	}

	public double getDishu() {
		return this.dishu;
	}

	public void setDishu(double dishu) {
		this.dishu = dishu;
	}

	public String getMeterid() {
		return this.meterid;
	}

	public void setMeterid(String meterid) {
		this.meterid = meterid;
	}

	public double getProdushu() {
		return this.produshu;
	}

	public void setProdushu(double produshu) {
		this.produshu = produshu;
	}

	public String getPrometerid() {
		return this.prometerid;
	}

	public void setPrometerid(String prometerid) {
		this.prometerid = prometerid;
	}

	public Date getShoufeidate() {
		return this.shoufeidate;
	}

	public void setShoufeidate(Date shoufeidate) {
		this.shoufeidate = shoufeidate;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}