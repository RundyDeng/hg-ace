package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TQIANFEI database table.
 * 
 */
@Entity
@NamedQuery(name="Tqianfei.findAll", query="SELECT t FROM Tqianfei t")
public class Tqianfei implements Serializable {
	private static final long serialVersionUID = 1L;

	private String memo;

	private double qfje;

	private double scjfjzds;

	private BigDecimal scjfpc;

	private String sfqf;

	private String yhbm;

	private String zxjfrq;

	public Tqianfei() {
	}

	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public double getQfje() {
		return this.qfje;
	}

	public void setQfje(double qfje) {
		this.qfje = qfje;
	}

	public double getScjfjzds() {
		return this.scjfjzds;
	}

	public void setScjfjzds(double scjfjzds) {
		this.scjfjzds = scjfjzds;
	}

	public BigDecimal getScjfpc() {
		return this.scjfpc;
	}

	public void setScjfpc(BigDecimal scjfpc) {
		this.scjfpc = scjfpc;
	}

	public String getSfqf() {
		return this.sfqf;
	}

	public void setSfqf(String sfqf) {
		this.sfqf = sfqf;
	}

	public String getYhbm() {
		return this.yhbm;
	}

	public void setYhbm(String yhbm) {
		this.yhbm = yhbm;
	}

	public String getZxjfrq() {
		return this.zxjfrq;
	}

	public void setZxjfrq(String zxjfrq) {
		this.zxjfrq = zxjfrq;
	}

}