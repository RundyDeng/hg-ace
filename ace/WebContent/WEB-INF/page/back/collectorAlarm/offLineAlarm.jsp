<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%
String today=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
%>
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
<div class="row">
	<div class="col-xs-12">
		<div id="sel_dialog" style="display : none;">
			<p></p>
			<p>小区：<select id="areainfo" style="width: 50%;"></select></p>
		</div>
		<div id="da-search"></div>
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div>
</div>

<script type="text/javascript">
		var scripts = [ null
		                ,"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"
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
        		var roundNum = function(cellvalue, options, rowObject){
        			if(cellvalue==0||cellvalue==undefined)
        				return 0;
					return cellvalue.toFixed(2);
				}
        		var _areaguid,_buildno,_unitno,_floorno,_sfdx;
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": ""} , 
									 
        				           	 { "field": "ISYES", "op": "eq", "data": ""} , 
        				           /*   { "field": "ALL","op": "eq","data":""}  */
        				         ] 
        		};
        		function getSelectElement(val){
        			if(val!=='undefined')
        				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
        		}
        		function emptyAndReset(e){
        			e.empty();
        			e.append("<option value=''>请选择</option>").attr("selected",true).change();
        		}
        		
        	//	var checkSearch = false; //1022
				var flag = true;
				//var dataGrid =  20171022
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/collectorAlarm/offLineAlerm/getOffLineSearch",
        			datatype : "json",
        			mtype: 'POST',
        			height : 450,
        			rownumbers:true,
        			colNames : ['小区名',
        			            ' 小区名称','安装位置','设备DTU号','是否在线','最后一次在线时间'
								],
        			colModel : [{
        							hidden:true,
	       			            	label:'小区名',
	       			            	name:'AREAGUID',
	       			            	search:true,
	       			            	stype:'select',
	       			            	width: 300,
	       			            	searchoptions : {
	       			            		searchhidden:true,
       			            		 	sopt : ['eq'],
       			            		 	dataUrl:'${contextPath}/sys/todaydata/getAreaDownList',
	       			            		
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
	        	        					      var sel = getSelectElement("AREAGUID");
	        	        					      _areaguid = areaguid;
	        	        					      sel.empty().append(s).val(areaguid).find('option[value='+areaguid+']').change();
        	        				     }
	       			            	}
        			            },
				        			{
				        				label : '小区名称',
				        			//	align:'center',
										formatter:function(c,o,r){
											return r.AREANAME;
										},
										width : 300
				        		} ,{
        	        				name : 'DADDRESS',
        	        				index :'DADDRESS',
        	        				label : '安装位置 ',
        	        			//	align:'center',
        	        				width: 300
        	        			},
				        		{
        	        				name : 'GPRSID',
        	        				index :'GPRSID',
        	        				label : '设备DTU号 ',
        	        			//	align:'center',
        	        				width: 300
        	        			},{
        	        				
        	        				name : 'ISYES',
        	        				index :'ISYES',
        	        				label : '是否在线 ',
        	        				sortable : false,
        	        				width: 300,
        	        				search:true,
        	        			//	align:'center', 
        	        		 		cellattr: addCellAttr,
        	        				stype:'select',
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.ISYES;
        	        				}, 
        	        				searchoptions:{
    			        					dataInit:function(elem){
    					            			 var opt = '<option value="" >请选择</option>' 
    					            				        +'<option value="在线" >在线</option>'
    					            			 			+ '<option value="不在线" >不在线</option>';
    					            			 
    					            			 $(elem).append(opt);
    					            			
    					         			},
    			        					sopt:['eq']
    			        				}
        	        			},{
        	        				name : 'ZXDATE',
        	        				index :'ZXDATE',
        	        				label : '最后一次在线时间 ',
        	        			//	align:'center',
        	        				width: 300
        	        			}],
        	        			
        			sortname : "AREANAME,DADDRESS",
        			sortorder : "asc",
        			shrinkToFit : true,//201722
        			viewrecords : true,
        			rowNum : 20,
        			rowList : [ 10, 20, 30 ],
        			pager : pager_selector,
        			altRows : true,
        			toppager : true,
        	     //   multiboxonly : true,//1022
        	        ondblClickRow: function(rowid){
        				jQuery(grid_selector).viewGridRow(rowid,{});
        			},
        	        loadComplete : function(data) {
        				if(data.rows==null||data.rows.length==0)
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
        			/*  beforeRequest: function(){
        			}, */
        		//	editurl : "${contextPath}/monitordata/meterconditioncontr/updatemetercondition?areaguid="+_areaguid
        		});
        	//	$(window).triggerHandler('resize.jqGrid');// 
        		
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
        			},
        			onClick : function(e) {
        			}
        		}, {
        			recreateForm : true,
        			tmplNames : ['多条件查询'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			closeAfterSearch : true,  //修改搜索页面20171022  点击搜索直接关闭窗口
        			searchOnEnter: true,
        			closeOnEscape:true,
        			/* onSearch:function(){
        				var sel = getSelectElement("是否在线");
        				if(sel.val()==''){
        					alert("请选择是否在线！");
        					return false;
        				}else{
        					_sfdx = sel.find('option[value="'+sel.val()+'"]').text();
        					jQuery(grid_selector).jqGrid("setGridParam", {
                			    postData: { sfdx: _sfdx }
                			})
        					 jQuery(grid_selector).jqGrid({
        						ajaxOptions: {
        							"sfdx": _sfdx
        						},
        						 postData: {    
        	        			     sfdx: _sfdx
        	        			}
        					}).addJSONData("{aa:11}");   
        				} 
        				checkSearch = true
        				$('.ui-jqdialog-titlebar-close.ui-corner-all')[0].click();
        			},*/
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
        		
        		if(true){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",//按钮名称
   				       title : "导出Excel",//按钮的提示信息 
   				       buttonicon : "ace-icon fa fa-file-excel-o green", //按钮的图标，必须为UI theme图标 
   				       onClickButton : function () { 
   				    	 
   				    	   var form = "<form name='csvexportform' action='${contextPath}/collectorAlarm/offLineAlerm/updateOffLineSearch?oper=excel' method='post'>";
   				    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
   				    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
   				    	   OpenWindow = window.open('', '','width=200,height=100');//打开一个新的浏览器窗口或查找一个已命名的窗口。
   				    	   OpenWindow.document.write(form);//向文档写 HTML 表达式 或 JavaScript 代码。
   				    	   OpenWindow.document.close();//关闭用 document.open() 方法打开的输出流，并显示选定的数据。  
   				    	   setTimeout("OpenWindow.close()",10000);
   				    	   //OpenWindow.close();
   				       } 
   					});
        		}
        		/* 字段内容颜色 */
        		function addCellAttr(rowId, val, rawObject, cm, rdata) {
                     if(rawObject.ISYES == "在线" ){
                        return "style='color:green'";
                    } 
                    if(rawObject.ISYES == "不在线" ){
                        return "style='color:red'";
                    }
                }
        		
        		function submitExcel(){
       				var areaguid = $('#areainfo').val();
       				var form = "<form name='csvexportform' action='${contextPath}/collectorAlarm/offLineAlerm/updateOffLineSearch?oper=excel&areaguid="+areaguid+"' method='post'>";
					   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
			    	   form = form + "</form><script>document.getElementById('export_excel').contentWindow.document.getElementsByTagName('form')[0].submit();</sc" + "ript>";
			    	   var childDom = document.getElementById('export_excel').contentWindow.document.getElementsByTagName('body');
			    	   $(childDom).empty().append(form).empty();
       			 
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
</script>



