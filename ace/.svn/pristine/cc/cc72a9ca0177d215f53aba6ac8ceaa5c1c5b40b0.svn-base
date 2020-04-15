package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TCLIENTCAT database table.
 * 
 */
@Entity
@NamedQuery(name="Tclientcat.findAll", query="SELECT t FROM Tclientcat t")
public class Tclientcat implements Serializable {
	private static final long serialVersionUID = 1L;

	private double cgprice;

	private String clientcat;

	private BigDecimal clientcatid;

	private double price;

	private String priceunit;

	public Tclientcat() {
	}

	public double getCgprice() {
		return this.cgprice;
	}

	public void setCgprice(double cgprice) {
		this.cgprice = cgprice;
	}

	public String getClientcat() {
		return this.clientcat;
	}

	public void setClientcat(String clientcat) {
		this.clientcat = clientcat;
	}

	public BigDecimal getClientcatid() {
		return this.clientcatid;
	}

	public void setClientcatid(BigDecimal clientcatid) {
		this.clientcatid = clientcatid;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getPriceunit() {
		return this.priceunit;
	}

	public void setPriceunit(String priceunit) {
		this.priceunit = priceunit;
	}

}