<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>

<head> 
<meta charset="utf-8" /> 
<title></title> 
<style> 
body{ text-align:center} 
.div{ margin:0 auto; width:400px; height:100px; } 

</style> 
</head> 	
<body> 
<div >
	<img src="${contextPath}/static/image/heatIndex.png" widwidth="100%" />  

	 
</div><div align="center">	 同一用户不同室外温度的热耗指标对比分析</div>
</body> 
</html> 	

