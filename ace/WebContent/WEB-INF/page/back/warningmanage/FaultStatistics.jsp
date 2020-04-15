<%@page import="core.util.MathUtils"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="core.util.MathUtils"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/chartsreports/morris.css" />
<link rel="stylesheet"
	href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery.gritter.css" />
<link rel="stylesheet"
	href="${contextPath }/static/pages/css/homepage.css" />
<script src="${contextPath }/static/pages/js/homepage.js"></script>
<script src="${contextPath }/static/pages/js/customer.btn.treeview.js"></script>
<script src="${contextPath }/static/pages/js/fuelux.tree2.js"></script>

			<!-- <div id="home-customer-btns" class="row ui-section" style="margin-bottom: 0px;">
			</div> -->

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="card" style="padding-bottom: 10px;">
							
							<div class="row">
								<div class="col-sm-12">
									<div class="header" style="margin-bottom: 5px;">
										<h4 class="title h-tit-style" style="display: inline;">
											<i class="ace-icon fa fa-caret-right orange"></i> 故障统计
										</h4>
										<div style="float: right;">
											<button id="warning-more" type="button" data-addtab="searchfaultparamwarn" title="故障统计"
												class="btn btn-primary" url="searchfaultparamwarn"  
												style="border-width: 0px; margin-left: 5px; padding: 3px 6px;">更多...</button>
												<button id="btn-excel" type="button" class="btn btn-primary" 
												style="border-width: 0px; margin-left: 5px; padding: 3px 6px;">导出Excel</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">

									<div class="widget-body">
										<div class="widget-main no-padding">
											<table id="getwarninginfo"></table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</div>



<script>


var checkInLay = false;
var btnHover = false;

function showOrHidePicFloat(){
	if(checkInLay == true && btnHover == true) $('#home-pic-float').stop().slideDown("slow");
	if(checkInLay == false && btnHover == false) $('#home-pic-float').stop().slideUp();
}

$(function(){
	
})


function roundFix(cellvalue) {
	if (cellvalue == '' || cellvalue == undefined) return 0;
	return cellvalue.toFixed(2);
}

var end = 50;
var mid = 1;
var currentPosition = 0;
var runId;
function goPosition() {
	runId = setInterval("runTo()", 10);
}
function runTo() {
	currentPosition = document.documentElement.scrollTop || document.body.scrollTop;
	currentPosition += mid;
	if (currentPosition < end) {
		window.scrollTo(0, currentPosition);
	} else {
		clearInterval(runId);
	}
}



var scripts = [ 
        $path_base + '/static/assets/js/jquery-ui.js',
		$path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		$path_base + "/static/Highcharts-4.2.5/js/highcharts.js",
		$path_base + "/static/Highcharts-4.2.5/js/modules/data.js",
		$path_base + "/static/Highcharts-4.2.5/highslide-full.min.js",
		$path_base + "/static/Highcharts-4.2.5/highslide.config.js",
		$path_base + "/static/Highcharts-4.2.5/js/highcharts-3d.js",
		$path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js",
		$path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		$path_base + '/static/Highcharts-4.2.5/js/modules/exporting.js',
		$path_base + "/static/assets/js/jquery.gritter.js"];
$('.page-content-area').ace_ajax('loadScripts',scripts,function() {
	Highcharts.theme = {  
			chart: { backgroundColor: null, style: { fontFamily: "Dosis, sans-serif" } }, 
			title: { style: { fontSize: '16px', fontWeight: 'bold', textTransform: 'uppercase' } }, 
			tooltip: { borderWidth: 0, backgroundColor: 'rgba(219,219,216,0.8)', shadow: false }, 
			legend: { itemStyle: { fontWeight: 'bold', fontSize: '13px' } }, 
			xAxis: { gridLineWidth: 1, labels: { style: { fontSize: '12px' } } }, 
			yAxis: { minorTickInterval: 'auto', title: { style: { textTransform: 'uppercase' } }, labels: { style: { fontSize: '12px' } } }, 
			plotOptions: { candlestick: { lineColor: '#404048' } },
			background2: '#F0F0EA',
			lang: {printChart: "打印图形",downloadJPEG: "下载JPEG文件",downloadPDF: "下载PDF文件",downloadPNG: "下载PNG文件",downloadSVG: "下载SVG文件"}
	};
	Highcharts.setOptions(Highcharts.theme);
	
			
		function roundFix(cellvalue) {
			if (cellvalue == '' || cellvalue == undefined) return 0;
			return cellvalue.toFixed(2);
		}

	        //故障部分    #getwarninginfo
	        jQuery('#getwarninginfo').jqGrid({
				url : $path_base + '/warningmanage/FaultStatiscontr/getwarninginfo',
				datatype : "json",
				height : 450,
				rownumbers:true,
				colNames : ['<i class="ace-icon fa fa-caret-right orange"></i>  小区名称','<i class="ace-icon fa fa-caret-right orange"></i>  地址',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  故障名称','<i class="ace-icon fa fa-caret-right orange"></i>  瞬时流量',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  进水温度','<i class="ace-icon fa fa-caret-right orange"></i>  回水温度',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  温差','<i class="ace-icon fa fa-caret-right orange"></i>  抄表时间'],
				colModel : [{name : '小区名称',width : 124,sortable:false},
			 	           {name:'门牌',width : 114,sortable:false},
				            {name:'异常情况',width : 270,sortable:false,formatter:function(cellVal){if(cellVal==null) return ""; return cellVal.replace(/,$/,'');}},
				            {name:'瞬时流量',width: 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('瞬时流量过低')!=-1) return getOverlowStr(cel,obj,'MeterLS');
				            	if(obj['异常情况'].indexOf('瞬时流量过高')!=-1) return getOvertopStr(cel,obj,'MeterLS');
				            	return cel;
				            }},
				            {name:'供水温度',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('供水温度过低')!=-1) return getOverlowStr(cel,obj,'MeterJSWD');
				            	if(obj['异常情况'].indexOf('供水温度过高')!=-1) return getOvertopStr(cel,obj,'MeterJSWD');
				            	return cel;
				            }},
				            {name:'回水温度',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('回水温度过低')!=-1) return getOverlowStr(cel,obj,'MeterHSWD');
				            	if(obj['异常情况'].indexOf('回水温度过高')!=-1) return getOvertopStr(cel,obj,'MeterHSWD');
				            	return cel;
				            }},
				            {name:'温差',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	setTimeout(function sss() {
				    	        	var warLenth = obj['异常情况'].split(',').length - 1;
				                	var $curRow = $('#' + op.rowId);
				                	if(warLenth == 1) $curRow.addClass("list-group-item-success");
				                	if(warLenth == 2) $curRow.addClass('list-group-item-info');
				                	if(warLenth == 3) $curRow.addClass('list-group-item-warning');
				                	if(warLenth == 4) $curRow.addClass('list-group-item-danger');
				    	        },0);
				            	
				            	if(obj['异常情况'].indexOf('温差过低')!=-1) return getOverlowStr(cel,obj,'MeterWC');
				            	if(obj['异常情况'].indexOf('温差过高')!=-1) return getOvertopStr(cel,obj,'MeterWC');
				            	return cel;
				            }},
				            {name:'抄表时间',width : 110,sortable:false}],
				scroll : 1,
				rowNum : 12,
				shrinkToFit : false
			});
	        
	   	$(window).on('resize.jqGrid', function() {
	   		$('#getwarninginfo').jqGrid('setGridWidth', $(".page-content").width()-25);
	   	});
	   	$(window).triggerHandler('resize.jqGrid');
	   	
	   	$('#warning-more').click(function(){
	   	//	window.location.href=$path_base + '/sys/sysuser/page/back/warningmanage/searchfaultparamwarn';
	   		
	   	 //window.location.href=$path_base + '/sys/sysuser/home#page/searchfaultparamwarn';
	   	});
	   	
	   	//20180316 导出excel
	   	$("#btn-excel").click(function(){	
	   		var form = "<form name='csvexportform' action='${contextPath}/warningmanage/FaultStatiscontr/updateFaultStatistics?oper=excel' method='post'>";
	    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
	    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
	    	   OpenWindow = window.open('', '','width=200,height=100');//打开一个新的浏览器窗口或查找一个已命名的窗口。
	    	   OpenWindow.document.write(form);//向文档写 HTML 表达式 或 JavaScript 代码。
	    	   OpenWindow.document.close();//关闭用 document.open() 方法打开的输出流，并显示选定的数据。  
	    	   setTimeout("OpenWindow.close()",10000);
	    	   //OpenWindow.close();
	    	  
	   	});

//故障部分    #getwarninginfo
var waringHomeTo = function(clientNO,date,btn,meterid){
		var url = $path_base + '/sys/sysuser/monitordata/clientCharts?clientno='+clientNO+'&date='+date+'&btn='+btn+'&meterid='+meterid;
	  document.location.href = url;
 }
var getOverlowStr = function(cel,obj,btn){
	return '<b class="green" title="参数过低" data-addtab="clientCharts" url="clientCharts?clientno='+obj['CLIENTNO']+'&date='+obj['抄表时间']+'&btn='+btn+'&meterid='+obj['METERID'] + '" '
	+ 'onClick="#(\''+obj['CLIENTNO']+'\',\''+obj['抄表时间']+'\',\''+btn+'\',\''+obj['METERID']+'\');">'+cel+' <li class="fa fa-arrow-down"></li></b>';
}//20180319 #-->waringHomeTo
var getOvertopStr = function(cel,obj,btn){
	return '<b class="red" title="参数过高" data-addtab="clientCharts" url="clientCharts?clientno='+obj['CLIENTNO']+'&date='+obj['抄表时间']+'&btn='+btn+'&meterid='+obj['METERID'] + '" '
	+' onClick="waringHomeTo(\''+obj['CLIENTNO']+'\',\''+obj['抄表时间']+'\',\''+btn+'\',\''+obj['METERID']+'\');">'+cel+' <li class="fa fa-arrow-up"></li></b>';
}


});
</script>
