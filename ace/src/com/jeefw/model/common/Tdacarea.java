package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TDACAREA database table.
 * 
 */
@Entity
@NamedQuery(name="Tdacarea.findAll", query="SELECT t FROM Tdacarea t")
public class Tdacarea implements Serializable {
	private static final long serialVersionUID = 1L;

	private BigDecimal areaid;

	//bi-directional many-to-one association to Tdacserver
	@ManyToOne
	@JoinColumn(name="DACID")
	private Tdacserver tdacserver;

	public Tdacarea() {
	}

	public BigDecimal getAreaid() {
		return this.areaid;
	}

	public void setAreaid(BigDecimal areaid) {
		this.areaid = areaid;
	}

	public Tdacserver getTdacserver() {
		return this.tdacserver;
	}

	public void setTdacserver(Tdacserver tdacserver) {
		this.tdacserver = tdacserver;
	}

}