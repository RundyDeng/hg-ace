package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TINFORMATION database table.
 * 
 */
@Entity
@NamedQuery(name="Tinformation.findAll", query="SELECT t FROM Tinformation t")
public class Tinformation implements Serializable {
	private static final long serialVersionUID = 1L;

	private String infauthor;

	@Lob
	private String infcontent;

	@Temporal(TemporalType.DATE)
	private Date infdate;

	private BigDecimal infid;

	private String infname;

	private BigDecimal inftype;

	private BigDecimal istg;

	public Tinformation() {
	}

	public String getInfauthor() {
		return this.infauthor;
	}

	public void setInfauthor(String infauthor) {
		this.infauthor = infauthor;
	}

	public String getInfcontent() {
		return this.infcontent;
	}

	public void setInfcontent(String infcontent) {
		this.infcontent = infcontent;
	}

	public Date getInfdate() {
		return this.infdate;
	}

	public void setInfdate(Date infdate) {
		this.infdate = infdate;
	}

	public BigDecimal getInfid() {
		return this.infid;
	}

	public void setInfid(BigDecimal infid) {
		this.infid = infid;
	}

	public String getInfname() {
		return this.infname;
	}

	public void setInfname(String infname) {
		this.infname = infname;
	}

	public BigDecimal getInftype() {
		return this.inftype;
	}

	public void setInftype(BigDecimal inftype) {
		this.inftype = inftype;
	}

	public BigDecimal getIstg() {
		return this.istg;
	}

	public void setIstg(BigDecimal istg) {
		this.istg = istg;
	}

}