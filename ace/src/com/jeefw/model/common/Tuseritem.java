package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the TUSERITEM database table.
 * 
 */
@Entity
@NamedQuery(name="Tuseritem.findAll", query="SELECT t FROM Tuseritem t")
public class Tuseritem implements Serializable {
	private static final long serialVersionUID = 1L;

	private String itemcode;

	private String itemname;

	private String itemparent;

	private String username;

	public Tuseritem() {
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

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}