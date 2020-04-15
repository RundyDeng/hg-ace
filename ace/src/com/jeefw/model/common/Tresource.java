package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TRESOURCE database table.
 * 
 */
@Entity
@NamedQuery(name="Tresource.findAll", query="SELECT t FROM Tresource t")
public class Tresource implements Serializable {
	private static final long serialVersionUID = 1L;

	private String itemcode;

	private String itemname;

	private String itemparent;

	private BigDecimal resourceid;

	private String resourcename;

	public Tresource() {
	}

	public String getItemcode() {
		return this.itemcode;
	}

	public void setItemcode(String itemcode) {
		this.itemcode = itemcode;
	}

	public String getItemname() {
		return this.itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemparent() {
		return this.itemparent;
	}

	public void setItemparent(String itemparent) {
		this.itemparent = itemparent;
	}

	public BigDecimal getResourceid() {
		return this.resourceid;
	}

	public void setResourceid(BigDecimal resourceid) {
		this.resourceid = resourceid;
	}

	public String getResourcename() {
		return this.resourcename;
	}

	public void setResourcename(String resourcename) {
		this.resourcename = resourcename;
	}

}