package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the SYS_MENU database table.
 * 
 */
@Entity
@Table(name="SYS_MENU")
@NamedQuery(name="SysMenu.findAll", query="SELECT s FROM SysMenu s")
public class SysMenu implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="MENU_ID")
	private long menuId;

	@Column(name="MENU_ICON")
	private String menuIcon;

	@Column(name="MENU_NAME")
	private String menuName;

	@Column(name="MENU_ORDER")
	private String menuOrder;

	@Column(name="MENU_TYPE")
	private String menuType;

	@Column(name="MENU_URL")
	private String menuUrl;

	@Column(name="PARENT_ID")
	private String parentId;

	public SysMenu() {
	}

	public long getMenuId() {
		return this.menuId;
	}

	public void setMenuId(long menuId) {
		this.menuId = menuId;
	}

	public String getMenuIcon() {
		return this.menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getMenuName() {
		return this.menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuOrder() {
		return this.menuOrder;
	}

	public void setMenuOrder(String menuOrder) {
		this.menuOrder = menuOrder;
	}

	public String getMenuType() {
		return this.menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getMenuUrl() {
		return this.menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}