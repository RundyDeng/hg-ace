package com.jeefw.model.haskey;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

//自定义桌面按钮
@Entity
@Table(name="customer_home_btn")
public class CustomerHomeBtn implements Serializable {
	private static final long serialVersionUID = 1155221860120866323L;
	@Id	
	@GeneratedValue
	@Column(name="id")
	private long id;
	@Column(name="user_id")
	private long userId;
	@Column(name="seq")
	private int seq;
	@Column(name="menu_code",length = 50, nullable = false)
	private String menuCode;
	//自定义按钮背景色
	@Column(name="bg_class",length = 50)
	private String bgClass;
	//@Column(name="crt_date")
	
	public String getBgClass() {
		return bgClass;
	}
	public void setBgClass(String bgClass) {
		this.bgClass = bgClass;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
}
