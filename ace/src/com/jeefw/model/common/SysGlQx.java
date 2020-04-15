package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the SYS_GL_QX database table.
 * 
 */
@Entity
@Table(name="SYS_GL_QX")
@NamedQuery(name="SysGlQx.findAll", query="SELECT s FROM SysGlQx s")
public class SysGlQx implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="GL_ID")
	private String glId;

	@Column(name="FW_QX")
	private BigDecimal fwQx;

	@Column(name="FX_QX")
	private BigDecimal fxQx;

	private BigDecimal qx1;

	private BigDecimal qx2;

	private BigDecimal qx3;

	private BigDecimal qx4;

	@Column(name="ROLE_ID")
	private String roleId;

	public SysGlQx() {
	}

	public String getGlId() {
		return this.glId;
	}

	public void setGlId(String glId) {
		this.glId = glId;
	}

	public BigDecimal getFwQx() {
		return this.fwQx;
	}

	public void setFwQx(BigDecimal fwQx) {
		this.fwQx = fwQx;
	}

	public BigDecimal getFxQx() {
		return this.fxQx;
	}

	public void setFxQx(BigDecimal fxQx) {
		this.fxQx = fxQx;
	}

	public BigDecimal getQx1() {
		return this.qx1;
	}

	public void setQx1(BigDecimal qx1) {
		this.qx1 = qx1;
	}

	public BigDecimal getQx2() {
		return this.qx2;
	}

	public void setQx2(BigDecimal qx2) {
		this.qx2 = qx2;
	}

	public BigDecimal getQx3() {
		return this.qx3;
	}

	public void setQx3(BigDecimal qx3) {
		this.qx3 = qx3;
	}

	public BigDecimal getQx4() {
		return this.qx4;
	}

	public void setQx4(BigDecimal qx4) {
		this.qx4 = qx4;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

}