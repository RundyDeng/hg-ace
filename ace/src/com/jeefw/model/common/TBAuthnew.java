package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the T_B_AUTHNEW database table.
 * 
 */
@Entity
@Table(name="T_B_AUTHNEW")
@NamedQuery(name="TBAuthnew.findAll", query="SELECT t FROM TBAuthnew t")
public class TBAuthnew implements Serializable {
	private static final long serialVersionUID = 1L;

	private String authid;

	private String authname;

	private String isdisplay;

	private String istrue;

	private String parentauth;

	private String url;

	public TBAuthnew() {
	}

	public String getAuthid() {
		return this.authid;
	}

	public void setAuthid(String authid) {
		this.authid = authid;
	}

	public String getAuthname() {
		return this.authname;
	}

	public void setAuthname(String authname) {
		this.authname = authname;
	}

	public String getIsdisplay() {
		return this.isdisplay;
	}

	public void setIsdisplay(String isdisplay) {
		this.isdisplay = isdisplay;
	}

	public String getIstrue() {
		return this.istrue;
	}

	public void setIstrue(String istrue) {
		this.istrue = istrue;
	}

	public String getParentauth() {
		return this.parentauth;
	}

	public void setParentauth(String parentauth) {
		this.parentauth = parentauth;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}