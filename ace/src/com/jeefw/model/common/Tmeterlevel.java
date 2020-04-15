package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TMETERLEVEL database table.
 * 
 */
@Entity
@NamedQuery(name="Tmeterlevel.findAll", query="SELECT t FROM Tmeterlevel t")
public class Tmeterlevel implements Serializable {
	private static final long serialVersionUID = 1L;

	private String meterlevel;

	private BigDecimal meterlevelid;

	public Tmeterlevel() {
	}

	public String getMeterlevel() {
		return this.meterlevel;
	}

	public void setMeterlevel(String meterlevel) {
		this.meterlevel = meterlevel;
	}

	public BigDecimal getMeterlevelid() {
		return this.meterlevelid;
	}

	public void setMeterlevelid(BigDecimal meterlevelid) {
		this.meterlevelid = meterlevelid;
	}

}