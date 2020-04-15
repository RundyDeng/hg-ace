package com.jeefw.model.sys.param;

import java.util.Date;

import javax.management.loading.PrivateClassLoader;

import core.support.ExtJSBaseParameter;

/**
 * 的参数类
 */
public class ExmineApproveParameter extends ExtJSBaseParameter {
	private static final long serialVersionUID = 6838680094606904424L;
	private Long fid;
	private String title; //标题
	private String applicator;//申请人
	private Date applictetime;//申请日期
	private String state;//相关操作记录
	private String url;  //相关操作路径
	
	public ExmineApproveParameter(){};
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

	
}
