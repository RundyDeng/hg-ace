package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the WARRINGSPARMSET database table.
 * 
 */
@Entity
@NamedQuery(name="Warringsparmset.findAll", query="SELECT w FROM Warringsparmset w")
public class Warringsparmset implements Serializable {
	private static final long serialVersionUID = 1L;

	@Temporal(TemporalType.DATE)
	private Date edate;

	private double ffmeterssllmax;

	private double ffmeterssllmin;

	private double hswdmax;

	private double hswdmin;

	private BigDecimal id;

	private double jswdmax;

	private double jswdmin;

	private double meterssllmax;

	private double meterssllmin;

	@Temporal(TemporalType.DATE)
	private Date sdate;

	private double wcmax;

	private double wcmin;

	public Warringsparmset() {
	}

	public Date getEdate() {
		return this.edate;
	}

	public void setEdate(Date edate) {
		this.edate = edate;
	}

	public double getFfmeterssllmax() {
		return this.ffmeterssllmax;
	}

	public void setFfmeterssllmax(double ffmeterssllmax) {
		this.ffmeterssllmax = ffmeterssllmax;
	}

	public double getFfmeterssllmin() {
		return this.ffmeterssllmin;
	}

	public void setFfmeterssllmin(double ffmeterssllmin) {
		this.ffmeterssllmin = ffmeterssllmin;
	}

	public double getHswdmax() {
		return this.hswdmax;
	}

	public void setHswdmax(double hswdmax) {
		this.hswdmax = hswdmax;
	}

	public double getHswdmin() {
		return this.hswdmin;
	}

	public void setHswdmin(double hswdmin) {
		this.hswdmin = hswdmin;
	}

	public BigDecimal getId() {
		return this.id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public double getJswdmax() {
		return this.jswdmax;
	}

	public void setJswdmax(double jswdmax) {
		this.jswdmax = jswdmax;
	}

	public double getJswdmin() {
		return this.jswdmin;
	}

	public void setJswdmin(double jswdmin) {
		this.jswdmin = jswdmin;
	}

	public double getMeterssllmax() {
		return this.meterssllmax;
	}

	public void setMeterssllmax(double meterssllmax) {
		this.meterssllmax = meterssllmax;
	}

	public double getMeterssllmin() {
		return this.meterssllmin;
	}

	public void setMeterssllmin(double meterssllmin) {
		this.meterssllmin = meterssllmin;
	}

	public Date getSdate() {
		return this.sdate;
	}

	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}

	public double getWcmax() {
		return this.wcmax;
	}

	public void setWcmax(double wcmax) {
		this.wcmax = wcmax;
	}

	public double getWcmin() {
		return this.wcmin;
	}

	public void setWcmin(double wcmin) {
		this.wcmin = wcmin;
	}

}