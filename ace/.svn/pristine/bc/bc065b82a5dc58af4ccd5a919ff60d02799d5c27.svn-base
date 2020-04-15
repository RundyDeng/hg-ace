package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TTASK database table.
 * 
 */
@Entity
@NamedQuery(name="Ttask.findAll", query="SELECT t FROM Ttask t")
public class Ttask implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long taskid;

	private BigDecimal channelcou;

	private BigDecimal channelcousuccess;

	private BigDecimal cnt;

	private BigDecimal cntsuccess;

	private BigDecimal gprscou;

	private BigDecimal gprscousuccess;

	private BigDecimal poolcou;

	private BigDecimal poolcousuccess;

	private BigDecimal status;

	@Temporal(TemporalType.DATE)
	private Date taskdate;

	//bi-directional many-to-one association to Tauto
	@ManyToOne
	@JoinColumn(name="AUTOSETID")
	private Tauto tauto;

	public Ttask() {
	}

	public long getTaskid() {
		return this.taskid;
	}

	public void setTaskid(long taskid) {
		this.taskid = taskid;
	}

	public BigDecimal getChannelcou() {
		return this.channelcou;
	}

	public void setChannelcou(BigDecimal channelcou) {
		this.channelcou = channelcou;
	}

	public BigDecimal getChannelcousuccess() {
		return this.channelcousuccess;
	}

	public void setChannelcousuccess(BigDecimal channelcousuccess) {
		this.channelcousuccess = channelcousuccess;
	}

	public BigDecimal getCnt() {
		return this.cnt;
	}

	public void setCnt(BigDecimal cnt) {
		this.cnt = cnt;
	}

	public BigDecimal getCntsuccess() {
		return this.cntsuccess;
	}

	public void setCntsuccess(BigDecimal cntsuccess) {
		this.cntsuccess = cntsuccess;
	}

	public BigDecimal getGprscou() {
		return this.gprscou;
	}

	public void setGprscou(BigDecimal gprscou) {
		this.gprscou = gprscou;
	}

	public BigDecimal getGprscousuccess() {
		return this.gprscousuccess;
	}

	public void setGprscousuccess(BigDecimal gprscousuccess) {
		this.gprscousuccess = gprscousuccess;
	}

	public BigDecimal getPoolcou() {
		return this.poolcou;
	}

	public void setPoolcou(BigDecimal poolcou) {
		this.poolcou = poolcou;
	}

	public BigDecimal getPoolcousuccess() {
		return this.poolcousuccess;
	}

	public void setPoolcousuccess(BigDecimal poolcousuccess) {
		this.poolcousuccess = poolcousuccess;
	}

	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	public Date getTaskdate() {
		return this.taskdate;
	}

	public void setTaskdate(Date taskdate) {
		this.taskdate = taskdate;
	}

	public Tauto getTauto() {
		return this.tauto;
	}

	public void setTauto(Tauto tauto) {
		this.tauto = tauto;
	}

}