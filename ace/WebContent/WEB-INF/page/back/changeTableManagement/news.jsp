<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" contentType="text/html; charset=utf-8">
<title>新闻推送</title>
</head>
<body>
<h1>每日头条</h1>
<div>
	<div>
		<h2>实时新闻在线看</h2>
		<div style="..."><b><p id="onTimeNews"></p></b> </div>
	</div>
	<hr>
	<div>2018年要深入推进改革开放，加快重点领域改革，做好电信、军工企业混合所有制改革</div>
	<hr>
	<div>
		中国移动完成公司制改制 成为”中国移动通信集团有限公司” 2017-12-26 13:15:16 中国移动完成改制 
		主要变更事宜如下：一、企业类型由全民所有制企业变更为国有独资公司。二、企业名称由“中国移动通信集团公司”变更为“中国移动通信集团有限公司”，英文名称由“China Mobile Communications Corporation”变更为China Mobile Communications Group Co.,Ltd”。三、企业原有业务、资产、资质、债权债务均由改制后的中国移动通信集团有限公司继承。
	</div>
</div>
<script type="text/javascript" src="${contextPath}/static/assets/js/jquery.js" ></script>
<script type="text/javascript">
	longloop();
	function longloop(){
		$.get('${contextPath}/newsContron/ontimeNews',function(data){
			console.log(data);
			$("#onTimeNews").html(data);
			longloop();
		})
	};
</script>
</body>
</html>