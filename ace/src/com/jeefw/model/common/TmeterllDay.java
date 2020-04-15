package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMETERLL_DAY database table.
 * 
 */
@Entity
@Table(name="TMETERLL_DAY")
@NamedQuery(name="TmeterllDay.findAll", query="SELECT t FROM TmeterllDay t")
public class TmeterllDay implements Serializable {
	private static final long serialVersionUID = 1L;

	private double area;

	private BigDecimal areaguid;

	private String areaguidname;

	private String buildname;

	private String customerid;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String doorname;

	private double eliuliang;

	@Temporal(TemporalType.DATE)
	private Date etime;

	private double liuliang;

	private String meterid;

	private double sliuliang;

	private String status;

	@Temporal(TemporalType.DATE)
	private Date stime;

	private String unitno;

	private String ysqd;

	private String ystr;

	public TmeterllDay() {
	}

	public double getArea() {
		return this.area;
	}

	public void setArea(double area) {
		this.area = area;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public String getAreaguidname() {
		return this.areaguidname;
	}

	public void setAreaguidname(String areaguidname) {
		this.areaguidname = areaguidname;
	}

	public String getBuildname() {
		return this.buildname;
	}

	public void setBuildname(String buildname) {
		this.buildname = buildname;
	}

	public String getCustomerid() {
		return this.customerid;
	}

	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public String getDoorname() {
		return this.doorname;
	}

	public void setDoorname(String doorname) {
		this.doorname = doorname;
	}

	public double getEliuliang() {
		return this.eliuliang;
	}

	public void setEliuliang(double eliuliang) {
		this.eliuliang = eliuliang;
	}

	public Date getEtime() {
		return this.etime;
	}

	public void setEtime(Date etime) {
		this.etime = etime;
	}

	public double getLiuliang() {
		return this.liuliang;
	}

	public void setLiuliang(double liuliang) {
		this.liuliang = liuliang;
	}

	public String getMeterid() {
		return this.meterid;
	}

	public void setMeterid(String meterid) {
		this.meterid = meterid;
	}

	public double getSliuliang() {
		return this.sliuliang;
	}

	public void setSliuliang(double sliuliang) {
		this.sliuliang = sliuliang;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getStime() {
		return this.stime;
	}

	public void setStime(Date stime) {
		this.stime = stime;
	}

	public String getUnitno() {
		return this.unitno;
	}

	public void setUnitno(String unitno) {
		this.unitno = unitno;
	}

	public String getYsqd() {
		return this.ysqd;
	}

	public void setYsqd(String ysqd) {
		this.ysqd = ysqd;
	}

	public String getYstr() {
		return this.ystr;
	}

	public void setYstr(String ystr) {
		this.ystr = ystr;
	}

}