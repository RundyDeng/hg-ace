package com.jeefw.model.haskey;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQuery;

import org.hibernate.annotations.GenericGenerator;


/**
 * The persistent class for the TFAILURECODE database table.
 * 
 */
@Entity
@NamedQuery(name="Tfailurecode.findAll", query="SELECT t FROM Tfailurecode t")
public class Tfailurecode implements Serializable {
	private static final long serialVersionUID = 9116219724560866256L;

	@Id
	//@GeneratedValue(strategy = GenerationType.AUTO)
	@GeneratedValue(generator = "failurecodeTableGenerator")
	@GenericGenerator(name = "failurecodeTableGenerator" , strategy="assigned")
	@Column(name="failureid",length=10,updatable=true)
	private BigDecimal failureid;
	@Column(name="areaguid",length=10,updatable=true)
	private String areaguid;
	@Column(name="failurecode",length=30,updatable=true)
	private String failurecode;

	@Column(name="failurecondition",length=2500,updatable=true)
	private String failurecondition;
	@Column(name="failurename",length=30)
	private String failurename;
	@Column(name="failuresign",length=100)
	private String failuresign;
	
	public Tfailurecode() {
	}

	public String getFailuresign() {
		return failuresign;
	}
	public void setFailuresign(String failuresign) {
		this.failuresign = failuresign;
	}
	
	public String getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(String areaguid) {
		this.areaguid = areaguid;
	}

	public String getFailurecode() {
		return this.failurecode;
	}

	public void setFailurecode(String failurecode) {
		this.failurecode = failurecode;
	}

	public String getFailurecondition() {
		return this.failurecondition;
	}

	public void setFailurecondition(String failurecondition) {
		this.failurecondition = failurecondition;
	}

	public BigDecimal getFailureid() {
		return this.failureid;
	}

	public void setFailureid(BigDecimal failureid) {
		this.failureid = failureid;
	}

	public String getFailurename() {
		return this.failurename;
	}

	public void setFailurename(String failurename) {
		this.failurename = failurename;
	}

}