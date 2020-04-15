package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TCOMMTYPE database table.
 * 
 */
@Entity
@NamedQuery(name="Tcommtype.findAll", query="SELECT t FROM Tcommtype t")
public class Tcommtype implements Serializable {
	private static final long serialVersionUID = 1L;

	private String commname;

	private BigDecimal commtype;

	public Tcommtype() {
	}

	public String getCommname() {
		return this.commname;
	}

	public void setCommname(String commname) {
		this.commname = commname;
	}

	public BigDecimal getCommtype() {
		return this.commtype;
	}

	public void setCommtype(BigDecimal commtype) {
		this.commtype = commtype;
	}

}