package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the TCHANNEL database table.
 * 
 */
@Entity
@NamedQuery(name="Tchannel.findAll", query="SELECT t FROM Tchannel t")
public class Tchannel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long channelno;

	private String channelname;

	public Tchannel() {
	}

	public long getChannelno() {
		return this.channelno;
	}

	public void setChannelno(long channelno) {
		this.channelno = channelno;
	}

	public String getChannelname() {
		return this.channelname;
	}

	public void setChannelname(String channelname) {
		this.channelname = channelname;
	}

}