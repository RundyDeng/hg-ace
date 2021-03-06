package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TMETER_GRQDATA database table.
 * 
 */
@Entity
@Table(name="TMETER_GRQDATA")
@NamedQuery(name="TmeterGrqdata.findAll", query="SELECT t FROM TmeterGrqdata t")
public class TmeterGrqdata implements Serializable {
	private static final long serialVersionUID = 1L;

	private String address;

	private BigDecimal areaguid;

	private BigDecimal autoid;

	private BigDecimal buildno;

	private String clientname;

	private String clientno;

	private BigDecimal counthour;

	@Temporal(TemporalType.DATE)
	private Date ddate;

	private BigDecimal devicestatus;

	private BigDecimal devicetype;

	private String doorname;

	private BigDecimal doorno;

	private double hotarea;

	private BigDecimal isyes;

	private BigDecimal isyesjl;

	private BigDecimal isyestr;

	private BigDecimal leftmoney;

	private BigDecimal mbusid;

	private BigDecimal meterfm;

	private double metergl;

	private double meterhswd;

	private BigDecimal meterid;

	private double meterjswd;

	private double meterls;

	private double meternllj;

	private double meternlljgj;

	private String metersj;

	private double metertj;

	private double meterwc;

	private BigDecimal pooladdr;

	private String remark;

	private String sysstatus;

	private BigDecimal unitno;

	public TmeterGrqdata() {
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public BigDecimal getBuildno() {
		return this.buildno;
	}

	public void setBuildno(BigDecimal buildno) {
		this.buildno = buildno;
	}

	public String getClientname() {
		return this.clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getClientno() {
		return this.clientno;
	}

	public void setClientno(String clientno) {
		this.clientno = clientno;
	}

	public BigDecimal getCounthour() {
		return this.counthour;
	}

	public void setCounthour(BigDecimal counthour) {
		this.counthour = counthour;
	}

	public Date getDdate() {
		return this.ddate;
	}

	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}

	public BigDecimal getDevicestatus() {
		return this.devicestatus;
	}

	public void setDevicestatus(BigDecimal devicestatus) {
		this.devicestatus = devicestatus;
	}

	public BigDecimal getDevicetype() {
		return this.devicetype;
	}

	public void setDevicetype(BigDecimal devicetype) {
		this.devicetype = devicetype;
	}

	public String getDoorname() {
		return this.doorname;
	}

	public void setDoorname(String doorname) {
		this.doorname = doorname;
	}

	public BigDecimal getDoorno() {
		return this.doorno;
	}

	public void setDoorno(BigDecimal doorno) {
		this.doorno = doorno;
	}

	public double getHotarea() {
		return this.hotarea;
	}

	public void setHotarea(double hotarea) {
		this.hotarea = hotarea;
	}

	public BigDecimal getIsyes() {
		return this.isyes;
	}

	public void setIsyes(BigDecimal isyes) {
		this.isyes = isyes;
	}

	public BigDecimal getIsyesjl() {
		return this.isyesjl;
	}

	public void setIsyesjl(BigDecimal isyesjl) {
		this.isyesjl = isyesjl;
	}

	public BigDecimal getIsyestr() {
		return this.isyestr;
	}

	public void setIsyestr(BigDecimal isyestr) {
		this.isyestr = isyestr;
	}

	public BigDecimal getLeftmoney() {
		return this.leftmoney;
	}

	public void setLeftmoney(BigDecimal leftmoney) {
		this.leftmoney = leftmoney;
	}

	public BigDecimal getMbusid() {
		return this.mbusid;
	}

	public void setMbusid(BigDecimal mbusid) {
		this.mbusid = mbusid;
	}

	public BigDecimal getMeterfm() {
		return this.meterfm;
	}

	public void setMeterfm(BigDecimal meterfm) {
		this.meterfm = meterfm;
	}

	public double getMetergl() {
		return this.metergl;
	}

	public void setMetergl(double metergl) {
		this.metergl = metergl;
	}

	public double getMeterhswd() {
		return this.meterhswd;
	}

	public void setMeterhswd(double meterhswd) {
		this.meterhswd = meterhswd;
	}

	public BigDecimal getMeterid() {
		return this.meterid;
	}

	public void setMeterid(BigDecimal meterid) {
		this.meterid = meterid;
	}

	public double getMeterjswd() {
		return this.meterjswd;
	}

	public void setMeterjswd(double meterjswd) {
		this.meterjswd = meterjswd;
	}

	public double getMeterls() {
		return this.meterls;
	}

	public void setMeterls(double meterls) {
		this.meterls = meterls;
	}

	public double getMeternllj() {
		return this.meternllj;
	}

	public void setMeternllj(double meternllj) {
		this.meternllj = meternllj;
	}

	public double getMeternlljgj() {
		return this.meternlljgj;
	}

	public void setMeternlljgj(double meternlljgj) {
		this.meternlljgj = meternlljgj;
	}

	public String getMetersj() {
		return this.metersj;
	}

	public void setMetersj(String metersj) {
		this.metersj = metersj;
	}

	public double getMetertj() {
		return this.metertj;
	}

	public void setMetertj(double metertj) {
		this.metertj = metertj;
	}

	public double getMeterwc() {
		return this.meterwc;
	}

	public void setMeterwc(double meterwc) {
		this.meterwc = meterwc;
	}

	public BigDecimal getPooladdr() {
		return this.pooladdr;
	}

	public void setPooladdr(BigDecimal pooladdr) {
		this.pooladdr = pooladdr;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSysstatus() {
		return this.sysstatus;
	}

	public void setSysstatus(String sysstatus) {
		this.sysstatus = sysstatus;
	}

	public BigDecimal getUnitno() {
		return this.unitno;
	}

	public void setUnitno(BigDecimal unitno) {
		this.unitno = unitno;
	}

}