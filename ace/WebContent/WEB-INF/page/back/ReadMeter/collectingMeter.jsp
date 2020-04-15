<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
			href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />

<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
		</style>


<div class="row">
	<div class="col-xs-12">
		<div id="downlistBar">
		<table style="width:100%">
<tr>
<td>
<label>小区：</label>
<select id="selArea" name="selArea" style="width:120px"> </select>
<label>楼栋：</label>
<select id="selBuild" name="selBuild" style="width:100px%"><option value="9999">请选择</option></select>
<label>单元：</label>
<select id="selUnit" name="selUnit" style="width:100px"><option value="9999">请选择</option></select>
<label>楼层：</label>
<select id="selFloor" name="selFloor" style="width:100px"><option value="9999">请选择</option></select>
<label>门牌：</label>
<select id="selDoorname" name="selDoorname" style="width:100px"><option value="9999">请选择</option></select>
</td>
</tr>
	<tr>
			<td style="border-bottom: 1px solid #ddd;">
			<button type="button" id="btn_cb" class="btn btn-info">开始抄表</button>
			<button type="button" id="btn_cal" class="btn btn-info">取消抄表</button>
			<button type="button" id="btn_excel" class="btn btn-info">导出EXCEL</button>
			<label id="lblmessage"></label>
			</td>
	</tr>
			
			</table>
		</div>

	  <div class="row">
    <div class="col-xs-12" style="text-align: center;width:100%">
		 <table id="operData" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr >
					      <th style="text-align: center;">门牌号</th>
					      <th style="text-align: center;">用热状态</th>
					      <th style="text-align: center;">用户编码</th>			     
					      <th style="text-align: center;">建筑面积</th>
					      <th style="text-align: center;">表编号</th>
					      <th style="text-align: center;">热表状态</th>
					      <th style="text-align: center;">瞬时热量(kw/h)</th>
					      <th style="text-align: center;">累计热量(kwh)</th>
					      <th style="text-align: center;">瞬时流量(t/h)</th>
					      <th style="text-align: center;">累计流量(t)</th>
					      <th style="text-align: center;">进水温度(℃)</th>
					      <th style="text-align: center;">回水温度(℃)</th>
					      <th style="text-align: center;">温差(℃)</th>
					      <th style="text-align: center;">时数</th>
					      <th style="text-align: center;">时间</th>
					      <th style="text-align: center;">抄表批次</th>
					    </tr>
					  </thead>
					  <tbody id="operlog">
					    
					  </tbody>
					</table>
	         </div>
	        
		</div>
	</div>
</div>
<script>
var scripts = [ null,"${contextPath}/static/assets/js/jquery-ui.js",,null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		var select_area = "#selArea";
		var session_areaguid="<%=(String)request.getSession().getAttribute("areaGuids") %>";
		$.get('${contextPath}/baseinfomanage/setarea/getArea',
		         function(data) {
								var selopt;

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

								$(select_area).append(selopt);
								$(select_area).children("option").each(function(){  
							        var temp_value = $(this).val();  
							       if(temp_value == session_areaguid){  
							             $(this).attr("selected","selected");  
							       }  
							  });
								 $.post("${contextPath}/priceMange/billprint/getBuild?areaguid="+$(select_area).val(), function (data) {  
							            /* 清空楼栋 */  
							            $("#selBuild option[value!='9999']").remove();  
							            /* 清空单元 */  
							            $("#selUnit option[value!='9999']").remove();  
							            /* 清空楼层 */  
							            $("#selFloor option[value!='9999']").remove();
							            /* 清空门牌 */  
							            $("#selDoorname option[value!='9999']").remove();
							            var jsonObj = eval("(" + data + ")");  
							            for (var i = 0; i < jsonObj.length; i++) {  
							                var $option = $("<option></option>");  
							                $option.attr("value", jsonObj[i].BUILDNO);  
							                $option.text(jsonObj[i].BUILDNAME);  
							                $("#selBuild").append($option);  
							            }  
							        });  
							}, 'json');
		 /* 根据小区楼栋 */  
	    $(select_area).change(function () {  
	        $.post("${contextPath}/priceMange/billprint/getBuild?areaguid="+$(select_area).val(), function (data) {  
	            /* 清空楼栋 */  
	            $("#selBuild option[value!='9999']").remove();  
	            /* 清空单元 */  
	            $("#selUnit option[value!='9999']").remove();  
	            /* 清空楼层 */  
	            $("#selFloor option[value!='9999']").remove();
	            /* 清空门牌 */  
	            $("#selDoorname option[value!='9999']").remove();
	            var jsonObj = eval("(" + data + ")");  
	            for (var i = 0; i < jsonObj.length; i++) {  
	                var $option = $("<option></option>");  
	                $option.attr("value", jsonObj[i].BUILDNO);  
	                $option.text(jsonObj[i].BUILDNAME);  
	                $("#selBuild").append($option);  
	            }  
	        });  
	    });  
	    /* 根据小区楼栋单元 */  
	    $("#selBuild").change(function (){  
	        $.post("${contextPath}/priceMange/billprint/getUnit?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val(), function (data) {  
	          
	            /* 清空单元 */  
	            $("#selUnit option[value!='9999']").remove();  
	            /* 清空楼层 */  
	            $("#selFloor option[value!='9999']").remove();
	            /* 清空门牌 */  
	            $("#selDoorname option[value!='9999']").remove();
	            var jsonObj = eval("(" + data + ")");  
	            for (var i = 0; i < jsonObj.length; i++) {  
	                var $option = $("<option></option>");  
	                $option.attr("value", jsonObj[i].UNITNO);  
	                $option.text(jsonObj[i].UNITNO);  
	                $("#selUnit").append($option);  
	            }  
	        });  
	    });  
	    /* 根据小区楼栋单元楼层 */  
	    $("#selUnit").change(function () {  
	        $.post("${contextPath}/priceMange/billprint/getFloor?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val()+"&unitno="+$("#selUnit").val(), function (data) {  
	           
	            /* 清空楼层 */  
	            $("#selFloor option[value!='9999']").remove();
	            /* 清空门牌 */  
	            $("#selDoorname option[value!='9999']").remove();
	            var jsonObj = eval("(" + data + ")");  
	            for (var i = 0; i < jsonObj.length; i++) {  
	                var $option = $("<option></option>");  
	                $option.attr("value", jsonObj[i].FLOORNO);  
	                $option.text(jsonObj[i].FLOORNO);  
	                $("#selFloor").append($option);  
	            }  
	        });  
	    });  
	    /* 根据小区楼栋单元楼层 */  
	    $("#selFloor").change(function () {  
	        $.post("${contextPath}/priceMange/billprint/getDoorName?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val()+"&unitno="+$("#selUnit").val()+"&floorno="+$("#selFloor").val(), function (data) {  
	          
	            /* 清空门牌 */  
	            $("#selDoorname option[value!='9999']").remove();
	            var jsonObj = eval("(" + data + ")");  
	            for (var i = 0; i < jsonObj.length; i++) {  
	                var $option = $("<option></option>");  
	                $option.attr("value", jsonObj[i].DOORNO);  
	                $option.text(jsonObj[i].FCODE);  
	                $("#selDoorname").append($option);  
	            }  
	        });  
	    }); 
	    
	  //集抄修改 2018/3/9  
		$("#btn_cb").click(function(){	
		  var buildno=$("#selBuild").val();
		  var unitno=$("#selUnit").val();
		  var floorno=$("#selFloor").val();
		  var doorno=$("#selDoorname").val();
		  if(buildno!='9999'){
			  $.post("${contextPath}/readmeter/collectingMeter/getUserInfo?areaguid="+$(select_area).val()+"&buildno="+$$("#selBuild").val(), function (data) {  
				  var productData=jQuery.parseJSON(data); 
				  var message = productData['message'];
				  var data = productData['data'];
				  $('#lblmessage').text('');
				  $("#lblmessage").append(message);
				  var str = '';
				  if(data.length>0){
					  for(var i=0 ; i<data.length ; i++){
							var msname='';
							var obj = data[i];
							if(obj['MSNAME']!=null){
								msname=obj['MSNAME'];
							}
							str += '<tr ><th style="text-align: center;">'+obj['MENPAI']+'</th><th style="text-align: center;">'+obj['SFTR']+'</th><th style="text-align: center;">'+obj['CLIENTNO'];
							str+='</th><th style="text-align: center;">'+obj['HOTAREA']+'</th><th style="text-align: center;">'+obj['METERID']+'</th><th style="text-align: center;">'+msname+'</th><th style="text-align: center;">'+obj['METERGL'];
							str+='</th><th style="text-align: center;">'+obj['METERNLLJ']+'</th><th style="text-align: center;">'+obj['METERLS']+'</th><th style="text-align: center;">'+obj['METERTJ']+'</th><th style="text-align: center;">'+obj['METERJSWD'];
							str+='</th><th style="text-align: center;">'+obj['METERHSWD']+'</th><th style="text-align: center;">'+obj['METERWC']+'</th><th style="text-align: center;">'+obj['COUNTHOUR']+'</th><th style="text-align: center;">'+obj['DDATE'];
							str+='</th><th style="text-align: center;">'+obj['AUTOID']+'</th></tr>';
						}
				  }
				$('#operlog').empty();
				$('#operlog').append(str);
			  });
		  }else{
			  alert("集抄选择楼栋");
		  }
		});
});
</script>


