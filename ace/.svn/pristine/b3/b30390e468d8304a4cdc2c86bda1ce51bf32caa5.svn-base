package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TRUNAREA database table.
 * 
 */
@Entity
@NamedQuery(name="Trunarea.findAll", query="SELECT t FROM Trunarea t")
public class Trunarea implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	private String areaname;

	private String autorunid;

	@Temporal(TemporalType.DATE)
	private Date autoruntime;

	private BigDecimal port;

	private BigDecimal yesorno;

	public Trunarea() {
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public String getAutorunid() {
		return this.autorunid;
	}

	public void setAutorunid(String autorunid) {
		this.autorunid = autorunid;
	}

	public Date getAutoruntime() {
		return this.autoruntime;
	}

	public void setAutoruntime(Date autoruntime) {
		this.autoruntime = autoruntime;
	}

	public BigDecimal getPort() {
		return this.port;
	}

	public void setPort(BigDecimal port) {
		this.port = port;
	}

	public BigDecimal getYesorno() {
		return this.yesorno;
	}

	public void setYesorno(BigDecimal yesorno) {
		this.yesorno = yesorno;
	}

}