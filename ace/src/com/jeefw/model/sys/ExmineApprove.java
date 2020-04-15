package com.jeefw.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.base.Objects;
import com.jeefw.model.sys.param.ExmineApproveParameter;

/**
 * 实体类
 */
@Entity
@Table(name = "ExmineApprove")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class ExmineApprove extends ExmineApproveParameter {
	private static final long serialVersionUID = 3465794691486154605L;
	// 各个字段的含义请查阅文档的数据库结构部分
	@Id
	@GeneratedValue
	@Column(name = "fid")
	private Long fid;
	@Column(name = "title")
	private String title; //标题
	@Column(name = "applicator")
	private String applicator;//申请人
	@Column(name = "applictetime")
	private Date applictetime;//申请日期
	@Column(name = "state")
	private String state;//相关操作记录
	@Column(name = "url")
	private String url;  //相关操作路径
	
	public Long getFid() {
		return fid;
	}
	public void setFid(Long fid) {
		this.fid = fid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getApplicator() {
		return applicator;
	}
	public void setApplicator(String applicator) {
		this.applicator = applicator;
	}
	public Date getApplictetime() {
		return applictetime;
	}
	public void setApplictetime(Date applictetime) {
		this.applictetime = applictetime;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((applicator == null) ? 0 : applicator.hashCode());
		result = prime * result + ((applictetime == null) ? 0 : applictetime.hashCode());
		result = prime * result + ((fid == null) ? 0 : fid.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + ((url == null) ? 0 : url.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ExmineApprove other = (ExmineApprove) obj;
		if (applicator == null) {
			if (other.applicator != null)
				return false;
		} else if (!applicator.equals(other.applicator))
			return false;
		if (applictetime == null) {
			if (other.applictetime != null)
				return false;
		} else if (!applictetime.equals(other.applictetime))
			return false;
		if (fid == null) {
			if (other.fid != null)
				return false;
		} else if (!fid.equals(other.fid))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (url == null) {
			if (other.url != null)
				return false;
		} else if (!url.equals(other.url))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ExmineApprove [fid=" + fid + ", title=" + title + ", applicator=" + applicator + ", applictetime="
				+ applictetime + ", state=" + state + ", url=" + url + "]";
	}
	
	

}
