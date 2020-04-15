<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>
打印退费单
</title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

<script src="${contextPath}/static/trueclock/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="${contextPath}/static/assets/js/ace/ace.ajax-content.js"></script>
<style type="text/css">

        table
        {
            width: 710px;
            border: 1px solid #000;
            border-width: 0px 0px 1px 1px;
        }
        table td
        {
            border-bottom: #000 1px solid;
            border-left: #000 1px solid;
            border-top: #000 1px solid;
            border-right: #000 1px solid;
        }
        P
        {
            page-break-after: always;
        }
        .titles
        {
            width: 100px;
            font-weight: bold;
        }
        .con
        {
            width: 130px;
        }
        .unit
        {
            width: 60px;
            font-weight: bold;
        }
        .con1
        {
            width: 70px;
            text-align: right;
        }
        .unit1
        {
            width: 40px;
            font-weight: bold;
        }
        .con2
        {
            text-align: right;
            width: 80px;
        }
        .con3
        {
            text-align: left;
            width: 80px;
        }
           
        P
        {
            page-break-after: always;
        }
    </style>
</head>
<body style="height: 100%; background-image: url(); background-color: #FFFFFF" >
<form>
<div id="table">
</div>
</form>
</body>
</html>
<script>
$(function(){
	var areaguid="<%= request.getParameter("areaguid")%>";
	var buildno="<%= request.getParameter("buildno")%>";
	var unitno="<%= request.getParameter("unitno")%>";
	var floorno="<%= request.getParameter("floorno")%>";
	var doorno="<%= request.getParameter("doorno")%>";
	var years="<%= request.getParameter("years")%>";
	 $.post("${contextPath}/priceMange/billprint/getTable?areaguid="+areaguid+"&buildno="+buildno+"&unitno="+unitno+"&floorno="+floorno+"&doorno="+doorno+"&years="+years, function (data) {
		 if(data!=""){
			 $('#table').append(data);
			 printdiv('table');
		 }
	 });
	 
});
function printdiv(printpage)
{
var headstr = "<html><head><title></title></head><body>";
var footstr = "</body></html>";
var newstr = document.all.item(printpage).innerHTML;
var oldstr = document.body.innerHTML;
document.body.innerHTML = headstr+newstr+footstr;
window.print(); 
document.body.innerHTML = oldstr;
return false;
}
</script>