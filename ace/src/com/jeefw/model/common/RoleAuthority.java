package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the ROLE_AUTHORITY database table.
 * 
 */
@Entity
@Table(name="ROLE_AUTHORITY")
@NamedQuery(name="RoleAuthority.findAll", query="SELECT r FROM RoleAuthority r")
public class RoleAuthority implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Column(name="MENU_CODE")
	private String menuCode;

	@Column(name="ROLE_KEY")
	private String roleKey;

	public RoleAuthority() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getMenuCode() {
		return this.menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getRoleKey() {
		return this.roleKey;
	}

	public void setRoleKey(String roleKey) {
		this.roleKey = roleKey;
	}

}