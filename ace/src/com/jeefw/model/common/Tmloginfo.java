package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMLOGINFO database table.
 * 
 */
@Entity
@NamedQuery(name="Tmloginfo.findAll", query="SELECT t FROM Tmloginfo t")
public class Tmloginfo implements Serializable {
	private static final long serialVersionUID = 1L;

	private String mlogmemo;

	@Temporal(TemporalType.DATE)
	private Date mlogtime;

	private BigDecimal mlogtypeid;

	private String mlogtypename;

	private String mloguser;

	public Tmloginfo() {
	}

	public String getMlogmemo() {
		return this.mlogmemo;
	}

	public void setMlogmemo(String mlogmemo) {
		this.mlogmemo = mlogmemo;
	}

	public Date getMlogtime() {
		return this.mlogtime;
	}

	public void setMlogtime(Date mlogtime) {
		this.mlogtime = mlogtime;
	}

	public BigDecimal getMlogtypeid() {
		return this.mlogtypeid;
	}

	public void setMlogtypeid(BigDecimal mlogtypeid) {
		this.mlogtypeid = mlogtypeid;
	}

	public String getMlogtypename() {
		return this.mlogtypename;
	}

	public void setMlogtypename(String mlogtypename) {
		this.mlogtypename = mlogtypename;
	}

	public String getMloguser() {
		return this.mloguser;
	}

	public void setMloguser(String mloguser) {
		this.mloguser = mloguser;
	}

}