<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />

<div class="row">
	<div class="col-xs-12">
		<div id="da-search"></div>
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div>
</div>


<script type="text/javascript">
	var scripts = [ null,
			"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js",
			"${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
			null ]
	$('.page-content-area')
			.ace_ajax(
					'loadScripts',
					scripts,
					function() {
						// inline scripts related to this page
						jQuery(function($) {
							var da_search = "#da-search";
							var grid_selector = "#grid-table";
							var pager_selector = "#grid-pager";
							var _factoryid;
							// resize to fit page size
							$(window).on(
									'resize.jqGrid',
									function() {
										$(grid_selector).jqGrid('setGridWidth',
												$(".page-content").width());
									})
							// resize on sidebar collapse/expand
							var parent_column = $(grid_selector).closest(
									'[class*="col-"]');
							$(document)
									.on(
											'settings.ace.jqGrid',
											function(ev, event_name, collapsed) {
												if (event_name === 'sidebar_collapsed'
														|| event_name === 'main_container_fixed') {
													// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
													setTimeout(
															function() {
																$(grid_selector)
																		.jqGrid(
																			'setGridWidth',
																				parent_column
																						.width());
															}, 0);
												}
											})

							var template1 = {
								"groupOp" : "AND",
								"rules" : [ {
									"field" : "AREAGUID",
									"op" : "eq",
									"data" : ""
								}, {
									"field" : "AREANAME",
									"op" : "cn",
									"data" : ""
								},

								]
							};

							function emptyAndReset(e) {
								e.empty();
								e.append("<option value=''>请选择</option>").attr(
										"selected", true).change();
							}

							jQuery(grid_selector)
									.jqGrid(
											{
												subGrid : false,
												url : "${contextPath}/baseinfomanage/areainfo/getallareainfo",
												datatype : "json",
												height : 450,
												colNames : [ '小区编号', '小区编号',
														'小区名称', '地址', '联系人',
														'联系电话', '小区概况',
														'所属分公司', '所属换热站' ],
												colModel : [
														{
															hidden : true,
															name : 'AREAGUID',
															index : 'AREAGUID',
															label : '小区编号',
															width : 120,
															editable : true

														},
														{
															name : 'AREAGUID',
															index : 'AREAGUID',
															label : '小区编号',
															width : 80,
															sorttype : "long",
															//searchoptions : {sopt : ['eq']},
															search : true
														},
														{
															name : 'AREANAME',
															index : 'AREANAME',
															label : '小区名称',
															width : 120,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "20"
															},
															//searchoptions : {sopt : ['cn']},
															editrules : {
																required : true
															}
														},
														{
															name : 'AREAPLACE',
															index : 'AREAPLACE',
															label : '地址',
															width : 160,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "200"
															},
															search : false

														},
														{
															name : 'LINKMAN',
															index : 'LINKMAN',
															label : '联系人',
															width : 110,
															editable : true,

															search : false
														},
														{
															name : 'TELEPHONE',
															index : 'TELEPHONE',
															label : '联系电话',
															width : 100,
															editable : true,
															editoptions : {
																size : "11",
																number : false
															},
															search : false
														},
														{
															name : 'SMEMO',
															index : 'SMEMO',
															label : '小区概况',
															width : 160,
															edittype : 'textarea',
															editable : true,

															search : false
														},
														{
															name : 'FACTORYNAME',
															index : 'FACTORYNAME',
															label : '所属分公司',
															width : 120,
															edittype : "select",
															editoptions : {
							       			            		
																dataUrl : "${contextPath}/baseinfomanage/areainfo/getFactoryname",
																dataEvents : [ {
																	type : 'change',
																	fn : function(e) {

																		_factoryid = $(e.target).val();

																		$.get('${contextPath}/baseinfomanage/areainfo/getSectionname?FACTORYID='+ _factoryid,function(data) {
																							
																							var response = jQuery.parseJSON(data);
																							var s = ' ';
																							if (response && response.length) {
																								for (var i = 0, l = response.length; i < l; i++) {
																									var ri = response[i];
																									s += '<option value="' + ri['SECTIONID'] + '">'+ ri['SECTIONNAME']+ '</option>';
																								}
																							}
																							var sel = $('#tr_SECTIONNAME select');
																							sel.empty()
																							sel.append(s);
																						});

																	}
																} ],	dataInit:function(elem){
							    			            			 
							    			         			},buildSelect:function(data){
							    			         				//var rowid = $(grid_selector).jqGrid('getGridParam','selrow');//获取选中行的ID
							    			         				//var rowData = $(grid_selector).jqGrid('getRowData',rowId);
							    			         				//var name=rowData.FACTORYNAME;
						        	        						var response = jQuery.parseJSON(data);
						        	        						var rowid = $("#grid-table").jqGrid('getGridParam','selrow');//获取选中行的ID
						        	        						var rowData = $("#grid-table").jqGrid('getRowData',rowid);
						        	        						var name="";
						        	        					      var s = '<option value="">请选择</option>';
						        	        					      if (response && response.length) {
						        	        					          for (var i = 0, l = response.length; i < l; i++) {
						        	        					           var ri = response[i];
						        	        					            if(ri["FACTORYNAME"]==rowData.FACTORYNAME){
						        	        					            	name=ri["FACTORYID"];
						        	        					            }
						        	        					           	   s += '<option value="' + ri['FACTORYID'] + '">' + ri['FACTORYNAME'] + '</option>';
						        	        					          }
						        	        					       }
						        	        					      s += "<script>$('select option[value=\""+name+"\"]').change().attr('selected',true);</sc"+"ript>  ";
							        	      	 					  var sel = $('#tr_FACTORYNAME select');
							        	      	 					  sel.append(s);
							        	      	        			 
						        	        				     }

															},
															editable : true,
															editrules : {
																required : true
															},
															search : false
														},
														{
															name : 'SECTIONNAME',
															index : 'SECTIONNAME',
															label : '所属换热站',
															width : 120,
															edittype : "select",
															editable : true,
															editrules : {
																required : true
															},
															editoptions:{value:{'':''}},
															search : false
														} ],
												//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
												sortname : "AREAGUID",
												sortorder : "asc",
												viewrecords : true,
												rowNum : 10,
												rowList : [ 10, 20, 30 ],
												pager : pager_selector,
												altRows : true,
												toppager : true,
												multiselect : true,
												multiboxonly : true,
												ondblClickRow: function(rowid){
							        				jQuery(grid_selector).viewGridRow(rowid,{});
							        			},
												loadComplete : function() {
													var table = this;
													setTimeout(
															function() {
																styleCheckbox(table);
																updateActionIcons(table);
																updatePagerIcons(table);
																enableTooltips(table);
															}, 0);
												},
												editurl : "${contextPath}/baseinfomanage/areainfo/operateareainfo"

											});

							$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

							function aceSwitch(cellvalue, options, cell) {
								setTimeout(
										function() {
											$(cell)
													.find(
															'input[type=checkbox]')
													.addClass(
															'ace ace-switch ace-switch-5')
													.after(
															'<span class="lbl"></span>');
										}, 0);
							}

							// navButtons
							jQuery(grid_selector)
									.jqGrid(
											'navGrid',
											pager_selector,
											{ // navbar options
												edit : <shiro:hasPermission name="${ROLE_KEY}:areaedit:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:edit">false</shiro:lacksPermission>,
												editicon : 'ace-icon fa fa-pencil blue',
												add : <shiro:hasPermission name="${ROLE_KEY}:areaedit:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:add">false</shiro:lacksPermission>,
												addicon : 'ace-icon fa fa-plus-circle purple',
												del : <shiro:hasPermission name="${ROLE_KEY}:areaedit:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:delete">false</shiro:lacksPermission>,
												delicon : 'ace-icon fa fa-trash-o red',
												search : <shiro:hasPermission name="${ROLE_KEY}:areaedit:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:search">false</shiro:lacksPermission>,
												searchicon : 'ace-icon fa fa-search orange',
												refresh : false,
												refreshicon : 'ace-icon fa fa-refresh blue',
												view : <shiro:hasPermission name="${ROLE_KEY}:areaedit:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:view">false</shiro:lacksPermission>,
												viewicon : 'ace-icon fa fa-search-plus grey'
											},
											{
												// edit record form
												// closeAfterEdit: true,
												// width: 700,
												closeAfterEdit : true,
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_edit_form(form);
												},
												errorTextFormat : function(
														response) {
													var result = eval('('
															+ response.responseText
															+ ')');
													return result.message;
												}
											},
											{
												// new record form
												// width: 700,
												closeAfterAdd : true,
												recreateForm : true,
												viewPagerButtons : false,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_edit_form(form);
												},
												errorTextFormat : function(
														response) {
													var result = eval('('
															+ response.responseText
															+ ')');
													return result.message;
												}
											},
											{
												// delete record form
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													if (form.data('styled'))
														return false;
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_delete_form(form);
													form.data('styled', true);
												},
												onClick : function(e) {
													// alert(1);
												}
											},
											{
												// search form
												recreateForm : true,
												closeAfterSearch : true,
												tmplNames : [ '' ],
												tmplFilters : [ template1 ],
												tmplLabel : "",

												afterShowSearch : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-title')
															.wrap(
																	'<div class="widget-header" />')
													style_search_form(form);
												},
												afterRedraw : function() {
													style_search_filters($(this));
												},
												multipleSearch : true
											/**
											 * multipleGroup:true, showQuery: true
											 */
											},
											{
												// view record form
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-title')
															.wrap(
																	'<div class="widget-header" />')
												}
											})

							// add custom button to export the data to excel
							if (<shiro:hasPermission name="${ROLE_KEY}:areaedit:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:areaedit:export">false</shiro:lacksPermission>) {
								jQuery(grid_selector)
										.jqGrid(
												'navButtonAdd',
												pager_selector,
												{
													caption : "",
													title : "导出Excel",
													buttonicon : "ace-icon fa fa-file-excel-o green",
													onClickButton : function() {
														/* var keys = [], ii = 0, rows = "";
														var ids = $(grid_selector).getDataIDs(); // Get All IDs
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
														var form = "<form name='csvexportform' action='${contextPath}/sys/department/operateDepartment?oper=excel' method='post'>";
														form = form
																+ "<input type='hidden' name='csvBuffer' value='"
																+ encodeURIComponent(1)
																+ "'>";
														form = form
																+ "</form><script>document.csvexportform.submit();</sc" + "ript>";
														OpenWindow = window
																.open('', '',
																		'width=200,height=100');
														OpenWindow.document
																.write(form);
														OpenWindow.document
																.close();
													}
												});
							}

							function style_edit_form(form) {
								// form.find('input[name=statusCn]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
								// don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
								// .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

								// update buttons classes
								var buttons = form.next().find(
										'.EditButton .fm-button');
								buttons.addClass('btn btn-sm').find(
										'[class*="-icon"]').hide();// ui-icon, s-icon
								buttons.eq(0).addClass('btn-primary').prepend(
										'<i class="ace-icon fa fa-check"></i>');
								buttons.eq(1).prepend(
										'<i class="ace-icon fa fa-times"></i>')

								buttons = form.next().find('.navButton a');
								buttons.find('.ui-icon').hide();
								buttons
										.eq(0)
										.append(
												'<i class="ace-icon fa fa-chevron-left"></i>');
								buttons
										.eq(1)
										.append(
												'<i class="ace-icon fa fa-chevron-right"></i>');
							}

							function style_delete_form(form) {
								var buttons = form.next().find(
										'.EditButton .fm-button');
								buttons.addClass(
										'btn btn-sm btn-white btn-round').find(
										'[class*="-icon"]').hide();// ui-icon, s-icon
								buttons
										.eq(0)
										.addClass('btn-danger')
										.prepend(
												'<i class="ace-icon fa fa-trash-o"></i>');
								buttons.eq(1).addClass('btn-default').prepend(
										'<i class="ace-icon fa fa-times"></i>')
							}

							function style_search_filters(form) {
								form.find('.delete-rule').val('X').hide();
								form.find('.add-rule').addClass(
										'btn btn-xs btn-primary').hide();
								form.find('.add-group').addClass(
										'btn btn-xs btn-success');
								form.find('.delete-group').addClass(
										'btn btn-xs btn-danger').hide();
							}
							function style_search_form(form) {

								var dialog = form.closest('.ui-jqdialog');
								var buttons = dialog.find('.EditTable');
								buttons
										.find(
												'.EditButton select[class="ui-template"] option[value="default"]')
										.attr("selected", false);
								buttons
										.find(
												'.EditButton select[class="ui-template"] option[value!="default"]')
										.attr("selected", true).change();//还需要再多加上一个change来触发
								buttons
										.find(
												'.EditButton select[class="ui-template"]')
										.hide();
								form.find('select[class="opsel"]').remove();
								form.find('.searchFilter table').remove()/* attr('align','center') */;
								/* console.log(form.find('.searchFilter table')); */
								buttons.find('.EditButton a[id*="_reset"]')
										.hide().addClass('btn btn-sm btn-info')
										.find('.ui-icon').attr('class',
												'ace-icon fa fa-retweet');
								buttons.find('.EditButton a[id*="_query"]')
										.addClass('btn btn-sm btn-inverse')
										.find('.ui-icon').attr('class',
												'ace-icon fa fa-comment-o');
								buttons.find('.EditButton a[id*="_search"]')
										.addClass('btn btn-sm btn-purple')
										.find('.ui-icon').css('class',
												'ace-icon fa fa-search');

								form.find('.columns select').attr('disabled',
										'disabled');
								form.find('.operators select').attr('disabled',
										'disabled');

							}

							function beforeDeleteCallback(e) {
								var form = $(e[0]);
								if (form.data('styled'))
									return false;
								form.closest('.ui-jqdialog').find(
										'.ui-jqdialog-titlebar').wrapInner(
										'<div class="widget-header" />')
								style_delete_form(form);
								form.data('styled', true);
							}

							function beforeEditCallback(e) {
								var form = $(e[0]);
								form.closest('.ui-jqdialog').find(
										'.ui-jqdialog-titlebar').wrapInner(
										'<div class="widget-header" />')
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
								$(
										'.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
										.each(
												function() {
													var icon = $(this);
													var $class = $.trim(icon
															.attr('class')
															.replace('ui-icon',
																	''));

													if ($class in replacement)
														icon
																.attr(
																		'class',
																		'ui-icon '
																				+ replacement[$class]);
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
							$(pager_selector + ' #grid-pager_left span').css({
								'text-indent' : 0
							}//否则不显示
							);
							$(pager_selector + ' #grid-pager_left span').css({'text-indent':0});
							var navTable = $(pager_selector + ' #grid-pager_left').clone(true);
							$(pager_selector + ' #grid-pager_left').empty();
			     			$('#grid-table_toppager_left').append(navTable);
			     			$('#grid-table_toppager_left').append(_go_back);
			     			$(window).triggerHandler('resize.jqGrid');
						});
					});
</script>
