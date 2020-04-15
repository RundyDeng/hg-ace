package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TCLIENTMODIFYRECORD database table.
 * 
 */
@Entity
@NamedQuery(name="Tclientmodifyrecord.findAll", query="SELECT t FROM Tclientmodifyrecord t")
public class Tclientmodifyrecord implements Serializable {
	private static final long serialVersionUID = 1L;

	private String clientname;

	private String clientno;

	@Temporal(TemporalType.DATE)
	private Date modiydate;

	private BigDecimal recordid;

	private String remarks;

	private String username;

	public Tclientmodifyrecord() {
	}

	public String getClientname() {
		return this.clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public Date getModiydate() {
		return this.modiydate;
	}

	public void setModiydate(Date modiydate) {
		this.modiydate = modiydate;
	}

	public BigDecimal getRecordid() {
		return this.recordid;
	}

	public void setRecordid(BigDecimal recordid) {
		this.recordid = recordid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}