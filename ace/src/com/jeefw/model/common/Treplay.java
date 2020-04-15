package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TREPLAY database table.
 * 
 */
@Entity
@NamedQuery(name="Treplay.findAll", query="SELECT t FROM Treplay t")
public class Treplay implements Serializable {
	private static final long serialVersionUID = 1L;

	private String author;

	private BigDecimal id;

	private String messcontent;

	@Temporal(TemporalType.DATE)
	private Date posttime;

	private BigDecimal ranks;

	private String replay;

	private BigDecimal tmessageid;

	public Treplay() {
	}

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public BigDecimal getId() {
		return this.id;
	}

	public void setId(BigDecimal id) {
		this.id = id;
	}

	public String getMesscontent() {
		return this.messcontent;
	}

	public void setMesscontent(String messcontent) {
		this.messcontent = messcontent;
	}

	public Date getPosttime() {
		return this.posttime;
	}

	public void setPosttime(Date posttime) {
		this.posttime = posttime;
	}

	public BigDecimal getRanks() {
		return this.ranks;
	}

	public void setRanks(BigDecimal ranks) {
		this.ranks = ranks;
	}

	public String getReplay() {
		return this.replay;
	}

	public void setReplay(String replay) {
		this.replay = replay;
	}

	public BigDecimal getTmessageid() {
		return this.tmessageid;
	}

	public void setTmessageid(BigDecimal tmessageid) {
		this.tmessageid = tmessageid;
	}

}