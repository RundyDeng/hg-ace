<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<div class="row">
<%
String today=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
%>
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

<script type="text/javascript">
		var scripts = [ null,"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"
		                ,"${contextPath}/static/assets/js/jquery-ui.js", null ]
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
				}
        		
        		var _forword = function(cel,op,rows,btn){
        			var celldate = new Date();
					celldate.setTime(rows['DDATE']);
					var _date = celldate.format_tmp('yyyy-MM-dd');
        			var _to = '${contextPath}/sys/sysuser/home#page/clientCharts?clientno='+rows.CLIENTNO
        					+ '&date=' + _date + '&btn=' + btn + '&meterid=' + rows.METERID;
        			return a_str = '<a href="' + _to + '">' + roundNum(cel,op,rows) + '</a>';
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
        			height : 370,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['小区编号','楼宇','单元','楼层', '小区名称','用户编号', '门牌号','集中器地址','通道号', '热表号', '是否停热', '热表状态'
        			            
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
			        				width : 100,
			        				search : false
			        			},
      			              {
        	        				name : 'CLIENTNO',//用户编号
        	        				index : 'CLIENTNO',//过滤里面的field
        	        				label : '用户编号',
        	        				width : 80,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}, {
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌 号',
        	        				width : 130,
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.BNAME+'-'+rowObject.UNITNO+'单元'+rowObject.DOORNAME;
        	        				},
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}, {
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
			        			},{
        	        				name : 'METERID',//热表号
        	        				index : 'METERID',
        	        				label : '热表号',
        	        				width : 100,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},{
        	        				name : 'SFTR',//热表号
        	        				index : 'SFTR',
        	        				label : '供热状态',
        	        				width : 100,
        	        				search : true,
        	        				stype:'select',
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.SFTR;
        	        				},
        	        				searchoptions:{
        	        				
    			        					dataInit:function(elem){
    					            			 var opt = '<option value="" >请选择</option>' 
    					            				        +'<option value="未停热" >未停热</option>'
    					            			 			+ '<option value="已停热" >已停热</option>';
    					            			 
    					            			 $(elem).append(opt);
    					            			
    					         			},
    			        					sopt:['eq']
    			        				}
        	        				
        	        			}, {
			        				name : 'MSNAME',//热表状态
			        				index : 'MSNAME',
			        				label : '热表状态',
			        				width : 100,
			        				search : false
			        			}, {
			        				name : 'METERGL',//瞬时热量
			        				index : 'METERGL',
			        				formatter: function(cel,op,objs){return _forword(cel,op,objs,'MeterGL');},
			        				width : 100,
			        				search : false
			        			}, {
			        				name : 'METERNLLJ',//累计热量
			        				index : 'METERNLLJ',
									formatter: roundNum,
									width : 100,
			        				search : false
			        			}, {
			        				name : 'METERLS',//瞬时流量
			        				index : 'METERLS',
			        				//formatter: roundNum,
			        				formatter: function(cel,op,objs){return _forword(cel,op,objs,'MeterLS');},
			        				width : 100,
			        				search : false
			        			}, {
			        				name : 'METERTJ',//累计流量
			        				index : 'METERTJ',
			        				formatter: roundNum,
			        				width : 100,
			        				search : false
			        			}, {
			         				name : 'METERJSWD',//进水温度
			        				index : 'METERJSWD',
			        				formatter: function(cel,op,objs){return _forword(cel,op,objs,'MeterJSWD');},
			        				width : 100,
			        				search : false
			        			}, {
			         				name : 'METERHSWD',//回水温度
			        				index : 'METERHSWD',
			        				label : '回水温度',
			        				formatter: function(cel,op,objs){return _forword(cel,op,objs,'MeterHSWD');},
			        				width : 100,
			        				search : false
			        			}, {
			         				name : 'METERWC',//温差
			        				index : 'METERWC',
			        				label : '温差',
			        				formatter: function(cel,op,objs){return _forword(cel,op,objs,'MeterWC');},
			        				width : 100,
			        				search : false
			        			}, {
			         				name : 'COUNTHOUR',//时数
			        				index : 'COUNTHOUR',
			        				label : '时数',
			        				width : 100,
			        				searchoptions : {
			        					sopt : ['eq']
			        				},
			        				search : false
			        			}, {
			        				name : 'DDATE',//时间
			        				index : 'DDATE',
			        				label : '日期',
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
			
			        				width : 150,
			        				search : true
			        			}, {
			        				name : 'AUTOID',//抄表批次
			        				index : 'AUTOID',
			        				label : '抄表批次',
			        				width : 70,
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
			        			shrinkToFit:false,
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
        			edit : <shiro:hasPermission name="${ROLE_KEY}:todaydata:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:edit">false</shiro:lacksPermission>,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : <shiro:hasPermission name="${ROLE_KEY}:todaydata:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:add">false</shiro:lacksPermission>,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : <shiro:hasPermission name="${ROLE_KEY}:todaydata:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:delete">false</shiro:lacksPermission>,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : <shiro:hasPermission name="${ROLE_KEY}:todaydata:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:search">false</shiro:lacksPermission>,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : <shiro:hasPermission name="${ROLE_KEY}:todaydata:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:view">false</shiro:lacksPermission>,
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
        		if(<shiro:hasPermission name="${ROLE_KEY}:todaydata:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:todaydata:export">false</shiro:lacksPermission>){
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
        });
</script>
