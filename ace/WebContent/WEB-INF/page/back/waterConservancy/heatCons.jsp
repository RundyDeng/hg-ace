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
		border: 1px solid #CCC; 
                       
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
						<td>平均流量：<input type="text" id="pjll" style="width: 50px; height: 28px;" value="30">  (T/万㎡.H) 							
						</td>
						<td>平均热量： <input type="text" id="pjrl" style="width: 50px; height: 28px;" value="30">  (W/㎡)							
						</td>
						<td>热力站分析： 
							<input id="rdoRlz" type="radio" name="banlance" value="3" />
						</td>
						<td>小区分析： 
							 <input id="rdoArea" type="radio" name="banlance" checked="checked" value="0" />
						</td>
						<td>楼栋高区：
							<input id="rdoBuild" type="radio" name="banlance" value="1" />
						</td>
						<td>
							楼栋低区：<input id="Radio1" type="radio" name="banlance" value="4" />							
						</td>
						<td >
							单元分析：
							<input id="rdoUnit" type="radio" name="banlance" value="2" />
						</td>	
					</tr>
					
					<tr>
						<td>小区： 
							<select id="community" onchange="building(this)">
							</select>
						</td>
						<td>楼宇： 
							<select id="build" onchange="uniting(this)">
							</select>
						</td>
						<td>图标类型： 
							<select id="sctype">
                                <option value='0'>柱状</option>
                                <option value='1'>曲线</option>                                            
                            </select>
						</td>
						<td>批次： 
							<select id="pc">
                                <option value='1'>第一批</option>
                                <option value='2'>第二批</option>
                            </select>
						</td>
												
						<td colspan="3" style="border-bottom: 1px solid #ddd;">
							日期：
							<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_sel_date" type="text"  value="<%=today %>" readonly="readonly">
						</td>						
					</tr>					
					<tr>
						<td colspan="7" style="border-bottom: 1px solid #ddd;">
							<button type="button" value="RL" class="btn btn-info" id="heat_btn">热量分析</button>
					  		<button type="button" value="excel" class="btn btn-info" id="excel_btn">导出EXCEL</button>
						 	<button type="button" value="home" class="btn btn-info" onclick ="javascript:history.go();">返回首页</button>	 <!--   "location.href='homepage.js'"-->
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 图显示div -->
		<div id="each_charts">
		</div>
			<!--  <img src="../../../../ace/static/image/rl.png"> 
		</div>   -->
	
		<!-- 表格div -->
		<div id="da-search"></div>  <!--@  -->
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
		
	</div>
</div>

<div id="container" style="height: 600px; min-width: 100px"></div>
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/highstock.js"></script>


<script type="text/javascript">
		
		var _areaguid,_buildno;/* _unitno,_floorno,_doorno; */
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
     		  /*emptyAndReset($('#unit'));
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door'));   */
			    sel.append(s);  
			});
		};
		  
		
		/* Ajax获取楼宇信息   */	
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
			  /*   var sel =  $("#unit");
			    emptyAndReset(sel);
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door')); */
			    sel.append(s);  
			});
		};
		
 
 		
	/* highchart图表数据显示 */	
		var scripts = [
		   			null,
		   			"${contextPath}/static/assets/js/jquery-ui.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
		   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
		   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",
		   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts-plugins/highcharts-zh.js",
		   			null ];
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	
				
			 <%-- 获取小区楼宇数据  --%>
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
			    	/*@  */ 
				     var obj = [];
				     obj.value=areaguid;
				     building(obj);
				}
			}); 
			 
			 /* 日期选择显示 */
        	 $("#input_sel_date").datepicker('destroy');
			$("#input_sel_date").datepicker({
		    		dateFormat: 'yy-mm-dd',
	    	});
				$("#input_sel_date2").datepicker({
		    		dateFormat: 'yy-mm-dd',
	    	}); 
        	
        	
        	/*highcharts图 形设置 */
        	Highcharts.theme = { colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
        			chart: { backgroundColor: null, style: { fontFamily: "Dosis, sans-serif" } }, 
        			title: { style: { fontSize: '16px', fontWeight: 'bold', textTransform: 'uppercase' } }, 
        			tooltip: { borderWidth: 0, backgroundColor: 'rgba(219,219,216,0.8)', shadow: false }, 
        			legend: { itemStyle: { fontWeight: 'bold', fontSize: '13px' } }, 
        			xAxis: { gridLineWidth: 1, labels: { style: { fontSize: '12px' } } }, 
        			yAxis: { minorTickInterval: 'auto', title: { style: { textTransform: 'uppercase' } }, 
        			labels: { style: { fontSize: '12px' } } }, plotOptions: { candlestick: { lineColor: '#404048' } },
        			background2: '#F0F0EA',
        			lang: {printChart: "打印图形",downloadJPEG: "下载JPEG文件",downloadPDF: "下载PDF文件",downloadPNG: "下载PNG文件",downloadSVG: "下载SVG文件"}
        			};Highcharts.setOptions(Highcharts.theme);
        	
				$('#grid-table').hide();
       	 $('#heat_btn').click(function(){// #heat_btn
				$('#grid-table').show();
       	 
	//	function InitLine(a, b, c){	
		  $('#each_charts').highcharts({
		        chart: {
		        //	type: 'column',//图形为柱状
		            renderTo: 'container'//指向的div的id属性
		        },
		        exporting: {  
		            enabled: false //是否能导出趋势图图片
		        }, 
		        title : {
		                text : '热量数据分析图'//图表标题
		            },
		        xAxis: {
		            tickPixelInterval:10,//x轴上的间隔
		            categories: ['御滨园','北都丽园','北都丽园', '御锦源一期','御锦源一期','向阳嘉苑','向阳嘉苑','太阳城一期','五金机电城', 
		            	           '华北星城一期','华北星城一期', '绿洲西城3区', '绿洲西城3区', '恒圆魏都', '绿洲西城3区','格兰云天','铁路沟西',
		            	           '铁路沟西',  '铁路沟西', '铁路沟西',  '铁路沟西','铁路沟西', '铁路沟西',  '铁路沟西', '铁路沟西', '铁路沟西',
		            	           '铁路沟西',  '铁路沟西',  '铁路沟西',  '铁路沟西', '铁路沟西','铁路沟西', '铁路沟西',  '铁路沟西', '铁路沟西', '铁路沟西', '铁路沟西', '铁路沟西', '铁路沟西'],
		     
       	       //   categories: a
		      
         /*    type: 'category', //定义x轴上日期的显示格式datetime
            labels: {
            formatter: function() {
                return date.value; 
            },
            align: 'center'
      	  } */
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        yAxis : {  
                   
              title: {  
                  text: 'HeatNum(T/H)'  //y轴上的标题
              }  
         },  
        tooltip: {
           // xDateFormat: '%Y-%m-%d, %A'//鼠标移动到趋势线上时显示的日期格式
        	shared: true,
            useHTML: true,
            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y} (t/h)</b></td></tr></tbody></table>',
        }, 
      /*   rangeSelector: {
            buttons: [//定义一组buttons,下标从0开始
         ],
            selected: 1//表示以上定义button的index,从0开始
        }, */
       
        series: [{
                type: 'column',
                name: '实际单位热量',
                data: [18,94,17,116,24,53.5,22.8,3.5,0,0,0,19.3,11.6,0,19.3,193.5,101.9,70.61,50.1,63.9,14.9,81.2,60.1,30.3,2,63.9,14.9,81.2,60.1,30.3,2,29.6,54,66.2,44.2,26.29,39.2,32.2,77.6],          
            //   data: b 	
        	},{
                type: 'spline',
                name: '平均值热量',
                data: [18,94,17,116,24,53.5,22.8,3.5,0,0,0,19.3,11.6,0,19.3,193.5,101.9,70.61,50.1,63.9,14.9,81.2,60.1,30.3,2,63.9,14.9,81.2,60.1,30.3,2,29.6,54,66.2,44.2,26.29,39.2,32.2,77.6],
                     //  data: c
        	}, 
	        ]
	   	 });
			 // }
			

		 /* 	function handleAreaColumn(productData){
			var clstr = new Array();
            var serstr = new Array();
            var slstr = [];
            var ydata = new Array();
            var ydata2 = new Array();

            var sum = 0;
            $.each(productData, function (i) {
            });
            $.each(productData, function (i) {
                clstr[i] = productData[i].小区名;
                serstr[i] = Number(productData[i].实际单位热量);
                ydata2[i] = Number(productData[i].平均值热量);

                var item = [];
                item.push(productData[i].小区名);
                slstr.push(item);

            });
            
            InitLine(clstr, serstr, ydata2);
		} 
		
		$.get('${contextPath}/waterConservancy/heatConsContr/getHeatConsChart',function(response){
	            var productData = jQuery.parseJSON(response);
	            newestAreaData = productData;
	            newspaper_showTable(productData);
	            productData = productData.slice(0,20);
	            newestAreaDataLte = productData;
	            handleAreaColumn(productData);
	        });
		 */
		//
		
		});
       	 
	});
     
           
        var scripts = [ null,"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"
		                ,"${contextPath}/static/assets/js/jquery-ui.js", null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	jQuery(function($) {
        		var da_search = "#da-search";   
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";
        		$(window).on('resize.jqGrid', function(){
        			$(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
        		})

        		var parent_column = $(grid_selector).closest('[class*="col-"]');
        		$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
        			if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
        				setTimeout(function() {
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		})
        		var _areaguid,_buildno;/* _unitno,_floorno; */
        		
        		
        	
        		
        		/* table搜索 */
        	<%-- 	var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "<%=AREAGUID%>" } , //小区
									 { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									 { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									 { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									 { "field": "DOORNO", "op": "eq", "data": "" } , //门牌
									 { "field": "DDATE", "op": "ge", "data": "<%=weekAgo%>"},
									 { "field": "DDATE", "op": "le", "data": "<%=today%>"}
        				         ] 
        		};
        		
        	    function roundFix(cellvalue){
        			if(cellvalue==''||cellvalue==undefined||cellvalue==0)
        				return 0;
        			return cellvalue.toFixed(2);
        	    }
        		var roundNum = function(cellvalue, options, rowObject){
        			if(cellvalue==0)
        				return 0;
					return cellvalue.toFixed(2);
				}
        		function getSelectElement(val){
        			if(val!=='undefined')
        				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
        		}
        		function emptyAndReset(e){
        			e.empty();
        			e.append("<option value=''>请选择</option>").attr("selected",true).change();
        		}
        		
        		 --%>
        		 
        		 var roundNum = function(cellvalue, options, rowObject){
         			if(cellvalue==0)
         				return 0;
 					return cellvalue.toFixed(2);
 				}
        		
				var flag = true;
				var initData = {};/* @ */
				if('<%=(String)request.getParameter("areaguid") %>'!='null'&&'<%=(String)request.getParameter("buildno") %>'!='null'){
					initData = {
						filters : "{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"AREAGUID\",\"op\":\"eq\",\"data\":\"\"},{\"field\":\"BUILDNO\",\"op\":\"eq\",\"data\":\"<%=(String)request.getParameter("buildno") %>\"},{\"field\":\"DDATE\",\"op\":\"ge\",\"data\":\"<%=(String)request.getParameter("bdate") %>\"},{\"field\":\"DDATE\",\"op\":\"le\",\"data\":\"<%=(String)request.getParameter("edate") %>\"}]}"
					}
				}
				 
				var firstGrid = jQuery(grid_selector).jqGrid({
        			subGrid : false,
        		 	url : "${contextPath}/waterConservancy/heatConsContr/getheatConsContr",  
        			datatype : "json",
        			postData:initData,
        			height : 450,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['序号','小区编号','小区名称','楼宇','单元','分析名', '累计流量',
        			            '累计热量（t）', '总建筑面积(㎡)','采样户数','分析类','数字日期',
        			            '日期', '实际流量(T/H)','总用户','采暖建筑面积','采暖形式','抄表数'],
        			colModel : [{
	        			            hidden:true,
	       			            	label:'小区名',
	       			            	name:'AREAGUID',
	       			            	search:true,
	       			            	stype:'select',
	       			            	searchoptions : {
	       			            		searchhidden:true,
       			            		 	sopt : ['eq'],
       			            		 	dataUrl:'${contextPath}/sys/todaydata/getAreaDownList',
	       			            		dataEvents:[{
			            		             type:'change',
			            		             fn:function(e){
			            		    			_areaguid = $(e.target).val();
			            		    				
			            		    			$.get('${contextPath}/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
			            		    				
			            		    				var response = jQuery.parseJSON(data);
			            		    				var s = ' ';
		        	        					      if (response && response.length) {
		        	        					          for (var i = 0, l = response.length; i < l; i++) {
		        	        					           var ri = response[i];
		        	        					           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
		        	        					          }
		        	        					       }
		        	        					    var sel = getSelectElement("BUILDNO");
		        	        					    emptyAndReset(sel);	        	        					    
		        	        					    emptyAndReset(getSelectElement("UNITNO"));
		        	        					    emptyAndReset(getSelectElement("FLOORNO"));
		        	        					    emptyAndReset(getSelectElement("DOORNO"));
		        	        					    sel.append(s);  
			            		    			});
			            		    				 
			            		             }
			            			 	}],
	    			         			buildSelect:function(data){
	    			         				var areaguid = '<%=(String) request.getSession().getAttribute("areaGuids")%>'
        	        						var response = jQuery.parseJSON(data);
        	        					      var s = '<option value="">请选择</option>';
        	        					      if (response && response.length) {
        	        					          for (var i = 0, l = response.length; i < l; i++) {
        	        					           var ri = response[i];
        	        					           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
        	        					          }
        	        					       }
        	        					      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);</sc"+"ript>";
        	        					      var sel = getSelectElement("AREAGUID");
        	        					      sel.empty().append(s);
        	        					      getSelectElement("DOORNO").parent('td').parent('tr').css('border-bottom','2px solid rgb(187, 194, 198)');
        	        				     }
	       			            	}
        			            },{
                                    name : 'AREAGUID',
                                    index : 'AREAGUID',
                                    label :'小区编号',  
                                    sortable : false,
                                    width : 100,
                                    search : false
                                },
        			            {
                                    name : 'AREANAME',
                                    index : 'AREANAME',
                                    label :'小区名称',  
                                    sortable : false,
                                    width : 100,
                                    search : true
                                },
        			            {
                                	name : 'BUILDNO',
                                    index : 'BUILDNO',
                                    label :'楼宇',  
                                    sortable : false,
                                    width : 70,
                                    search : true
       			            	},
       			            	{
       			            		name : 'UNITNO',
                                    index : 'UNITNO',
                                    label :'单元',  
                                    sortable : false,
                                    width : 70,
                                    search : false
       			             	},          
       			            	{
       			             	name : 'ANALYSISNAME',
                                index : 'ANALYSISNAME',
                                label :'分析名',  
                                sortable : false,
                                width : 80,
                                search : false
      			             	}, {
        	        				name : 'SUMFLOW',
                                    index : 'SUMFLOW',
                                    label :'累计流量',  
                                    sortable : false,
                                    width : 100,
                                    search : false
			        			},{
                                    name : 'SUMHEAT',
                                    index : 'SUMHEAT',
                                    label :'累计热量（t）',
                                    sortable : false,
                                    width : 120,
                                    search : false
                                },{
                                	name : 'SUMAREA',
                                    index : 'SUMAREA',
                                    label :'总建筑面积(㎡)',
                                    sortable : false,
                                    width : 120,
                                    search : false
        	        			}, {
        	        				name : 'SUMUSER',
                                    index : 'SUMUSER',
                                    label :'采样户数',
                                    sortable : false,
                                    width : 100,
                                    search : false
        	        			},{
        	        				name : 'ANALYSISTYPE',
                                    index : 'ANALYSISTYPE',
                                    label :'分析类',
                                    sortable : false,
                                    width : 80,
                                    formatter: function(cellValue, options, rowObject) {  
                                    	if(cellValue==0){
                                    		return analysistype?'分析类';
                                    	}
                                        return cellValue;  
                                    }//jqgrid自定义格式化 
        	        				/* searchoptions : {
	       			            		dataEvents:[{
			            		             type:'change',
			            		             fn:function(e){
			            		            	 ANALYSISTYPE = $(e.target).val();		            		    			
			            		    			if(ANALYSISTYPE=='')
			            		    				{
			        	        					    emptyAndReset(getSelectElement("DOORNO"));
			        	        					    return;
			            		    				}	
			            		    			$.get('${contextPath}/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
			            		    					+"&BUILDNO="+_buildno+"&UNITNO="+_unitno+"&FLOORNO="+_floorno, function(data){
			            		    				var response = jQuery.parseJSON(data);
			            		    				var s = ' ';
		        	        					      if (response && response.length) {
		        	        					          for (var i = 0, l = response.length; i < l; i++) {
		        	        					           var ri = response[i];
		        	        					           s += '<option value="' + ri['DOORNO'] + '">' + ri['FCODE'] + '</option>';
		        	        					          }
		        	        					       }
		        	        					    var sel =  getSelectElement("DOORNO");
		        	        					    emptyAndReset(sel);	      
		        	        					    sel.append(s);  
			            		    			});
			            		             }
			            			 	}],
	       			            		 searchhidden:true,
	       			            		 sopt : ['eq'] */
	       			             	} 	
                                },{
                                	name : 'DDATE',
                                    index : 'DDATE',
                                    label :'数字日期',
                                    sortable : "date",
                                    formatoptions: {srcformat:'u',newformat:'Y-m-d'},
                                    width : 100,
                                    search : false
                                },
                                {
                                	name : 'TODAY',
                                    index : 'TODAY',
                                    label :'日期',
                                    sorttype : 'date',
			        				formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'},
			        				stype:'text',
			        				searchoptions : {
			        					sopt : ['ge','le'],
			        					searchhidden:true,
			        					dataInit :  function (elem) {
			        						$(elem).datepicker({
			                					format : 'yyyy-mm-dd',
			                					autoclose : true,
			                				    language: 'zh-CN'
			                				});
			        						
			        					}
			        				},
                                    width : 150,
                                    search : false
                                },{
                                	name : 'FLOW',
                                    index : 'FLOW',
                                    label :'实际流量(T/H)',
                                    sortable : false,
                                    width : 120,
                                    search : false
                                    
                                },{
                                	name : 'COUNTUSER',
                                    index : 'COUNTUSER',
                                    label :'总户数',
                                    sortable : false,
                                    width : 100,
                                    search : false
        	        			}, {
        	        				name : 'SUMHAREA',
        	        				index : 'SUMHAREA',
        	        				label : '采暖建筑面积',
        	        				sortable : false,
        	        				width : 120,
        	        				search : false
        	        				
        	        			}, {
        	        				name : 'HEATMODE',
        	        				index : 'HEATMODE',
        	        				label : '采暖形式',
        	        				sortable : false,
        	        				width : 100,
        	        				search : false
        	        				
        	        			}, {
        	        				name : 'COUNTCB',
        	        				index : 'COUNTCB',
        	        				label : '抄表数',
        	        				sortable : false,
			        				width : 80,
        	        				search : false
        	        			}],
        			sortname : "BUILDNO",
        			sortorder : "asc",
        			shrinkToFit:false,
        			viewrecords : true,
        			rowNum : 20,
        			rowList : [ 10, 20, 30 ],
        			pager : pager_selector,
        			altRows : true,
        			toppager : true,
        	        multiboxonly : true,
        	        ondblClickRow: function(rowid){
        				jQuery(grid_selector).viewGridRow(rowid,{});
        			},
        			loadComplete : function(data) {
        				if(data.rows.length==0)
        					$('.ui-jqgrid-htable').css('width','auto');
        				else
        					$('.ui-jqgrid-htable').css('width','100%');
        				var table = this;
        				setTimeout(function(){
        					styleCheckbox(table);
        					updateActionIcons(table);
        					updatePagerIcons(table);
        					enableTooltips(table);
        				}, 0);
        			},
        			 editurl :"${contextPath}/waterConservancy/heatConsContr/updateheatConsContr" /*  @*/
        		});
				
				
				
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		function pickDate(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=text]').datepicker({
        					format : 'yyyy-mm-dd',
        					autoclose : true,
        				    language: 'zh-CN'
        				});
        			}, 0);
        		}
        		
        		// navButtons
        		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { // navbar options
        			edit : <shiro:hasPermission name="${ROLE_KEY}:hisdata:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:edit">false</shiro:lacksPermission>,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : <shiro:hasPermission name="${ROLE_KEY}:hisdata:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:add">false</shiro:lacksPermission>,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : <shiro:hasPermission name="${ROLE_KEY}:hisdata:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:delete">false</shiro:lacksPermission>,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : <shiro:hasPermission name="${ROLE_KEY}:hisdata:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:search">false</shiro:lacksPermission>,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : <shiro:hasPermission name="${ROLE_KEY}:hisdata:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:view">false</shiro:lacksPermission>,
        			viewicon : 'ace-icon fa fa-search-plus grey'
        		}, {
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval('('+response.responseText+')');
    				    return result.message;
    				}
        		}, {
        			closeAfterAdd : true,
        			recreateForm : true,
        			viewPagerButtons : false,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval('('+response.responseText+')');
    				    return result.message;
    				}
        		}, {
        			recreateForm : true,
        			beforeShowForm : function(e){
        				var form = $(e[0]);
        				if (form.data('styled'))
        					return false;
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_delete_form(form);
        				form.data('styled', true);
        			}
        		}, {
        			recreateForm : true,
        			tmplNames : ['多条件查询'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			closeAfterSearch : true,
        			searchOnEnter: true,
        			closeOnEscape:true,
        			afterShowSearch : function(e){
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function(){
        				style_search_filters($(this));
        			},
        			multipleSearch : true,
        			onSearch: _J_setAreaGuid
        		}, {
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		})
        		
    /*  */    		
        	if(<shiro:hasPermission name="${ROLE_KEY}:hisdata:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:export">false</shiro:lacksPermission>){
        			jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green ", // ace-icon fa fa-file-excel-o green
   				       onClickButton :  function() { 
   				    	 var currentDate = new Date();
   				    	 var searchDateValue = $('input[class="hasDatepicker input-elm"]:first').val();
   				    	 var searchDateValue2 = $('input[class="hasDatepicker input-elm"]:last').val();
 				    	 if(searchDateValue ==''||searchDateValue==undefined)
 				    		   searchDateValue = new Date(new Date().setDate(new Date().getDate()-7)).toLocaleDateString().replace(/\//g,'-'); 
 				    	if(searchDateValue2 ==''||searchDateValue2==undefined)
				    		   searchDateValue2 = currentDate.toLocaleDateString().replace(/\//g,'-'); 
    	
   				    	$("#sel_dialog").dialog({
   				    		title : '选择日期范围',
   				    		bgiframe: true,
   				    	    resizable: false,
   				    	    modal: true,
	   				    	buttons: {
				   				          '导出': function() {
						   				        	var areaguid = $('#areainfo').val();
						   		        			if(areaguid==''){
						   		        				alert('请选择小区！');
						   		        				return;
						   		        			}
				   				        			  submitExcel();
						   				              $(this).dialog('destroy');
						   				           	  $("#input_sel_date").datepicker('destroy');
						   				          },
				   				          '取消': function() {
						   				              $(this).dialog('destroy');
						   				          	  $("#input_sel_date").datepicker('destroy');
						   				          }
				   				      },
				   				      
   				    	    
				   			focus: function(event, ui) {
				   				$("#input_sel_date").datepicker({
		   				    		dateFormat: 'yy-mm-dd',
		   				    		defaultDate : new Date()-7,
						    	});
				   				$("#input_sel_date2").datepicker({
		   				    		dateFormat: 'yy-mm-dd',
						    	});
				   				$("#input_sel_date").blur().val(searchDateValue);
				   				$("#input_sel_date2").blur().val(searchDateValue2);
				   				
				   				$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
									  var response = jQuery.parseJSON(data);
	        					      var s = '<option value="">请选择</option>';
	        					      if (response && response.length) {
	        					          for (var i = 0, l = response.length; i < l; i++) {
	        					           var ri = response[i];
	        					           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
	        					          }
	        					       }
	        					      $('#areainfo').append(s);
	        					      var $areaguid = getSelectElement("AREAGUID").val();
	        					      if($areaguid==''||$areaguid==undefined){
	        					    	  var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
	        					    	  $('#areainfo option[value="'+areaguid+'"]').attr('selected',true);
	        					      }else
	        					    	  $('#areainfo option[value="'+$areaguid+'"]').attr('selected',true);
								})
				   			}
   				    	});
   				       } 
   					});        			
        		}
        		
        	function submitExcel(){
      			   var date1 = $("#input_sel_date").val();
      			   var date2 = $("#input_sel_date2").val();
      			   var areaguid = $('#areainfo').val();
      			   if(areaguid=='')
      				   return;
      			   
      				   
      			  
      			 $.get('${contextPath}/waterConservancy/heatConsContr/updateheatConsContr?'
      					   +'oper=excel&flag=1&date1='+date1+"&date2="+date2+"&areaguid=" + areaguid,function(data){
      				   if(data==1){
      					   alert('没有数据！');
      				   }else{
      					   var form = "<form name='csvexportform' action='${contextPath}/waterConservancy/heatConsContr/"
      					   +"updateheatConsContr?oper=excel&&date1="+date1+"&date2="+date2+"&areaguid="+areaguid+"' method='post'>";
      					   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
      			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
      			    	   $('#excel_btn').empty().append(form).empty();
      				   }
      			   })
      			}
        			
        		function style_edit_form(form) {
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();
        			buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
        			buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
        			buttons = form.next().find('.navButton a');
        			buttons.find('.ui-icon').hide();
        			buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
        			buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
        		}

        		function style_delete_form(form) {
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();
        			buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
        			buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
        		}

        		function style_search_filters(form) {
        			form.find('.delete-rule').val('X').hide();
        			form.find('.add-rule').addClass('btn btn-xs btn-primary').hide();
        			form.find('.add-group').addClass('btn btn-xs btn-success');
        			form.find('.delete-group').addClass('btn btn-xs btn-danger').hide();
        		}
        		function style_search_form(form) {
        			var dialog = form.closest('.ui-jqdialog');
        			var buttons = dialog.find('.EditTable');
        			buttons.find('.EditButton select[class="ui-template"] option[value="default"]').attr("selected",false);
        			buttons.find('.EditButton select[class="ui-template"] option[value!="default"]').attr("selected",true).change();//还需要再多加上一个change来触发
        			buttons.find('.EditButton select[class="ui-template"]').hide();
        			form.find('select[class="opsel"]').remove();
        			form.find('.searchFilter table').remove()/* attr('align','center') */;
        			buttons.find('.EditButton a[id*="_reset"]').hide().addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
        			buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
        			buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').css('class', 'ace-icon fa fa-search');
        			form.find('.columns select').attr('disabled','disabled'); 
        			form.find('.operators select').attr('disabled','disabled');
        		}
        		function beforeDeleteCallback(e) {
        			var form = $(e[0]);
        			if (form.data('styled'))
        				return false;
        			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        			style_delete_form(form);
        			form.data('styled', true);
        		}
        		function beforeEditCallback(e) {
        			var form = $(e[0]);
        			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        			style_edit_form(form);
        		}
        		function styleCheckbox(table) {}
        		$('.ui-jqgrid-htable').css('width','auto');
        		function updateActionIcons(table) {}
        		function updatePagerIcons(table) {
        			var replacement = {
        				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
        				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
        				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
        				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
        			};
        			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
        				var icon = $(this);
        				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
        				if ($class in replacement)
        					icon.attr('class', 'ui-icon ' + replacement[$class]);
        			})
        		}
        		function enableTooltips(table) {
        			$('.navtable .ui-pg-button').tooltip({container : 'body'});
        			$(table).find('.ui-pg-div').tooltip({container : 'body'});
        		}
        		$(document).one('ajaxloadstart.page', function(e) {
        			$(grid_selector).jqGrid('GridUnload');
        			$('.ui-jqdialog').remove();
        		});
        		$(pager_selector + ' #grid-pager_left span').css({'text-indent':0});
				var navTable = $(pager_selector + ' #grid-pager_left').clone(true);
				$(pager_selector + ' #grid-pager_left').empty();
     			$('#grid-table_toppager_left').append(navTable);
     			$('#grid-table_toppager_left').append(_go_back);
     			$(window).triggerHandler('resize.jqGrid');
        	});
        });
        
      
  //导出查询数据
 	$("#excel_btn").click(function(){
 		
 		// var date1 = $("#input_sel_date").val();
		//   var date2 = $("#input_sel_date2").val();
		   var areaguid = $('#areainfo').val();
		   if(areaguid=='')
			   return;
 		 $.get('${contextPath}/waterConservancy/heatConsContr/updateheatConsContr?'
				   +'oper=excel&flag=1'+"&areaguid=" + areaguid,function(data){
			   if(data==1){
				   alert('没有数据！');
			   }else{
				   var form = "<form name='csvexportform' action='${contextPath}/waterConservancy/heatConsContr/"
				   +"updateheatConsContr?oper=excel&&areaguid="+areaguid+"' method='post'>";
				   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
		    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
		    	 //  $('#excel_btn').empty().append(form).empty();
		    	   $('#excel_btn').append(form);
			   }
		   })
 		
	
	/*	var rows = '';
		var row = '';//标题部分
		$('#tabList thead th').each(function(index,value){
			index ==0 ? row+=value.innerHTML : row += '\t'+value.innerHTML;
		});
		rows += row;
		var $tb_tr = $('#tabList tbody tr');
		$tb_tr.each(function(index,value){
			rows +='\n';
			
			$(value).find('td').each(function(i,v){
				if(v.innerHTML!=''){
					i==0 ? rows += v.innerHTML : rows += '\t' + v.innerHTML;
				}else{
					i==0 ? rows += v.innerHTML : rows += '\t ';
				}
			});
		});
		if(row==rows){
			alert("没有数据");
			return;
		}
		 var form = "<form name='csvexportform' action='${contextPath}/waterConservancy/heatConsContr/updateheatConsContr?title="+encodeURIComponent(encodeURIComponent(title))+"' method='post'>";
    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
    	   OpenWindow = window.open('', '导出数据','width=500,height=300');
    	   OpenWindow.document.write(form);
    	   OpenWindow.document.close(); */
	}); 
        
</script>

