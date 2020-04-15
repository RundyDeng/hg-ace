<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<title></title>
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
		
<br/>
		<div class="row" style="height: 30px;">
			<div id="detail_dialog" style="display:none;">
				<table id="grid-table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					<thead>
					    <tr>
					     <th>序号</th>
					      <th>用户编码</th>
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
			
			<div class="col-md-2 col-xs-2">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">公司 </span>
					  	 <select name="lbEnergyFactory" id="lbEnergyFactory" onchange="getHeatingStation(this);"  class="form-control">
					  </select>
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			
			<div class="col-md-3 col-xs-3" style="margin-left:-20px;">
				<div class="input-group">
				
					 <span class="input-group-addon" id="basic-addon3" >热力站</span> <select
						name="lbhot" id="lbhot" onchange="getResidenceCommunity(this);" class="form-control" ></select>
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
				
			</div>
			
			<div class="col-md-2 col-xs-2" style="margin-left:-20px;">
				<div class="input-group">
					  <span class="input-group-addon"  id="basic-addon3">小区</span>
					<!--   <select name="lbFactorySection" id="lbFactorySection"  onchange="commitSetting(this)" class="form-control" >
					  </select> -->
					  
					   <select name="lbFactorySection" id="lbFactorySection" class="form-control" >
					  </select>
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			
			<div class="col-md-2 col-xs-2">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">日期</span>
<%
String today=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
%>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
		
			<div class="col-md-2 col-xs-2">
				<button type="button" class="btn btn-info" id="statistic_new" >查询</button>
				
			</div>
			<div class="col-md-1 col-xs-1">
				
			</div>
			
		</div>
		
		<div id="divload" style="top: 50%; right: 50%; position: absolute; padding: 0px;
                            margin: 0px; z-index: 999; display: none">
       <img src="${contextPath}/static/image/spinner3-greenie.gif" />正在加载,请稍后......
       
      </div>
      
		<br/>
		
		<div class="row">
		    <div class="col-md-10" style="text-align: center;">
			      
			      <table class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr>
					       <th>用户编码</th>
					      <th>用户面积(m²)</th>
					      <th>表故障</th> 
					   	  <th>耗热量(GJ)</th>
					    </tr>
					  </thead>
					  <tbody id="statisticTbody">
					    
					  </tbody>
					</table>
			      
			      <div id="statis_pagination">
			      		
			      </div>
		    </div>
		    <div class="col-md-2" style="display:none;">
		      	
				<p style="color: red;">最新统计情况：</p>
				<p id="statistics_date">统计时间：</p>
				<p>住户总数： ${statisticInfo.TOTZHSUM }</p>
				<p>抄表总数： ${statisticInfo.TOTCBSUM }</p>
				<p>抄表正常数：${statisticInfo.ZCSUM }</p>
				<p>未抄表数：${statisticInfo.WCSUM }</p>
				<p>表故障数： ${statisticInfo.GZSUM }</p>
				<%-- <p>表无反应数：${statisticInfo.WFYSUM }</p> --%>
		    </div>
 		 </div>
		
		
	</div>
	
	
</body>
</html>

<script>

var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
var page = 1;    
var pagesize=20;
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	var select_company = "#lbEnergyFactory";
	$.get($path_base + '/baseinfomanage/setarea/getEnergyFactory',
			function(data) {
				var dom = '';
				for (ea in data) {
					if (ea == 0)
						dom += '<option  value="'+data[ea]['FACTORYID']+'">'
								+ data[ea]['FACTORYNAME'] + '</option>';
					else
						dom += '<option value="'+data[ea]['FACTORYID']+'">'
								+ data[ea]['FACTORYNAME'] + '</option>';
				}
				$(select_company).append(dom);
				
				$(select_company).each(function(){
					$(this).find("option").eq(0).prop("selected" ,true);
				});
			    
				
				var factoryid = $(select_company).val();
				  $('#lbEnergyFactory option[value="'+factoryid+'"]').attr('selected',true);
				     var obj = [];
				     obj.value=factoryid;
				     getHeatingStation(obj); 
				
			}, 'json');
	
	
	$("#input_sel_date").datepicker({
    		dateFormat: 'yy-mm-dd',
    		defaultDate : new Date(),
	});
	

	
	
	$('#statistic_search').click(function(){
		page = 1;
		getStatisticInfo();
	});
	/*最新统计  */
	$('#statistic_new').click(function(){
		
		$("#divload").show(); 
		var newdate = '${date }';
		page = 1;
	
		getStatisticInfo();
	});
	
});

var getHeatingStation = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	$.get($path_base + '/baseinfomanage/setarea/getHeatingStation?FACTORYID= ' + sel.value,
			function(data) {
				var dom = '';
				for (ea in data) {
					if (ea == 0)
						dom += '<option  value="'+data[ea]['SECTIONID']+'">'
								+ data[ea]['SECTIONNAME'] + '</option>';
					else
						dom += '<option value="'+data[ea]['SECTIONID']+'">'
								+ data[ea]['SECTIONNAME'] + '</option>';
				}
				$('#lbhot').empty().append(dom)
				
				
				var sectionid = $('#lbhot').val();
				  $('#lbhot option[value="'+sectionid+'"]').attr('selected',true);
				     var obj = [];
				     obj.value=sectionid;
				     getResidenceCommunity(obj);
	
			}, 'json');
};

var getResidenceCommunity = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	$.get($path_base + '/baseinfomanage/setarea/getResidenceCommunity?SECTIONID=' + sel.value,
			function(data) {
				var dom = '';
				for (ea in data) {
					if (ea == 0)
						dom += '<option  value="'+data[ea]['AREAGUID']+'">'
								+ data[ea]['AREANAME']
								+ '</option>';
					else
						dom += '<option value="'+data[ea]['AREAGUID']+'">'
									+ data[ea]['AREANAME']
								+ '</option>';
				}
				$('#lbFactorySection').empty().append(dom)
			}, 'json');
};

var commitSetting = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	_J_setAreaGuid(sel.value,$(sel).find('option[value="'+sel.value+'"]').html());
	window.location.href=$path_base + "/sys/sysuser/home#page/todaydata"
};
    
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
	    }
		);
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
				
				strHtml += '<tr><th>'+(i+1)+'</th><th>'+obj['CLIENTNO']+'</th><th>'+obj['ADDRESS']+'</th><th>'+obj['METERID']+'</th><th>'+obj['MSNAME']
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
			
		 $('#statistics_date').empty().append("统计时间："+date);

		 var areaNo = $('#lbFactorySection').val();
		 $.get('${contextPath}/baseinfomanage/areaSearch/getStatistic?page='+page+'&date=' + date +'&areaNo=' + areaNo,function(response){
			 
			 $('#statisticTbody').empty();
			 
			 if(response.length<3){
	        		alert("没有数据！");
	        		return;
	        	}
			 
			 var jsonData = jQuery.parseJSON(response);
			 
			 showTable(jsonData);
		 }).complete(function() {  
	        	$("#divload").hide(); 
	        }); 
		
	}
	
	function showTable(jsonData){
		
		 var trs = '';
		$(jsonData).each(function(index ,obj){
		
			trs += '<tr><td>' + obj.userno + '</td>';
			trs += '<td>' + obj.area + '</td>';
			trs += '<td>' + obj.devicestatuts + '</td>';
			trs += '<td>' + obj.totalheat + '</td></tr>';
		});
	 	
		$('#statisticTbody').append(trs); 
		
	}

 
</script>