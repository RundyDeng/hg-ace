package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the SYS_ROLE_BATIS database table.
 * 
 */
@Entity
@Table(name="SYS_ROLE_BATIS")
@NamedQuery(name="SysRoleBati.findAll", query="SELECT s FROM SysRoleBati s")
public class SysRoleBati implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ROLE_ID")
	private String roleId;

	@Column(name="ADD_QX")
	private String addQx;

	@Column(name="CHA_QX")
	private String chaQx;

	@Column(name="DEL_QX")
	private String delQx;

	@Column(name="EDIT_QX")
	private String editQx;

	@Column(name="PARENT_ID")
	private String parentId;

	@Column(name="QX_ID")
	private String qxId;

	private String rights;

	@Column(name="ROLE_NAME")
	private String roleName;

	public SysRoleBati() {
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getAddQx() {
		return this.addQx;
	}

	public void setAddQx(String addQx) {
		this.addQx = addQx;
	}

	public String getChaQx() {
		return this.chaQx;
	}

	public void setChaQx(String chaQx) {
		this.chaQx = chaQx;
	}

	public String getDelQx() {
		return this.delQx;
	}

	public void setDelQx(String delQx) {
		this.delQx = delQx;
	}

	public String getEditQx() {
		return this.editQx;
	}

	public void setEditQx(String editQx) {
		this.editQx = editQx;
	}

	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getQxId() {
		return this.qxId;
	}

	public void setQxId(String qxId) {
		this.qxId = qxId;
	}

	public String getRights() {
		return this.rights;
	}

	public void setRights(String rights) {
		this.rights = rights;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

}