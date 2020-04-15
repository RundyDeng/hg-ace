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
			    <legend>计量单价设置</legend>
			
			    <p>
			      <label for="CLIENTCATID">住户类型：</label>
			      <select name="CLIENTCATID" id="CLIENTCATID">
			      <c:forEach var="obj" items="${list }">
			      		<option value="${obj.CLIENTCATID }">${obj.CLIENTCAT }</option>
			      </c:forEach>
			      </select>
			    </p>
			
			    <p>
			      <label for="PRICE">计量单价：</label>
			      <input name="PRICE" id="PRICE" type="text" value="${list[0].PRICE }">&nbsp;&nbsp;元/KW.H
			      
			    </p>
				<p>
			      <label for="CGPRICE">热费单价：</label>
			      <input name="CGPRICE" id="CGPRICE" value="${list[0].CGPRICE }" type="text">&nbsp;&nbsp;元/平方米
			      
			    </p>
			    <p>
			      <label for="Auto">热费基率：</label>
			      <input id="Auto" name="Auto" value="${Auto }" type="text">
			      
			    </p>
	
			    <p style="margin-left: 72px;">
			      <button type="button" class="btn btn-info" id="subm">保&nbsp;&nbsp;存</button>
			      <a href="${contextPath}/sys/sysuser/setUnitPriceContr"><label></label></a>
			    </p>
			  </fieldset>
			</form>
	</div>
	
</body>
</html>
<script>
    
    $(function(){
    	var $clientcatid = $('#CLIENTCATID');
    	$clientcatid.change(function(){
    		var _id = $clientcatid.val();
    		$.get('${contextPath}/priceMange/setUnitPriceContr/getSetUnitPrice?CLIENTCATID='+_id,function(response){
        		 var $data = jQuery.parseJSON(response);
        		 $('#PRICE').val($data['PRICE']);
        		 $('#CGPRICE').val($data['CGPRICE']);
        	})		
		})
    	
    	$('#subm').click(function(){
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
    	})
		
		
    })
    
    
    var scripts = [ null,'', null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {});
   
</script>