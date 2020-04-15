package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TGAIBIANTMETER database table.
 * 
 */
@Entity
@NamedQuery(name="Tgaibiantmeter.findAll", query="SELECT t FROM Tgaibiantmeter t")
public class Tgaibiantmeter implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	@Temporal(TemporalType.DATE)
	private Date changdate;

	private String changmeterno;

	private double changmetrnjll;

	private String clientno;

	private double meternjll;

	private String meterno;

	private double meteryl;

	private BigDecimal types;

	public Tgaibiantmeter() {
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public Date getChangdate() {
		return this.changdate;
	}

	public void setChangdate(Date changdate) {
		this.changdate = changdate;
	}

	public String getChangmeterno() {
		return this.changmeterno;
	}

	public void setChangmeterno(String changmeterno) {
		this.changmeterno = changmeterno;
	}

	public double getChangmetrnjll() {
		return this.changmetrnjll;
	}

	public void setChangmetrnjll(double changmetrnjll) {
		this.changmetrnjll = changmetrnjll;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public double getMeternjll() {
		return this.meternjll;
	}

	public void setMeternjll(double meternjll) {
		this.meternjll = meternjll;
	}

	public String getMeterno() {
		return this.meterno;
	}

	public void setMeterno(String meterno) {
		this.meterno = meterno;
	}

	public double getMeteryl() {
		return this.meteryl;
	}

	public void setMeteryl(double meteryl) {
		this.meteryl = meteryl;
	}

	public BigDecimal getTypes() {
		return this.types;
	}

	public void setTypes(BigDecimal types) {
		this.types = types;
	}

}