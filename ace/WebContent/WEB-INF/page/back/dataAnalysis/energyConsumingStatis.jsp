<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!-- 5 link -->
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />


<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/datepicker.css" />
	
 <style>
        html,body{text-align:center;margin:0px auto;}
 </style>	
	
<body>	
<%
			Calendar c = Calendar.getInstance();
			String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
			c.add(Calendar.DATE, -7);
			String weekAgo = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
		%>
<div class="row">
	<div class="col-xs-12">
		
		<div id="sel_dialog" style="display: none;">
			<p> 选择小区：<select id="areainfo" style="width: 50%;"></select></p>
			<p>
				开始日期：<input id="input_sel_date" type="text" value="<%=weekAgo%>"
					readonly="readonly">
			</p>
			<p>
				结束日期：<input id="input_sel_date2" type="text" value="<%=today%>"
					readonly="readonly">
			</p>
		</div>
		<div id="da-search"></div>
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div>
</div>





<div id="myModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
	<div class="modal-dialog"   style="width:1100px;">
		<form id="authorityForm" class="form-inline">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						用户增量曲线图
					</div>
				</div>
				<div class="modal-body" style="max-height: 450px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
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
									<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;"  id="input_selsdate" type="text"  value="<%=weekAgo%>" readonly="readonly"> 
									<label>结束时间：</label>
									<input style="height: 28px;width: 100px; padding-top: 2px; padding-bottom: 2px;"  id="input_seledate" type="text"  value="<%=today %>" readonly="readonly"> 
								 	<!-- <label>用户编号：</label> 
									<input style="height: 28px;width: 120px; padding-top: 2px; padding-bottom: 2px;" id="clientno" type="text"  value="143401101002" readonly="readonly"/>
	                         			 -->
	                         					 
	                         	 </div>
	                         	 &nbsp;&nbsp;&nbsp;
	                           <div class="form-group">
		                         <button type="button" class="btn btn-success" id="LLIANG" value="LLIANG">流量增量</button>
								 <button type="button" class="btn btn-success" id="RELIANG" value="RELIANG">热量增量</button>
								 <button type="button" onClick = "javascript:history.go();" class="btn btn-success">返&nbsp;&nbsp;回</button>
	                           </div>
	                          
	                            <div class="row"> <div class="col-xs-12">
	                            <div id="List_tableview" style="width:1000px"></div>
	                            <div id="zlcharts"></div><!-- 图表 -->
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

</body>

</html>



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
        				// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
        				setTimeout(function() {
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		})
        		var _areaguid,_buildno,_unitno,_floorno;
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
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
        		
        	/* 用户编号链接 */	
        		
        	/* 	 var zlChart=function (clientno,ddate,btn,meterid){
        			var url="${contextPath}/sys/sysuser/home#page/zlCharts?clientno="+rows.CLIENTNO
        					+ "&date=" + _date + "&btn=" + btn + "&meterid=" + rows.METERID;
        			window.location.href =url;
        	};  */ 
      		    var _forword = function(cel,op,rows,btn){
        			var celldate = new Date();
					celldate.setTime(rows['DDATE']);
					var _date = celldate.format_tmp('yyyy-MM-dd');
					$("#clientno").append(rows.CLIENTNO);
					$("#meterno").append(rows.METERID);//$(\"#meterno\").val(\"" + rows.METERID +"\")
        		 /* 	return	 '<a href=" <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">'
		                                	    +''+rows.CLIENTNO+''
		                                	    +'  </button> </a>'   */
					return "<a href='javascript:$(\"#myModal\").modal(\"toggle\");$(\"#clientno\").val(\"" + rows.CLIENTNO +"\");'>"+rows.CLIENTNO+" </a>"
		      		                         	    
		                                	    
      		    };
      		    
        		
        		function getSelectElement(val){
        			if(val!=='undefined')
        				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
        		}
        		function emptyAndReset(e){
        			e.empty();
        			e.append("<option value=''>请选择</option>").attr("selected",true).change();
        		}
				var flag = true;
				var initData = {};
				if('<%=(String)request.getParameter("areaguid") %>'!='null'&&'<%=(String)request.getParameter("buildno") %>'!='null'){
					initData = {
						filters : "{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"AREAGUID\",\"op\":\"eq\",\"data\":\"\"},{\"field\":\"BUILDNO\",\"op\":\"eq\",\"data\":\"<%=(String)request.getParameter("buildno") %>\"},{\"field\":\"DDATE\",\"op\":\"ge\",\"data\":\"<%=(String)request.getParameter("bdate") %>\"},{\"field\":\"DDATE\",\"op\":\"le\",\"data\":\"<%=(String)request.getParameter("edate") %>\"}]}"
					}
				}
				var firstGrid = jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/dataAnalysis/energyConsumingStatisContr/getEnergyConsumingStatis",
        			datatype : "json",
        			postData:initData,
        			height : 450,
        			rownumbers:true, //10-02
        			rownumWidth:40,
        			colNames : ['小区编号','小区名称','楼宇','单元','楼层','门牌', '日期',
                                
                                '住户姓名', '用户编码','表编号','地址','使用面积(㎡)','起始时间', '终止时间','起始热量(KWH)','终止热量(KWH)'
        			            ,'用热量(KWH)','系数','热量单耗(KWH/㎡)','起始流量(t)','终止流量(t)','用流量(t)','流量单耗(t/㎡)'],
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
        	        					      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);</sc"+"ript>  ";
        	        					      var sel = getSelectElement("AREAGUID");
        	        					      sel.empty().append(s);
        	        					      getSelectElement("DOORNO").parent('td').parent('tr').css('border-bottom','2px solid rgb(187, 194, 198)');
        	        				     }
	       			            	}   
        			            },{
                                    name : 'AREANAME',
                                    index : 'AREANAME',
                                    label :'小区名称',
                                    sortable : false,
                                    width : 100,
                                    search : false
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
			            		            	if(_buildno=='')
			            		            		{
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
		        	        					           s += '<option value="' + ri['UNITNO'] + '">' + ri['UNITNO'] + '单元</option>';
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
			            		    			if(_unitno=='')
			            		    				{
			            		    				   emptyAndReset(getSelectElement("FLOORNO"));
			        	        					    emptyAndReset(getSelectElement("DOORNO"));
			        	        					    return;
			            		    				}
			            		    			$.get('${contextPath}/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
			            		    					+"&BUILDNO="+_buildno+"&UNITNO="+_unitno, function(data){
			            		    				
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
			            		    			if(_floorno=='')
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
	       			            		 sopt : ['eq']
	       			             	} 	
      			             	}, { hidden:true,
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌号 ',
        	        				width : 163,
        	        				sortable : false,
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					searchhidden:true,
        	        					sopt:['eq']
        	        				}
        	        			},{
			        				name : 'DDATE',//时间
			        				index : 'DDATE',
			        				label : '日期',
			        				hidden : true,
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
			        				search : true
			        			},{
                                    name : 'CLIENTNAME',
                                    index : 'CLIENTNAME',
                                    label :'住户姓名',
                                    sortable : false,
                                    width : 100,
                                    search : false,
                                },{
        	        				name : 'CLIENTNO',
        	        				index : 'CLIENTNO',
        	        				label : '用户编号',
        	        				width : 100,
        	        			
                        	   
        	        		 	formatter: function(cel,op,rows){return _forword(cel,op,rows,'CLIENTNO')},  
        	        				
        	        				sortable : false
        	        				
        	        			}, {
        	        				name : 'METERNO',//热表号
        	        				index : 'METERNO',
        	        				label : '热表号',
        	        				width : 100,
        	        				search : true,
        	        				sortable : false,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},{
                                    name : 'ADDRESS',
                                    label : '地址',
                                    sortable : false,
                                    width : 120,
        	        				search : true
                                   
                                },{
									name : 'HOTAREA',
                                	label:'使用面积',
                                	sortable : false,
                                	formatter: roundFix,
                                	width : 86,
                                },{
                                	name : 'MINDATE',
                                    label:'起始时间',
                                    sortable : false,
                                    formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d'},
                                },{
                                	name : 'MAXDATE',
                                    label: '终止时间',
                                    formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d'},
                                    
                                },{
        	        				name : 'MINNLLJ',
        	        				label : '起始热量',
        	        				formatter: roundFix,
        	        				sortable : false,
        	        				width : 100,
        	        			}, {
        	        				name : 'MAXNLLJ',
        	        				label : '终止热量',
        	        				formatter: roundFix,
        	        				sortable : false,
        	        				width : 70
        	        				
        	        			}, {
        	        				name : 'RLYL',
        	        				sortable : false,
        	        				index : '',
        	        				label : '用热量',
        	        				formatter: roundFix,
        	        				width : 100
        	        				
        	        			},{
        	        				name : 'METERXISH',
        	        				index : 'METERXISH',
        	        				label : '系数',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 80,
        	        				search : false
        	        			}, {
        	        				name : 'RLDH',
        	        				index : 'RLDH',
        	        				label : '热量单耗',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'MINTJ',
        	        				index : 'MINTJ',
        	        				label : '起始流量',
			        				width : 100,
			        				sortable : false,
			        			
        	        				search : false
        	        			}, {
        	        				name : 'MAXTJ',
        	        				index : 'MAXTJ',
        	        				label : '终止流量',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'LLYL',
        	        				index : 'LLYL',
        	        				label : '用流量',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'LLDH',
        	        				index : 'LLDH',
        	        				label : '流量单耗',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 100,
        	        				search : false
        	        			}],
        			sortname : "BUILDNO,UNITNO,FLOORNO,DOORNAME",
        			sortorder : "asc",
        			shrinkToFit:false,
        			viewrecords : true,
        			rowNum : 20,
        			rowList : [ 20, 30, 50 ],
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
        			}
        		}, {
        			recreateForm : true,
        			tmplNames : ['多条件查询'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			closeAfterSearch : true,
        			searchOnEnter: true,
        			closeOnEscape:true,
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function() {
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
        		
        		if(true/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:export">false</shiro:lacksPermission> */){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () { 
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
      			   $.get('${contextPath}/dataAnalysis/energyConsumingStatisContr/updateEnergyConsumingStatis?'
      					   +'oper=excel&flag=1&date1='+date1+"&date2="+date2+"&areaguid=" + areaguid,function(data){
      				   if(data==1){
      					   alert('没有数据！');
      				   }else{
      					   var form = "<form name='csvexportform' action='${contextPath}/dataAnalysis/energyConsumingStatisContr/"
      					   +"updateEnergyConsumingStatis?oper=excel&&date1="+date1+"&date2="+date2+"&areaguid="+areaguid+"' method='post'>";
      					   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
      			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
      			    	   $('#export_excel').empty().append(form).empty();
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
     			$(window).triggerHandler('resize.jqGrid')
     			
        	}); 
        	
        	
        	
        	
   		//用户增量曲线事件 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     		
   		
	   		$("#input_selsdate").datepicker({
	        		dateFormat: 'yy-mm-dd',
	    	});
	    		$("#input_seledate").datepicker({
	        		dateFormat: 'yy-mm-dd',
	    	});
	    	
    		$('button').click(function(){
    			
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
			 	  		 
  	  	 $.post("${contextPath}/dataAnalysis/energyConsumingStatisContr/getzlData?zl="+buttonname+"&areaguid="+<%=(String)request.getSession().getAttribute("areaGuids") %>+"&customerid="+$('#clientno').val()+"&sdate="+$('#input_selsdate').val()+"&edate="+$('#input_seledate').val(), function (data) {            
       			
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
        		 }); 
    		});
    	//	$('button[value="RELIANG"]').click();

        	
    	 });
</script>
