package com.jeefw.model.haskey;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

import com.jeefw.model.haskey.param.WarringsparmsetP;

@Entity
@NamedQuery(name="Warringsparmset.findAll", query="SELECT w FROM Warringsparmset w")
public class Warringsparmset extends WarringsparmsetP {
	@Id
	@GeneratedValue(generator = "warningsparmstTableGenerator")
	@GenericGenerator(name = "warningsparmstTableGenerator" , strategy="assigned")
	@Column(name="id")
	private int id;
	@Temporal(TemporalType.DATE)
	private Date edate;
	@Column(name="ffmeterssllmax")
	private float ffmeterssllmax;
	@Column(name="ffmeterssllmin")
	private float ffmeterssllmin;
	@Column(name="hswdmax")
	private float hswdmax;
	@Column(name="hswdmin")
	private float hswdmin;
	@Column(name="jswdmax")
	private float jswdmax;
	@Column(name="jswdmin")
	private float jswdmin;
	@Column(name="meterssllmax")
	private float meterssllmax;
	@Column(name="meterssllmin")
	private float meterssllmin;
	@Column(name="sdate")
	@Temporal(TemporalType.DATE)
	private Date sdate;
	@Column(name="wcmax")
	private float wcmax;
	@Column(name="wcmin")
	private float wcmin;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getEdate() {
		return edate;
	}
	public void setEdate(Date edate) {
		this.edate = edate;
	}
	public float getFfmeterssllmax() {
		return ffmeterssllmax;
	}
	public void setFfmeterssllmax(float ffmeterssllmax) {
		this.ffmeterssllmax = ffmeterssllmax;
	}
	public float getFfmeterssllmin() {
		return ffmeterssllmin;
	}
	public void setFfmeterssllmin(float ffmeterssllmin) {
		this.ffmeterssllmin = ffmeterssllmin;
	}
	public float getHswdmax() {
		return hswdmax;
	}
	public void setHswdmax(float hswdmax) {
		this.hswdmax = hswdmax;
	}
	public float getHswdmin() {
		return hswdmin;
	}
	public void setHswdmin(float hswdmin) {
		this.hswdmin = hswdmin;
	}
	public float getJswdmax() {
		return jswdmax;
	}
	public void setJswdmax(float jswdmax) {
		this.jswdmax = jswdmax;
	}
	public float getJswdmin() {
		return jswdmin;
	}
	public void setJswdmin(float jswdmin) {
		this.jswdmin = jswdmin;
	}
	public float getMeterssllmax() {
		return meterssllmax;
	}
	public void setMeterssllmax(float meterssllmax) {
		this.meterssllmax = meterssllmax;
	}
	public float getMeterssllmin() {
		return meterssllmin;
	}
	public void setMeterssllmin(float meterssllmin) {
		this.meterssllmin = meterssllmin;
	}
	public Date getSdate() {
		return sdate;
	}
	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
	public float getWcmax() {
		return wcmax;
	}
	public void setWcmax(float wcmax) {
		this.wcmax = wcmax;
	}
	public float getWcmin() {
		return wcmin;
	}
	public void setWcmin(float wcmin) {
		this.wcmin = wcmin;
	}


}