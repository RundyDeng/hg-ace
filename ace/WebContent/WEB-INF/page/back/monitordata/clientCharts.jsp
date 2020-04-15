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
							<button type="button" value="MeterLS" class="btn btn-info">瞬时流量</button>
						  	<button type="button" value="MeterGL" class="btn btn-info">瞬时热量</button>
						 	<button type="button" value="MeterJSWD" class="btn btn-info">进水温度</button>
						 	<button type="button" value="MeterHSWD" class="btn btn-info">回水温度</button>
						 	<button type="button" value="MeterWC" class="btn btn-info">温    差</button>
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
        	
        //	$('button').click(); 
        	
        	
        //	Highcharts.theme = { colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"], chart: { backgroundColor: null, style: { fontFamily: "Dosis, sans-serif" } }, title: { style: { fontSize: '16px', fontWeight: 'bold', textTransform: 'uppercase' } }, tooltip: { borderWidth: 0, backgroundColor: 'rgba(219,219,216,0.8)', shadow: false }, legend: { itemStyle: { fontWeight: 'bold', fontSize: '13px' } }, xAxis: { gridLineWidth: 1, labels: { style: { fontSize: '12px' } } }, yAxis: { minorTickInterval: 'auto', title: { style: { textTransform: 'uppercase' } }, labels: { style: { fontSize: '12px' } } }, plotOptions: { candlestick: { lineColor: '#404048' } },background2: '#F0F0EA'};Highcharts.setOptions(Highcharts.theme);
        });
        
        $('button').click(function(){
    		var fieldName = $(this).val();
    		
    		var chartData = '';
    		var yAxisFormatter = '';
    		var showTooltipName = '';
    		if(fieldName == 'MeterLS'){
    			yAxisFormatter = '{value} t/h';
    			chartData = '日期,瞬时流量';
    			showTooltipName = '瞬时流量';
    		}else if(fieldName=='MeterGL'){
    			yAxisFormatter = '{value} kw';
    			chartData = '日期,瞬时热量';
    			showTooltipName = '瞬时热量';
    		}else{
    			yAxisFormatter = '{value} ℃';
    			chartData = '日期,温度';
    			showTooltipName = '温度';
    		}
    		chartData += '\n';
    		
    		Highcharts.setOptions({ colors: [ '#058DC7', '#50B432', '#ED561B',  '#DDDF00', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4' ] });
    		
    		if(fieldName==''||fieldName=='undefined')
    			return;
    		var load_url = '${contextPath}/monitorData/clientChartsContr/getClientChartsByFiledName?filedName='+fieldName 
    				+ '&beginDate=' + $('#input_sel_date').val() + '&endDate=' + $('#input_sel_date2').val(); // + '&meterid='+$('#meterid').val();

    		if($('#client').val()!=''){
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
			}
    		
    		var title = $(this).html();
    		
			
    		$.get(load_url, function (csv) {
    			chartData += csv;
    			
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
					  yAxis: [{ // left y axis
		                title: {
		                    text: null//轴标题的显示文本。它可以包含类似的，基本的HTML标签。但是文本的旋转使用向量绘制技术实现,有些文本样式会清除。通过设置text为null来禁用轴标题
		                },
		                //gridLineWidth:0,
		                labels: {
		                    align: 'left',
		                    x: -10,
		                    y: 16,
		                    format: yAxisFormatter
		                },
		                showFirstLabel: false
		            }],
		            
			            data: {
			                csv: chartData
			            },
			            credits: {
			                enabled:false//关闭作者
			      		},
			      		exporting: {
			                enabled:false//关闭导出按钮
			    		},
			            //主标题
			            title: {
			                text: title
			            },
			            /* //副标题
			            subtitle: {
			                text: 'Source: Google Analytics'
			            }, */
			            
			            //x轴
			             xAxis: {
			              //  tickInterval:  8 * 3600 * 1000, //坐标轴上的刻度线的单位间隔。   
			                tickWidth: 10,  //刻度线的宽度
			              //  gridLineWidth: 0, //网格线的宽度
                        tickColor: '#00FFFF',
                        type: 'datetime',

			                labels: {  //轴标签（显示在刻度上的数值或者分类名称）
			                    rotation: -45,   //45度倾斜
			                    align: 'center',  //轴标签的水平对其方式，可取的值："left", "center" or "right".默认是居中显示
			                    x: 3, //轴标签相对于轴刻度在水平方向上的偏移量
			                    y: 20,  //轴标签相对于轴刻度在y轴方向上的偏移量，默认根据轴标签字体大小给予适当的值
			                    formatter: function () {  
                              return Highcharts.dateFormat('%Y-%m-%d', this.value);
                              		//+'<br/>'+Highcharts.dateFormat('%H:%M:%S', this.value);  
                          	},
			                }
			            },
			            //图例
			            legend: {
			                align: 'left',
			                verticalAlign: 'top',
			                y: 20,
			                floating: true,
			                borderWidth: 0
			            },
			            //数据提示框
			            tooltip: {
			                shared: true,
			                crosshairs: true,
			                formatter:function(){
			                	return '日期：'+ Highcharts.dateFormat('%Y-%m-%d', this.x)
			                	+ '<br/>时间：' + Highcharts.dateFormat('%H:%M:%S', this.x)
			                	+'<br/> ' + showTooltipName + '：'+this.y;
			                 }
			            },
			           plotOptions: { area: { fillColor: { linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1}, 
			        	   stops: [ [0, Highcharts.getOptions().colors[0]], 
			        	            [1, Highcharts.Color(Highcharts.getOptions().colors[0]).
			        	             setOpacity(0).get('rgba')] ] }, lineWidth: 0.05,
			        	             marker: { enabled: false }, shadow: false, 
			        	             states: { hover: { lineWidth: 0.05 } }, 
			        	             threshold: null } }, 
			            series: [{ 
			            	//type: 'area', 
			            	pointInterval: 24 * 3600 * 1000,
			            	}]
			        });
			    });
    	})
    	
    	if('${btn}'!=''){
			$('#client').change(function(){$('#meterid').val('');})
    		$('#downlistBar button[value="${btn}"]').click();  
    	}
</script>

 
 