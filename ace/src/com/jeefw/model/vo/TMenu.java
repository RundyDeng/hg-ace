package com.jeefw.model.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="e_tmp_menu_tree")
public class TMenu implements Serializable {
	@Id
	@Column(name="id")
	private String id;
	@Column(name="parent_id")
	private String parentid;
	@Column(name="menu_name")
	private String menuName;
	@Column(name="menu_level")
	private int level;
	
	@Transient
	private State state = new State();

	public class State {
		public boolean checked = false;
		public boolean disable = false;
	    public boolean expanded = true;
	    public boolean selected = false;
	}
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
	
}
