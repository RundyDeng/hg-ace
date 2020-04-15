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
	<%-- <link rel="stylesheet"
		href="${contextPath}/static/bootstrap-4.0/css/bootstrap.min.css"> --%>
		<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
		<%-- <link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" /> --%>
		<%-- <link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" /> --%>
		<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
		
	<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
	<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
	<%-- <link rel="stylesheet"
		href="${contextPath}/static/bootstrap-4.0/perstyle/test.css"> --%>
		
	<!-- basic scripts -->
	<!--[if !IE]> -->
	<script type="text/javascript">
				window.jQuery || document.write("<script src='${contextPath}/static/assets/js/jquery.js'>" + "<"+"/script>");
			</script>
	<!-- <![endif]-->
	<!--[if IE]>
			<script type="text/javascript">
			 	window.jQuery || document.write("<script src='${contextPath}/static/assets/js/jquery1x.js'>"+"<"+"/script>");
			</script>
		<![endif]-->
		<!--[if lte IE 8]>
		<script src="${contextPath}/static/assets/js/html5shiv.js"></script>
		<script src="${contextPath}/static/assets/js/respond.js"></script>
		<![endif]-->
		<script src="${contextPath}/static/assets/js/ace-extra.js"></script>
	<script
		src="${contextPath}/static/bootstrap-4.0/js/bootstrap.min.js"></script>
	<script src="${contextPath}/static/assets/js/bootstrap.js"></script>
	<script
		src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script
		src="${contextPath}/static/pageclock/compiled/flipclock.js"></script>
		


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
		 <!-- <div class="collapse" id="exCollapsingNavbar">
		 <div class="bg-inverse p-a">
		    <h4>Collapsed content</h4>
		    <span class="text-muted">Toggleable via the navbar brand.</span>
		  </div>
		</div>
		<nav class="navbar navbar-light bg-faded">
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
		    &#9776;    &nbsp;&nbsp;&nbsp;数据统计信息查询
		  </button>
		</nav> -->
		<style>
 .flip-clock-wrapper ul{
	margin: 3px;
} 
		</style>
		<nav class="navbar navbar-dark bg-primary" style="background: #0275d8; height: 60px; padding-top: 3px; margin-left: 0px;">
		  <div class="container" style="padding-left: 0px; border-left-width: 0px; border-left-style: solid; margin-left: auto;">
		  	<div class="row">
		  		<div class="col-sm-9">
		  			<a class="navbar-brand" href="#">&#9776;    &nbsp;&nbsp;&nbsp;小区整体运行情况统计</a>
		  		</div>
			  	<div class="col-sm-3" style="padding: 0px;">	
			  		<div class="clock" style="margin: 0px;"></div>
			  	</div>
			   
		  	</div>
		    
		  </div>
		  
		</nav>
<br/>
		<div class="row">
			<div id="detail_dialog" style="display:none;">
				<table id="grid-table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					<thead>
					    <tr>
					      <th>住户</th>
					      <th>地址</th>
					      <th>表编号</th>
					      <th>热表状态</th>
					      <th>瞬时热量(KW)</th>
					      <th>累计热量(KWH)</th>
					      <th>瞬时流量(t/h)</th>
					     <th>累计流量(t)</th>
					      <th>进水温度</th>
					      <th>回水温度</th>
					      <th>温差</th>
					      <th>问题说明</th>
					    </tr>
					  </thead>
					  <tbody id="detail_tbody">
					    
					  </tbody>
				
				</table>
		
				<div id="grid-pager"></div>
			</div>
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">其他日期：</span>
<%
String today=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
%>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			<div class="col-md-4">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">按小区名称查询: </span>
					  <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3">
				</div>
			</div>
			<div class="col-md-3">
				<button type="button" class="btn btn-primary" onclick="javascript:window.close();" style="float: right; margin-left: 8px;">关闭</button>
				<button type="button" class="btn btn-success" style="float: right;" id="statistic_search">查询</button>
				<button type="button" class="btn btn-danger-outline" id="statistic_new" >最新统计</button>
				
			</div>
			<div class="col-md-2">
				
			</div>
			
		</div>
		
		<br/>
		
		<div class="row">
		    <div class="col-md-10" style="text-align: center;">
			      
			      <table class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr>
					      <th>序号</th>
					      <th>分公司</th>
					      <th>换热站</th>
					      <th>小区</th>
					      <th>住户数</th>
					      <th>抄表数</th>
					      <th>正常数</th>
					     <!--  <th>表状态数</th> -->
					      <th>无反应</th>
					      <th>未抄表</th>
					    </tr>
					  </thead>
					  <tbody id="statisticTbody">
					    
					  </tbody>
					</table>
			      
			      <div id="statis_pagination">
			      		
			      </div>
		    </div>
		    <div class="col-md-2">
		      	<!-- 20171009 修改 -->
				<%-- <p style="color: red;">最新统计情况：</p>
				<p>统计时间${date }</p>
				<p>住户总数： ${statisticInfo.TOTZHSUM }</p>
				<p>抄表总数： ${statisticInfo.TOTCBSUM }</p>
				<p>抄表正常数：${statisticInfo.ZCSUM }</p>
				<p>未抄表数：${statisticInfo.WCSUM }</p>
				<p>表故障数： ${statisticInfo.GZSUM }</p> --%>
				<%-- <p>表无反应数：${statisticInfo.WFYSUM }</p> --%>
		    </div>
 		 </div>
		
		
	</div>
	
	
</body>
</html>
<script>
var page = 1;
var fileName = "";
	$(function(){
		/* var clock;
		
		$(document).ready(function() {
			clock = $('.clock').FlipClock({
				clockFace: 'TwentyFourHourClock',
				
			});
		}); */
		
		
		$("#input_sel_date").datepicker({
	    		dateFormat: 'yy-mm-dd',
	    		defaultDate : new Date(),
    	});
		
		$('#statistic_search').click(function(){
			page = 1;
			getStatisticInfo();
		});
		
		$('#statistic_new').click(function(){
			var newdate = '${date }';
			$('#input_sel_date').val(newdate);
			page = 1;
			getStatisticInfo();
		});
	})
	
	var title = '今日运行状态详情';
	
	var go = function(e){
		page = e;
		getStatisticInfo();
	}
	
	var exportExcel = function(){
		var rows = '';
		var row = '';//标题部分
		$('#grid-table thead th').each(function(index,value){
			index ==0 ? row+=value.innerHTML : row += '\t'+value.innerHTML;
		});
		rows += row;
		var $tb_tr = $('#grid-table tbody tr');
		$tb_tr.each(function(index,value){
			rows +='\n';
			
			$(value).find('th').each(function(i,v){
				if(v.innerHTML!=''){
					i==0 ? rows += v.innerHTML : rows += '\t' + v.innerHTML;
				}else{
					i==0 ? rows += v.innerHTML : rows += '\t ';
				}
				
			});
		});
		if(row==rows){
			alert("没有数据");
			return;
		}
		var form = "<form name='csvexportform' action='${contextPath}/homePage/excelTodayStatus?title="+encodeURIComponent(encodeURIComponent(title))+"' method='post'>";
    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
    	   OpenWindow = window.open('', '导出数据','width=500,height=300');
    	   OpenWindow.document.write(form);
    	   OpenWindow.document.close();
	}
	
	var showdialog = function(){
		$("#detail_dialog").dialog({
	    		title : title,
	    		bgiframe: true,
	    	    resizable: true,
	    	    height:600,
	    	    width:1200,
	    	    modal: true,
		    	buttons: {
   				          '导出': function() {
   				        			  exportExcel();
		   				              $(this).dialog('destroy');
		   				           	  $("#input_sel_date").datepicker('destroy');
		   				          },
   				          '关闭': function() {
		   				              $(this).dialog('destroy');
		   				          	  $("#input_sel_date").datepicker('destroy');
		   				          }
   				      },
   			focus: function(event, ui) {
   				
   				
   			}
	    	});
	}
	
	function roundFix(cellvalue){
		if(cellvalue==''||cellvalue==undefined)
			return 0;
		return cellvalue.toFixed(2);
	}
	
	var loadTable = function(url){
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";
		
		$.get(url,function(response){
			var data = jQuery.parseJSON(response);

			var strHtml = ''; 
			for(var i=0 ;i<data.length;i++){
				var obj = data[i];
				
				strHtml += '<tr><th>'+obj['CLIENTNO']+'</th><th>'+obj['ADDRESS']+'</th><th>'+obj['METERID']+'</th><th>'+obj['MSNAME']
						+'</th><th>'+roundFix(obj['METERGL'])+'</th><th>'+roundFix(obj['METERNLLJ'])+'</th><th>'+roundFix(obj['METERLS'])
						+'</th><th>'+roundFix(obj['METERTJ'])+'</th><th>'+roundFix(obj['METERJSWD'])+'</th><th>'+roundFix(obj['METERHSWD'])
						+'</th><th>'+roundFix(obj['METERWC'])+'</th><th>';
				if(obj['REMARK']==null||obj['REMARK']==undefined||obj['REMARK']=='null'){
				
				}else{
					strHtml += obj['REMARK'];
				}
						
				strHtml += '</th></tr>';
			}
			
			$('#detail_tbody').empty().append(strHtml);
		});

		showdialog();
	}
	
	var detail = function(SYSSTATUS,AREAGUID,AREANAME){

		if(SYSSTATUS==1){
			title = "今日运行状态详情（未抄表）- "+AREANAME+"小区";
		}
		if(SYSSTATUS==999){
			title = "今日运行状态详情(无反应) - "+AREANAME+"小区";
		}
		var url = '${contextPath}/homePage/getMeterDetail?SYSSTATUS='+SYSSTATUS+'&DDATE='+$('#input_sel_date').val()
				+'&areaguid='+AREAGUID+'&autoid=1';
		loadTable(url);
	}
	
	var getStatisticInfo = function(){
		 var date = $('#input_sel_date').val();
		 alert(date);
		 var areaName = $('#search_areaname').val();
		 $.get('${contextPath}/homePage/getStatisticInfo?page='+page+'&date=' + date +'&areaname=' + areaName,function(response){
				var target = jQuery.parseJSON(response);
				var data = target['data'];
				var pageCount = target['pageCount'];
				
				var str = '';
				if(data.length>0){
					for(var i=0 ; i<data.length ; i++){
			
						var obj = data[i];
						str += '<tr><th>'+(i+1)+"</th><th>"+obj['FACTORYNAME']+'</th><th>'+obj['SECTIONNAME']+'</th><th>'+obj['AREANAME']
							+ '</th><th>'+obj['TOTZHSUM']+'</th><th>'+obj['TOTCBSUM']+'</th><th>'+obj['ZCSUM']+'</th>'
							+'<th><a href="javascript:detail(999,'+obj['AREAGUID']+',\''+obj['AREANAME']+'\');">'+obj['WFYSUM']+'</a></th>'
							+'<th><a href="javascript:detail(1,'+obj['AREAGUID']+',\''+obj['AREANAME']+'\');">'+obj['WCBSUM']+'</a></th></tr>';
					}
				}
				$('#statisticTbody').empty();
				$('#statisticTbody').append(str);
				
				var pageHtml = '<nav><ul class="pagination">'
				if(page == 1){
					pageHtml += '<li class="disabled"><a href="javascript:void(0);" aria-label="Previous">';
				}else{
					pageHtml += '<li><a href="javascript:go('+(page-1)+');" aria-label="Previous">';
				}
				pageHtml +=  '<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>';
				for(var i = 0 ;i<pageCount;i++){
					var j = i+1;
					if(page==j){
						pageHtml += '<li class="active"><a href="javascript:void(0);">'+j+' <span class="sr-only">(current)</span></a></li>';
					}else{
						pageHtml += '<li><a href="javascript:go('+j+')">'+j+'</a></li>';
					}
					
				}
				if(page==pageCount){
					pageHtml += '<li class="disabled"><a href="javascript:void(0);" aria-label="Next">'
				}else{
					pageHtml += '<li><a href="javascript:go('+(page+1)+')" aria-label="Next">';
				}
				pageHtml += '<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li></ul></nav>';			
					
				$('#statis_pagination').empty(); 
				if(data.length>0){
					$('#statis_pagination').append(pageHtml); 
				}
			});
	}
 
</script>
