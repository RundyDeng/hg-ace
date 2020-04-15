package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the WEIXIN_COMMAND database table.
 * 
 */
@Entity
@Table(name="WEIXIN_COMMAND")
@NamedQuery(name="WeixinCommand.findAll", query="SELECT w FROM WeixinCommand w")
public class WeixinCommand implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="COMMAND_ID")
	private String commandId;

	private String bz;

	private String commandcode;

	private String createtime;

	private String keyword;

	private BigDecimal status;

	public WeixinCommand() {
	}

	public String getCommandId() {
		return this.commandId;
	}

	public void setCommandId(String commandId) {
		this.commandId = commandId;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getCommandcode() {
		return this.commandcode;
	}

	public void setCommandcode(String commandcode) {
		this.commandcode = commandcode;
	}

	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

}