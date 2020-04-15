package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the FILELISTS database table.
 * 
 */
@Entity
@Table(name="FILELISTS")
@NamedQuery(name="Filelist.findAll", query="SELECT f FROM Filelist f")
public class Filelist implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long filelistid;

	@Temporal(TemporalType.DATE)
	private Date addtime;

	private String contactor;

	private BigDecimal downloadtimes;

	private String fileclasses;

	private String filecontent;

	private String filesize;

	private String filetype;

	private String leixin;

	private String upfilename;

	private String useraccount;

	public Filelist() {
	}

	public long getFilelistid() {
		return this.filelistid;
	}

	public void setFilelistid(long filelistid) {
		this.filelistid = filelistid;
	}

	public Date getAddtime() {
		return this.addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public String getContactor() {
		return this.contactor;
	}

	public void setContactor(String contactor) {
		this.contactor = contactor;
	}

	public BigDecimal getDownloadtimes() {
		return this.downloadtimes;
	}

	public void setDownloadtimes(BigDecimal downloadtimes) {
		this.downloadtimes = downloadtimes;
	}

	public String getFileclasses() {
		return this.fileclasses;
	}

	public void setFileclasses(String fileclasses) {
		this.fileclasses = fileclasses;
	}

	public String getFilecontent() {
		return this.filecontent;
	}

	public void setFilecontent(String filecontent) {
		this.filecontent = filecontent;
	}

	public String getFilesize() {
		return this.filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	public String getFiletype() {
		return this.filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getLeixin() {
		return this.leixin;
	}

	public void setLeixin(String leixin) {
		this.leixin = leixin;
	}

	public String getUpfilename() {
		return this.upfilename;
	}

	public void setUpfilename(String upfilename) {
		this.upfilename = upfilename;
	}

	public String getUseraccount() {
		return this.useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}

}