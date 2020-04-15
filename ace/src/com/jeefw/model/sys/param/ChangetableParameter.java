package com.jeefw.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 流程表的参数类
 */
public class ChangetableParameter extends ExtJSBaseParameter {
	private static final long serialVersionUID = -2593568451244937138L;
	private String Flowname;
	private String Flows;
	private String Opertor;
	
	public ChangetableParameter(){};
	
	public String getFlowname() {
		return Flowname;
	}
	public void setFlowname(String flowname) {
		Flowname = flowname;
	}
	public String getFlows() {
		return Flows;
	}
	public void setFlows(String flows) {
		Flows = flows;
	}
	public String getOpertor() {
		return Opertor;
	}
	public void setOpertor(String opertor) {
		Opertor = opertor;
	}
	
	

	
}
