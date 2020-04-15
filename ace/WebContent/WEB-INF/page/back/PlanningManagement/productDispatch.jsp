<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title></title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
		</style>
</head>
<body>
<%
Calendar c = Calendar.getInstance();
String startdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
<form class="form-inline" style="align:center">
  <div class="form-group">
	<label for="company">分公司：</label>
<select id="selarea">
	<c:forEach items="${result}" var="e">
    <option value="${e.AREAGUID}">
    <c:out value="${e.AREANAME}"/>
    </option>
   </c:forEach>
</select></div><div class="form-group">
	<label for="startdate">日期：</label>
	<input type="text"  class="form-control" value="<%=startdate %>" id="input_sel_sdate" readonly="readonly"  >
	 </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <button type="button" class="btn btn-success" id="searchdata" >查询</button>
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <button type="button" class="btn btn-success" id="planissued" >计划下达</button>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <button type="button" class="btn btn-success" id="saveplan" >保存计划</button>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <button type="button" class="btn btn-success" id="exportdata" >导出EXCEL</button>
	 </form>
	 <div id="tabview"></div>
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	$("#input_sel_sdate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$('#searchdata').click(function(){
		getplandate();
	   });
});
function getplandate(){
	var mydate = new Date();
	/* var str="<table><tr><td>时间</td><td>"+mydate.toLocaleDateString()+"</td><td>室外气温<br/>(℃)</td><td>3</td><td colspan='1'>填报时间</td><td colspan='2'>" + mydate.toLocaleDateString() + "</td><td>热源比例(%)</td><td id='glbi' colspan='2'>98</td></tr>";
	str += "<tr ><td rowspan='2'>分公司名称</td><td rowspan='2'>换热站名称</td><td rowspan='2'>供热<br/>面积<br />(㎡)</td><td rowspan='2'>供热<br/>方式</td><td colspan='4'>日计划耗热指标</td><td colspan='2'>次日计划热量</td></tr>";
	str += "<tr ><td>温度<br />系数</td><td>热量<br />系数</td><td>单耗<br />(W/㎡)</td><td>指标<br />(W/㎡)</td><td>(MW*h)</td><td>(GJ)</td></tr></table>";
	$('#tabview').empty();
	$('#tabview').append(str); */
}
</script>