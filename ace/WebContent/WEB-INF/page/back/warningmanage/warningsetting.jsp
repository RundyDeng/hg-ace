<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

			<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
			<link rel="stylesheet" href="${contextPath }/static/Validform_v5.3.2/style.css"/>
			<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
			<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
			<link rel="stylesheet" href="${contextPath}/static/pages/css/index.css"/>

<style>
    .form-label {
        border: 0rem solid #ccc;
        /*width: 90px;*/
        width: auto;
        float: left;
        padding-right: 0.5rem;
        height: 31px;
        background-color: transparent;
    }
    
    .form-content {
        float: left;
        width: auto;
    }
    
    .padding-0 {
        padding-right: 0rem;
        padding-left: 0rem;
    }
    
    .form-padding-min {
        padding-right: 0rem;
        padding-left: 0rem;
    }
    
    .form-mar {
        margin-left: 0.5rem;
    }
    .last-button {
        margin-top: 0.5rem;
        padding-left: 0rem;
        margin-left: 0rem;
    }
    .form-mid-main {
        padding-top: 0.3rem;
        /*border: 1px dotted #5b5c55;*/
    }
    .form-mid-main .form-padding-min{
    	width: 100%;
    	padding-left: 0rem;
    	padding-right: 0rem;
    }
	.dialog-ini {
		border-radius: 5px;
	}

.Validform_checktip{
	margin-left:0;
}

.info{
	border:1px solid #ccc; 
	padding:2px 20px 2px 5px; 
	color:#666; 
	position:absolute;
	display:none;
	line-height:20px;
	background-color:#fff;
	z-index:10000;
}
.dec {
    top: -8px;
    display: block;
    height: 8px;
    overflow: hidden;
    position: absolute;
    left: 10px;
    width: 17px;
}
.dec s {
    font-family: simsun;
    font-size: 16px;
    height: 19px;
    left: 0;
    line-height: 21px;
    position: absolute;
    text-decoration: none;
    top: px;
    width: 17px;
}
.dec .dec1 {
    color: #ccc;
}
.dec .dec2 {
    color: #fff;
    top: 1px;
}
</style>


    <div class="container-fluid" style="display: none; overflow-x: hidden;overflow-y: auto; margin: 10px -20px 0px 20px;" id="warn-set-dialog">
        <form id="warning-setting" class="" method="post" action="${contextPath}/warningmanage/warningsettingcontr/upadatewarningsetting">
            <div class="row" style="border-bottom: 2px solid rgb(239, 239, 239); margin-bottom: 5px; margin-top: 0px; padding-bottom: 4px;">
                <div class="col-sm-6">
                    <div class="row">

                        <div class="col-xs-6 padding-0">
                            <fieldset>
                                <label for="sel-area" class="form-control form-label">小区选择:</label>
                                <select name="areaguid" id="sel-area" class="form-control form-content">
                                </select>
                            </fieldset>

                        </div>
                        <div class="col-xs-6 padding-0">
                            <fieldset>
                                <label for="faultname" class="form-control form-label">故障名称:</label>
                                <input id="faultname" name="failurename" type="text" class="form-control form-content" style="width: 130px"
                                datatype="s3-16" errormsg="故障名称至少3个字符，最多16字符" nullmsg="请输入故障名称"  
                                ajaxurl="${contextPath}/warningmanage/warningsettingcontr/checkfailurename" >
                               		<div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                               		</div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-xs-6 padding-0">
                            <fieldset>
                                <label for="faultname" class="form-control form-label">故障代码:</label>
                                <input id="faultname" name="failurecode" type="text" class="form-control form-content" style="width: 130px"
                                datatype="s3-16" errormsg="故障名称至少3个字符，最多16字符" nullmsg="请输入故障 代码"  
                                ajaxurl="${contextPath}/warningmanage/warningsettingcontr/checkfailurecode" >
                                <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                               	</div>
                            </fieldset>

                        </div>
                        <div class="col-xs-6 padding-0">
                            <fieldset>
                                <label for="failureid" class="form-control form-label">故障编号:</label>
                                <input id="failureid" name="failureid" type="text" class="form-control form-content" value="" readonly="readonly" style="width: 130px">
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row form-mid-main">
                <div class="col-sm-5">
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">热能表编号:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">d</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">累计流量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">T</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">累计热量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">KWH</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">进水温度:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">回水温度:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">温差:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">瞬时流量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">T/H</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">瞬时热量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">KW</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">时数:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">H</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">是否停热:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <select id="sftr" class="form-control form-content form-padding-min form-mar">
                              
                                <option value="0">否</option>
                                <option value="1">是</option>
                            </select>
                        </div>

                        <div class="col-xs-1 padding-0">
                            
                        </div>
                        <div class="col-xs-2 padding-0">
                            
                        </div>
                    </div>

                </div>



                <!--中间的-->
                <div class="col-sm-1" style="top: 10rem;margin-left: 40px;">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-inverse">
                            <input type="radio" name="d" id="option1" data-thv='and' autocomplete="off">与
                        </label>
                        <label class="btn btn-inverse">
                            <input type="radio" name="d" id="option2" data-thv='or' autocomplete="off">或
                        </label>
                        <label class="btn btn-inverse">
                            <input type="radio" name="d" id="option3" data-thv='' autocomplete="off">非
                        </label>
                    </div>
                </div>



                <div class="col-sm-5">
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">热能表编号:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">d</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">累计流量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">T</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">累计热量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">KWH</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">进水温度:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">回水温度:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">温差:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">℃</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">瞬时流量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">T/H</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">瞬时热量:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">KW</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">时数:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="1">&lt;</option>
                                <option value="2">&gt;</option>
                                <option value="3">&lt;=</option>
                                <option value="4">&gt;=</option>
                                
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <input  type="text" class="form-control form-mar" datatype="n0-20" errormsg="请填写数字（正整数）！">
                            <div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <span class="form-control form-label form-padding-min">H</span>
                        </div>
                        <div class="col-xs-2 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="">值</option>
                                <option value="0">绝对值</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <!-- <div class="col-xs-3  padding-0">
                            <label for="a1" class="form-control form-label">是否停热:</label>
                        </div>
                        <div class="col-xs-1 padding-0">
                            <select id="a1" class="form-control form-content form-padding-min">
                                <option value="0">=</option>
                                <option value="2">&gt;</option>
                            </select>
                        </div>
                        <div class="col-xs-5">
                            <select id="a1" class="form-control form-content form-padding-min form-mar">
                                <option value="">请选择</option>
                                <option value="">是</option>
                                <option value="">否</option>
                            </select>
                        </div>

                        <div class="col-xs-1 padding-0">
                            
                        </div>
                        <div class="col-xs-2 padding-0">
                            
                        </div> -->
                    </div>

                </div>
                <!-- <div class="col-sm-1">

                </div> -->
            </div>
            <div class="row">
                        <div class="col-sm-1  padding-0">
                            <label for="a1" class="form-control form-label">生成参数:</label>
                        </div>
                        <div class="col-sm-8" style="padding-left: 26px;">

                            <textarea name="failurecondition" class="form-control" id="exampleTextarea" rows="2" readonly="readonly"
                            datatype="*3-2500" errormsg="至少选择一个告警参数作为告警条件！" nullmsg="请选择热表编号等告警参数！"></textarea>
							<div class="info">
                               			<span class="Validform_checktip"></span>
                               			<span class="dec">
                               				<s class="dec1">&#9670;</s><s class="dec2">&#9670;</s>
                               			</span>
                            </div>
                        </div>
                        <div class="col-sm-3 padding-0"></div>
            </div>
            
        </form>
        <!----------->
    </div>


	<div class="container-fluid" style="display:none;">

		    <div class="row last-button">
                <div class="col-sm-5">
                    <div class="row">
                        <div class="col-xs-12">
                            <button id="btn-add" type="button" class="btn btn-primary">新增</button>
                            <button type="button" class="btn btn-primary">修改</button>
                            <button type="button" class="btn btn-primary">删除</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-7"></div>
            </div>
            
            
            
			

	</div>


			<div class="row">
				<div class="col-xs-12">
			
					<div id="da-search"></div>
			
					<table id="grid-table"></table>
			
					<div id="grid-pager" style="display:none;"></div>
			
				</div>
			</div>



<script>

var scripts = [ 
                '${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js",
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                '${contextPath}/static/Validform_v5.3.2/Validform_v5.3.2.js'
               ];
               
   	$('.page-content-area').ace_ajax('loadScripts',scripts,function() {
		
		var da_search = "#da-search";
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";	
   		
   		var currentValid ;
   		$('#warning-setting').Validform({
   			ajaxPost: true,
   			postonce: true,
   			showAllError: false,
   			
   			tiptype:function(msg,o,cssctl){
   			    
   				if(!o.obj.is("form")){
   					console.log(o.obj)
   	   				console.log(cssctl)
   					var objtip=o.obj.parent().find(".Validform_checktip");
   					cssctl(objtip,o.type);
   					objtip.text(msg);
   					
   					var infoObj=o.obj.parent().find(".info");
   					console.log(infoObj)
   					currentValid = infoObj;
   					if(o.type==2){
   						infoObj.fadeOut(200);
   					}else{
   						if(infoObj.is(":visible")){return;}
   						var left=o.obj.offset().left,
   							top=o.obj.offset().top;
   						infoObj.css({
   							left:80,
   							top:50
   						}).show().animate({
   							top:43
   						},200);
   					}
   					
   				}	
   			},
   			beforeSubmit:function(curform){
   				$('#warning-setting').Validform()
   				setTimeout("return true;",1000);
   			},
   			callback:function(data){
   				
   				if(1==data){
     	   			alert('保存成功');
     	   			$('#warn-set-dialog').dialog('destroy');
     	   			resetF();
     	   			jQuery(grid_selector).jqGrid
     	   		}else{
     	   			alert('保存失败！');
     	   		}
   			}
   		}).config({
   			showAllError: false,
   			url: '${contextPath}/warningmanage/warningsettingcontr/upadatewarningsetting'
   		});
   		
   		$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
   			var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
   			var flagName = '';
   				var response = jQuery.parseJSON(data);
   			      var s = '<option value="">请选择</option>';
   			      if (response && response.length) {
   			          for (var i = 0, l = response.length; i < l; i++) {
   				           var ri = response[i];
   				           if(ri['AREAGUID']==areaguid){
   				        	   flagName = ri['AREAGUID'];
   				           }
   			        	   s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';   
   			          }
   			       }
   			      
   			      if(flagName!=''){
   			    	  s += "<script>$('select option[value=\""+flagName+"\"]').change().attr('selected',true);</sc"+"ript>  ";
   			      }
   			  
   			      $('#sel-area').empty().append(s);
   		})
   		
   		
   		var initPara = function(sort){
   			var params = '';
   			$('.row.form-mid-main .col-sm-5:'+sort+' .row').each(function(index,obj){
   				var paraName = $(obj).find('.col-xs-3 label').text().replace(':','');
   				var dx = $(obj).find('.col-xs-1 select option:selected').text();
   				var paraVal = $(obj).find('.col-xs-5 input').val();
   				if(paraVal!=''&&paraVal!=undefined){
   					if($(obj).find('.col-xs-2 select').val() == '0'){
   	   					params += '((' + paraName + dx + paraVal + ') or (' + paraName + dx + '(-' + paraVal + '))) and ';
   	   				}else{
   	   					params += '(' + paraName + dx + paraVal + ') and ';
   	   				}
   				}
   			})
   			params = params.replace(/ and $/, "");
   			if(params!=''){
   				if(sort=='first'){
   	   				params = '(' + params + ' and (是否停热=' + $('#sftr').val() + ')' + ')'
   	   			}else{
   	   				params = '(' + params + ')'
   	   			}
   				return params;
   			}else
   				return '';
   		};
   		
   		var getPara = function(){
   			if($('.col-sm-1 div label input[type="radio"]:checked').length==1){
   				var p1 = initPara('first');
   				var p2 = initPara('eq(1)');
   				var lian = $('.col-sm-1 div label input[type="radio"]:checked').attr('data-thv');
				if(p2!='' && p1!='' && lian!=undefined){
					return p1 + '   '+lian+'   ' + p2;
				}else 
					return p1;
   			}else{
   				return initPara('first');
   			}
   		}
   		
   		var resetF = function(){
   			$('#warning-setting .info').hide();
   			//currentValid.hide();
   			$('#warning-setting').Validform().resetForm();
   			$('#warning-setting div[data-toggle="buttons"] label').removeClass('active');
   		}
   		
   		var showdialog = function(title){
   			$('#warn-set-dialog').dialog({
   				title : title,
	    		bgiframe: true,
	    	    resizable: true,
	    	    height:600,
	    	    width:1250,
	    	    dialogClass: 'dialog-ini',
	    	    modal: true,
		    	buttons: {
   				           '保存': function() {
   				        			    $('#warning-setting').Validform().ajaxPost(false,true,'${contextPath}/warningmanage/warningsettingcontr/upadatewarningsetting');
   				        			    jQuery(grid_selector).jqGrid().trigger("reloadGrid");
		   				          },
		   				   '重置': function(){
			   							resetF();
				   				   },
   				           '关闭': function() {
		   				              $(this).dialog('destroy');
		   				           	  resetF();
		   				          }
   				      },
	   			focus: function(event, ui) {
	   				
	   			}
   			})
   		}
   		
   		$('#btn-add').click(function(){
   			showdialog("新增");
   			$.get('${contextPath}/warningmanage/warningsettingcontr/getid',function(response){
   				$('#failureid').attr('value',response);
   			});
   		});
   		
   		$('#warning-setting input').blur(function(){
   			$('#exampleTextarea').val(getPara());
   		})
   		$('#warning-setting select').blur(function(){
   			$('#exampleTextarea').val(getPara());
   		})
   		$('#warning-setting div[data-toggle="buttons"]').change(function(){
   			$('#exampleTextarea').val(getPara())
   		})
   		
   		
   		///////
   		

		$(window).on('resize.jqGrid', function() {
			$(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
		})

		var parent_column = $(grid_selector).closest('[class*="col-"]');
		$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
			if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
				setTimeout(function() {
					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
				}, 0);
			}
		});
		
	
		function getSelectElement(val){
			if(val!=='undefined')
				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
		}
		function emptyAndReset(e){
			e.empty();
			e.append("<option value=''>请选择</option>").attr("selected",true).change();
		}
		
		function convertCN(cellvalue, options, rowdata){

			if(cellvalue == 0)
				return '否';
			else if(cellvalue == 1)
				return '是';
		}
		
		function settleObj(objd,i){
			var setObj = [];
			$(objd).each(function(index,value){
				if(value!=undefined)
					setObj.push(value);
			})
			return setObj;
		}
		
		function getSelVal(p){
			if(p=='=') return 0;
			if(p=='<') return 1;
			if(p=='>') return 2;
			if(p=='<=') return 3;
			if(p=='>=') return 4;
		}
		
		function setEachParam(objs,post,abs){
			
			var parasObj;
			if(objs.length==0) return;
				parasObj = settleObj(objs);
			var sort;
			
					if(post==1) sort='first';
						else sort='eq(1)';
					$('.row.form-mid-main .col-sm-5:'+sort+' .row').each(function(index,obj){
		   				var paraName = $(obj).find('.col-xs-3 label').text().replace(':','');	
		   				if(parasObj[0]==paraName){
		   					if(paraName=='是否停热'){
		   						$(obj).find('.col-xs-5 select').val(parasObj[2]);
		   					}else{
			   					$(obj).find('.col-xs-1 select').val(getSelVal(parasObj[1]));
			   					$(obj).find('.col-xs-5 input').val(parasObj[2]);
			   					if(abs==1){
			   						$(obj).find('.col-xs-2 select').val(0);
			   					}
		   					}
		   				}
		   			})
		}
		
		function eachParse(ara,post){
			if(ara.length==0) return;
			
			for(var i=0;i<ara.length;i++){
				var ff = ara[i];
				var sss;
				var abs = 0;
			    if(ff.indexOf(')or(')>0){
			        abs = 1;
			        sss = ff.split('or')[0].replace(/\(|\)/g,'');
			    }else{
			    	abs = 0;
			    	sss = ff.replace(/\(|\)/g,'');
			    }		    
		        setEachParam(sss.split(/(>=)|(<=)|(=)|(<)|(>)/),post,abs);			    
			}
		}
		
		function parseParam(str){
			if(str=='')
				return;
			var leftPara,midPara,rightPara;
		    var midAr = str.split(/\)\)(   and   )\(\(|\)\)(   or   )\(\(|\)\)(      )\(\(/);
		    for(var i=0;i<midAr.length;i++){
		        if(midAr[i]!=undefined){
		            if(i==0){
		                leftPara = (midAr[i].replace(/ /g,'') + '))').split('and');
		                eachParse(leftPara,1);
		            }else if(i==midAr.length-1){   
		                rightPara = ('(('+midAr[i].replace(/ /g,'')).split('and');
		                eachParse(rightPara,2);
		            }else{
		                midPara = midAr[i].replace(/ /g,'')
		                $('.col-sm-1 div label input[data-thv="'+midPara+'"]').click();
		            }
		        }   
		    }
		}
		
		function setAjaxUrl(){
			$('fieldset input[ajaxurl]').each(function(index,obj){
				var ajaxStr = $(obj).attr('ajaxurl');
				ajaxStr = ajaxStr.split('?currentvalue')[0];
				var currentVal = $(obj).val();
				var currentAjaxUrl = ajaxStr + '?currentvalue='+ currentVal;
				$(obj).attr('ajaxurl',currentAjaxUrl);
			});
		}
		
		var flag = true;
   		editDialogx = function(rowObj){ 				
   				var editFormObj = JSON.stringify(rowObj); 
    			var failureConditionStr = rowObj.FAILURECONDITION;
    			parseParam(failureConditionStr);
    			showdialog("修改");
    			$('#warn-set-dialog').parent().find('button span:contains("重置")').parent().hide();
    			thisFormObj = rowObj;
    			$('#warning-setting').zqFormReset(rowObj);
    			setAjaxUrl();
   		}
   		
   		////////////

   		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } //小区
        				         ] 
        		};
		jQuery(grid_selector).jqGrid({
			subGrid : false,
			url : "${contextPath}/warningmanage/warningsettingcontr/getwarningsetting",
			datatype : "json",
			height : 450,
			rownumbers:true,
			colNames : ['FailureID','操作','故障编号','故障名称','小区编号','所属小区','故障条件'],
			colModel : [{
							name : 'FAILUREID',
							index : 'FAILUREID',
							label : '故障ID',
							key : true,
							hidden : true,
							search : false,
							
	        				searchoptions:{
	        					searchhidden:false,
	        					sopt:['eq']
	        				},
							editable : true
							
						},
			            {
	        				name : '',
	        				index : '',
	        				label : '操作',
	        				width : 63,
	        				viewable : false,
	        				fixed : true,
	        				sortable : false,
	        				resize : false,
	        				formatter : function(cell,option,rowsObj){
	        					var sss = '<div style="margin-left:8px;"><div title="编辑所选记录" style="float:left;cursor:pointer;" class="ui-pg-div ui-inline-edit" id="jEditButton_42" onclick=\'editDialogx('+JSON.stringify(rowsObj)+');\' '   
	        							+ '  onmouseover=\"jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');"><span class="ui-icon ui-icon-pencil"></span></div>'
	        							+ '<div title="删除所选记录" style="float:left;margin-left:5px;" class="ui-pg-div ui-inline-del" id="jDeleteButton_42" onclick="jQuery.fn.fmatter.rowactions.call(this,\'del\');"'
	        							+ 'onmouseover="jQuery(this).addClass(\'ui-state-hover\');" onmouseout="jQuery(this).removeClass(\'ui-state-hover\');"><span class="ui-icon ui-icon-trash"></span></div></div>';
	        				    return sss;
	        				}
	        			},{
    			            hidden:false,
   			            	label:'故障编号',
   			            	name:'FAILURECODE',
   			            	index : 'FAILURECODE',
   			            	width : 100,
   			            	editable : true,
   			            	edittype : 'text',
   			            	editoptions : { 
   			            					size : "20", 
   			            					maxlength : "50",
   			            					NullIfEmpty : false
   			            				  },
   			            	editrules : {
   			            					edithidden : true, 
   			            					required : true
   			            				},
   			            	
			            },
			            {
   			            	 hidden:false,
   			            	 label:'故障名称',
   			            	 name:'FAILURENAME',
   			            	 index : 'FAILURENAME',
   			            	width : 130,
   			            	editable : true,
   			            	edittype : 'text',
   			            	editoptions : { 
   			            					size : "20", 
   			            					maxlength : "50",
   			            					NullIfEmpty : false
   			            				  },
   			            	editrules : {
   			            					edithidden : true, 
   			            					required : true
   			            				}
			            	
			            	},{
       			            	label:'小区名',
       			            	name:'AREAGUID',
       			            	width : 88,
       			            	search:true,
       			            	stype:'select',
       			            	searchoptions : {
       			            		searchhidden:true,
   			            		 	sopt : ['eq'],
   			            		 	dataUrl:'${contextPath}/sys/todaydata/getAreaDownList',
    			         			buildSelect:function(data){
    			         				var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>'
    	        						var response = jQuery.parseJSON(data);
    	        					      var s = '<option value="">请选择</option>';
    	        					      if (response && response.length) {
    	        					          for (var i = 0, l = response.length; i < l; i++) {
    	        					           var ri = response[i];
    	        					           
    	        					           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
    	        					          }
    	        					       }
    	        					      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);</sc"+"ript>  ";
    	        					      var sel = getSelectElement("AREAGUID");
    	        					      sel.append(s);
    	        				     }
       			            	}
    			            }/* ,{
	   			            	
	   			            	 label:'小区编号',
	   			            	 name:'AREAGUID',
	   			            	 index : 'AREAGUID',
	   			            	 width : 88,
	   			            	 editable : false
				             	} */,{
	  			             	 label:'故障编号所属小区名',
	  			             	 width: 110,
	   			            	 name:'AREANAME',
	   			            	 index : 'AREANAME',
	   			            	 editable : true,
	   			            	 edittype : 'select',
	   			            	 editoptions : {
	   			            		dataUrl:'${contextPath}/sys/todaydata/getAreaDownList',
				         			buildSelect:function(data){
		        						var response = jQuery.parseJSON(data);
		        					      var s = '<select><option value="">请选择</option>';
		        					      if (response && response.length) {
		        					          for (var i = 0, l = response.length; i < l; i++) {
		        					           var ri = response[i];
		        					           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
		        					          }
		        					       }
		        					     return s + "</select>";
		        				     }
	   			            	 },
	   			            	 editrules : {
	   			            		 //required : true, 
	   			            		 custom : true,
	   			            		 custom_func : function(value,colname){
	   			            			 if(value==''||value == 'undefined')
	   			            			 	return [false,"请故障所属选择小区！"];
	   			            			 return [true,""];
	   			            		 }
	   			            	 },
	   			            	formatoptions : {
	   			            	}
		        			},{
   			            	 hidden:false,
   			            	 label:'故障条件',
   			            	 index : 'FAILURECONDITION',
   			            	 name:'FAILURECONDITION',
   			            	 width : 550,
   			            	 editable : true,
   			            	 edittype : 'textarea',
   			            	 editoptions : { 
   			            					rows:'1',
   			            					cols:'60',
   			            					NullIfEmpty : false
   			            				  },
   			            	 editrules :  {
   			            					edithidden : true, 
   			            					required : true
   			            				  }
			             	}],
			//sortname : "CLIENTNO",
			//sortorder : "asc",
			//shrinkToFit : true,
			//forceFit : true,
			//viewrecords : true,
			rowNum : 1000,
			//rowList : [ 10, 20, 30 ],
			pager : pager_selector,
			//altRows : true,
			toppager : true,
	        multiboxonly : true,
	        ondblClickRow: function(rowid){
				jQuery(grid_selector).viewGridRow(rowid,{});
			},
			loadComplete : function(data) {
				/* if(data.rows==null||data.rows.length==0)
					$('.ui-jqgrid-htable').css('width','auto');
				else
					$('.ui-jqgrid-htable').css('width','100%'); */
				var table = this;
				setTimeout(function(){
					/* styleCheckbox(table);
					updateActionIcons(table); */
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			editurl : "${contextPath}/warningmanage/warningsettingcontr/upadatewarningsetting"
		});
		
		$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

		function aceSwitch(cellvalue, options, cell) {
			setTimeout(function() {
				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
			}, 0);
		}
		
		function pickDate(cellvalue, options, cell) {
			setTimeout(function() {
				$(cell).find('input[type=text]').datepicker({
					format : 'yyyy-mm-dd',
					autoclose : true,
				    language: 'zh-CN'
				});
			}, 0);
		}
		
		
		var buttonflag1 = false;
		var buttonflag2 = true;
		// navButtons
		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { // navbar options
			edit : <shiro:hasPermission name="${ROLE_KEY}:setmeterfailure:edit">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:setmeterfailure:edit">buttonflag1</shiro:lacksPermission>,
			editicon : 'ace-icon fa fa-pencil blue',
			add : <shiro:hasPermission name="${ROLE_KEY}:setmeterfailure:add">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:setmeterfailure:add">buttonflag1</shiro:lacksPermission>,
			addicon : 'ace-icon fa fa-plus-circle purple',
			del : <shiro:hasPermission name="${ROLE_KEY}:setmeterfailure:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:setmeterfailure:delete">buttonflag1</shiro:lacksPermission>,
			delicon : 'ace-icon fa fa-trash-o red',
			search : <shiro:hasPermission name="${ROLE_KEY}:setmeterfailure:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:setmeterfailure:search">buttonflag1</shiro:lacksPermission>,
			searchicon : 'ace-icon fa fa-search orange',
			refresh : false,
			refreshicon : 'ace-icon fa fa-refresh blue',
			view : <shiro:hasPermission name="${ROLE_KEY}:setmeterfailure:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:setmeterfailure:view">buttonflag1</shiro:lacksPermission>,
			viewicon : 'ace-icon fa fa-search-plus grey'
		}, {
			
		}, {
			// new record form
			// width: 700,
			width : 900,
			closeAfterAdd : true,
			recreateForm : true,
			viewPagerButtons : false,
			beforeShowForm : function(e) {

				
			},
			errorTextFormat: function (response) {
				var result = eval('('+response.responseText+')');
			    return result.message;
			}
		}, {
			// delete record form
			recreateForm : true,
			beforeShowForm : function(e) {
				var form = $(e[0]);
				if (form.data('styled'))
					return false;
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_delete_form(form);
				form.data('styled', true);
			},
			onClick : function(e) {
				
			}
		}, {
			width : 600,
			recreateForm : true,
			tmplNames : ['多条件查询'],
			tmplFilters : [template1],
			tmplLabel : "",
			closeAfterSearch : true,
			searchOnEnter: true,
			closeOnEscape:true,
			afterShowSearch : function(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
				style_search_form(form);
			},
			afterRedraw : function() {
				style_search_filters($(this));
			},
			//multipleGroup : true,
			multipleSearch : true ,
			onSearch: _J_setAreaGuid
		}, {
			// view record form
			width : 1000,
			recreateForm : true,
			beforeShowForm : function(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
			}
		})
		
		// add custom button to export the data to excel
		if(<shiro:hasPermission name="${ROLE_KEY}:hisdata:export">buttonflag1</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:export">false</shiro:lacksPermission>){
			jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
				   caption : "",
			       title : "导出Excel",
			       buttonicon : "ace-icon fa fa-file-excel-o green", 
			       onClickButton : function () { 
			    	   var keys = [], ii = 0, rows = "";
			    	   var ids = $(grid_selector).getDataIDs(); // Get All IDs
			    	   var row = $(grid_selector).getRowData(ids[0]); // Get First row to get the labels
			    	   //var label = $(grid_selector).jqGrid('getGridParam','colNames');
  			    	   for (var k in row) {
			    	   	   keys[ii++] = k; // capture col names
			    	   	   var kv = $('#jqgh_grid-table_' + k).text();
		    	   	   rows = rows + kv + "\t";
			    	   }
			    	   rows = rows + "\n"; // Output header with end of line
			    	   for (i = 0; i < ids.length; i++) {
			    	   	   row = $(grid_selector).getRowData(ids[i]); // get each row
			    	   	   for (j = 0; j < keys.length; j++)
			    	   		   rows = rows + row[keys[j]] + "\t"; // output each Row as tab delimited
			    	   	   rows = rows + "\n"; // output each row with end of line
			    	   }
			    	   rows = rows + "\n"; // end of line at the end
			    	   var form = "<form name='csvexportform' action='${contextPath}/sys/hisdata/operateHisData?oper=excel' method='post'>";
			    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			    	   OpenWindow = window.open('', '');
			    	   OpenWindow.document.write(form);
			    	   OpenWindow.document.close();
			       } 
				});        			
		}
		
		jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
			   caption : "新增",
		       title : "新增警告",
		       buttonicon : "ui-icon ace-icon fa fa-plus-circle purple", 
		       onClickButton : function () { 
		    	   $('#btn-add').click();
		    	   setAjaxUrl();
		       } 
			});        			
		
   		function style_edit_form(form) {
			var buttons = form.next().find('.EditButton .fm-button');
			buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();
			buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
			buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
			buttons = form.next().find('.navButton a');
			buttons.find('.ui-icon').hide();
			buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
			buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
		}

		function style_delete_form(form) {
			var buttons = form.next().find('.EditButton .fm-button');
			buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();
			buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
			buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
		}

		function style_search_filters(form) {
			form.find('.delete-rule').val('X').hide();
			form.find('.add-rule').addClass('btn btn-xs btn-primary').hide();
			form.find('.add-group').addClass('btn btn-xs btn-success');
			form.find('.delete-group').addClass('btn btn-xs btn-danger').hide();
		}
		function style_search_form(form) {
			
			var dialog = form.closest('.ui-jqdialog');
			var buttons = dialog.find('.EditTable');
			buttons.find('.EditButton select[class="ui-template"] option[value="default"]').attr("selected",false);
			buttons.find('.EditButton select[class="ui-template"] option[value!="default"]').attr("selected",true).change();//还需要再多加上一个change来触发
			buttons.find('.EditButton select[class="ui-template"]').hide();
			form.find('select[class="opsel"]').remove();
			form.find('.searchFilter table').remove()/* attr('align','center') */;
			/* console.log(form.find('.searchFilter table')); */
			buttons.find('.EditButton a[id*="_reset"]').hide().addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
			buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
			buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').css('class', 'ace-icon fa fa-search');
		
			form.find('.columns select').attr('disabled','disabled'); 
			form.find('.operators select').attr('disabled','disabled');
		
		}

		function beforeDeleteCallback(e) {
			var form = $(e[0]);
			if (form.data('styled'))
				return false;
			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
			style_delete_form(form);
			form.data('styled', true);
		}

		function beforeEditCallback(e) {
			var form = $(e[0]);
			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
			style_edit_form(form);
		}
		function styleCheckbox(table) {}
		function updateActionIcons(table) {}
		function updatePagerIcons(table) {
			var replacement = {
				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
			};
			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

				if ($class in replacement)
					icon.attr('class', 'ui-icon ' + replacement[$class]);
			})
		}
		function enableTooltips(table) {
			$('.navtable .ui-pg-button').tooltip({container : 'body'});
			$(table).find('.ui-pg-div').tooltip({container : 'body'});
		}
		$(document).one('ajaxloadstart.page', function(e) {
			$(grid_selector).jqGrid('GridUnload');
			$('.ui-jqdialog').remove();
		});
		$(pager_selector + ' #grid-pager_left span').css({'text-indent':0});
		var navTable = $(pager_selector + ' #grid-pager_left').clone(true);
		$(pager_selector + ' #grid-pager_left').empty();
			$('#grid-table_toppager_left').append(navTable);
			$('#grid-table_toppager_left').append(_go_back);
			$(window).triggerHandler('resize.jqGrid');
   	});
</script>