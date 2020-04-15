package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDOOR_METER database table.
 * 
 */
@Entity
@Table(name="TDOOR_METER")
@NamedQuery(name="TdoorMeter.findAll", query="SELECT t FROM TdoorMeter t")
public class TdoorMeter implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	private String clientno;

	private BigDecimal doorno;

	private BigDecimal meterno;

	private BigDecimal metertype;

	public TdoorMeter() {
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

	public BigDecimal getDoorno() {
		return this.doorno;
	}

	public void setDoorno(BigDecimal doorno) {
		this.doorno = doorno;
	}

	public BigDecimal getMeterno() {
		return this.meterno;
	}

	public void setMeterno(BigDecimal meterno) {
		this.meterno = meterno;
	}

	public BigDecimal getMetertype() {
		return this.metertype;
	}

	public void setMetertype(BigDecimal metertype) {
		this.metertype = metertype;
	}

}