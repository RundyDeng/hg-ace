<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<!-- <meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="viewport"
		content="width=device-width, 
	                                     initial-scale=1.0, 
	                                     maximum-scale=1.0, 
	                                     user-scalable=no"> -->
	<title>供热大数据智慧运行系统</title>
	<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
		
	<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
	<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />

	<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
	
.ui-dialog .ui-dialog-titlebar-close::before, .ui-jqdialog .ui-dialog-titlebar-close::before, .ui-dialog .ui-jqdialog-titlebar-close::before, .ui-jqdialog .ui-jqdialog-titlebar-close::before {
    content: "x";
    }
		
	</style>
</head>
<body>

	<div class="container-fluid" style="background-color: #f7f7f9;">
		
<style>
     .flip-clock-wrapper ul{
        margin: 3px;
    }
    #build_th th{
        min-width: 69px;
    }   
</style>
		
<br/>
		<div class="row" style="height: 30px;">
			<div class="col-md-3">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">选择小区: </span>
					  <select id="search_areaname" class="form-control">
					  </select>
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">起始时间：</span>
<%
String edate = "";
String sdate = "";
String attrDate= (String)request.getParameter("sdate");
if(attrDate!=""&&attrDate!=null){
 	edate = (String)request.getParameter("edate");
 	sdate = (String)request.getParameter("sdate");
}else{
	Calendar c = Calendar.getInstance();
	edate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	sdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
}
%>
					  <input type="text" class="form-control" value="<%= sdate %>" id="input_sel_sdate" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			
			<div class="col-md-3">
			<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">结束时间：</span>

					  <input type="text" class="form-control" value="<%= edate %>" id="input_sel_edate" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			
			<div class="col-md-2">
				<button type="button" class="btn btn-success" id="build_data_search">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
			</div>
		</div>
		
		<br/>
		
		<div class="row" style="margin-left: 1px; margin-right: 1px;word-break:break-all;">
        	<div id="container" style="min-width:400px;height:400px"></div>
        </div>
        
        
	</div>
	<div id="divload" style="top: 50%; right: 50%; position: absolute; padding: 0px;
                            margin: 0px; z-index: 999; display: none">
       <img src="${contextPath}/static/image/spinner3-greenie.gif" />正在加载,请稍后......
      </div>
	
	
</body>
</html>

<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
                null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	   	
	$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
		var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
		var urlParm = '<%=(String)request.getParameter("areaguid")%>';
		if(urlParm!='null') areaguid = urlParm;
		var flagName = '';
			var response = jQuery.parseJSON(data);
		      var s = '';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
		        	   s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';   
		          }
		       }
		      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);if('<%=(String)request.getParameter("areaguid")%>'!='null') $('#build_data_search').click();</sc"+"ript>  ";
		      $('#search_areaname').empty().append(s);
	})
	
	$("#input_sel_sdate").datepicker({
    		dateFormat: 'yy-mm-dd',
    	
	});
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		
});
    
	$('#build_data_search').click();
	
});
$('#build_data_search').click(function(){
	$("#divload").show(); 
	page = 1;
	var _sdate = $('#input_sel_sdate').val();
	var _edate = $('#input_sel_edate').val();
    var areaguid = $('#search_areaname').val();
    if(areaguid==''||areaguid==null){
    	areaguid='<%=(String)request.getSession().getAttribute("areaGuids") %>';
    }
	
	
    $.get('${contextPath}/dataAnalysis/useHeatDistributionContr/get?areaguid='+areaguid+'&sdate='+_sdate+'&edate='+_edate,function(response){
        
    	if(response.length<3){
    	//	alert("没有数据！");
    		return;
    	}
    	var highData = jQuery.parseJSON(response);
    	
        $('#container').highcharts({
	        chart: {
	            type: 'scatter',
	            zoomType: 'xy',
	            
	        },
	        title: {
	            text: '不同面积住户单耗散点图'
	        }, 
	        credits: {  
	            enabled: false    
	        },
	        xAxis: {
	            title: {
	                enabled: true,
	                text: '面积 (m2)'
	            },
	            startOnTick: true,
	            endOnTick: true,
	            showLastLabel: true
	        },
	        yAxis: {
	            title: {
	                text: '耗热量 (GJ/m2)'
	            }
	        },
	      
	        plotOptions: {
	            scatter: {
	                marker: {
	                    radius: 5,
	                    states: {
	                        hover: {
	                            enabled: true,
	                            lineColor: 'rgb(100,100,100)'
	                        }
	                    }
	                },
	                states: {
	                    hover: {
	                        marker: {
	                            enabled: false
	                        }
	                    }
	                },
	                tooltip: {
	                    headerFormat: '',
	                    pointFormat: '{point.x} (m2)面积, {point.y} (GJ/m2)耗热量'
	                }
	            }
	        },
	        series: [{
	            name: '单耗(GJ/m2)',
	             color: 'rgba(223, 83, 83, .5)',
	            data: highData
	        }]
	    });
        //_J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
    }).complete(function() {  
    	$("#divload").hide(); 
    }); 
});

</script>
