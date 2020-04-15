package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the T_B_ROLE database table.
 * 
 */
@Entity
@Table(name="T_B_ROLE")
@NamedQuery(name="TBRole.findAll", query="SELECT t FROM TBRole t")
public class TBRole implements Serializable {
	private static final long serialVersionUID = 1L;

	private String roleid;

	private String rolename;

	public TBRole() {
	}

	public String getRoleid() {
		return this.roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

}