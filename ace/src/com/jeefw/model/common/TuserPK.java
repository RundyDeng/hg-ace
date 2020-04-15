package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the TUSER database table.
 * 
 */
@Embeddable
public class TuserPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private long userid;

	private String username;

	public TuserPK() {
	}
	public long getUserid() {
		return this.userid;
	}
	public void setUserid(long userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return this.username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof TuserPK)) {
			return false;
		}
		TuserPK castOther = (TuserPK)other;
		return 
			(this.userid == castOther.userid)
			&& this.username.equals(castOther.username);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.userid ^ (this.userid >>> 32)));
		hash = hash * prime + this.username.hashCode();
		
		return hash;
	}
}