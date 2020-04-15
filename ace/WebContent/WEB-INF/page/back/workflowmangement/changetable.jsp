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

	<label for="bpeople">流程名称：</label>
	<input type="text" class="form-control" id="bname" placeholder="流程名称" >
<%
Calendar c = Calendar.getInstance();
String enddate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
c.add(Calendar.DATE, -7);
String startdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
</div>
    <div class="form-group">
	<label for="startdate">开始时间：</label>

	<input type="text"  class="form-control" value="<%=startdate %>" id="input_sel_sdate" readonly="readonly" aria-describedby="basic-addon3">
	</div><div class="form-group">
	<label for="enddate">结束时间：</label>
	<input type="text"  class="form-control" value="<%=enddate %>" id="input_sel_edate" readonly="readonly" aria-describedby="basic-addon3">
	</div>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" class="btn btn-success" id="searchdata" >查询</button>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" class="btn btn-success" id="exportdata" >导出EXCEL</button>

    <div class="row">
    <div class="col-xs-12" style="text-align: center;">
		 <table id="operData" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr>
					    	<th style="text-align: center;">序号</th>
                            <th style="text-align: center;">流程名称</th>
                            <th style="text-align: center;">流程</th>
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
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
var page = 1;
var pagesize=20;
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	$("#input_sel_sdate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
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
	 var sdate = $('#input_sel_sdate').val();
	 var edate = $('#input_sel_edate').val();
	 var Flowname=$('#bname').val();
	 var areaName = $('#searchdata').val();
	 $.get('${contextPath}/workflowmanagement/changetable/getChar?page='+page+'&username='+Flowname+'&pagesize='+pagesize+'&sdate=' + sdate +'&edate=' + edate,function(response){
		 	var target = jQuery.parseJSON(response);
			var data = target['data'];
			var pageCount = target['pageCount'];
			console.log(target);
			var str = '';
			if(data.length>0){
				for(var i=0 ; i<data.length ; i++){
					var obj = data[i];
					str += '<tr ><th style="text-align: center;">'+(pagesize*(page-1)+i+1)+'</th><th style="text-align: center;">'+obj['FLOWNAME']+'</th><th style="text-align: center;">'+obj['FLOWS']+'</th><th style="text-align: center;">'+obj['OPERTOR']+'</tr>';
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

<%-- <!DOCTYPE html>
<html lang="zh-cn">
<head>
	<title>供热大数据智慧运行系统</title>

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
			<form class="bd-example"  >
			  <fieldset>
			    <legend>换表流程设置</legend>
			
			    <p>
			      <label for="charid">表单类型：</label>
			      <select name="charid" id="charid">
			      <c:forEach var="obj" items="${list }">
			      		<option value="${obj.charid }">${obj.charname }</option>
			      </c:forEach>
			      </select>
			    </p>
			
				<table id="table_t" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;" >
						<thead> 
	                        <tr>
	                            <th style="text-align: center;">流程名称</th>
	                            <th style="text-align: center;">流程</th>
	                            <th style="text-align: center;">相关操作</th>
	                        </tr> 
                       </thead>
                       <tbody id="tbody-result">  
          			  </tbody>  
                    </table>    
						
				</br>
			    <p style="margin-left: 72px;">
			      <button type="button" class="btn btn-info" id="subm">保&nbsp;&nbsp;存</button>
			      <a href="${contextPath}/sys/sysuser/changetable"><label></label></a>
			    </p> 
			  </fieldset>
			</form>
	</div>
	
</body>
</html>
<script>
	$(function(){
		$.ajax({
			url : '${contextPath}/workflowmanagement/changetable/getChar',
			type : 'POST',
			data:$('form').serialize(),
			dataType : 'json',
			success : function(response){
				 var str = "";  
				for(var i in response){
					var ri = response[i];
			           str += ' <tr> '
		                      +' <th style="text-align: center;">'+ri['Flowname']+'</th>'
		                      +' <th style="text-align: center;">'+ri['Flows']+'</th>'
		                      +' <th style="text-align: center;">'+ri['Opertor']+'</th>'
                  		 +' </tr>';
			          
				}
				$("#tbody-result").empty();
				$("#tbody-result").append(str);
			}
		})
	});
   /*  
    $(function(){
    	var $table_t = $('#table_t');
    	$table_t.change(function(){
    		var _id = $table_t.val();
    		$.get('${contextPath}/workflowmanagement/changetable/getChar',function(response){
        		 var $data = jQuery.parseJSON(response);
        		 $('#PRICE').val($data['PRICE']);
        		 $('#CGPRICE').val($data['CGPRICE']);
        	})		
		})
    	
    	$('#subm').click(function(){
    		$.ajax({
    			url : '${contextPath}/workflowmanagement/changetable/updateSetUnitPrice',
    			type : 'POST',
    			data:$('form').serialize(),
    			dataType : 'json',
    			success : function(data){
    				if(data==true) alert('修改成功');
                    else alert('修改失败');
    			}
    		});
    	})
		
		
    })
     */
    
    var scripts = [ null,'', null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {});
   
</script>
 --%>
