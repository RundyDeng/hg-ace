package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the TLOG database table.
 * 
 */
@Entity
@NamedQuery(name="Tlog.findAll", query="SELECT t FROM Tlog t")
public class Tlog implements Serializable {
	private static final long serialVersionUID = 1L;

	private String logtype;

	@Column(name="\"OPERATION\"")
	private String operation;

	@Temporal(TemporalType.DATE)
	private Date operdate;

	private String operresult;

	private String username;

	public Tlog() {
	}

	public String getLogtype() {
		return this.logtype;
	}

	public void setLogtype(String logtype) {
		this.logtype = logtype;
	}

	public String getOperation() {
		return this.operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public Date getOperdate() {
		return this.operdate;
	}

	public void setOperdate(Date operdate) {
		this.operdate = operdate;
	}

	public String getOperresult() {
		return this.operresult;
	}

	public void setOperresult(String operresult) {
		this.operresult = operresult;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}