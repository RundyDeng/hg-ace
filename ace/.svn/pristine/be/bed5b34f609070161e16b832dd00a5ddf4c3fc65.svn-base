package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMETER_TASK database table.
 * 
 */
@Entity
@Table(name="TMETER_TASK")
@NamedQuery(name="TmeterTask.findAll", query="SELECT t FROM TmeterTask t")
public class TmeterTask implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaguid;

	private String clientno;

	private BigDecimal id;

	private BigDecimal isfinish;

	private BigDecimal meterno;

	@Temporal(TemporalType.DATE)
	private Date taskdate;

	private BigDecimal taskid;

	private String username;

	public TmeterTask() {
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public BigDecimal getId() {
		return this.id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public BigDecimal getIsfinish() {
		return this.isfinish;
	}

	public void setIsfinish(BigDecimal isfinish) {
		this.isfinish = isfinish;
	}

	public BigDecimal getMeterno() {
		return this.meterno;
	}

	public void setMeterno(BigDecimal meterno) {
		this.meterno = meterno;
	}

	public Date getTaskdate() {
		return this.taskdate;
	}

	public void setTaskdate(Date taskdate) {
		this.taskdate = taskdate;
	}

	public BigDecimal getTaskid() {
		return this.taskid;
	}

	public void setTaskid(BigDecimal taskid) {
		this.taskid = taskid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}