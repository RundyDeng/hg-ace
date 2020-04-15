package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the TB_PICTURES database table.
 * 
 */
@Entity
@Table(name="TB_PICTURES")
@NamedQuery(name="TbPicture.findAll", query="SELECT t FROM TbPicture t")
public class TbPicture implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PICTURES_ID")
	private String picturesId;

	private String bz;

	private String createtime;

	@Column(name="MASTER_ID")
	private String masterId;

	private String name;

	@Column(name="\"PATH\"")
	private String path;

	private String title;

	public TbPicture() {
	}

	public String getPicturesId() {
		return this.picturesId;
	}

	public void setPicturesId(String picturesId) {
		this.picturesId = picturesId;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getMasterId() {
		return this.masterId;
	}

	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}