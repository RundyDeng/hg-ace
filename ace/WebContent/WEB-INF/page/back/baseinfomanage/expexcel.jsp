<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<form>
<div class="row">
 <div class="col-xs-9">
  <table style="width: 100%;" class="table table" cellpadding="0" cellspacing="0">
   <tr>
   <td>
   <label for="lblMessage1">小区选择</label>
   </td>
   <td>
   <label for="lblMessage1">选择类型</label>
   </td>
   <td>
   <label for="lblMessage1">已下载小区</label>
   </td>
   </tr>
   <tr>
   <td>
   <select size="4" name="selArea" onClick=""
      id="selArea" style="height: 400px; width: 180px;" multiple="multiple"></select>
   </td>
   <td>
   <select size="4" name="selType" onClick=""
      id="selType" style="height: 200px; width: 180px;"></select>
   </td>
   <td>
   <select size="4" name="uploadedArea" onClick=""
      id="uploadedArea" style="height: 300px; width: 180px;"></select>
   </td>
   </tr>
   <tr>
   <td>
   <button type="button" id="exportExcel" class="btn btn-success">导出EXCEL</button>
   </td>
   </tr>
   
  </table>
 </div>
 <div class="col-xs-3"></div>
</div>
</form>
<script type="text/javascript">

var scripts = [
   			null,
   			"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js",
   			"${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
   			null ]
$('.page-content-area').ace_ajax('loadScripts',scripts,function() {
	$('#exportExcel').click(function(){
		var areaguids="";
		
		 $.each($('#selArea').val(), function(i,val){      
		     areaguids+=val+",";
		  });  
		
		var arr=$('#selArea').val();
		if(areaguids.length>0){
		if($.inArray("999", arr)>-1){ //选择了全部小区
			if($('#selType').val()=="0"){ //选择导出所有 getAllAreaAllData
				var form = "<form name='csvexportform' action='${contextPath}/baseinfomanage/ExpExcel/getAllAreaAllData?type=0' method='post'>";
			 	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
			 	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			 	  
			}else if($('#selType').val()=="1"){ //选择导出故障数据
				var form = "<form name='csvexportform' action='${contextPath}/baseinfomanage/ExpExcel/getAllAreaAllData?type=1' method='post'>";
			 	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
			 	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";  
			}
			
		}else{//选择了部份小区
			if($('#selType').val()=="0"){ //选择导出所有 
				var form = "<form name='csvexportform' action='${contextPath}/baseinfomanage/ExpExcel/getAllAreaAllData?type=0'  method='post'>";
			 	   form = form + "<input type='hidden' name='csvBuffer' value='" + areaguids + "'>";
			 	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			 	  
			}else if($('#selType').val()=="1"){//选择导出故障数据
				var form = "<form name='csvexportform' action='${contextPath}/baseinfomanage/ExpExcel/getAllAreaAllData?type=1'  method='post'>";
			 	   form = form + "<input type='hidden' name='csvBuffer' value='" + areaguids + "'>";
			 	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			}
		}
		 OpenWindow = window.open('', '_blank','width=300,height=300');
	 	  OpenWindow.document.write(form);
	 	  OpenWindow.document.close();
	 	  var e1=document.getElementById('selArea');
	 	  var e2=document.getElementById('uploadedArea');
			 for (var i = 0; i < e1.options.length; i++) {
	             if (e1.options[i].selected) {
	                 var e = e1.options[i];
	                 e2.options.add(new Option(e.text, e.value));
	                 e1.remove(i);
	                 i = i - 1;
	             }
			 }
	 }else{
		 alert("请先选择小区，再导出数据");
	 }
		
	});
	var select_area = "#selArea";
	var select_type = "#selType";
	var select_upload = "#uploadedArea";
	$.get('${contextPath}/baseinfomanage/setarea/getArea',
         function(data) {
						var selopt = '<option  value="999" selected="true">全部小区</option>';

						for (i in data) {
							if (i == 0)
								selopt += '<option  value="'+data[i]['AREAGUID']+'">'
										+ data[i]['AREANAME']
										+ '</option>';
							else
								selopt += '<option value="'+data[i]['AREAGUID']+'">'
										+ data[i]['AREANAME']
										+ '</option>';

						}

						$(select_area).append(selopt)

					}, 'json');
	$(select_type).append("<option  value='0' selected='true'>导出所有</option><option  value='1'>导出故障</option>");
	$(select_upload).append("<option  value='0' selected='true'>已下载小区</option>");
});

</script>