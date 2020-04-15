<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title></title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
		</style>
</head>
<body>
<form class="form-inline">
    <div class="form-group">
	<h3>待审批处理</h3>
	</div>
	</br>
    <div class="row">
    <div class="col-xs-12" style="text-align: center;">
		 <table id="operData" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr>
					    	<th style="text-align: center;">标题</th>
                            <th style="text-align: center;">申请人</th>
                            <th style="text-align: center;">申请日期</th>
                             <th style="text-align: center;">状态</th>
                            <th style="text-align: center;">相关操作</th>
                        </tr> 
					  </thead>
					  <tbody id="operlog">
					  </tbody>
					</table>
				 <div id="operlog_pagination">
			      		
			      </div>
		</div>
     </div>
</form>
</br>
</br>
<div class="Description">
	说明：<br />
	1，待审批处理，在相关操作中进行审批处理与查看记录。<br />
	2，审批处理同意，不同意，返回本页面。<br />
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
	
   $('#searchdata').click(function(){
	page = 1;
	getoperlog();
   });
   $('#exportdata').click(function(){
	   exportExcel();
	   });
});
var go = function(e){
	page = e;
	getoperlog();
}
 function getoperlog(){
	//fid,title,applicator,applictetime,state,url
	// var areaName = $('#searchdata').val();
	 
	 $.get('${contextPath}/workflowmanagement/exmineApprove/getApprove?page='+page+'&pagesize='+pagesize,function(response){
		 	var target = jQuery.parseJSON(response);
			var data = target['data'];
			var pageCount = target['pageCount'];
			console.log(target);
			var str = '';
			if(data.length>0){
				for(var i=0 ; i<data.length ; i++){
					var obj = data[i];
					str += '<tr ><th style="text-align: center;">'+(pagesize*(page-1)+i+1)+'</th><th style="text-align: center;">'+obj['title']+'</th><th style="text-align: center;">'+obj['applicator']+'</th><th style="text-align: center;">'+obj['applictetime']+'</th><th style="text-align: center;">'+obj['state']+'</th></tr>';
				}  
			}
			$('#operlog').empty();
			$('#operlog').append(str);
			
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
			
			$('#operlog_pagination').empty(); 
			if(data.length>0){
				$('#operlog_pagination').append(pageHtml); 
			}
		});
}

</script>


