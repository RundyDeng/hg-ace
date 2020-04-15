package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the TUSER database table.
 * 
 */
@Entity
@NamedQuery(name="Tuser.findAll", query="SELECT t FROM Tuser t")
public class Tuser implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private TuserPK id;

	private BigDecimal userlevel;

	private String userpass;

	public Tuser() {
	}

	public TuserPK getId() {
		return this.id;
	}

	public void setId(TuserPK id) {
		this.id = id;
	}

	public BigDecimal getUserlevel() {
		return this.userlevel;
	}

	public void setUserlevel(BigDecimal userlevel) {
		this.userlevel = userlevel;
	}

	public String getUserpass() {
		return this.userpass;
	}

	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}

}