<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pages/css/baseinfomanage/betweenmeterchange.css" />
	
<script src="${contextPath }/static/pages/js/baseinfomanage/betweenmeterchange.js"></script>	
	
<div class="row">
	<div class="col-xs-12" >
	<form name="form1" method="post" action="" id="form1">
		<div id="downlistBar">
			<div class="tit">
                 <h3 class="icon4"> 选择查询条件</h3>
            </div>
            <br/>
			<table style="width: 100%" class="table table" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                <tr>
                                    <th width="130px">小区</th>
                                    <th> 楼宇</th>
                                    <th>单元</th>
                                    <th>楼层</th>
                                    <th>门牌</th>
                                    <th>表类型</th>
                                    <th>子表类型</th>
                                    <th>表序列</th>
                                    <th> 当前表号</th>
                                    <th> 计划互换表号</th>
                                </tr>
                                <tr>
                                    <th>
                                        <select id="community" name="community" onchange="building(this)">
                                    </th>
                                    <th>
                                        <select id="build" name="build" onchange="uniting(this)">
                                    </th>
                                    <th>
                                        <select id="unit" name="unit" onchange="flooring(this)">
                                    </th>
                                    <th>
                                         <select id="floor" name="floor" onchange="dooring(this)">
                                    </th>
                                    <th>
                                         <select name="doorno_up" id="door" onchange="oldInfo(this)">
                                    </th>
                                    <th>
                                        <select  id="ddlblx" class="selectputaspx">
											<option selected="selected" value="0">热能表</option>
										</select>
                                    </th>
                                    <!-- 子表类型 -->
                                    <th>
                                        <select  id="ddlBiaoLeiXing" name="ddlBiaoLeiXing" class="selectputaspx"> 
                                        </select>
                                    </th>
                                    <!-- 表序列》貌似就是表号啊，先不理 -->
                                    <th>
                                        <select  id="comMeterSeq1" name="comMeterSeq1" style="width:130px;">
										</select>
                                    </th>
                                    <!-- 当前表号 -->
                                    <th style="width: 110px">
                                        <input id="TDOOR_METER_METERNO"  name="TDOOR_METER_METERNO" disabled="disabled"  enablemultistyle="true"  style="width:110px;" type="text"/>
                                    </th>
                                    
                                    <!-- 计划互换表号 -->
                                    <th style="width: 120px">
                                        <input name="meterno_up" id="plan_meterno1" readonly="readonly" enablemultistyle="true" type="text"/>
                                    </th>
                                    
                                    
                                </tr>
                                <tr>
                                    <td colspan="10" align="center">
                                        <font color="red" size="6">↑↓</font>
                                    </td>
                                </tr>
                                <tr>
                                    <th>小区</th>
                                    <th>楼宇</th>
                                    <th>单元</th>
                                    <th>楼层</th>
                                    <th>门牌</th>
                                    <th>表类型</th>
                                    <th>子表类型</th>
                                    <th>表序列</th>
                                    <th> 当前表号</th>
                                    <th>计划互换表号</th>
                                </tr>
                                <tr>
                                    <th>
                                        <select id="community2" name="community2" onchange="building2(this)">
                                    </th>
                                    <th>
                                        <select id="build2" name="build2" onchange="uniting2(this)">
                                    </th>
                                    <th>
                                        <select id="unit2" name="unit2" onchange="flooring2(this)">
                                    </th>
                                    <th>
                                         <select id="floor2" name="floor2" onchange="dooring2(this)">
                                    </th>
                                    <th>
                                         <select name="doorno_down" id="door2" onchange="oldInfo2(this)">
                                    </th>
                                    <th>
                                        <select  id="ddlblx" class="selectputaspx">
											<option selected="selected" value="0">热能表</option>
										</select>
                                    </th>
                                    <th>
                                        <select  id="ddlBiaoLeiXing2" name="ddlBiaoLeiXing2" class="selectputaspx"> 
                                        </select>
                                    </th>
                                    <!-- 表序列》貌似就是表号啊，先不理 -->
                                    <th style="width: 120px">
                                        <select style="width: 100%;" id="comMeterSeq2" name="comMeterSeq2">
										</select>
                                    </th>
                                    <!-- 当前表号 -->
                                    <th style="width: 110px">
                                        <input id="TDOOR_METER_METERNO2" name="TDOOR_METER_METERNO2" disabled="disabled"  enablemultistyle="true"  style="width:110px;" type="text"/>
                                    </th>
                                    
                                    <!-- 计划互换表号 -->
                                    <th style="width: 120px">
                                        <input name="meterno_down" style="width: 100%;" id="plan_meterno2" readonly="readonly" type="text"/>
                                    </th>
                                    
                                </tr>
                                <tr>
                                    <td colspan="10" align="center">
                                    	<button type="button" id="modify" onclick="modifyMeter()" class="btn btn-info-outline">修改数据</button>
                                        <span id="Label1" style="color:Red;">(★提示：同一小区，同一通道，互换表号！★)</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="10" align="center">
                                        <span id="labMessage"></span>
                                    </td>
                                </tr>
                            </tbody></table>
		</div>
</form>

		
	</div>
</div>

