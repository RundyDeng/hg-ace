<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" 
	href="${contextPath}/static/assets/css/datepicker.css" />

<%
Calendar c = Calendar.getInstance();
String sdate="";
String edate="";
int year=c.get(Calendar.YEAR);
int month=c.get(Calendar.MONTH);
if(month>10){
	sdate=year+"-10-15";
	edate=(year+1)+"-04-15";
}else{
	sdate=(year-1)+"-10-15";
	edate=year+"-04-15";
}
%>
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
			"${contextPath}/static/assets/js/jquery-ui.js",
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
							var title="换热站信息";
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
							$(document).on(
											'settings.ace.jqGrid',
											function(ev, event_name, collapsed) {
												if (event_name === 'sidebar_collapsed'
														|| event_name === 'main_container_fixed') {
													// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
													setTimeout(
															function() {
																$(grid_selector).jqGrid('setGridWidth',parent_column.width());
															}, 0);
												}
											})

							var template1 = {
								"groupOp" : "AND",
								"rules" : [ {
									"field" : "SECTIONID",
									"op" : "eq",
									"data" : ""
								}, {
									"field" : "SECTIONNAME",
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

							jQuery(grid_selector).jqGrid(
											{
												subGrid : false,
												url : "${contextPath}/baseinfomanage/FactorySectionInfo/getallfactorysection",
												datatype : "json",
												height : 450,
												colNames : [ 'id','操作','换热站编号','分公司名称','换热站编号', '换热站名称','换热站图片','供热年份','起始日期','结束日期' ],
												colModel : [ {
													name : 'SECTIONID',
													index:'SECTIONID',
													label:'主键',
													key : true,
													hidden : true
				        						}, {
							        				name : '',
							        				index : '',
							        				label : '操作',
							        				width : 80,
							        				viewable : false,
							        				fixed : true,
							        				sortable : false,
							        				resize : false,
							        				formatter : 'actions',
							        				formatoptions : {
							        					keys : true,
							        					delOptions : {
							        						recreateForm : true,
							        						beforeShowForm : beforeDeleteCallback
							        					}, 
							        					editOptions:{
							        						recreateForm: true, 
							        						beforeShowForm:beforeEditCallback
							        						},
							        				}
							        			},
							        			{
													name : 'SECTIONID',
													index:'SECTIONID',
													label:'换热站编号',
													editable : true,
													hidden : true
				        						},
														{
															name : 'FACTORYNAME',
															index : 'FACTORYNAME',
															label : '分公司名称',
															width : 80,
															sorttype : "long",
															editable : true,
															edittype : "select",
															editoptions : {
									        					dataUrl : "${contextPath}/baseinfomanage/FactorySectionInfo/getFactorySelectList"
									        				},
															search : false
														},
														{
															name : 'SECTIONID',
															index : 'SECTIONID',
															label : '换热站编号',
															width : 120,
															editable : false,
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
															name : 'SECTIONNAME',
															index : 'SECTIONNAME',
															label : '换热站名称',
															width : 160,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "200"
															},
															search : true

														},{
															name : 'SECTIONPHOTO',
															index : 'SECTIONPHOTO',
															label : '换热站图片',
															width : 160,
															editable : false,
															search : false

														},{
															name : 'YEARS',
															index : 'YEARS',
															label : '供热年份',
															width : 160,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "200"
															},
															search : false

														},{
															name : 'BDATE',
															index : 'BDATE',
															label : '起始日期',
															width : 160,
															editable : true,
															sorttype : 'date',
									        				formatter:"date",
									        				
									        				formatoptions: {srcformat:'u',newformat:'Y-m-d'},
									        				editoptions : {
									        					
									        					dataInit :  function (elem) {
									        						
									        						$(elem).datepicker({
									                					format : 'yyyy-mm-dd',
									                					autoclose : true,
									                				    language: 'zh-CN'
									                				});
									        						
									        					}
									        				},
															search : false

														},{
															name : 'ADATE',
															index : 'ADATE',
															label : '结束日期',
															width : 160,
															editable : true,
															sorttype : 'date',
									        				formatter:"date",
									        				formatoptions: {srcformat:'u',newformat:'Y-m-d'},
									        			 
									        				editoptions : {
									        					
									        					dataInit :  function (elem) {
									        						
									        						$(elem).datepicker({
									                					format : 'yyyy-mm-dd',
									                					autoclose : true,
									                				    language: 'zh-CN'
									                				});
									        						
									        					}
									        				},
									        				formatoptions: {srcformat:'u',newformat:'Y-m-d'},
									        				
															search : false

														}],
												
												sortname : "FACTORYID",
												sortorder : "asc",
												viewrecords : true,
												rowNum : 10,
												rowList : [ 10, 20, 30 ],
												pager : pager_selector,
												altRows : true,
												toppager : true,
												loadonce:true,  //9-21 翻页按钮
												multiselect : true, /* multikey : "ctrlKey", */
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
												editurl : "${contextPath}/baseinfomanage/FactorySectionInfo/operatefactorysectioninfo"

											});

							$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

							function aceSwitch(cellvalue, options, cell) {
								setTimeout(
										function() {
											$(cell).find('input[type=checkbox]')
													.addClass('ace ace-switch ace-switch-5')
													.after('<span class="lbl"></span>');
										}, 0);
							}

							// navButtons
							jQuery(grid_selector)
									.jqGrid(
											'navGrid',
											pager_selector,
											{ // navbar options
												edit : <shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:edit">false</shiro:lacksPermission>,
												editicon : 'ace-icon fa fa-pencil blue',
												add : <shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:add">false</shiro:lacksPermission>,
												addicon : 'ace-icon fa fa-plus-circle purple',
												del : <shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:delete">false</shiro:lacksPermission>,
												delicon : 'ace-icon fa fa-trash-o red',
												search : <shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:search">false</shiro:lacksPermission>,
												searchicon : 'ace-icon fa fa-search orange',
												refresh : false,
												refreshicon : 'ace-icon fa fa-refresh blue',
												view : <shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:view">false</shiro:lacksPermission>,
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
													form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
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
							if (<shiro:hasPermission name="${ROLE_KEY}:factorysectioninfo:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:factorysectioninfo:export">false</shiro:lacksPermission>) {
								jQuery(grid_selector).jqGrid('navButtonAdd',pager_selector,
												{
													caption : "导出",
													title : "导出Excel",
													buttonicon : "ace-icon fa fa-file-excel-o green",
													onClickButton : function() {
													
														var form = "<form name='csvexportform' action='${contextPath}/baseinfomanage/FactorySectionInfo/operatefactorysectioninfo?oper=excel&title="+title+"' method='post'>";
														form = form+ "<input type='hidden' name='csvBuffer' value='"+ encodeURIComponent(1)+ "'>";
														form = form+ "</form><script>document.csvexportform.submit();</sc" + "ript>";
														OpenWindow = window.open('', '','width=200,height=100');
														OpenWindow.document.write(form);
														OpenWindow.document.close();
													}
												});
							}

							function style_edit_form(form) {
								// form.find('input[name=statusCn]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
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
								buttons.addClass(
										'btn btn-sm btn-white btn-round').find(
										'[class*="-icon"]').hide();// ui-icon, s-icon
								buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
								buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
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
