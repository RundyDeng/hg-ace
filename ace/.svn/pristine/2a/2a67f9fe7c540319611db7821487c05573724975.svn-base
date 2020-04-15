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

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
			href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />

<style>
	.table > tbody > tr > th{
		padding: 12px;
		padding-left: 0px; padding-right: 0px;
	}
	.btn{
		border: 1px solid #FFF;
	}
</style>	
	
<%
String edate = "";
String sdate = "";
String attrDate= (String)request.getParameter("sdate");
if(attrDate!=""&&attrDate!=null){
 	Calendar cal = new GregorianCalendar();
 	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
 	Date parseDate = df.parse(attrDate);
 	cal.setTime(parseDate);
 	cal.add(Calendar.DATE, -7);
 	sdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
 	edate = (String)request.getParameter("edate");
}else{
	Calendar c = Calendar.getInstance();
	edate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	sdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
}
%>

<div class="row">
	<div class="col-xs-12">
		<div id="downlistBar">
		<table>
<tr>
<td>
<label>起始时间：</label>
<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_selsdate" type="text"  value="<%=sdate %>" readonly="readonly">
<label>结束时间：</label>
<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_seledate" type="text"  value="<%=edate %>" readonly="readonly">
</td>
<td>
<label>用户编号：</label>
<input style="height: 28px;width: 130px; padding-top: 2px; padding-bottom: 2px;" id="clientno" type="text"  value="<%=(String)request.getParameter("customerid") %>" readonly="readonly">
</td>

<td style="border-bottom: 1px solid #ddd;">
		<button style="margin-left:20px;" type="button" value="LLIANG" class="btn btn-info">流量增量</button>
	  	<button type="button" value="RELIANG" class="btn btn-info">热量增量</button>
	  	<button type="button" onClick = "javascript:history.back();" class="btn btn-success-outline">返&nbsp;&nbsp;回</button>
	</td>
</tr>


			
			</table>
		</div>

		<!-- 曲线图显示位置 -->
		<div id="zlcharts">
		
		
		</div>
	</div>
</div>
<script>
var scripts = [ null,"${contextPath}/static/assets/js/jquery-ui.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	$("#input_selsdate").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
		$("#input_seledate").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
		$('button').click(function(){
    		var buttonname = $(this).val();
    		var y='';
    		var dw='';
    		var title1='';
    		var title2='';
    		if(buttonname=='LLIANG'){
    			y='流量增量(m³)';
    			title1='累计流量--增量曲线';
    			title2='每日流量增量';
    			dw='m³';
    		}else{
    			y='热量增量(KWH)';
    			title1='累计热量--增量曲线';
    			title2='每日热量增量';
    			dw='KWH';
    		}
    		
    	$.post("${contextPath}/monitorData/zlcharts/getzlData?zl="+buttonname
    			+"&areaguid=<%=(String)request.getParameter("areaguid")%>&customerid="+$('#clientno').val()+"&sdate="+$('#input_selsdate').val()+"&edate="+$('#input_seledate').val(), function (data) {  
    		var chartdata = [];
    		var xchart=[];
    		var jsonarray = eval("("+data+")");
    		if(buttonname=='LLIANG'){
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata[i] = parseFloat(jsonarray[i].LLIANG);
    				xchart[i] = jsonarray[i].DDATE;
    			}

    		}else{
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata[i] = parseFloat(jsonarray[i].RELIANG);
    				xchart[i] =jsonarray[i].DDATE;
    			}

    		}
    		$('#zlcharts').highcharts({
    		        title: {
    		            text: title1,
    		            x: -20 //center
    		        },
    		        credits: {
    		            enabled:false
    		        },
    		        subtitle: {
    		            text: title2,
    		            x: -20
    		        },
    		        xAxis: {
    		        	tickInterval: 5,
    		            categories:xchart,
    		            labels:{
    		            	 rotation: -45   //45度倾斜
    	                   
    	                 }
    		        },
    		        yAxis: {
    		            title: {
    		                text: y
    		            },
    		            plotLines: [{
    		                value: 0,
    		                width: 1,
    		                color: '#808080'
    		            }]
    		        },
    		        tooltip: {
    		            valueSuffix: dw
    		        },
    		        legend: {
    		            layout: 'vertical',
    		            align: 'right',
    		            verticalAlign: 'middle',
    		            borderWidth: 0
    		        },
    		        series: [{
    		            name: y,
    		            data: chartdata
    		        }]
    		    }); 
    		 });
		});
		
		$('button[value="RELIANG"]').click();
		
});
</script>