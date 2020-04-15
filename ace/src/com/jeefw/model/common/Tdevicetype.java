package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDEVICETYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Tdevicetype.findAll", query="SELECT t FROM Tdevicetype t")
public class Tdevicetype implements Serializable {
	private static final long serialVersionUID = 1L;

	private String devicesmybol;

	private BigDecimal devicetypeguid;

	private String devicetypename;

	private String smemo;

	public Tdevicetype() {
	}

	public String getDevicesmybol() {
		return this.devicesmybol;
	}

	public void setDevicesmybol(String devicesmybol) {
		this.devicesmybol = devicesmybol;
	}

	public BigDecimal getDevicetypeguid() {
		return this.devicetypeguid;
	}

	public void setDevicetypeguid(BigDecimal devicetypeguid) {
		this.devicetypeguid = devicetypeguid;
	}

	public String getDevicetypename() {
		return this.devicetypename;
	}

	public void setDevicetypename(String devicetypename) {
		this.devicetypename = devicetypename;
	}

	public String getSmemo() {
		return this.smemo;
	}

	public void setSmemo(String smemo) {
		this.smemo = smemo;
	}

}