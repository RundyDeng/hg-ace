package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the T_B_USEAUTH database table.
 * 
 */
@Entity
@Table(name="T_B_USEAUTH")
@NamedQuery(name="TBUseauth.findAll", query="SELECT t FROM TBUseauth t")
public class TBUseauth implements Serializable {
	private static final long serialVersionUID = 1L;

	private String authid;

	private String hasauth;

	private String usename;

	public TBUseauth() {
	}

	public String getAuthid() {
		return this.authid;
	}

	public void setAuthid(String authid) {
		this.authid = authid;
	}

	public String getHasauth() {
		return this.hasauth;
	}

	public void setHasauth(String hasauth) {
		this.hasauth = hasauth;
	}

	public String getUsename() {
		return this.usename;
	}

	public void setUsename(String usename) {
		this.usename = usename;
	}

}