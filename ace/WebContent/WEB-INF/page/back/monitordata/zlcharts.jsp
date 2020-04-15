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
String edate = "";
String sdate = "";
String attrDate= (String)request.getParameter("sdate");
if(attrDate!=""&&attrDate!=null){
 	edate = (String)request.getParameter("edate");
 	sdate = (String)request.getParameter("sdate");
}else{
	Calendar c = Calendar.getInstance();
	edate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	sdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
}
%>

<div class="row">
	<div class="col-xs-12">
		<div id="downlistBar">
		<table>
<tr>
<td>
<label>小区：</label>
<select id="selArea" name="selArea" style="width:100px"> </select>
<label>楼栋：</label>
<select id="selBuild" name="selBuild" style="width:100px"><option value="9999">请选择</option></select>
<label>单元：</label>
<select id="selUnit" name="selUnit" style="width:100px"><option value="9999">请选择</option></select>
<label>楼层：</label>
<select id="selFloor" name="selFloor" style="width:100px"><option value="9999">请选择</option></select>
<label>门牌：</label>
<select id="selDoorname" name="selDoorname" style="width:100px"><option value="9999">请选择</option></select>
<label>起始时间：</label>
<input style="height: 28px;width: 80px; padding-top: 2px; padding-bottom: 2px;" id="input_selsdate" type="text"  value="<%=sdate %>" readonly="readonly">
<label>结束时间：</label>
<input style="height: 28px;width: 80px; padding-top: 2px; padding-bottom: 2px;" id="input_seledate" type="text"  value="<%=edate %>" readonly="readonly">
</td>

</tr>

					
					<tr>
						<td style="border-bottom: 1px solid #ddd;">
							<button type="button" value="LLIANG" class="btn btn-info">流量增量</button>
						  	<button type="button" value="RELIANG" class="btn btn-info">热量增量</button>
						</td>
					</tr>


			
			</table>
		</div>

		<!-- 曲线图显示位置 -->
		<div id="zlcharts">
		
		
		</div>
	</div>
</div>
<script>
var scripts = [ null,"${contextPath}/static/assets/js/jquery-ui.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	$("#input_selsdate").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
		$("#input_seledate").datepicker({
    		dateFormat: 'yy-mm-dd',
	});
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
	    $("#selBuild").change(function () {  
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
		$('button').click(function(){
			if($("#selDoorname").val()=="9999"){
				alert("请先选择门牌后查询！");
			}else{
				
    		var buttonname = $(this).val();
    		var y='';
    		var dw='';
    		var title1='';
    		var title2='';
    		if(buttonname=='LLIANG'){
    			y='流量增量(m³)';
    			title1='累计流量--增量曲线';
    			title2='每日流量增量';
    			dw='m³';
    		}else{
    			y='热量增量(KWH)';
    			title1='累计热量--增量曲线';
    			title2='每日热量增量';
    			dw='KWH';
    		}
    		
    	$.post("${contextPath}/monitorData/zlcharts/getzlData?zl="+buttonname+"&areaguid="+$('#selArea').val()+"&doorno="+$('#selDoorname').val()+"&sdate="+$('#input_selsdate').val()+"&edate="+$('#input_seledate').val(), function (data) {  
    		var chartdata = [];
    		var xchart=[];
    		var jsonarray = eval("("+data+")");
    		if(buttonname=='LLIANG'){
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata[i] = parseFloat(jsonarray[i].LLIANG);
    				xchart[i] = jsonarray[i].DDATE;
    			}

    		}else{
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata[i] = parseFloat(jsonarray[i].RELIANG);
    				xchart[i] =jsonarray[i].DDATE;
    			}

    		}
    		$('#zlcharts').highcharts({
    		        title: {
    		            text: title1,
    		            x: -20 //center
    		        },
    		        credits: {
    		            enabled:false
    		        },
    		        subtitle: {
    		            text: title2,
    		            x: -20
    		        },
    		        xAxis: {
    		        	tickInterval: 5,
    		            categories:xchart,
    		            labels:{
    		            	 rotation: -45   //45度倾斜
    	                   
    	                 }
    		        },
    		        yAxis: {
    		            title: {
    		                text: y
    		            },
    		            plotLines: [{
    		                value: 0,
    		                width: 1,
    		                color: '#808080'
    		            }]
    		        },
    		        tooltip: {
    		            valueSuffix: dw
    		        },
    		        legend: {
    		            layout: 'vertical',
    		            align: 'right',
    		            verticalAlign: 'middle',
    		            borderWidth: 0
    		        },
    		        series: [{
    		            name: y,
    		            data: chartdata
    		        }]
    		    }); 
    		_J_setAreaGuid($('#selArea').val(),$("#selArea").find("option:selected").text());
    		 });
			}
		});
		
		
});
</script>