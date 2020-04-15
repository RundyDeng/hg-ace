<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<div style="width:581px; height:auto; float:left; display:inline">
<img src="${contextPath}/static/image/reyun.png" width="581px" height="362px"/>
</div> 
<div style="width:505px; height:auto; float:left; display:inline">
<img src="${contextPath}/static/image/chart.png" width="505px" height="342px"/>与生产调度系统结合实现热网调控运行：
统计各小区建筑物的耗热数据，初步确定小区供热量指标，并进一步确定热源生产计划；
根据实际室内温度结果调整供热计划；
在运行调控方案数据基础上建立数学模型。
</div> 
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                "${contextPath}/static/Highcharts-4.2.5/grouped-categories.js", 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
                null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
});
</script>