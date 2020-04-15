package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMPTODAY database table.
 * 
 */
@Entity
@NamedQuery(name="Tmptoday.findAll", query="SELECT t FROM Tmptoday t")
public class Tmptoday implements Serializable {
	private static final long serialVersionUID = 1L;

	private double adata;

	@Temporal(TemporalType.DATE)
	private Date adate;

	private double area;

	private BigDecimal areaguid;

	private BigDecimal autoid;

	private double bdata;

	@Temporal(TemporalType.DATE)
	private Date bdate;

	private String bname;

	private String buildcode;

	private double cgprice;

	private double chjy;

	private String clientcat;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private String devices;

	private String devicetypechildno;

	private String fcode;

	private BigDecimal floorno;

	@Column(name="\"HOURS\"")
	private BigDecimal hours;

	private double hwen;

	private String isfee;

	private String isstop;

	private String isyesjl;

	private double jcjfe;

	private double jlje;

	private double jlrl;

	private double jwen;

	private double ljll;

	private double ljrl;

	private String meterno;

	private String mobphone;

	private double price;

	private double qfe;

	private double qfns;

	private double sjfse;

	private double ssll;

	private double ssrl;

	private String sysstatus;

	private String tel;

	private double uarea;

	private BigDecimal ucode;

	private String uname;

	private String usercode;

	private double wenc;

	private BigDecimal xh;

	private double yjfse;

	private double yjrf;

	private double znj;

	public Tmptoday() {
	}

	public double getAdata() {
		return this.adata;
	}

	public void setAdata(double adata) {
		this.adata = adata;
	}

	public Date getAdate() {
		return this.adate;
	}

	public void setAdate(Date adate) {
		this.adate = adate;
	}

	public double getArea() {
		return this.area;
	}

	public void setArea(double area) {
		this.area = area;
	}

	public BigDecimal getAreaguid() {
		return this.areaguid;
	}

	public void setAreaguid(BigDecimal areaguid) {
		this.areaguid = areaguid;
	}

	public BigDecimal getAutoid() {
		return this.autoid;
	}

	public void setAutoid(BigDecimal autoid) {
		this.autoid = autoid;
	}

	public double getBdata() {
		return this.bdata;
	}

	public void setBdata(double bdata) {
		this.bdata = bdata;
	}

	public Date getBdate() {
		return this.bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}

	public String getBname() {
		return this.bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBuildcode() {
		return this.buildcode;
	}

	public void setBuildcode(String buildcode) {
		this.buildcode = buildcode;
	}

	public double getCgprice() {
		return this.cgprice;
	}

	public void setCgprice(double cgprice) {
		this.cgprice = cgprice;
	}

	public double getChjy() {
		return this.chjy;
	}

	public void setChjy(double chjy) {
		this.chjy = chjy;
	}

	public String getClientcat() {
		return this.clientcat;
	}

	public void setClientcat(String clientcat) {
		this.clientcat = clientcat;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public String getDevices() {
		return this.devices;
	}

	public void setDevices(String devices) {
		this.devices = devices;
	}

	public String getDevicetypechildno() {
		return this.devicetypechildno;
	}

	public void setDevicetypechildno(String devicetypechildno) {
		this.devicetypechildno = devicetypechildno;
	}

	public String getFcode() {
		return this.fcode;
	}

	public void setFcode(String fcode) {
		this.fcode = fcode;
	}

	public BigDecimal getFloorno() {
		return this.floorno;
	}

	public void setFloorno(BigDecimal floorno) {
		this.floorno = floorno;
	}

	public BigDecimal getHours() {
		return this.hours;
	}

	public void setHours(BigDecimal hours) {
		this.hours = hours;
	}

	public double getHwen() {
		return this.hwen;
	}

	public void setHwen(double hwen) {
		this.hwen = hwen;
	}

	public String getIsfee() {
		return this.isfee;
	}

	public void setIsfee(String isfee) {
		this.isfee = isfee;
	}

	public String getIsstop() {
		return this.isstop;
	}

	public void setIsstop(String isstop) {
		this.isstop = isstop;
	}

	public String getIsyesjl() {
		return this.isyesjl;
	}

	public void setIsyesjl(String isyesjl) {
		this.isyesjl = isyesjl;
	}

	public double getJcjfe() {
		return this.jcjfe;
	}

	public void setJcjfe(double jcjfe) {
		this.jcjfe = jcjfe;
	}

	public double getJlje() {
		return this.jlje;
	}

	public void setJlje(double jlje) {
		this.jlje = jlje;
	}

	public double getJlrl() {
		return this.jlrl;
	}

	public void setJlrl(double jlrl) {
		this.jlrl = jlrl;
	}

	public double getJwen() {
		return this.jwen;
	}

	public void setJwen(double jwen) {
		this.jwen = jwen;
	}

	public double getLjll() {
		return this.ljll;
	}

	public void setLjll(double ljll) {
		this.ljll = ljll;
	}

	public double getLjrl() {
		return this.ljrl;
	}

	public void setLjrl(double ljrl) {
		this.ljrl = ljrl;
	}

	public String getMeterno() {
		return this.meterno;
	}

	public void setMeterno(String meterno) {
		this.meterno = meterno;
	}

	public String getMobphone() {
		return this.mobphone;
	}

	public void setMobphone(String mobphone) {
		this.mobphone = mobphone;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getQfe() {
		return this.qfe;
	}

	public void setQfe(double qfe) {
		this.qfe = qfe;
	}

	public double getQfns() {
		return this.qfns;
	}

	public void setQfns(double qfns) {
		this.qfns = qfns;
	}

	public double getSjfse() {
		return this.sjfse;
	}

	public void setSjfse(double sjfse) {
		this.sjfse = sjfse;
	}

	public double getSsll() {
		return this.ssll;
	}

	public void setSsll(double ssll) {
		this.ssll = ssll;
	}

	public double getSsrl() {
		return this.ssrl;
	}

	public void setSsrl(double ssrl) {
		this.ssrl = ssrl;
	}

	public String getSysstatus() {
		return this.sysstatus;
	}

	public void setSysstatus(String sysstatus) {
		this.sysstatus = sysstatus;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public double getUarea() {
		return this.uarea;
	}

	public void setUarea(double uarea) {
		this.uarea = uarea;
	}

	public BigDecimal getUcode() {
		return this.ucode;
	}

	public void setUcode(BigDecimal ucode) {
		this.ucode = ucode;
	}

	public String getUname() {
		return this.uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUsercode() {
		return this.usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public double getWenc() {
		return this.wenc;
	}

	public void setWenc(double wenc) {
		this.wenc = wenc;
	}

	public BigDecimal getXh() {
		return this.xh;
	}

	public void setXh(BigDecimal xh) {
		this.xh = xh;
	}

	public double getYjfse() {
		return this.yjfse;
	}

	public void setYjfse(double yjfse) {
		this.yjfse = yjfse;
	}

	public double getYjrf() {
		return this.yjrf;
	}

	public void setYjrf(double yjrf) {
		this.yjrf = yjrf;
	}

	public double getZnj() {
		return this.znj;
	}

	public void setZnj(double znj) {
		this.znj = znj;
	}

}