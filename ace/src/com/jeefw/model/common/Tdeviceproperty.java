package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDEVICEPROPERTY database table.
 * 
 */
@Entity
@NamedQuery(name="Tdeviceproperty.findAll", query="SELECT t FROM Tdeviceproperty t")
public class Tdeviceproperty implements Serializable {
	private static final long serialVersionUID = 1L;

	private String areafield;

	private BigDecimal areaguid;

	private String deviceaddress;

	private BigDecimal deviceseq;

	private BigDecimal devicetypeid;

	private BigDecimal devicetypeno;

	private String metercalibre;

	private BigDecimal meterlevelid;

	private String meterno;

	private BigDecimal meterqualityid;

	private BigDecimal multiple;

	private String parentmeterno;

	public Tdeviceproperty() {
	}

	public String getAreafield() {
		return this.areafield;
	}

	public void setAreafield(String areafield) {
		this.areafield = areafield;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public String getDeviceaddress() {
		return this.deviceaddress;
	}

	public void setDeviceaddress(String deviceaddress) {
		this.deviceaddress = deviceaddress;
	}

	public BigDecimal getDeviceseq() {
		return this.deviceseq;
	}

	public void setDeviceseq(BigDecimal deviceseq) {
		this.deviceseq = deviceseq;
	}

	public BigDecimal getDevicetypeid() {
		return this.devicetypeid;
	}

	public void setDevicetypeid(BigDecimal devicetypeid) {
		this.devicetypeid = devicetypeid;
	}

	public BigDecimal getDevicetypeno() {
		return this.devicetypeno;
	}

	public void setDevicetypeno(BigDecimal devicetypeno) {
		this.devicetypeno = devicetypeno;
	}

	public String getMetercalibre() {
		return this.metercalibre;
	}

	public void setMetercalibre(String metercalibre) {
		this.metercalibre = metercalibre;
	}

	public BigDecimal getMeterlevelid() {
		return this.meterlevelid;
	}

	public void setMeterlevelid(BigDecimal meterlevelid) {
		this.meterlevelid = meterlevelid;
	}

	public String getMeterno() {
		return this.meterno;
	}

	public void setMeterno(String meterno) {
		this.meterno = meterno;
	}

	public BigDecimal getMeterqualityid() {
		return this.meterqualityid;
	}

	public void setMeterqualityid(BigDecimal meterqualityid) {
		this.meterqualityid = meterqualityid;
	}

	public BigDecimal getMultiple() {
		return this.multiple;
	}

	public void setMultiple(BigDecimal multiple) {
		this.multiple = multiple;
	}

	public String getParentmeterno() {
		return this.parentmeterno;
	}

	public void setParentmeterno(String parentmeterno) {
		this.parentmeterno = parentmeterno;
	}

}