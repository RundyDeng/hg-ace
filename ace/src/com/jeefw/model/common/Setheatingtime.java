package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the SETHEATINGTIME database table.
 * 
 */
@Entity
@NamedQuery(name="Setheatingtime.findAll", query="SELECT s FROM Setheatingtime s")
public class Setheatingtime implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private String areaguid;

	private String areaname;

	@Temporal(TemporalType.DATE)
	private Date endtime;

	@Temporal(TemporalType.DATE)
	private Date starttime;

	public Setheatingtime() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(String areaguid) {
		this.areaguid = areaguid;
	}

	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public Date getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Date getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

}