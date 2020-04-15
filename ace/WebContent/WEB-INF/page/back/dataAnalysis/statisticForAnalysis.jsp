<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
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
					      <th>仪表厂商</th>
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
Calendar c = Calendar.getInstance();
String today=new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			<div class="col-md-4">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">按小区名称查询: </span>
					  <select id="search_areaname" class="form-control">
					  	
					  </select>
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			<div class="col-md-4">
				<button type="button" class="btn btn-success"  id="statistic_search">查询</button>
				<button type="button" class="btn btn-info" id="statistic_new" >最新统计</button>
				<button type="button" class="btn btn-primary" id="btn-excel" >导出EXCEL</button>
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
		      	
				<p style="color: red;">最新统计情况：</p>
				<p>统计时间: <%=today %> </p> <!--${date }  -->
				<p>住户总数： ${statisticInfo.TOTZHSUM }</p>
				<p>抄表总数： ${statisticInfo.TOTCBSUM }</p>
				<p>抄表正常数：${statisticInfo.ZCSUM }</p>
				<p>未抄表数：${statisticInfo.WCSUM }</p>
				<p>表故障数： ${statisticInfo.GZSUM }</p>
				 <p>表无反应数：${statisticInfo.WFYSUM }</p> 
				 <p style="color: red;">备注：</br>1.未抄表：指没有上报数据的表；</br>2.无反应：指有通讯，上报数据为0的表;</p>
				 
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
	   	
	$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
		var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
		var flagName = '';
			var response = jQuery.parseJSON(data);
		      var s = '<option value="">请选择</option>';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           if(ri['AREAGUID']==areaguid){
			        	   flagName = ri['AREANAME'];
			           }
		        	   s += '<option value="' + ri['AREANAME'] + '">' + ri['AREANAME'] + '</option>';   
		          }
		       }
		      
		      //if(flagName!=''){
		    	 // s += "<script>$('select option[value=\""+flagName+"\"]').change().attr('selected',true);</sc"+"ript>  ";
		    //}
		  
		      $('#search_areaname').empty().append(s);
	})
	
	$("#input_sel_date").datepicker({
    		dateFormat: 'yy-mm-dd',
    		defaultDate : new Date(),
	});
	
	$('#statistic_search').click(function(){
		page = 1;
		getStatisticInfo();
	});
	  //  $('#statistic_new').click();   //20171009
	
});
$('#statistic_new').click(function(){
	var newdate = '${date }';
	
	$('#input_sel_date').val(newdate);
	page = 1;
	getStatisticInfo();
});

//20180316 导出excel
	$("#btn-excel").click(function(){	
		var form = "<form name='csvexportform' action='${contextPath}/dataAnalysis/statisticContr/updateStatistic?oper=excel' method='post'>";
	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
	   OpenWindow = window.open('', '','width=200,height=100');//打开一个新的浏览器窗口或查找一个已命名的窗口。
	   OpenWindow.document.write(form);//向文档写 HTML 表达式 或 JavaScript 代码。
	   OpenWindow.document.close();//关闭用 document.open() 方法打开的输出流，并显示选定的数据。  
	   setTimeout("OpenWindow.close()",10000);
	   //OpenWindow.close();
	  
	});



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
	    	    height:500,
	    	    width:1000,
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
   			focus: function(event, ui){
   				
   				
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
				
				strHtml += '<tr><th>'+(i+1)+'</th><th>'+obj['CLIENTNO']+'</th><th>'+obj['ADDRESS']+'</th><th>'+obj['METERID']+'</th><th>'+obj['DEVICECHILDTYPENAME']+'</th><th>'+obj['MSNAME']
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
		 var areaName = $('#search_areaname').val();
		 $.get('${contextPath}/dataAnalysis/statisticContr/getStatistic?page='+page+'&date=' + date +'&areaname=' + areaName,function(response){
				var target = jQuery.parseJSON(response);
				var data = target['data'];
				var pageCount = target['pageCount'];
				var str = '';
				if(data.length>0){
					for(var i=0 ; i<data.length ; i++){
			
						var obj = data[i];
						if(obj['FACTORYNAME']==null){
							obj['FACTORYNAME']="";
						}
						if(obj['SECTIONNAME']==null){
							obj['SECTIONNAME']="";
						}
						str += '<tr><th>'+(pagesize*(page-1)+i+1)+"</th><th>"+obj['FACTORYNAME']+'</th><th>'+obj['SECTIONNAME']+'</th><th>'+obj['AREANAME']
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
