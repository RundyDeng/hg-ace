package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the T_B_USEAUTH_NEW database table.
 * 
 */
@Entity
@Table(name="T_B_USEAUTH_NEW")
@NamedQuery(name="TBUseauthNew.findAll", query="SELECT t FROM TBUseauthNew t")
public class TBUseauthNew implements Serializable {
	private static final long serialVersionUID = 1L;

	private String authid;

	private String hasauth;

	private String usename;

	public TBUseauthNew() {
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