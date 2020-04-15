<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

        <link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
        <link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
        <script src="${contextPath }/static/pages/js/baseinfomanage/changemeter.js"></script>

        <div class="row">
            <div class="col-xs-12">
                <div id="downlistBar">
                    <table style="width: 100%" class="table">
                        <tbody>
                            <tr>
                                <th>小区：
                                    <select id="community" onchange="building(this)">
                                    </select>
                                </th>
                                <th>&nbsp;楼宇：
                                    <select id="build" onchange="uniting(this)">
                                    </select>
                                </th>
                                <th>&nbsp;单元：
                                    <select id="unit" onchange="flooring(this)">
                                    </select>
                                </th>
                                <th>&nbsp;楼层：
                                    <select id="floor" onchange="dooring(this)">
                                    </select>
                                </th>
                                <th>&nbsp;门牌：
                                    <select id="door" onchange="oldInfo(this)">
                                    </select>
                                </th>
                                <th>表类型：
                                    <select name="ddlblx" id="ddlblx" class="selectputaspx">
                                        <option selected="selected" value="0">热能表</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th>旧表号码:
                                    <input id="TDOOR_METER_METERNO" disabled="disabled" class="input" enablemultistyle="true" style="height: 26px; width: 90px;" type="text">
                                </th>
                                <th>旧表底数：
                                    <input id="PRODUSHU" disabled="disabled" class="input" enablemultistyle="true" style="height: 26px; width: 80px;" type="text">
                                </th>
                                <th>新表号码:
                                    <input id="TMODIFYMETER_METERID" class="input" enablemultistyle="true" style="height: 26px; width: 90px;" type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') ">
                                </th>
                                <th>新表底数：
                                    <input id="DISHU" class="input" enablemultistyle="true" style="height: 26px; width: 80px;" type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') ">
                                </th>
                                <th>&nbsp; 用户编码：
                                    <input id="CLIENTNO" disabled="disabled" class="input" enablemultistyle="true" style="height: 26px; width: 110px;" type="text">
                                </th>
                                <th>表品牌：
                                    <select name="ddlBiaoLeiXing" id="ddlBiaoLeiXing" class="selectputaspx">
                                    </select>&nbsp;&nbsp;
                                </th>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <button type="button" id="btnSearch" class="btn btn-secondary-outline">换表记录查询</button>
                                    <button type="button" id="Button1" onClick="modifyMeter()" class="btn btn-success-outline">更&nbsp;&nbsp;改</button>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <%--jqgrid表格 --%>
                    <div id="da-search"></div>
                    <table id="grid-table"></table>
                    <div id="grid-pager"></div>

            </div>
        </div>