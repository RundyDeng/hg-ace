package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TMLOGTYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Tmlogtype.findAll", query="SELECT t FROM Tmlogtype t")
public class Tmlogtype implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal mlogtypeid;

	private String mlogtypename;

	public Tmlogtype() {
	}

	public BigDecimal getMlogtypeid() {
		return this.mlogtypeid;
	}

	public void setMlogtypeid(BigDecimal mlogtypeid) {
		this.mlogtypeid = mlogtypeid;
	}

	public String getMlogtypename() {
		return this.mlogtypename;
	}

	public void setMlogtypename(String mlogtypename) {
		this.mlogtypename = mlogtypename;
	}

}