<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
<div class="row">
	<div class="col-xs-12">
<%
Calendar c = Calendar.getInstance();
String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
c.add(Calendar.DATE, -7);
String weekAgo = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());

%>
		<div id="sel_dialog" style="display : none;">
			<p> 选择小区：<select id="areainfo" style="width: 50%;"></select></p>
			<p>开始日期：<input  id="input_sel_date" type="text"  value="<%=weekAgo %>" readonly="readonly"></p>
			<p>结束日期：<input  id="input_sel_date2" type="text"  value="<%=today %>" readonly="readonly"></p>
		</div>
		<div id="da-search"></div>
	
		<table id="grid-table"></table>

		<div id="grid-pager"></div>

	</div>
</div>

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
        				// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
        				setTimeout(function() {
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		})
        		
        	
        		var _areaguid,_buildno,_unitno,_floorno;
/*          		var currentday7ago = new Date(new Date().setDate(new Date().getDate()-7)).toLocaleDateString().replace(/\//g,'-');
        		var currentday = new Date().toLocaleDateString().replace(/\//g,'-');  */
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
									 { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									 { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									 { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									 { "field": "DOORNO", "op": "eq", "data": "" } , //门牌
									 
									 
        				             { "field": "CLIENTNO", "op": "eq", "data": "" } , 
									 { "field": "METERID", "op": "eq", "data": ""},
									 { "field": "MSNAME", "op": "eq", "data": ""},
									 { "field": "COUNTHOUR", "op": "eq", "data": ""},
									 
									 { "field": "SFTR", "op": "eq", "data": ""},
									 { "field": "DDATE", "op": "ge", "data": "<%=weekAgo %>"},
									 { "field": "DDATE", "op": "le", "data": "<%=today %>"},
									 { "field": "AUTOID", "op": "eq", "data": ""}
        				         ] 
        		};
        		
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
        		
				var flag = true;
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/sys/hisdata/getHisdata",
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['小区编号','楼宇','单元','楼层',  '小区名称',   '用户编码', '门牌', '热表号', '用热状态','热表状态', '瞬时热量(kw)','累计热量(kwh)','瞬时流量(t/h)'
        			            ,'累计流量(t)','进水温度(℃)','回水温度(℃)','温差(℃)','时数','日期','抄表批次'], /*'门牌', '集中器地址','通道号','热表号', */
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
		        	        					    //var sel =  $('td[class="columns"]:has(option:selected[value="BUILDNO"]) ~ td[class="data"] select');
		        	        					    var sel = getSelectElement("BUILDNO");
		        	        					    //sel.find("option[value='']").attr("selected",true).change();
		        	        					    emptyAndReset(sel);	        	        					    
		        	        					    emptyAndReset(getSelectElement("UNITNO"));
		        	        					    emptyAndReset(getSelectElement("FLOORNO"));
		        	        					    emptyAndReset(getSelectElement("DOORNO"));
		        	        					    sel.append(s);  
			            		    			});
			            		    				 
			            		             }
			            			 	}],
       			            		 	dataInit:function(elem){//选择此元素为搜索条件时触发初始化
	    			            			 
	    			         			},
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
      			             	},{
        	        				name : 'AREANAME',//热表号
        	        				index : 'AREANAME',
        	        				label : '小区名称',
        	        				width : 100,
        	        			},{
        	        				name : 'CLIENTNO',//用户编号
        	        				index : 'CLIENTNO',//过滤里面的field
        	        				label : '用户编号',
        	        				width : 80,
        	        				sortable : false,
        	        				//sorttype : "date",//使用此类型排序当前列
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}, {
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌 ',
        	        				width : 130,
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.BNAME+'-'+rowObject.UNITNO+'单元'+rowObject.DOORNAME;
        	        				},
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}/* ,{
        	        				name : 'POOLADDR',//热表号
        	        				index : 'POOLADDR',
        	        				label : '集中器地址',
        	        				width : 100
        	        				
        	        			},{
        	        				name : 'MBUSID',//热表号
        	        				index : 'MBUSID',
        	        				label : '通道号',
        	        				width : 100,
        	        			} */, {
        	        				name : 'METERID',//热表号
        	        				index : 'METERID',
        	        				label : '热表号',
        	        				width : 100,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			}, {
        	        				name : 'SFTR',//热表号
        	        				index : 'SFTR',
        	        				label : '用热状态',
        	        				width : 80,
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
        	        				
        	        			},{
        	        				name : 'MSNAME',//热表状态
        	        				index : 'MSNAME',
        	        				label : '热表状态',
        	        				width : 100,
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					dataInit:function(elem){//选择此元素为搜索条件时触发初始化
	    			            			 var opt =  '<option value="" >请选择</option>'
	    			            				 		+ '<option value="未抄表" >未抄表</option>'
	    			            			 			+ '<option value="正常" >正常</option>'
	    			            			 			+ '<option value="终端无反应" >终端无反应</option>';
	    			            			 
	    			            			 $(elem).append(opt);
	    			            			
	    			         			},
        	        					sopt:['eq']
        	        				}
        	        			}, {
        	        				name : 'METERGL',//瞬时热量(kw)
        	        				index : 'METERGL',
        	        				label : '瞬时热量(kw)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERNLLJ',//累计热量(kwh)
        	        				index : 'METERNLLJ',
        	        				label : '累计热量(kwh)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERLS',//瞬时流量(t/h)
        	        				index : 'METERLS',
        	        				label : '瞬时流量(t/h)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERTJ',//累计流量(t)
        	        				index : 'METERTJ',
        	        				label : '累计流量(t)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERJSWD',//进水温度(℃)
        	        				index : 'METERJSWD',
        	        				label : '进水温度(℃)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERHSWD',//回水温度(℃)
        	        				index : 'METERHSWD',
        	        				label : '回水温度(℃)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'METERWC',//温差(℃)
        	        				index : 'METERWC',
        	        				label : '温差(℃)',
        	        				formatter: roundNum,
			        				width : 100,
        	        				search : false
        	        			}, {
        	        				name : 'COUNTHOUR',//时数
        	        				index : 'COUNTHOUR',
        	        				label : '时数',
        	        				width : 100,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},  {
        	        				name : 'DDATE',//时间
        	        				index : 'DDATE',
        	        				label : '日期',
        	        				sorttype : 'date',
        	        				formatter:"date",
        	        				formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'},
        	        				/* unformat : pickDate, */
        	        				stype:'text',
        	        				searchoptions : {
        	        					sopt : ['ge','le'],
        	        					dataInit :  function (elem) {
        	        						 
        	        						$(elem).datepicker({
        	                					format : 'yyyy-MM-dd',
        	                					autoclose : true
        	                				});
        	        						
        	        					}
        	        				},

        	        				width : 150,
        	        				search : flag
        	        			},{
        	        				name : 'AUTOID',//抄表批次
        	        				index : 'AUTOID',
        	        				label : '抄表批次',
        	        				width : 70,
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					dataInit:function(elem){//选择此元素为搜索条件时触发初始化
        	        						var opt =  	 '<option value="999" >全部</option>'
	    			            				 		+' <option value="1" >1</option>'
	    			            			            + '<option value="2" >2</option>';
	    			            			 
	    			            			 $(elem).append(opt);
	    			            			
	    			         			},
        	        					sopt:['eq']
        	        				}

        	        			}],
        			//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
        			sortname : "CLIENTNO",
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
        			}

        		});
        		
        		$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

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
        			// new record form
        			// width: 700,
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
        			// delete record form
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
        			// search form
        			recreateForm : true,
        			
        			tmplNames : ['多条件查询'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			
        			closeAfterSearch : true,
        			//回车搜索
        			searchOnEnter: true,
					//按esc键，退出查询对话框
        			closeOnEscape:true,
        			
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function() {
        				style_search_filters($(this));
        			},
        			//multipleGroup : true,
        			multipleSearch : true,
        			onSearch: _J_setAreaGuid
	        		
        		}, {
        			// view record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		})
        		
        		// add custom button to export the data to excel
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
   				    	    //height:150,
   				    	    modal: true,
	   				    	buttons: {
				   				          '导出': function() {
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
		   				    		defaultDate : new Date(),////这个没发现用处  难不成是默认？
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
								});
				   			}
   				    	});
   				    	   
   				       } 
   					});        			
        		}
        		
        		
        		function submitExcel(){
      			   var date1 = $("#input_sel_date").val();
      			   var date2 = $("#input_sel_date2").val();
      			   var areaguid = $('#areainfo').val();
      			   var autoid = $('#autoid').val();
    			   if(areaguid=='')
    				   return;
      			   $.get('${contextPath}/sys/hisdata/operateHisData?oper=excel&flag=1&date1='+date1+"&date2="+date2+"&areaguid=" + areaguid+"&autoid="+autoid,function(data){
      				   
      				   if(data==1){
      					   alert('此时间段没有数据！');
      				   }else{
      					   var form = "<form name='csvexportform' action='${contextPath}/sys/hisdata/operateHisData?oper=excel&&date1="+date1+"&date2="+date2+"&areaguid="+areaguid+"&autoid="+autoid+"' method='post'>";
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
        			/* console.log(form.find('.searchFilter table')); */
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

        		
        		function styleCheckbox(table) {
        			
        		}

        		
        		function updateActionIcons(table) {
        		
        		}

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
</script>
