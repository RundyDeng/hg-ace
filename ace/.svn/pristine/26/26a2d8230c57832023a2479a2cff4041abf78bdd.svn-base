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
			<form class="bd-example">
			  <fieldset>
			    <legend>小区图片设置</legend>
			
			    <p>
			      <label for="areaName">小区选择：</label>
			      <select name="areaName" id="areaName" style="width: 120px;">
			      
			      </select>
			    </p>
			
			    <p>
			      <label for="picNo">图片编号：</label>
			      <select name="picNo" id="picNo" style="width: 120px;">
			      	<option value=1>1环</option>
			      	<option value=2>2环</option>
			      	<option value=3>3环</option>
			      	<option value=4>4环</option>
			      </select>
			    </p>
				
	
			    <p style="margin-left: 72px;">
			      <button type="button" class="btn btn-info" id="subm">保&nbsp;&nbsp;存</button>
			    </p>
			  </fieldset>
			</form>
	</div>
	
</body>
</html>
<script>
    
    $(function(){
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

    		      $('#areaName').empty().append(s);
    	})
    	
    	/* $('#subm').click(function(){
    		$.ajax({
    			url : '${contextPath}/priceMange/setUnitPriceContr/updateSetUnitPrice',
    			type : 'POST',
    			data:$('form').serialize(),
    			dataType : 'json',
    			success : function(data){
    				if(data==true) alert('修改成功');
                    else alert('修改失败');
    			}
    		});
    	}) */
		
		
    })
    
    
    var scripts = [ null,'', null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {});
    
</script>
