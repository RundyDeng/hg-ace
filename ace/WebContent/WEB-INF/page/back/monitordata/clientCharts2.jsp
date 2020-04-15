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
	.table > tbody > tr > td{
		padding: 12px;
		padding-left: 0px; padding-right: 0px;
	}
	.btn{
		border: 1px solid #FFF;
	}
</style>	
	
	
	
	
<%
String today = "";
String weekAgo = "";
String attrDate= (String)request.getAttribute("date");
if(attrDate!=""){
 	Calendar cal = new GregorianCalendar();
 	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
 	Date parseDate = df.parse(attrDate);
 	cal.setTime(parseDate);
 	cal.add(Calendar.DATE, -7);
 	today = attrDate;
 	weekAgo =  new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
// 	today = attrDate;
// 	weekAgo = attrDate;
}else{
	Calendar c = Calendar.getInstance();
	today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	weekAgo = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
}

%>
<div class="row">
	<div class="col-xs-12">
		<div id="downlistBar">
			<table style="width: 100%" class="table">
				<tbody>
					<tr>
						<td>小区： 
							<select id="community" onchange="building(this)">
							</select>
						</td>
						<td>楼宇： 
							<select id="build" onchange="uniting(this)">
							</select>
						</td>
						<td>单元： 
							<select id="unit" onchange="flooring(this)">
							</select>
						</td>
						<td>楼层： 
							<select id="floor" onchange="dooring(this)">
							</select>
						</td>
						<td>门牌：
							<select id="door" onchange="oldInfo(this)">
							</select>
						</td>
						<td>
							<!-- 按用户： --><input hidden id="client" style="width: 90px; height: 28px; " value="${clientno}">
							<input hidden id="meterid" value="${meterid}" />
						</td>
						<td style="border-bottom: 1px solid #ddd;">
							起止时间：
							<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_sel_date" type="text"  value="<%=weekAgo %>" readonly="readonly">
						</td>
						<td>
							至
							<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_sel_date2" type="text"  value="<%=today %>" readonly="readonly">
						</td>
						
					</tr>
					
					<tr>
						<td colspan="8" style="border-bottom: 1px solid #ddd;">
		                     <button type="button" class="btn btn-success" value="MeterTJNLLJ" >累计流/热量</button>
		                     <button type="button" class="btn btn-success" value="MeterLSGL" >瞬时流/热量</button>
		                     <button type="button" class="btn btn-success" value="TEMP" >温 度</button>  
			                  
							
							<!-- <button type="button" value="MeterLS" class="btn btn-info">瞬时流量</button>
						  	<button type="button" value="MeterGL" class="btn btn-info">瞬时热量</button>
						 	<button type="button" value="MeterJSWD" class="btn btn-info">进水温度</button>
						 	<button type="button" value="MeterHSWD" class="btn btn-info">回水温度</button>
						 	<button type="button" value="MeterWC" class="btn btn-info">温    差</button> -->
						</td>
					</tr>


				</tbody>
			</table>
		</div>

		<!-- 曲线图显示位置 -->
		<div id="each_charts">
		<div id="hight_charts">
		
		</div>
	</div>
</div>
<script
		src="${contextPath}/static/assets/js/jquery-ui.js"></script>
<script type="text/javascript">
		var _areaguid,_buildno,_unitno,_floorno,_doorno;
		
		var building = function(obj){
			
			_areaguid = obj.value;
			if(_areaguid==''||_areaguid=='null')
				return
			$.get('${contextPath}/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
				
				var response = jQuery.parseJSON(data);
				
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['BUILDCODE'] + '">' + ri['BUILDNAME'] + '</option>';
			          }
			       }
			    var sel = $('#build');
			    
			    emptyAndReset(sel);	        	        					    
     		    emptyAndReset($('#unit'));
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door')); 
			    sel.append(s);  
			});
		};

		var uniting = function(obj){
			
			_buildno = obj.value;
			if(_buildno=='')
				return;
			$.get('${contextPath}/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
					+"&BUILDCODE="+_buildno, function(data){
				
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['UCODE'] + '">' + ri['UCODE'] + '单元</option>';
			          }
			       }
			    var sel =  $("#unit");
			    emptyAndReset(sel);
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});
		};
		
		var flooring = function(obj){
			
			_unitno = obj.value;
			if(_unitno=='')
				return;
			$.get('${contextPath}/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
					+"&BUILDCODE="+_buildno+"&UCODE="+_unitno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['FLOORNO'] + '">' + ri['FLOORNO'] + '层</option>';
			          }
			       }
			    var sel =  $('#floor');
			   
			    emptyAndReset(sel);
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});    	
		};
		
		var dooring = function(obj){
			_floorno = obj.value;
			if(_floorno=='')
				return;
			$.get('${contextPath}/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
					+"&BUILDCODE="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno, function(data){
				
				var response = jQuery.parseJSON(data);
				
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           
			           s += '<option value="' + ri['DOORNO'] + '">' + ri['FCODE'] + '</option>';
			          }
			       }
			      
			    var sel =  $('#door');
			    emptyAndReset(sel);	      
			    sel.append(s);  
			});
		};

		var oldInfo = function(obj){
			_doorno = obj.value;//门牌
			if(_doorno=='')
				return;
			$('#meterid').append('METERID');
			$('#client').val(CLIENTNO);
			
			/* $.get('${contextPath}/sys/todaydata/getRemainInfo?AREAGUID='+_areaguid
					+"&BUILDCODE="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno+"&doorno="+_doorno,
				function(){}
			) */
		};

 		function emptyAndReset(e){
 			e.empty();
			e.append("<option value=''>请选择</option>").attr("selected",true).change();
		}

		
		var scripts = [
		   			null,
		   			"${contextPath}/static/assets/js/jquery-ui.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",
		   			null ];
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	$("#input_sel_date").datepicker('destroy');
			$("#input_sel_date").datepicker({
		    		dateFormat: 'yy-mm-dd',
	    	});
				$("#input_sel_date2").datepicker({
		    		dateFormat: 'yy-mm-dd',
	    	});
				
			$.ajax({
				url : '${contextPath}/sys/todaydata/getAreaDownList',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					var response = data;
				      var s = '<option value="">请选择</option>';
				      if (response && response.length) {
				          for (var i = 0, l = response.length; i < l; i++) {
				           var ri = response[i];
				           
				           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
				          }
				       }
				      
				     $('#community').append(s);
				     var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
				     if(areaguid=='null'||areaguid=='')
						return;
				     $('#community option[value="'+areaguid+'"]').attr('selected',true);
				     
				     var obj = [];
				     obj.value=areaguid;
				     building(obj);
				}
				
			});
			
			
        });
        
        
    	$('button').click(function(){
			
			var fieldName = $(this).val();
			var y1='';
			var y2='';
			var y3=''; 
			var dw='';
			var title =$(this).html();
			var title1='';
			Highcharts.setOptions({ colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'] });
			/*  if($('#client').val()!=''){
    			load_url += '&clientno=' + $('#client').val();
    		}else if(_areaguid=='' ||_buildno==''||_unitno==''||_floorno==''||_doorno=='' ){
				alert("请选择门牌或者输入用户编号！")
				return;
			}else{
				load_url += '&areaguid=' + _areaguid
						+ '&buildno=' + _buildno
						+ '&unitno=' + _unitno
						+ '&floorno=' + _floorno
						+ '&doorno=' + _doorno;
			}  */
			
			$.post('${contextPath}/monitorData/clientChartsContr2/getClientChartsByFiled?filedName='+fieldName 
				+ '&beginDate=' + $('#input_sel_date').val() + '&endDate=' + $('#input_sel_date2').val()
				+ '&meterid='+ '16024940', function (data) { 
					
		
				var chartdata1 = [];
	    		var chartdata2 = [];
	    		var chartdata3 = [];
	    		var xchart=[];
	    		var jsonarray = eval("("+data+")");
    			
    		/* if(fieldName=='' || fieldName!='undefined')
				return;*/
			if( jsonarray==''||jsonarray==null){
    			alert("起始结束时间数据为空，请重新选择条件查询！");
    		}else{
    			
    		 if(fieldName=='MeterTJNLLJ'){
    			y1='累计热量(kwh)';
    			y2='累计流量(t)';
    			title1=$("#input_sel_date").val()+'至'+$("#input_sel_date2").val()+title+'曲线';
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata1[i] = parseFloat(jsonarray[i].METERNLLJ);
    				chartdata2[i] = parseFloat(jsonarray[i].METERTJ); 
    				xchart[i] =jsonarray[i].DDATE;
    			}	
    			
    		}else if(fieldName=='MeterLSGL'){
    			y1='瞬时流量(t/h)';
    			y2='瞬时热量(KW)';
    			title1=$("#input_sel_date").val()+'至'+$("#input_sel_date2").val()+title+'曲线';
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata1[i] = parseFloat(jsonarray[i].METERLS);
    				chartdata2[i] = parseFloat(jsonarray[i].METERGL);
    				xchart[i] = jsonarray[i].DDATE;
    			}
    			
    		}else if(fieldName=='TEMP'){
    			y1='进水温度(℃)';
    			y2='回水温度(℃)';
    			y3='温差(℃)';
    			title1=$("#input_sel_date").val()+'至'+$("#input_sel_date2").val()+title+'曲线';
    			dw='℃';
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata1[i] = parseFloat(jsonarray[i].METERJSWD); 
    				chartdata2[i] = parseFloat(jsonarray[i].METERHSWD); 
    				chartdata3[i] = parseFloat(jsonarray[i].METERWC);
    				xchart[i] =jsonarray[i].DDATE;
    			}
    		}	
	               
	     if(fieldName=='MeterTJNLLJ'){
	    		 $('#each_charts').highcharts({
	    			 
	    			 chart: {
	    				 marginRight: 80,
						  backgroundColor: {
				                linearGradient: [0, 0, 500, 500],
				                stops: [
				                    [0, 'rgb(225, 205, 205)'],
				                    [1, 'rgb(200, 190, 255)']
				                ]
				            },
				            type: 'spline'
				        },
	    			  title: {
	    		            text: title1,
	    		            x: -20 //center
	    		        },
	    		        credits: {
	    		            enabled:false
	    		        },
	    		       
	    		        xAxis: {
	    		        	tickInterval: 2,
	    		            categories:xchart,
	    		            labels:{
	    		            	 rotation: -45   //45度倾斜
	    	                 }
	    		        },
	    		        yAxis: {
	    		            title: {
	    		                text: y1+'/'+y2
	    		            },
	    		            labels: {
	    	                    align: 'left',
	    	                    x: 3,
	    	                    y: 16,
	    	                    format: '{value:.,0f}'
	    	                },
	    		        },
	    		        
	    		        tooltip: {
	    		            valueSuffix: dw,
	    		            shared: true
	    		        },
	    		        legend: {
	    		        	align: 'left',
	    	                verticalAlign: 'top',
	    	                y: 20,
	    	                floating: true,
	    	                borderWidth: 0
	    	            },
	    		        series: [{
	    		            name: y1,
	    		            data: chartdata1
	    		        },{ name:y2,
	    		        	data: chartdata2
	    		        
	    		        }]
	    		    }); 
	     }else if( fieldName=='MeterLSGL'){  
			 $('#each_charts').highcharts({
				 
				 chart: {
					  backgroundColor: {
			                linearGradient: [0, 0, 500, 500],
			                stops: [
			                    [0, 'rgb(225, 205, 255)'],
			                    [1, 'rgb(200, 200, 255)']
			                ]
			            },
			            type: 'spline'
			        },
				
    		        title: {
    		            text: title1,
    		            x: -20 //center
    		        },
    		        credits: {
    		            enabled:false
    		        },
    		       
    		        xAxis: {
    		        	tickInterval: 2,
    		            categories:xchart,
    		            labels:{
    		            	 rotation: -45   //45度倾斜
    	                 }
    		        },
    		        yAxis: {
    		            title: {
    		                text: y1+'/'+y2
    		            },
    		            labels: {
    	                    align: 'left',
    	                    x: 3,
    	                    y: 16,
    	                    format: '{value:.,0f}'
    	                },
    		        },
    		     
    		        tooltip: {
    		            valueSuffix: dw,
    		            shared: true
    		        },
    		        legend: {
    		        	align: 'left',
    	                verticalAlign: 'top',
    	                y: 20,
    	                floating: true,
    	                borderWidth: 0
    	            },
    		        series: [{
    		            name: y1,
    		            data: chartdata1
    		        },{ name:y2,
    		        	data: chartdata2
    		        
    		        }]
    		    }); 
			 
	     		}else {  
	    			 $('#each_charts').highcharts({
	    				 
	    				 chart: {
							  backgroundColor: {
					                linearGradient: [0, 0, 500, 500],
					                stops: [
					                    [0, 'rgb(255, 255, 255)'],
					                    [1, 'rgb(200, 200, 255)']
					                ]
					            },
					            type: 'spline'
					        },
	    				
    	    		        title: {
    	    		            text: title1,
    	    		            x: -20 //center
    	    		        },
    	    		        credits: {
    	    		            enabled:false
    	    		        },
    	    		       
    	    		        xAxis: {
    	    		        	tickInterval: 2,
    	    		            categories:xchart,
    	    		            labels:{
    	    		            	 rotation: -45   //45度倾斜
    	    	                 }
    	    		        },
    	    		        yAxis: {
    	    		            title: {
    	    		                text: y1+'/'+y2+'/'+y3
    	    		            },
    	    		            labels: {
    	    	                    align: 'left',
    	    	                    x: 3,
    	    	                    y: 16,
    	    	                    format: '{value:.,0f}'
    	    	                },
    	    		        },
    	    		     
    	    		        tooltip: {
    	    		            valueSuffix: dw,
    	    		            shared: true
    	    		        },
    	    		        legend: {
    	    		        	align: 'left',
    	    	                verticalAlign: 'top',
    	    	                y: 20,
    	    	                floating: true,
    	    	                borderWidth: 0
    	    	            },
    	    		        series: [{
    	    		            name: y1,
    	    		            data: chartdata1
    	    		        },{ name:y2,
    	    		        	data: chartdata2
    	    		        
    	    		        },{ name:y3,
    	    		        	data: chartdata3,
    	    		        
    	    		        }]
    	    		    }); 
	    			 
	    		 }; //曲线
	    		};//if
		});  //post
		
	});//click
        
        
</script>

 
 