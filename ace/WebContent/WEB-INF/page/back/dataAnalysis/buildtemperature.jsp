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
	<%-- <script
		src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script
		src="${contextPath}/static/pageclock/compiled/flipclock.js"></script> --%>
		


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
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">选择时间：</span>
<%
	String today = (String)request.getParameter("day");
	if(today==""||today==null){
		Calendar c = Calendar.getInstance();
	    today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	}
%>
					  <input type="text" class="form-control" value="<%= today %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			
			<div class="col-md-3">
			</div>
			
			<div class="col-md-2">
				<button type="button" class="btn btn-success" id="build_data_search">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
			</div>
		</div>
		
		<br/>
		
		<div class="row" style="overflow: auto; margin-left: 1px; margin-right: 1px;">
		    
			      
			      <table id="build_table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <!-- <thead>
					    <tr id="build_th">
					      
					    </tr>
					  </thead>
					  <tbody id="build_td">
                        
				      </tbody> -->
					</table>
			      
			      
 		 </div>
        
        <div class="row" style="margin-left: 1px; margin-right: 1px;word-break:break-all;">
            <div class="col-md-7" style="border:0px solid red;overflow-x: hidden;">
              
				<div id="3d-column" style="min-width:570px;margin-left: -30px;min-height: 450px;"></div>
            </div>
            <div class="col-md-5" style="border:0px solid red;min-height: 450px;">
            	
                <div id="3d-pie"></div>
            </div>
        </div>
         
		
	</div>
	
	
</body>
</html>

<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                //"${contextPath}/static/old/highcharts.js",
                 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
	   			/* "${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js", */
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
	
	$("#input_sel_date").datepicker({
    		dateFormat: 'yy-mm-dd',
    		defaultDate : new Date(),
	});
	
	$('#build_data_search').click();
	
	
});

$('#build_data_search').click(function(){
	page = 1;
	var _date = $('#input_sel_date').val();
    var areaguid = $('#search_areaname').val();
    if(areaguid==''||areaguid==null) {
    	areaguid='<%=(String)request.getSession().getAttribute("areaGuids") %>';
    }
	
	
    $.get('${contextPath}/dataanalysis/buildtemperaturecontr/getbuildtemperature?areaguid='+areaguid+'&date='+_date,function(response){
        var productData = jQuery.parseJSON(response);
        
        showTable(productData);

        var clstr = new Array();
        var serstr = new Array();
        var slstr = [];
        var ydata = new Array();
        var ydata2 = new Array();
        var ydata3 = new Array();

        var sum = 0;
        $.each(productData, function (i) {
            sum += Math.abs(Number(productData[i].平均温差));
        });
        $.each(productData, function (i) {
            clstr[i] = productData[i].楼栋号;
            serstr[i] = Number(productData[i].平均进水温度);
            ydata2[i] = Number(productData[i].平均回水温度);
            ydata3[i] = Math.abs(Number(productData[i].平均温差));

            var item = [];
            item.push(productData[i].楼栋号);
            item.push(Number(((Math.abs(Number(productData[i].平均温差)) / sum) * 100).toFixed(2)));
            slstr.push(item);

        });
        
        InitLine(clstr, serstr, ydata2, ydata3);
        InitPie(slstr);
        
        _J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
    })
	
});
	function showTable(productData){
		var trs = "<tr><th style='min-width: 170px;'>分析项目</th>";
        $.each(productData, function (j, m) {
            trs += "<th style='min-width: 60px;'><a href='${contextPath}/sys/sysuser/home#page/todaydata?buildno="+m.BUILDNO+"&day="+$('#input_sel_date').val()+"'>" + m.楼栋号 + /* "栋"+ */ "</a></th>";

        });
        trs += "</tr>"
        var td = "<tr><td>平均进水温度(℃)</td>";
        $.each(productData, function (i, n) {
            td += "<td>" + n.平均进水温度 + "</td>";

        });
        td += "</tr>";
        var tds = "<tr><td>平均回水温度(℃)</td>";
        $.each(productData, function (a, b) {
            tds += "<td>" + b.平均回水温度 + "</td>";

        });
        tds += "</tr>";
        var tb = "<tr><td>平均温差(℃)</td>";
        $.each(productData, function (c, d) {
            tb += "<td>" + d.平均温差 + "</td>";

        });
        tb += "</tr>";
        var tbs = "<tr><td>分析对象(户)</td>";
        $.each(productData, function (c, d) {
            tbs += "<td>" + d.户数 + "</td>";

        });
        tbs += "</tr>";
        tbody = trs + td + tds + tb + tbs;

        $("#build_table").empty().append(tbody);
	}
	
	function InitPie(m) {
	    $('#3d-pie').highcharts({
	    	
		 	exporting: {
                enabled:false
    		},
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: '小区楼栋平均温差数据饼状图'
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '平均温差',
	            data: m
	        }]
	    });

	}
	function InitLine(a, b, c, d) {
	    $('#3d-column').highcharts({
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'column'
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: '小区楼栋进回水温度统计分析'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: a
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '平均温度 (℃)'
	            }
	        },

	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        tooltip: {
	            shared: true,
	            useHTML: true,
	            headerFormat: '<small>{point.key}</small>',
	            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y} ℃</b></td></tr></tbody></table>',
	            footerFormat: '',
	            valueDecimals: 2
	        },
	        series: [{ name: '平均进水温度',
	            data: b
	        },
	                         { name: '平均回水温度',
	                             data: c
	                         },
	                         { name: '平均温差',
	                             data: d
	                         }]

	    });
	}
   
</script>
	

 