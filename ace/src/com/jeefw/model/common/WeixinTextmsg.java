package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the WEIXIN_TEXTMSG database table.
 * 
 */
@Entity
@Table(name="WEIXIN_TEXTMSG")
@NamedQuery(name="WeixinTextmsg.findAll", query="SELECT w FROM WeixinTextmsg w")
public class WeixinTextmsg implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="TEXTMSG_ID")
	private String textmsgId;

	private String bz;

	private String content;

	private String createtime;

	private String keyword;

	private BigDecimal status;

	public WeixinTextmsg() {
	}

	public String getTextmsgId() {
		return this.textmsgId;
	}

	public void setTextmsgId(String textmsgId) {
		this.textmsgId = textmsgId;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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