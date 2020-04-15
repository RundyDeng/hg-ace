package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the TAUTO database table.
 * 
 */
@Entity
@NamedQuery(name="Tauto.findAll", query="SELECT t FROM Tauto t")
public class Tauto implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long autosetid;

	private BigDecimal autoid;

	private BigDecimal bccou;

	@Temporal(TemporalType.DATE)
	private Date begintime;

	@Temporal(TemporalType.DATE)
	private Date createtime;

	private BigDecimal tasktype;

	private BigDecimal yesorno;

	//bi-directional many-to-one association to Tdacserver
	@ManyToOne
	@JoinColumn(name="DACID")
	private Tdacserver tdacserver;

	//bi-directional many-to-one association to Ttask
	@OneToMany(mappedBy="tauto")
	private List<Ttask> ttasks;

	public Tauto() {
	}

	public long getAutosetid() {
		return this.autosetid;
	}

	public void setAutosetid(long autosetid) {
		this.autosetid = autosetid;
	}

	public BigDecimal getAutoid() {
		return this.autoid;
	}

	public void setAutoid(BigDecimal autoid) {
		this.autoid = autoid;
	}

	public BigDecimal getBccou() {
		return this.bccou;
	}

	public void setBccou(BigDecimal bccou) {
		this.bccou = bccou;
	}

	public Date getBegintime() {
		return this.begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public BigDecimal getTasktype() {
		return this.tasktype;
	}

	public void setTasktype(BigDecimal tasktype) {
		this.tasktype = tasktype;
	}

	public BigDecimal getYesorno() {
		return this.yesorno;
	}

	public void setYesorno(BigDecimal yesorno) {
		this.yesorno = yesorno;
	}

	public Tdacserver getTdacserver() {
		return this.tdacserver;
	}

	public void setTdacserver(Tdacserver tdacserver) {
		this.tdacserver = tdacserver;
	}

	public List<Ttask> getTtasks() {
		return this.ttasks;
	}

	public void setTtasks(List<Ttask> ttasks) {
		this.ttasks = ttasks;
	}

	public Ttask addTtask(Ttask ttask) {
		getTtasks().add(ttask);
		ttask.setTauto(this);

		return ttask;
	}

	public Ttask removeTtask(Ttask ttask) {
		getTtasks().remove(ttask);
		ttask.setTauto(null);

		return ttask;
	}

}