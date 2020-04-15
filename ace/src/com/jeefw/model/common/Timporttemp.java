package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TIMPORTTEMP database table.
 * 
 */
@Entity
@NamedQuery(name="Timporttemp.findAll", query="SELECT t FROM Timporttemp t")
public class Timporttemp implements Serializable {
	private static final long serialVersionUID = 1L;

	private String areacode;

	private String areaname;

	private String areavalue;

	private String buildcode;

	private String buildname;

	private BigDecimal channelno;

	private String clientno;

	private BigDecimal commtype;

	private BigDecimal devicetypechildno;

	private String devicetypename;

	private BigDecimal devicetypeno;

	private String doorname;

	private BigDecimal floorno;

	private String gprsid;

	private String meterid;

	private BigDecimal meterseq;

	private String no1;

	private String no2;

	private String pooladdr;

	private String remark;

	private BigDecimal unitno;

	private String wyid;

	public Timporttemp() {
	}

	public String getAreacode() {
		return this.areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public String getAreavalue() {
		return this.areavalue;
	}

	public void setAreavalue(String areavalue) {
		this.areavalue = areavalue;
	}

	public String getBuildcode() {
		return this.buildcode;
	}

	public void setBuildcode(String buildcode) {
		this.buildcode = buildcode;
	}

	public String getBuildname() {
		return this.buildname;
	}

	public void setBuildname(String buildname) {
		this.buildname = buildname;
	}

	public BigDecimal getChannelno() {
		return this.channelno;
	}

	public void setChannelno(BigDecimal channelno) {
		this.channelno = channelno;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public BigDecimal getCommtype() {
		return this.commtype;
	}

	public void setCommtype(BigDecimal commtype) {
		this.commtype = commtype;
	}

	public BigDecimal getDevicetypechildno() {
		return this.devicetypechildno;
	}

	public void setDevicetypechildno(BigDecimal devicetypechildno) {
		this.devicetypechildno = devicetypechildno;
	}

	public String getDevicetypename() {
		return this.devicetypename;
	}

	public void setDevicetypename(String devicetypename) {
		this.devicetypename = devicetypename;
	}

	public BigDecimal getDevicetypeno() {
		return this.devicetypeno;
	}

	public void setDevicetypeno(BigDecimal devicetypeno) {
		this.devicetypeno = devicetypeno;
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

	public String getGprsid() {
		return this.gprsid;
	}

	public void setGprsid(String gprsid) {
		this.gprsid = gprsid;
	}

	public String getMeterid() {
		return this.meterid;
	}

	public void setMeterid(String meterid) {
		this.meterid = meterid;
	}

	public BigDecimal getMeterseq() {
		return this.meterseq;
	}

	public void setMeterseq(BigDecimal meterseq) {
		this.meterseq = meterseq;
	}

	public String getNo1() {
		return this.no1;
	}

	public void setNo1(String no1) {
		this.no1 = no1;
	}

	public String getNo2() {
		return this.no2;
	}

	public void setNo2(String no2) {
		this.no2 = no2;
	}

	public String getPooladdr() {
		return this.pooladdr;
	}

	public void setPooladdr(String pooladdr) {
		this.pooladdr = pooladdr;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getUnitno() {
		return this.unitno;
	}

	public void setUnitno(BigDecimal unitno) {
		this.unitno = unitno;
	}

	public String getWyid() {
		return this.wyid;
	}

	public void setWyid(String wyid) {
		this.wyid = wyid;
	}

}