package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDEVICE database table.
 * 
 */
@Entity
@NamedQuery(name="Tdevice.findAll", query="SELECT t FROM Tdevice t")
public class Tdevice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long deviceno;

	private BigDecimal areaguid;

	private BigDecimal cdata;

	private BigDecimal channelno;

	private BigDecimal customid;

	private BigDecimal deviceaddress;

	private BigDecimal devicenumber;

	private BigDecimal devicetypechildno;

	private String devicetypename;

	private BigDecimal devicetypeno;

	private BigDecimal dishu;

	private BigDecimal gprsno;

	private BigDecimal meterno;

	private BigDecimal meterseq;

	private BigDecimal poolno;

	private String remark;

	public Tdevice() {
	}

	public long getDeviceno() {
		return this.deviceno;
	}

	public void setDeviceno(long deviceno) {
		this.deviceno = deviceno;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public BigDecimal getCdata() {
		return this.cdata;
	}

	public void setCdata(BigDecimal cdata) {
		this.cdata = cdata;
	}

	public BigDecimal getChannelno() {
		return this.channelno;
	}

	public void setChannelno(BigDecimal channelno) {
		this.channelno = channelno;
	}

	public BigDecimal getCustomid() {
		return this.customid;
	}

	public void setCustomid(BigDecimal customid) {
		this.customid = customid;
	}

	public BigDecimal getDeviceaddress() {
		return this.deviceaddress;
	}

	public void setDeviceaddress(BigDecimal deviceaddress) {
		this.deviceaddress = deviceaddress;
	}

	public BigDecimal getDevicenumber() {
		return this.devicenumber;
	}

	public void setDevicenumber(BigDecimal devicenumber) {
		this.devicenumber = devicenumber;
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

	public BigDecimal getDishu() {
		return this.dishu;
	}

	public void setDishu(BigDecimal dishu) {
		this.dishu = dishu;
	}

	public BigDecimal getGprsno() {
		return this.gprsno;
	}

	public void setGprsno(BigDecimal gprsno) {
		this.gprsno = gprsno;
	}

	public BigDecimal getMeterno() {
		return this.meterno;
	}

	public void setMeterno(BigDecimal meterno) {
		this.meterno = meterno;
	}

	public BigDecimal getMeterseq() {
		return this.meterseq;
	}

	public void setMeterseq(BigDecimal meterseq) {
		this.meterseq = meterseq;
	}

	public BigDecimal getPoolno() {
		return this.poolno;
	}

	public void setPoolno(BigDecimal poolno) {
		this.poolno = poolno;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}