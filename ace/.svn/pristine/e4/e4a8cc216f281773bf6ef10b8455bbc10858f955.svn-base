package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the SYS_DICTIONARIES database table.
 * 
 */
@Entity
@Table(name="SYS_DICTIONARIES")
@NamedQuery(name="SysDictionary.findAll", query="SELECT s FROM SysDictionary s")
public class SysDictionary implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ZD_ID")
	private String zdId;

	private String bianma;

	private BigDecimal jb;

	private String name;

	@Column(name="ORDY_BY")
	private BigDecimal ordyBy;

	@Column(name="P_BM")
	private String pBm;

	@Column(name="PARENT_ID")
	private String parentId;

	public SysDictionary() {
	}

	public String getZdId() {
		return this.zdId;
	}

	public void setZdId(String zdId) {
		this.zdId = zdId;
	}

	public String getBianma() {
		return this.bianma;
	}

	public void setBianma(String bianma) {
		this.bianma = bianma;
	}

	public BigDecimal getJb() {
		return this.jb;
	}

	public void setJb(BigDecimal jb) {
		this.jb = jb;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getOrdyBy() {
		return this.ordyBy;
	}

	public void setOrdyBy(BigDecimal ordyBy) {
		this.ordyBy = ordyBy;
	}

	public String getPBm() {
		return this.pBm;
	}

	public void setPBm(String pBm) {
		this.pBm = pBm;
	}

	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}