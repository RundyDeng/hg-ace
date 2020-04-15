package com.jeefw.model.vo;

import java.util.List;

public class MenuTree {
	private String text;     //menuName  菜单名与以下level对应，分别是其名
	private int menuLevel;   //level，，1是热力公司 2是 换热站  3是小区
	private String menuId;   //  与level对应，，分别是热力公司id  换热站ID   小区guid
	private com.jeefw.model.vo.TMenu.State state;
	
	private List<MenuTree> nodes;

	public com.jeefw.model.vo.TMenu.State getState() {
		return state;
	}
	public void setState(com.jeefw.model.vo.TMenu.State state2) {
		this.state = state2;
	}
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public List<MenuTree> getNodes() {
		return nodes;
	}
	public void setNodes(List<MenuTree> nodes) {
		this.nodes = nodes;
	}
	
}
