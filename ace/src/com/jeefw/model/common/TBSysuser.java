package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the T_B_SYSUSER database table.
 * 
 */
@Entity
@Table(name="T_B_SYSUSER")
@NamedQuery(name="TBSysuser.findAll", query="SELECT t FROM TBSysuser t")
public class TBSysuser implements Serializable {
	private static final long serialVersionUID = 1L;

	private String deprt;

	private String factoryid;

	private BigDecimal id;

	private BigDecimal istrue;

	private String psw;

	private String roleid;

	private String sex;

	private String tel;

	private String usename;

	public TBSysuser() {
	}

	public String getDeprt() {
		return this.deprt;
	}

	public void setDeprt(String deprt) {
		this.deprt = deprt;
	}

	public String getFactoryid() {
		return this.factoryid;
	}

	public void setFactoryid(String factoryid) {
		this.factoryid = factoryid;
	}

	public BigDecimal getId() {
		return this.id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public BigDecimal getIstrue() {
		return this.istrue;
	}

	public void setIstrue(BigDecimal istrue) {
		this.istrue = istrue;
	}

	public String getPsw() {
		return this.psw;
	}

	public void setPsw(String psw) {
		this.psw = psw;
	}

	public String getRoleid() {
		return this.roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getUsename() {
		return this.usename;
	}

	public void setUsename(String usename) {
		this.usename = usename;
	}

}