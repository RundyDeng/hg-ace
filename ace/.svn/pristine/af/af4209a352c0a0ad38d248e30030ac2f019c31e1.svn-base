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
Calendar c = Calendar.getInstance();
String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
c.add(Calendar.DATE, -7);
String weekAgo = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
<div class="row">
	<div class="col-xs-12">
		<div id="downlistBar">
			<table style="width: 100%" class="table">
				<tbody>
					<tr>
						<th style="padding-left: 12px;">小区： 
							<select id="community" style="width: 180px;">
							</select>
						</th>
						
						<th style="border-bottom: 1px solid #ddd;">
							&nbsp;起止时间：
							<input style="margin-right: 20px;height: 28px; padding-top: 2px; padding-bottom: 2px;" id="input_sel_date" type="text"  value="<%=weekAgo %>" readonly="readonly">
							至
							<input style="margin-left: 20px;height: 28px; padding-top: 2px; padding-bottom: 2px;" id="input_sel_date2" type="text"  value="<%=today %>" readonly="readonly">
						</th>
						
					</tr>
					
					<tr>
						<td colspan="7" style="border-bottom: 1px solid #ddd;">
							<button type="button" value="MeterTJ" class="btn btn-info">累计流量</button>
						  	<button type="button" value="MeterNLLJ" class="btn btn-info">累计热量</button>
						</td>
					</tr>


				</tbody>
			</table>
		</div>

		<!-- 曲线图显示位置 -->
		<div id="each_charts">
		
		
		</div>
	</div>
</div>

<script type="text/javascript">

		var scripts = [
		   			null,
		   			"${contextPath}/static/assets/js/jquery-ui.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
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
				      var s = '';
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
			    	 
				}
				
			});
        	
        	
        	
        	
        	Highcharts.theme = { colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"], chart: { backgroundColor: null, style: { fontFamily: "Dosis, sans-serif" } }, title: { style: { fontSize: '16px', fontWeight: 'bold', textTransform: 'uppercase' } }, tooltip: { borderWidth: 0, backgroundColor: 'rgba(219,219,216,0.8)', shadow: false }, legend: { itemStyle: { fontWeight: 'bold', fontSize: '13px' } }, xAxis: { gridLineWidth: 1, labels: { style: { fontSize: '12px' } } }, yAxis: { minorTickInterval: 'auto', title: { style: { textTransform: 'uppercase' } }, labels: { style: { fontSize: '12px' } } }, plotOptions: { candlestick: { lineColor: '#404048' } },background2: '#F0F0EA'};Highcharts.setOptions(Highcharts.theme);
        	
        	
        	$('button').click(function(){
        		var fieldName = $(this).val();
        		
        		var chartData = '';
        		var yAxisFormatter = '';
        		var showTooltipName = '';
        		if(fieldName == 'MeterTJ'){
        			yAxisFormatter = '{value} T';
        			chartData = '日期,累计流量';
        			showTooltipName = '累计流量';
        		}else if(fieldName=='MeterNLLJ'){
        			yAxisFormatter = '{value} KWH';
        			chartData = '日期,累计热量';
        			showTooltipName = '累计热量';
        		}
        		chartData += '';
        		
        		if(fieldName==''||fieldName=='undefined')
        			return;
        		
        		var load_url = '${contextPath}/monitorData/areachartcontr/getAreaChart?filedName='+fieldName 
        				+ '&beginDate=' + $('#input_sel_date').val() + '&endDate=' + $('#input_sel_date2').val()
        				+ '&areaguid=' + $('#community').val();

        		
        		var title = $(this).html();
        		$.get(load_url, function (csv) {
        			
        			
        			chartData += csv;
        			var flagX = 0;
 				   $('#each_charts').highcharts({
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
 			                //tickInterval:  8 * 24 * 3600 * 1000, //坐标轴上的刻度线的单位间隔。   
 			                //tickInterval:  2,//隔1个再显示
 			                tickWidth: 5,  //刻度线的宽度
 			                //gridLineWidth: 0, //网格线的宽度
	                        tickColor: '#00FFFF',
	                        //type: 'datetime',
							/* min : 0,
							max : 5, */
 			                labels: {  //轴标签（显示在刻度上的数值或者分类名称）
 			                	//step:2,
 			                    align: 'center',  //轴标签的水平对其方式，可取的值："left", "center" or "right".默认是居中显示
 			                    x: 3, //轴标签相对于轴刻度在水平方向上的偏移量
 			                    y: 20,  //轴标签相对于轴刻度在y轴方向上的偏移量，默认根据轴标签字体大小给予适当的值
 			                    formatter: function () {
 			                    	//暂时这样解决
 			                    	var sb = typeof this.value == 'string'?this.value.split(" ")[0]:Highcharts.dateFormat('%Y-%m-%d', this.value);
 			                    	if(sb != flagX){
 			                    		return sb;	
 			                    	}
                              	}
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
 			                	var dateFix =  typeof this.points[0].key == 'string'?this.points[0].key.split(" ")[0]:Highcharts.dateFormat('%Y-%m-%d', this.points[0].key);
 			                	return '日期：'+ dateFix +'<br/> ' + showTooltipName + '：'+this.y.toFixed(2);
 			                 } 
 			            },
 			           //数据点配置
						            plotOptions: {
						                series: {
						                    cursor: 'pointer',
						                    point: {
						                        events: {
						                            click: function (e) {
						                                hs.htmlExpand(null, {
						                                    pageOrigin: {
						                                        x: e.pageX || e.clientX,
						                                        y: e.pageY || e.clientY
						                                    },
						                                    headingText: this.series.name,
						                                    maincontentText: '日期：'+ Highcharts.dateFormat('%Y-%m-%d', this.x)
						     			                	+ '<br/>时间：' + Highcharts.dateFormat('%H:%M:%S', this.x)
						     			                	+'<br/> ' + showTooltipName + '：'+this.y.toFixed(2),
						                                    width: 200
						                                });
						                            }
						                        }
						                    },
						                    marker: {
						                        lineWidth: 1
						                    }
						                }
						            },
 			            series: [{ 
 			            	type: 'area', 
 			            	//pointInterval: 24 * 3600 * 1000, 
 			            	}]
 			        });
 			    });
        	})
        	
        	
        });
</script>
