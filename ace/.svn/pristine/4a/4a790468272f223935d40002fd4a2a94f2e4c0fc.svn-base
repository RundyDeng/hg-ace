package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the AUTHORITY database table.
 * 
 */
@Entity
@NamedQuery(name="Authority.findAll", query="SELECT a FROM Authority a")
public class Authority implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Column(name="DATA_URL")
	private String dataUrl;

	@Column(name="MENU_CLASS")
	private String menuClass;

	@Column(name="MENU_CODE")
	private String menuCode;

	@Column(name="MENU_NAME")
	private String menuName;

	@Column(name="PARENT_MENUCODE")
	private String parentMenucode;

	@Column(name="\"SEQUENCE\"")
	private BigDecimal sequence;

	public Authority() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDataUrl() {
		return this.dataUrl;
	}

	public void setDataUrl(String dataUrl) {
		this.dataUrl = dataUrl;
	}

	public String getMenuClass() {
		return this.menuClass;
	}

	public void setMenuClass(String menuClass) {
		this.menuClass = menuClass;
	}

	public String getMenuCode() {
		return this.menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuName() {
		return this.menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getParentMenucode() {
		return this.parentMenucode;
	}

	public void setParentMenucode(String parentMenucode) {
		this.parentMenucode = parentMenucode;
	}

	public BigDecimal getSequence() {
		return this.sequence;
	}

	public void setSequence(BigDecimal sequence) {
		this.sequence = sequence;
	}

}