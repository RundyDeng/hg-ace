<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
 <style>
        html,body{text-align:center;margin:0px auto;}
 </style>


<%
	Calendar c = Calendar.getInstance();
	String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	String weekAgo = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>

<div class="row"  >
	<div class="col-xs-12">
		<div id="sel_dialog" style="display : none;">
			<p>选择小区：<select id="areainfo" style="width: 50%;"></select></p>
			<p>选择日期：<input  id="input_sel_date" type="text"  value="<%=today %>" readonly="readonly"></p>
		</div>
		<div id="da-search"></div>
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div><!-- /.col -->
</div><!-- /.row -->


	<div id="myModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
		<div class="modal-dialog"   style="width:1100px;">
			<form id="authorityForm" class="form-inline">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							住户运行曲线图
						</div>
					</div>
					<div class="modal-body" style="max-height: 450px;overflow-y: scroll;">
						<div id="modal-tip" class="red clearfix"></div>
	
						<input id="clientno" name="clientno" type="hidden" />
						<input id="meterno" name="meterno" type="hidden" />
	
						<input id="clientno"  type="hidden" />
						<input id="meterno" type="hidden" />
	
						<input id="type" type="hidden" />
						<div class="widget-box widget-color-blue2">
							<div class="widget-body" >
								<div class="widget-main padding-8" >
								 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
								 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
									 <div class="form-group">
	
									   <label>起始时间：<span></span></label>
										<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_selsdate" type="text"  value="<%=weekAgo%>" readonly="readonly"> 
										<label>结束时间：</label>
										<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;" id="input_seledate" type="text"  value="<%=today %>" readonly="readonly"> 
										
		                         	 </div>
		                         	 &nbsp;&nbsp;&nbsp;
		                           <div class="form-group">
			                       	 <button type="button" class="btn btn-success" value="MeterNLLJ" >累计热量</button>
				                     <button type="button" class="btn btn-success" value="MeterTJ" >累计流量</button>
									 <button type="button" class="btn btn-success" value="MeterGL" >瞬时热量</button>
				                     <button type="button" class="btn btn-success" value="MeterLS" >瞬时流量</button>
				                     <button type="button" class="btn btn-success" value="TEMP" >温 度</button>  
				                  
		                           </div>
		                          
		                           <div class="row"> <div class="col-xs-12">
		                            <div id="List_tableview" style="width:1000px"></div> 
		                            <div id="each_charts"></div><!-- 图表 -->
		                           </div>
		                           </div>  
								</div>
							</div>
						</div>
					</div>
				</div><!-- /.modal-content -->
			</form>
		</div><!-- /.modal-dialog -->
	</div>





<script type="text/javascript">
		var scripts = [ null,"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"
		                ,"${contextPath}/static/assets/js/jquery-ui.js",
		                
		                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
			   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
			   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
			   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
			   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",
		                null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	jQuery(function($) {
        		var da_search = "#da-search";
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";
        		$(window).on('resize.jqGrid', function() {
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
        		
				var _areaguid,_buildno,_unitno,_floorno;
        		//var currentday = new Date().toLocaleDateString().replace(/\//g,'-');
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
									 { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									 { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									 { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									 { "field": "DOORNO", "op": "eq", "data": "" } , //门牌  其实就是 DOORNO
        				             { "field": "CLIENTNO", "op": "eq", "data": "" } , 
									 { "field": "METERID", "op": "eq", "data": ""},
									 { "field": "SFTR", "op": "eq", "data": ""},
									 { "field": "AUTOID", "op": "eq", "data": ""},
									 { "field": "DDATE", "op": "eq", "data": "<%=today %>"}
        				         ] 
        		};
        		
        		var roundNum = function(cellvalue, options, rowObject){
        			if(cellvalue==0)
        				return 0;
					return cellvalue.toFixed(2);
				};
        		
        		/* jqGrids表格内容页面跳转路径  */
        		
        		var goChart=function (clientno,ddate,btn,meterid){
        		 	window.location.href="${contextPath}/sys/sysuser/home#page/clientCharts?clientno="+rows.CLIENTNO
        					+ "&date=" + _date + "&btn=" + btn + "&meterid=" + rows.METERID;
        			
        		};  
        		
      		     var _forword = function(cel,op,rows,btn){
        			var celldate = new Date();
					celldate.setTime(rows['DDATE']);
					var _date = celldate.format_tmp('yyyy-MM-dd');
        			$("#clientno").append(rows.CLIENTNO);
        			$("#meterno").append(rows.METERID);
      		   		 return "<a href='javascript:$(\"#myModal\").modal(\"toggle\");$(\"#clientno\").val(\"" + rows.CLIENTNO +"\");$(\"#meterno\").val(\"" + rows.METERID +"\")'>"+roundNum(cel,op,rows)+" </a>"
      		  
      		     }  
				        			

  
        		/*根据字段名获取选择下拉框*/
        		function getSelectElement(val){
        			if(val!=='undefined')
        				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
        		}
        		
        		function emptyAndReset(e){
        			e.empty();
        			e.append("<option value=''>请选择</option>").attr("selected",true).change();
        		}
				var urlParm = {};
				if('<%=(String)request.getParameter("day") %>'!='null'&&'<%=(String)request.getParameter("buildno") %>'!='null'){
					urlParm = {
						filters: "{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"AREAGUID\",\"op\":\"eq\",\"data\":\"\"},{\"field\":\"BUILDNO\",\"op\":\"eq\",\"data\":\"<%=(String)request.getParameter("buildno") %>\"},{\"field\":\"DDATE\",\"op\":\"eq\",\"data\":\"<%=(String)request.getParameter("day") %>\"}]}"
					}
				}
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/sys/todaydata/getTodayData",
        			mtype:'POST',
        			datatype : "json",
        			postData: urlParm,
        			height : 420,
        			rownumbers:true,
        			rownumWidth:40,  /* '门牌号','集中器地址','通道号', '热表号',  */
        			colNames : ['小区编号','楼宇','单元','楼层', '小区名称','用户编码', '门牌号', '热表号', '用热状态', '热表状态',
        			            '位置','系数'
        			            ,'瞬时热量(kw)','累计热量(kwh)','瞬时流量(t/h)','累计流量(t)'
        			            ,'进水温度(℃)','回水温度(℃)	','温差(℃)','时数(h)','日期','抄表批次'],
        			colModel : [ 
							  {
							    hidden:true,
							   	label:'小区名',
							   	name:'AREAGUID',
							   	search:true,
							   	stype:'select',
							   	searchoptions : {
							   		searchhidden:true,
									 	sopt : ['eq'],
									 	dataUrl:$path_base + '/sys/todaydata/getAreaDownList',
							   		dataEvents:[{
							             type:'change',
							             fn:function(e){
							    			_areaguid = $(e.target).val();
							    			$.get($path_base + '/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
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
						 		    var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>' 
									var response = jQuery.parseJSON(data);
								    var s = '<option value="">请选择</option>';
								    if (response && response.length) {
								          for (var i = 0, l = response.length; i < l; i++) {
								           var ri = response[i];
								           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
								          }
								       }
								      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);</sc"+"ript>  ";
								      var sel = getSelectElement("AREAGUID");
								      sel.empty().append(s);
	                    			 }
   	                      		  }
                                },
        			            {
	       			            	 hidden:true,
	       			            	 label:'楼宇',
	       			            	 name:'BUILDNO',
	       			            	 search:true,
	       			            	 stype:'select',
	       			            	 searchoptions : {
	       			            		dataEvents:[{
			            		             type:'change',//下拉选择的时候
			            		             fn:function(e){
			            		            	_buildno = $(e.target).val();
			            		            	if(_buildno==''){
			            		            		  emptyAndReset(getSelectElement("UNITNO"));
			            		            		  emptyAndReset(getSelectElement("FLOORNO"));
			        	        					  emptyAndReset(getSelectElement("DOORNO"));
			        	        					  return;
			            		            	}
			            		            		
			            		    			$.get('${contextPath}/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
			            		    					+"&BUILDNO="+_buildno, function(data){
			            		    				var response = jQuery.parseJSON(data);
			            		    				var s = ' ';
		        	        					      if (response && response.length) {
		        	        					          for (var i = 0, l = response.length; i < l; i++) {
		        	        					           var ri = response[i];
		        	        					           s += '<option value="' + ri['UCODE'] + '">' + ri['UCODE'] + '单元</option>';
		        	        					          }
		        	        					       }
		        	        					    var sel =  getSelectElement("UNITNO");
		        	        					    emptyAndReset(sel);
		        	        					    emptyAndReset(getSelectElement("FLOORNO"));
		        	        					    emptyAndReset(getSelectElement("DOORNO"));
		        	        					    sel.append(s);  
			            		    			});
			            		    				 
			            		             }
			            			 	}],
	       			            		 searchhidden:true,
	       			            		 sopt : ['eq'],
	       			             	}
       			            	},
       			            	{
	       			            	 hidden:true,
	       			            	 label:'单元',
	       			            	 name:'UNITNO',
	       			            	 search:true,
	       			            	 stype:'select',
	       			            	 searchoptions : {
	       			            		dataEvents:[{
			            		             type:'change',
			            		             fn:function(e){
			            		            	 _unitno = $(e.target).val();
			            		    			if(_unitno==''){
			            		    				 
			            		            		  emptyAndReset(getSelectElement("FLOORNO"));
			        	        					  emptyAndReset(getSelectElement("DOORNO"));
			        	        					  return;
			            		    			}
			            		    				
			            		    			$.get('${contextPath}/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
			            		    					+"&BUILDNO="+_buildno+"&UCODE="+_unitno, function(data){
			            		    				var response = jQuery.parseJSON(data);
			            		    				var s = ' ';
		        	        					      if (response && response.length) {
		        	        					          for (var i = 0, l = response.length; i < l; i++) {
		        	        					           var ri = response[i];
		        	        					           s += '<option value="' + ri['FLOORNO'] + '">' + ri['FLOORNO'] + '层</option>';
		        	        					          }
		        	        					       }
		        	        					    var sel =  getSelectElement("FLOORNO");
		        	        					    emptyAndReset(sel);
		        	        					    emptyAndReset(getSelectElement("DOORNO"));
		        	        					    sel.append(s);  
			            		    			});    		    				 
			            		             }
			            			 	}],
	       			            		 searchhidden:true,
	       			            		 sopt : ['eq']
	       			             	}           	
       			             	},          
       			            	{
	       			            	 hidden:true,
	       			            	 label:'楼层',
	       			            	 name:'FLOORNO',
	       			            	 search:true,
	       			            	 stype:'select',
	       			            	 searchoptions : {
	       			            		dataEvents:[{
			            		             type:'change',
			            		             fn:function(e){
			            		            	 _floorno = $(e.target).val();		            		    			
			            		    			if(_floorno==''){
			            		    				
			        	        					  emptyAndReset(getSelectElement("DOORNO"));
			        	        					  return;
			            		    			}
			            		    					
			            		    			$.get('${contextPath}/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
			            		    					+"&BUILDNO="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno, function(data){
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
	       			            		 sopt : ['eq']
	       			             	} 	
      			             	}, 
      			             	{
			        				name : 'AREANAME',//热表状态
			        				index : 'AREANAME',
			        				label : '小区名称',
			        				width : 180,
			        				search : false
			        			},
      			              {
        	        				name : 'CLIENTNO',//用户编号
        	        				index : 'CLIENTNO',//过滤里面的field
        	        				label : '用户编码',
        	        				width : 90,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}, {
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌 号',
        	        				width : 150,
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.BNAME+'-'+rowObject.UNITNO+'单元'+rowObject.DOORNAME;
        	        				},
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},/*  {
			        				name : 'POOLADDR',//热表状态
			        				index : 'POOLADDR',
			        				label : '集中器地址',
			        				width : 100,
			        				search : false
			        			},
			        			{
			        				name : 'MBUSID',//热表状态
			        				index : 'AREANAME',
			        				label : '通道号',
			        				width : 100,
			        				search : false
			        			}, */{
        	        				name : 'METERID',//热表号
        	        				index : 'METERID',
        	        				label : '热表号',
        	        				width : 110,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},{ 
        	        				name : 'SFTR',
        	        				index : 'SFTR',
        	        				label : '用热状态',
        	        			//	width : 100,
        	        				search : true,
        	        				stype:'select',
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.SFTR;
        	        				},
        	        				searchoptions:{
        	        				
    			        					dataInit:function(elem){
    					            			 var opt = '<option value="" >请选择</option>' 
    					            				        +'<option value="开" >开</option>'
    					            			 			+ '<option value="关" >关</option>';
    					            			 			
    					            			 $(elem).append(opt);
    					         			},
    			        					sopt:['eq']
    			        				}
        	        			}, {
			        				name : 'MSNAME',//热表状态
			        				index : 'MSNAME',
			        				label : '热表状态',
			        			//	width : 100,
			        				cellattr: addCellAttr,
			        				search : false
			        			},
			        			{
        	        				name : 'POSITION',
        	        				index : 'POSITION',
        	        				label : '位置',
        	        			//	width : 100,
        	        				search : true,
			        				stype:'select',
			        				searchoptions:{
			        					dataInit:function(elem){
					            			 var opt =  '<option value="" >请选择</option>' 
				            				        +'<option value="0.77" >顶层</option>'
				            			 			+ '<option value="0.68" >顶边层</option>'
				            			 			+ '<option value="0.95" >边层</option>'
				            			 			+ '<option value="0.89" >底层</option>'
				            			 			+ '<option value="0.76" >底边</option>'
				            			 			+ '<option value="1.00" >中间层</option>';
					            			 $(elem).append(opt);
					            			
					         			},
			        					sopt:['eq']
			        				}
        	        			},
			        			{
			        				name : 'METERXISH',
        	        				index : 'METERXISH',
        	        				label : '系数',
        	        			//	width : 80,
        	        				formatter: roundFix,
        	        				stype:'select',
        	        				search : false
        	        			},
        	        			 {
			        				name : 'METERGL',//瞬时热量
			        				index : 'METERGL',
			        				//formatter: roundNum,
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterGL');},
			        			//	width : 100,
			        				search : false
			        			},
			        			{
			        				name : 'METERNLLJ',//累计热量
			        				index : 'METERNLLJ',
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterNLLJ');},
								//	width : 100,
			        				search : false,
			        			}, {
			        				name : 'METERLS',//瞬时流量
			        				index : 'METERLS',
			        				//formatter: roundNum,
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterLS');},
			        			//	width : 100,
			        				search : false
			        			}, {
			        				name : 'METERTJ',//累计流量
			        				index : 'METERTJ',
			        				//formatter: roundNum,
			        			  	formatter: function (cel,op,rows){return _forword(cel,op,rows,'MeterTJ');}, 
			        			//	width : 100,
			        				search : false
			        			}, {
			         				name : 'METERJSWD',//进水温度
			        				index : 'METERJSWD',
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterJSWD');},
			        			//	width : 100,
			        				search : false
			        			}, {
			         				name : 'METERHSWD',//回水温度
			        				index : 'METERHSWD',
			        				label : '回水温度',
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterHSWD');},
			        			//	width : 100,
			        				search : false
			        			}, {
			         				name : 'METERWC',//温差
			        				index : 'METERWC',
			        				label : '温差',
			        				formatter: function(cel,op,rows){return _forword(cel,op,rows,'MeterWC');},
			        		//		width : 100,
			        				search : false
			        			}, {
			         				name : 'COUNTHOUR',//时数
			        				index : 'COUNTHOUR',
			        				label : '时数',
			        		//		width : 100,
			        				searchoptions : {
			        					sopt : ['eq']
			        				},
			        				search : false
			        			}, {
			        				name : 'DDATE',//时间
			        				index : 'DDATE',
			        				label : '日期',
			        		//		width : 180,
			        				sorttype : 'date',
			        				formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'},
			        				/* unformat : pickDate, */
			        				stype:'text',
			        				searchoptions : {
			        					sopt : ['eq'],
			        					dataInit :  function (elem) {
			        						$(elem).datepicker({
			                					format : 'yyyy-mm-dd',
			                					autoclose : true,
			                				    language: 'zh-CN'
			                				});
			        						
			        					}
			        				},
			
			        		//		width : 150,
			        				search : true
			        			}, {
			        				name : 'AUTOID',//抄表批次
			        				index : 'AUTOID',
			        				label : '抄表批次',
			        		//		width : 70,
			        				search : true,
			        				stype:'select',
			        				searchoptions:{
			        					dataInit:function(elem){
					            			 var opt =  '<option value="1" selected="true">1</option>'
					            			 			+ '<option value="2" >2</option>';
					            			 
					            			 $(elem).append(opt);
					            			
					         			},
			        					sopt:['eq']
			        				}
			
			        			}],
			        			sortname : "id",
			        			sortorder : "asc",
			        			viewrecords : true,
			        			rowNum : 20,
			        			rowList : [ 20, 30, 50 ],
			        			pager : pager_selector,
			        			altRows : true,
			        			toppager: true,
			        			shrinkToFit:true,//列线对齐
			        			multiselect : false,
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
			        			beforeRequest:function(){
			        				}
			        			
			        		});

        		$(window).triggerHandler('resize.jqGrid');
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { 
        			edit : false/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:edit">false</shiro:lacksPermission> */,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : false/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:add">false</shiro:lacksPermission> */,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : false/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:delete">false</shiro:lacksPermission> */,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : true/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:search">false</shiro:lacksPermission> */,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : false/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:view">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:view">false</shiro:lacksPermission> */,
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
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				if (form.data('styled'))
        					return false;
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_delete_form(form);
        				form.data('styled', true);
        			},
        			onClick : function(e) {
        				
        			}
        		}, {
        			recreateForm : true,
        			tmplNames : ['多条件查询'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			closeAfterSearch : true,
        			searchOnEnter: true,
        			closeOnEscape:true,
        			loadDefaults : false,
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);

        			},
        			afterRedraw : function() {
        				style_search_filters($(this));
        				var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>' 
        				$('select option[value="'+areaguid+'"]').change().attr('selected',true).parent('select').attr('value','"'+areaguid+'"')
        			},
        			onInitializeSearch:function(){
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
        		
        		// add custom button to export the data to excel
        		if(true/* <shiro:hasPermission name="${ROLE_KEY}:todaydata:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:export">false</shiro:lacksPermission> */){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () { 
   				    	   var searchDateValue = $('input[class="hasDatepicker input-elm"]').val();
   				    	   if(searchDateValue ==''||searchDateValue==undefined)
   				    		   searchDateValue = new Date().toLocaleDateString().replace(/\//g,'-');
   				    	   $("#sel_dialog").dialog({
	   				    		title : '指定日期导出数据',
	   				    		bgiframe: true,
	   				    	    resizable: false,
	   				    	    //height:150,
	   				    	    modal: true,
	   				    	 
		   				    	buttons: {
					   				          '导出': function() {
					   				        			  submitExcel();
							   				              $(this).dialog('destroy');
							   				           	  $("#input_sel_date").datepicker('destroy');
							   				          },
					   				          '取消': function() {
					   				        	  		  //$(this).dialog('destroy');
							   				              $(this).dialog('destroy');
							   				          	  $("#input_sel_date").datepicker('destroy');
							   				          }
					   				      },
					   				      
					   			open : function(event, ui){
					   				
					   			},
					   			focus: function(event, ui) {
					   				$("#input_sel_date").datepicker({
			   				    		dateFormat: 'yy-mm-dd',
			   				    		//altFormat: 'yy-mm-dd' 
			   				    		//defaultDate : searchDateValue,//这个没发现用处
			   				    		//showOn : 'button'
							    	});
					   				$("#input_sel_date").blur();
					   			 	$("#sel_dialog input").val(searchDateValue);
					   			 	
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
								});
					   			}
	   				    	});
   				       } 
   					});        			
        		}
        		function addCellAttr(rowId, val, rawObject, cm, rdata) {
                    if(rawObject.MSNAME == "正常" ||rawObject.MSNAME == "未抄表"||rawObject.MSNAME == "终端无反应" ){
                       return "style='color:green'";
                   }else{
                	   return "style='color:red'";
                   } 
               }
     			function submitExcel(){
     			   var currentDate = $("#input_sel_date").val();
     			   var areaguid = $('#areainfo').val();
     			   if(areaguid=='')
     				   return;
     			   $.get('${contextPath}/sys/todaydata/operateTodayData?oper=excel&flag=1&date='+currentDate+"&areaguid=" + areaguid,function(data){
     				   if(data==1){
     					   alert('没有当日数据！');
     				   }else{
     					  var form = "<form name='csvexportform' action='${contextPath}/sys/todaydata/operateTodayData?oper=excel&date="+currentDate+"&areaguid=" + areaguid+"' method='post'>";
     			    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
     			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
     			    	   OpenWindow = window.open('', '','width=200,height=100');
     				       OpenWindow.document.write(form);
     				       OpenWindow.document.close();
     				   }
     			   })
     			}
        		
        		function style_edit_form(form) {
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();// ui-icon, s-icon
        			buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
        			buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
        			buttons = form.next().find('.navButton a');
        			buttons.find('.ui-icon').hide();
        			buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
        			buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
        		}

        		function style_delete_form(form) {
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();// ui-icon, s-icon
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
        			form.find('.searchFilter table').remove();
        		
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
        		function assertElement(ele){
        			try{
        				ele.cloneNode(true);
        				if(ele.nodeType!=1&&ele.nodeType!=9){
        					return false;
        				}		
        			}catch(e){
        				throw new Error("ele参数不合法");
        			}
        				return false;
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
        	
        	
        	//住户运行曲线事件 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            
	   		$("#input_selsdate").datepicker({
	        		dateFormat: 'yy-mm-dd',
	    	});
	    		$("#input_seledate").datepicker({
	        		dateFormat: 'yy-mm-dd',

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
	    			
	    			
	    			$.post('${contextPath}/sys/todaydata/getClientChartsByFiledName?filedName='+fieldName 
		        				+ '&beginDate=' + $('#input_selsdate').val() + '&endDate=' + $('#input_seledate').val() 
		        				+ '&meterno='+ $("#meterno").val()+'&clientno='+ $("#clientno").val(), function (data) { 
	    		
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
		    			
		    		 if(fieldName=='MeterNLLJ'){
    	    			y1='累计热量(kwh)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='kwh';
    	    			for(var i=0;i<jsonarray.length;i++){
    	    				chartdata1[i] = parseFloat(jsonarray[i].METERNLLJ); 
    	    				xchart[i] =jsonarray[i].DDATE;
    	    			}	
    	    		}else if(fieldName=='MeterTJ'){
    	    			y1='累计流量(t)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='t';
    	    			for(var i=0;i<jsonarray.length;i++){
    	    				chartdata1[i] = parseFloat(jsonarray[i].METERTJ); 
    	    				xchart[i] =jsonarray[i].DDATE;
    	    			}		
		    			
    	    		}else if(fieldName=='MeterLS'){
    	    			y1='瞬时流量(t/h)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='t/h';
    	    			
    	    			for(var i=0;i<jsonarray.length;i++){
    	    				chartdata1[i] = parseFloat(jsonarray[i].METERLS);
    	    				xchart[i] = jsonarray[i].DDATE;
    	    			}
    	    		}else if(fieldName=='MeterGL'){
    	    			y1='瞬时热量(KW)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='KW';
    	    			for(var i=0;i<jsonarray.length;i++){
    					chartdata1[i] = parseFloat(jsonarray[i].METERGL);
    					xchart[i] =jsonarray[i].DDATE;
    					}
						
    	    	/* 	}else if(fieldName=='MeterWC'){
    	    			y1='温差(℃)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='℃ ';
    	    			for(var i=0;i<jsonarray.length;i++){
    					chartdata1[i] = parseFloat(jsonarray[i].METERWC);
    					xchart[i] =jsonarray[i].DDATE;
    					} */
    	    			
    	    		}else if(fieldName=='TEMP'){
    	    			y1='进水温度(℃)';
    	    			y2='回水温度(℃)';
    	    			y3='温差(℃)';
    	    			title1=$("#input_selsdate").val()+'至'+$("#input_seledate").val()+title+'曲线';
    	    			dw='℃';
    	    			for(var i=0;i<jsonarray.length;i++){
    	    				chartdata1[i] = parseFloat(jsonarray[i].METERJSWD); 
    	    				chartdata2[i] = parseFloat(jsonarray[i].METERHSWD); 
    	    				chartdata3[i] = parseFloat(jsonarray[i].METERWC);
    	    				xchart[i] =jsonarray[i].DDATE;
    	    			}
    	    		}	
	    	               
	    	     if(fieldName=='MeterNLLJ'||fieldName=='MeterTJ'||fieldName=='MeterLS'||fieldName=='MeterGL'){
	    	    		 $('#each_charts').highcharts({
	    	     		        title: {
	    	     		            text: title1,
	    	     		            x: -20 //center
	    	     		        },
	    	     		        credits: {
	    	     		            enabled:false
	    	     		        },
	    	     		        
	    	     		        xAxis: {
	    	     		        	tickInterval: 10,
	    	     		            categories:xchart,
	    	     		            labels:{
	    	     		            	 rotation: -45  , //45度倾斜
	    	     	                 }
	    	     		        },
	    	     		        yAxis: {
	    	     		            title: {
	    	     		                text: y1
	    	     		            },
	    	     		            labels: {
	    	     	                    align: 'left',
	    	     	                    x: 3,
	    	     	                    y: 16,
	    	     	                    format: '{value:.,of}'
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
		    	    		        	tickInterval: 10,
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
	    		

	    });     	
        	
</script>
