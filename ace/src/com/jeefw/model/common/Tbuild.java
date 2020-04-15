package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TBUILD database table.
 * 
 */
@Entity
@NamedQuery(name="Tbuild.findAll", query="SELECT t FROM Tbuild t")
public class Tbuild implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long buildno;

	private BigDecimal areaguid;

	private String buildcode;

	private String buildname;

	private String nameinjifei;

	private BigDecimal totalfloor;

	private BigDecimal totalunit;

	public Tbuild() {
	}

	public long getBuildno() {
		return this.buildno;
	}

	public void setBuildno(long buildno) {
		this.buildno = buildno;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
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

	public String getNameinjifei() {
		return this.nameinjifei;
	}

	public void setNameinjifei(String nameinjifei) {
		this.nameinjifei = nameinjifei;
	}

	public BigDecimal getTotalfloor() {
		return this.totalfloor;
	}

	public void setTotalfloor(BigDecimal totalfloor) {
		this.totalfloor = totalfloor;
	}

	public BigDecimal getTotalunit() {
		return this.totalunit;
	}

	public void setTotalunit(BigDecimal totalunit) {
		this.totalunit = totalunit;
	}

}