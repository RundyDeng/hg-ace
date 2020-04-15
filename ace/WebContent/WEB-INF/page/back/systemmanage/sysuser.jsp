<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />

<div class="row">
	<div class="col-xs-12">
	<!-- <div id="mysearch"></div> -->
		<table id="grid-table"></table>

		<div id="grid-pager"></div>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
		var scripts = [ null, /* "${contextPath}/static/assets/js/date-time/bootstrap-datepicker.js", 
		                "${contextPath}/static/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js", */
		                "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js",
		                 "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		                //, "${contextPath}/static/assets/js/jqGrid/grid.addons.js"
		                "${contextPath}/static/assets/js/jquery-ui.js", null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	// inline scripts related to this page
        	jQuery(function($) {
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";

        		// resize to fit page size
        		$(window).on('resize.jqGrid', function() {
        			$(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
        		})
        		// resize on sidebar collapse/expand
        		var parent_column = $(grid_selector).closest('[class*="col-"]');
        		$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
        			if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
        				// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
        				setTimeout(function() {
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		})
        		
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "userName", "op": "cn", "data": "" } , 
									 { "field": "email", "op": "eq", "data": "" } ,
        				         ] 
        		};
        		
				
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/sys/sysuser/getSysUser",
        			datatype : "json",
        			height : 450,
        			colNames : ['', 'ID', '姓名', '性别', '邮箱', '联系电话', '生日', '所属部门', '角色', '是否禁用', '最后登录时间'],
        			colModel : [ {
        				name : '',
        				index : '',
        				width : 80,
        				fixed : true,
        				sortable : false,
        				resize : false,
        				formatter : 'actions',
        				formatoptions : {
        					keys : true,
        					//delbutton : false,//disable delete button
        					delOptions : {
        						recreateForm : true,
        						beforeShowForm : beforeDeleteCallback
        					}
        					//editformbutton:true, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
        				}
        			}, {
        				name : 'id',
        				index : 'id',
        				label : 'ID',
        				key : true,
        				width : 60,
        				sorttype : "long",
        				search : false
        			}, {
        				name : 'userName',
        				index : 'userName',
						label : '姓名',
        				width : 100,
        				editable : true,
        				editoptions : {size : "20", maxlength : "50"},
        				editrules : {required : true},
        				//searchtype:"integer",似乎不存在这个属性,还是我搞错了
        				//searchoptions : {sopt : ['cn']}
        				
        			}, {
        				name : 'sexCn',
        				index : 'sex',
        				label : '性别',
        				width : 80,
        				editable : true,
        				edittype : "select",
        				editoptions : {value : "1:男;2:女"},
        				search : false
        			}, {
        				name : 'email',
        				index : 'email',
        				label : '邮箱',
        				width : 160,
        				editable : true,
        				editoptions : {size : "20", maxlength : "30"},
        				//searchoptions : {sopt : ['eq']},
        				editrules : {required : true}
        			}, {
        				name : 'phone',
        				index : 'phone',
        				label : '联系电话',
        				width : 110,
        				editable : true,
        				editoptions : {size : "20", maxlength : "20"},
        				search : false
        			}, {
        				name : 'birthday',
        				index : 'birthday',
        				label : '生日',
        				width : 110,
        				editable : true,
        				readonly : true,
        				search : false,
        				sorttype : 'date',
        				unformat : pickDate
        			}, {
        				name : 'departmentValue',
        				index : 'departmentKey',
        				label : '所属部门',
        				width : 120,
        				editable : true,
        				edittype : "select",
        				//editoptions : {value : "YFB:研发部;XZB:行政部"},
        				editoptions : {
        					dataUrl : "${contextPath}/sys/department/getDepartmentSelectList"
        				},
        				search : false
        			}, {
        				name : 'roleCn',
        				index : 'role',
        				label : '角色',
        				width : 100,
        				editable : true,
        				edittype : "select",
        				//editoptions : {value : "ROLE_ADMIN:超级管理员;ROLE_RESTRICTED_ADMIN:普通管理员;ROLE_USER:普通用户"},
        				editoptions : {
        					dataUrl : "${contextPath}/sys/role/getRoleSelectList"
        				},
        				search : false
        			}, {
        				name : 'statusCn',
        				index : 'status',
        				label : '是否禁用',
        				width : 80,
        				editable : true,
        				edittype : "checkbox",
        				editoptions : {value : "是:否"},
        				unformat : aceSwitch,
        				search : false
        			}, {
        				name : 'lastLoginTime',
        				index : 'lastLoginTime',
        				label : '最后登录时间',
        				width : 150,
        				sorttype : "date",
        				search : false
        			} ],
        			//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
        			sortname : "id",
        			sortorder : "asc",
        			viewrecords : true,
        			rowNum : 10,
        			rowList : [ 10, 20, 30 ],
        			pager : pager_selector,
        			altRows : true,
        			//toppager : true,
        			multiselect : true,
        			//multikey : "ctrlKey",
        	        multiboxonly : true,
        	        ondblClickRow: function(rowid){
        				jQuery(grid_selector).viewGridRow(rowid,{});
        			},
        			loadComplete : function() {
        				var table = this;
        				setTimeout(function(){
        					styleCheckbox(table);
        					updateActionIcons(table);
        					updatePagerIcons(table);
        					enableTooltips(table);
        				}, 0);
        			},
        			editurl : "${contextPath}/sys/sysuser/operateSysUser"
        			//caption : "用户管理列表",
        			//autowidth : true,
        			/**
        			grouping : true, 
        			groupingView : { 
        				 groupField : ['name'],
        				 groupDataSorted : true,
        				 plusicon : 'fa fa-chevron-down bigger-110',
        				 minusicon : 'fa fa-chevron-up bigger-110'
        			},
        			*/
        		});
        		
				
/*         	jQuery("#mysearch").jqGrid('filterGrid',grid_selector,{
    			
    			gridModel:true,
    			formtype:'horizontal'
    			
    		});  */
        		$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size
        		
        		// enable search/filter toolbar
        		// jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
        		// jQuery(grid_selector).filterToolbar({});
        		// switch element when editing inline
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		
        		// enable datepicker
        		//1.日期值  2015-02-11,   2. rowId:以及 当前colModel对象    3. 当前html单元格
          		function pickDate(cellvalue, options, cell) {
        			
        			setTimeout(function() {
        				$(cell).find('input[type=text]').datepicker({
        					dateFormat: 'yy-mm-dd',
        					/* format : 'yyyy-mm-dd',
        					autoclose : true,
        				    language: 'zh-CN' */
        				});
        			}, 0);
        		}
        		
          		
        		
        		// navButtons
        		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { // navbar options
        			edit : <shiro:hasPermission name="${ROLE_KEY}:sysuser:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:edit">false</shiro:lacksPermission>,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : <shiro:hasPermission name="${ROLE_KEY}:sysuser:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:add">false</shiro:lacksPermission>,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : <shiro:hasPermission name="${ROLE_KEY}:sysuser:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:delete">false</shiro:lacksPermission>,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : <shiro:hasPermission name="${ROLE_KEY}:sysuser:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:search">false</shiro:lacksPermission>,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : <shiro:hasPermission name="${ROLE_KEY}:sysuser:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:view">false</shiro:lacksPermission>,
        			viewicon : 'ace-icon fa fa-search-plus grey'
        		}, {
        			// edit record form
        			// closeAfterEdit: true,
        			// width: 700,
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
        				//console.log(e)//e为表单部分
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
        			recreateForm : false,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				if (form.data('styled'))
        					return false;
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_delete_form(form);
        				form.data('styled', true);
        			},
        			onClick : function(e) {
        				// alert(1);
        			}
        		}, {
        			// search form
        			
        			////when set to true the form is recreated every time the search dialog is activated with the new options from colModel (if they are changed)
        			recreateForm : false,//没发现作用
        			closeAfterSearch : true,
        			//回车搜索
        			searchOnEnter: true,
					//按esc键，退出查询对话框
        			closeOnEscape:true,

        			tmplNames : ['模板'],
        			tmplFilters : [template1],
        			tmplLabel : "",
        			//加载页面时自动弹出搜索查询框
        			//showOnLoad:true,
        			
        			//每次点击查询对话框按钮 触发.
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function() {
        				
        				style_search_filters($(this));
        			},
        			multipleSearch : true 
	        		/**
	        		 * multipleGroup:true, showQuery: true
	        		 */
        		}, {
        			// view record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		})
        		
        		// add custom button to export the data to excel
        		if(<shiro:hasPermission name="${ROLE_KEY}:sysuser:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:export">false</shiro:lacksPermission>){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",//按钮名称
   				       title : "导出Excel",//按钮的提示信息 
   				       buttonicon : "ace-icon fa fa-file-excel-o green", //按钮的图标，必须为UI theme图标 
   				       onClickButton : function () { 
   				    	   /* var keys = [], ii = 0, rows = "";
   				    	   var ids = $(grid_selector).getDataIDs(); // Get All IDs  这个ids就是colmodel里的key : true
   				    	   var row = $(grid_selector).getRowData(ids[0]); // Get First row to get the labels
   				    	   
   				    	   //var label = $(grid_selector).jqGrid('getGridParam','colNames');
   	   			    	   for (var k in row) {
   				    	   	   keys[ii++] = k; // capture col names
   				    	   	   var kv = $('#jqgh_grid-table_' + k).text();
				    	   	   rows = rows + kv + "\t";
   				    	   }
   				    	   rows = rows + "\n"; // Output header with end of line
   				    	   for (i = 0; i < ids.length; i++) {
   				    	   	   row = $(grid_selector).getRowData(ids[i]); // get each row
   				    	   	   for (j = 0; j < keys.length; j++)
   				    	   		   rows = rows + row[keys[j]] + "\t"; // output each Row as tab delimited
   				    	   	   rows = rows + "\n"; // output each row with end of line
   				    	   }
   				    	   rows = rows + "\n"; // end of line at the end */
   				    	   var form = "<form name='csvexportform' action='${contextPath}/sys/sysuser/operateSysUser?oper=excel' method='post'>";
   				    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
   				    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
   				    	   OpenWindow = window.open('', '','width=200,height=100');//打开一个新的浏览器窗口或查找一个已命名的窗口。
   				    	   OpenWindow.document.write(form);//向文档写 HTML 表达式 或 JavaScript 代码。
   				    	   OpenWindow.document.close();//关闭用 document.open() 方法打开的输出流，并显示选定的数据。  
   				    	   setTimeout("OpenWindow.close()",1800000);
   				    	   //OpenWindow.close();
   				       } 
   					});
        		}
        		
        		function style_edit_form(form) {
        			// enable datepicker on "birthday" field and switches for "stock" field
        			form.find('input[name=birthday]').datepicker({
        				format : 'yyyy-mm-dd',
        				autoclose : true,
        			    language: 'zh-CN'
        			})

        			form.find('input[name=statusCn]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			// don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
        			// .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

        			// update buttons classes
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
        			form.find('.searchFilter table').remove()/* attr('align','center') */;
        			/* console.log(form.find('.searchFilter table')); */
        			buttons.find('.EditButton a[id*="_reset"]').hide().addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
        			buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
        			buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').css('class', 'ace-icon fa fa-search');
        		
        			form.find('.columns select').attr('disabled','disabled'); 
        			form.find('.operators select').attr('disabled','disabled');
        		
        		}
        		
/*         		function style_search_filters(form) {
        			form.find('.delete-rule').val('X');
        			form.find('.add-rule').addClass('btn btn-xs btn-primary');
        			form.find('.add-group').addClass('btn btn-xs btn-success');
        			form.find('.delete-group').addClass('btn btn-xs btn-danger');
        		}
        		function style_search_form(form) {
        			
        			var dialog = form.closest('.ui-jqdialog');
        			var buttons = dialog.find('.EditTable')
        			buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
        			buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
        			buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
        		} */

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

        		// it causes some flicker when reloading or navigating grid
        		// it may be possible to have some custom formatter to do this as the grid is being created to prevent this
        		// or go back to default browser checkbox styles for the grid
        		function styleCheckbox(table) {
        			/**
        			 * $(table).find('input:checkbox').addClass('ace') .wrap('<label />') .after('<span class="lbl align-top" />') $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
        			 * .find('input.cbox[type=checkbox]').addClass('ace') .wrap('<label />').after('<span class="lbl align-top" />');
        			 */
        		}

        		// unlike navButtons icons, action icons in rows seem to be hard-coded
        		// you can change them like this in here if you want
        		function updateActionIcons(table) {
        			/**
        			 * var replacement = { 'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue', 'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red', 'ui-icon-disk' : 'ace-icon fa fa-check green', 'ui-icon-cancel' :
        			 * 'ace-icon fa fa-times red' }; $(table).find('.ui-pg-div span.ui-icon').each(function(){ var icon = $(this); var $class = $.trim(icon.attr('class').replace('ui-icon', '')); if($class in replacement)
        			 * icon.attr('class', 'ui-icon '+replacement[$class]); })
        			 */
        		}

        		// replace icons with FontAwesome icons like above
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
        			$('.navtable .ui-pg-button').tooltip({
        				container : 'body'
        			});
        			$(table).find('.ui-pg-div').tooltip({
        				container : 'body'
        			});
        		}

        		// var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

        		$(document).one('ajaxloadstart.page', function(e) {
        			$(grid_selector).jqGrid('GridUnload');
        			$('.ui-jqdialog').remove();
        		});
        		
				
        		
        	});
        });
</script>