package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the DEPARTMENT database table.
 * 
 */
@Entity
@NamedQuery(name="Department.findAll", query="SELECT d FROM Department d")
public class Department implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Column(name="DEPARTMENT_KEY")
	private String departmentKey;

	@Column(name="DEPARTMENT_VALUE")
	private String departmentValue;

	private String description;

	@Column(name="PARENT_DEPARTMENTKEY")
	private String parentDepartmentkey;

	public Department() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDepartmentKey() {
		return this.departmentKey;
	}

	public void setDepartmentKey(String departmentKey) {
		this.departmentKey = departmentKey;
	}

	public String getDepartmentValue() {
		return this.departmentValue;
	}

	public void setDepartmentValue(String departmentValue) {
		this.departmentValue = departmentValue;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getParentDepartmentkey() {
		return this.parentDepartmentkey;
	}

	public void setParentDepartmentkey(String parentDepartmentkey) {
		this.parentDepartmentkey = parentDepartmentkey;
	}

}