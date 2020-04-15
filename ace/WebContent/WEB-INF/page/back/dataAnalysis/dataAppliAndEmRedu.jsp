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
	<img src="${contextPath}/static/image/data.png" width="100%" />  
	 
</div>
<div align="center">通过数据对比分析可以初步得出以下结论：
通过精细化管理、二级泵及用户行为节能总热量逐年下降；
退费用户的热耗指标逐年降低，但补费用户基本不变；
只退不补的政策对公司收支及供热成本变化的统计。</div>
</body> 
</html> 	

