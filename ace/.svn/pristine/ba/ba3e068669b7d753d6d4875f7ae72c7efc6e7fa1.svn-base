package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the TDACSERVER database table.
 * 
 */
@Entity
@NamedQuery(name="Tdacserver.findAll", query="SELECT t FROM Tdacserver t")
public class Tdacserver implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long dacid;

	private String dacip;

	private String dacname;

	//bi-directional many-to-one association to Tauto
	@OneToMany(mappedBy="tdacserver")
	private List<Tauto> tautos;

	//bi-directional many-to-one association to Tdacarea
	@OneToMany(mappedBy="tdacserver")
	private List<Tdacarea> tdacareas;

	public Tdacserver() {
	}

	public long getDacid() {
		return this.dacid;
	}

	public void setDacid(long dacid) {
		this.dacid = dacid;
	}

	public String getDacip() {
		return this.dacip;
	}

	public void setDacip(String dacip) {
		this.dacip = dacip;
	}

	public String getDacname() {
		return this.dacname;
	}

	public void setDacname(String dacname) {
		this.dacname = dacname;
	}

	public List<Tauto> getTautos() {
		return this.tautos;
	}

	public void setTautos(List<Tauto> tautos) {
		this.tautos = tautos;
	}

	public Tauto addTauto(Tauto tauto) {
		getTautos().add(tauto);
		tauto.setTdacserver(this);

		return tauto;
	}

	public Tauto removeTauto(Tauto tauto) {
		getTautos().remove(tauto);
		tauto.setTdacserver(null);

		return tauto;
	}

	public List<Tdacarea> getTdacareas() {
		return this.tdacareas;
	}

	public void setTdacareas(List<Tdacarea> tdacareas) {
		this.tdacareas = tdacareas;
	}

	public Tdacarea addTdacarea(Tdacarea tdacarea) {
		getTdacareas().add(tdacarea);
		tdacarea.setTdacserver(this);

		return tdacarea;
	}

	public Tdacarea removeTdacarea(Tdacarea tdacarea) {
		getTdacareas().remove(tdacarea);
		tdacarea.setTdacserver(null);

		return tdacarea;
	}

}