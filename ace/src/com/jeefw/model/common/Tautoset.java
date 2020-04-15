package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TAUTOSET database table.
 * 
 */
@Entity
@NamedQuery(name="Tautoset.findAll", query="SELECT t FROM Tautoset t")
public class Tautoset implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long autoid;

	private BigDecimal autoday;

	private BigDecimal automonth;

	@Temporal(TemporalType.DATE)
	private Date autotime1;

	private BigDecimal autotype;

	private BigDecimal autoyear;

	private BigDecimal yesorno;

	public Tautoset() {
	}

	public long getAutoid() {
		return this.autoid;
	}

	public void setAutoid(long autoid) {
		this.autoid = autoid;
	}

	public BigDecimal getAutoday() {
		return this.autoday;
	}

	public void setAutoday(BigDecimal autoday) {
		this.autoday = autoday;
	}

	public BigDecimal getAutomonth() {
		return this.automonth;
	}

	public void setAutomonth(BigDecimal automonth) {
		this.automonth = automonth;
	}

	public Date getAutotime1() {
		return this.autotime1;
	}

	public void setAutotime1(Date autotime1) {
		this.autotime1 = autotime1;
	}

	public BigDecimal getAutotype() {
		return this.autotype;
	}

	public void setAutotype(BigDecimal autotype) {
		this.autotype = autotype;
	}

	public BigDecimal getAutoyear() {
		return this.autoyear;
	}

	public void setAutoyear(BigDecimal autoyear) {
		this.autoyear = autoyear;
	}

	public BigDecimal getYesorno() {
		return this.yesorno;
	}

	public void setYesorno(BigDecimal yesorno) {
		this.yesorno = yesorno;
	}

}