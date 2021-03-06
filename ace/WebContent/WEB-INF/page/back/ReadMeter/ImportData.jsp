<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
	<style>
	.table > tbody > tr > th{
		padding: 12px;
		padding-left: 0px; padding-right: 0px;
	}
	.btn{
		border: 1px solid #FFF;
	}
</style>
	<%
Calendar c = Calendar.getInstance();
String sdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());

%>

<form id="form1">
	<div>
<table class="table table-condensed">
<tr>
<td>
<label style="width:110px">小区：</label><select id="area" name="area" style="width:120px"></select>
</td>
<td>
<label style="width:110px">小区编号：</label><input id="areaguid" name="areaguid" style="width:120px"  type="text"  readonly>
</td>
<td>
<label style="width:110px">集中器编号：</label><input id="pooladdr" name="pooladdr" style="width:120px"  type="text" onkeyup="var v=this.value||'';v=v.replace(/[^\d]/g,'');this.value=v.substr(0,3);" >
</td>
</tr>
<tr>
<td>
<label style="width:110px">通道号：</label><input id="mbusid" name="mbusid" style="width:120px"  type="text" onkeyup="var v=this.value||'';v=v.replace(/[^1-4]/g,'');this.value=v.substr(0,1);" >
</td>
<td>
<label style="width:110px">表号：</label><input id="meterid" name="meterid" style="width:120px"  type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
</td>
<td>
<label style="width:110px">表类型：</label><input id="devicetype" name="devicetype" style="width:120px"  type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
</td>
</tr>
<tr>
<td>
<label style="width:110px">表状态：</label><input id="devicestatus" name="devicestatus" style="width:120px"  type="text"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
</td>
<td>
<label style="width:110px">瞬时热量(kw)：</label><input id="metergl" name="metergl" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')">
</td>
<td>
<label style="width:110px">累计热量(kwh):</label><input id="meternllj" name="meternllj" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" >
</td>
</tr>
<tr>
<td>
<label style="width:110px">瞬时流量(t/h)：</label><input id="meterls" name="meterls" style="width:120px"  type="text"  onkeyup="value=value.replace(/[^\d.]/g,'')">
</td>
<td>
<label style="width:110px">累计流量(m³)：</label><input id="metertj" name="metertj" style="width:120px"   type="text" onkeyup="value=value.replace(/[^\d.]/g,'')">
</td>
<td>
<label style="width:110px">进水温度(℃)：</label><input id="meterjswd" name="meterjswd" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" >
</td>
</tr>
<tr>
<td>
<label style="width:110px">回水温度(℃)：</label><input id="meterhswd" name="meterhswd" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" >
</td>
<td>
<label style="width:110px">温差(℃)：</label><input id="meterwc" name="meterwc" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')">
</td>
<td>
<label style="width:110px">时数(h)：</label><input id="counthour" name="counthour" style="width:120px" type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
</td>
</tr>
<tr>
<td>
<label style="width:110px">抄表时间：</label><input style="height: 28px;width: 120px; padding-top: 2px; padding-bottom: 2px;" id="metersj" name="metersj" type="text"  value="<%=sdate %>" readonly="readonly">
</td>
<td>
<label style="width:110px">采集时间：</label><input style="height: 28px;width: 120px; padding-top: 2px; padding-bottom: 2px;" id="ddate" name="ddate" type="text"  value="<%=sdate %>" readonly="readonly">
</td>
<td>
<label style="width:110px">抄表批次：</label><input id="autoid" name="autoid" style="width:120px"  type="text" onkeyup="var v=this.value||'';v=v.replace(/[^1-4]/g,'');this.value=v.substr(0,1);">
</td>
</tr>
<tr>
<td>
<label style="width:110px">设备备注：</label><input id="remark" name="remark" style="width:120px"  type="text"  >
</td>
<td>
<label style="width:110px">系统状态：</label><input id="sysstatus" name="sysstatus" style="width:120px"  type="text">
</td>
<td>
<label style="width:110px">累计热量(GJ)：</label><input id="meternlljgj" name="meternlljgj" style="width:120px"  type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" >
</td>
</tr>
<tr>
<td>
<td>
<button type="button" class="btn btn-success" id="importdata">人工录入</button>
&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" class="btn btn-info" id="importexcel"  >批量导入</button>
</td>
<td></td>
</tr>
</table>
</div>
</form>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
                
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	$("#metersj").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
	$("#ddate").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
	  
	
	var select_area = "#area";
	var session_areaguid="<%=(String)request.getSession().getAttribute("areaGuids") %>";
	$.get('${contextPath}/baseinfomanage/setarea/getArea',
	         function(data) {
							var selopt;

							for (i in data) {
							
									selopt += '<option value="'+data[i]['AREAGUID']+'">'
											+ data[i]['AREANAME']
											+ '</option>';

							}

							$(select_area).append(selopt);
							$(select_area).children("option").each(function(){  
						        var temp_value = $(this).val();  
						       if(temp_value == session_areaguid){  
						             $(this).attr("selected","selected");  
						       }  
						  });
							$('#areaguid').val($(select_area).val());
							
	}, 'json');
	 
    $(select_area).change(function () {  
    	$("input[name='areaguid']").val("");
    	$('#areaguid').val($(select_area).val());
    });
    $('#importdata').click(function(){
    	$.ajax({
    	     type: "POST",
    	     dataType: "json",
    	     url:'${contextPath}/readmeter/importdata/importData',
    	     data:$('#form1').serialize(),
    	     success: function(success){
    	    	// if(sucess==null){ /* return */ alert("请录入内容");}
    	         if(success==true){
    	        	 $("input[name='pooladdr']").val("");
    	        	 $("input[name='mbusid']").val("");$("input[name='meterid']").val("");
    	        	 $("input[name='devicetype']").val("");$("input[name='devicestatus']").val("");
    	        	 $("input[name='metergl']").val("");$("input[name='meternllj']").val("");
    	        	 $("input[name='meterls']").val("");$("input[name='metertj']").val("");
    	        	 $("input[name='meterjswd']").val("");$("input[name='meterhswd']").val("");
    	        	 $("input[name='meterwc']").val("");$("input[name='counthour']").val("");
    	        	 $("input[name='autoid']").val("");$("input[name='remark']").val("");
    	        	 $("input[name='sysstatus']").val("");$("input[name='meternlljgj']").val("");
    	        	
    	        	 alert("添加成功！");
    	         }else{
    	        	 alert("添加失败！");
    	         }
    	     }
    	 });

    });
    $("#importexcel").hide()
    $('#importexcel').click(function(){
    	window.location.href="${contextPath}/sys/sysuser/importview";
    	/* setTimeout(function(){ 
    		window.location.href="${contextPath}/sys/sysuser/importview"; 
    		},100); */  
    }); 
						
});
</script>