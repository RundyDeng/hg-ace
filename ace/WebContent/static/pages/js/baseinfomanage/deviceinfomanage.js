var scripts = [ $path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js", $path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js", null ]
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
        				setTimeout(function(){
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		});
        		
        		
        		var _areaguid,_buildno,_unitno,_floorno;
        		//var currentday = new Date().toLocaleDateString().replace(/\//g,'-');
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
									 { "field": "GPRSID", "op": "eq", "data": "" }
									// { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									// { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									// { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									// { "field": "DOORNO", "op": "eq", "data": "" }  //门牌  其实就是 DOORNO
        				         ] 
        		};
        	/*	function getSelectElement(val){
        			if(val!=='undefined')
        				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
        		}
        		function emptyAndReset(e){
        			e.empty();
        			e.append("<option value=''>请选择</option>").attr("selected",true).change();
        		}*/
        		
				var flag = true;
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : $path_base + "/baseinfomanage/deviceinfomanage/getdeviceinfo",
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:32,
        			colNames : ['小区编号','操作','编号','小区名称','设备型号','设备编号','安装位置','GPRS编号','备注'
								],
        			colModel : [
									{   hidden:true,
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
												    sel.append(s);  
												});
													 
									         }
									 	}],
										buildSelect:function(data){
										var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>' ;
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
			        				name : '',
			        				index : '',
			        				label : '操作',
			        				width : 63,
			        				viewable : false,
			        				fixed : true,
			        				sortable : false,
			        				resize : false,
			        				formatter : 'actions',
			        				formatoptions : {
			        					keys : true,
			        					delbutton : true,//disable delete button
			        					delOptions : {
			        						recreateForm : true,
			        						beforeShowForm : beforeDeleteCallback
			        					}
			        				}
			        			},
			        			{
        							name : 'ID',
        							index : 'ID',
        							label : '编号',
        							width : 54,
        							key : true,//做delete等时使用，相当于是id吧
        							search : false,
        						},
        			            {
	       			            	 hidden:false,
	       			            	 label:'小区名称',
	       			            	 name:'AREANAME',
	       			            	 index : 'AREANAME',
	       			            	 width : 200,
	       			            	 editable : true,
	       			            	 edittype : 'select',
	       			            	 editoptions : {
	       			            		dataUrl:$path_base + '/sys/todaydata/getAreaDownList',
	    			         			buildSelect:function(data){
	    			         			  var areaguid = _J_getAreaGuid();
	    			         			  var response = jQuery.parseJSON(data);
       	        					      var s = '<select><option value="">请选择</option>';
       	        					      if (response && response.length) {
       	        					          for (var i = 0, l = response.length; i < l; i++) {
       	        					           var ri = response[i];
       	        					            s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
       	        					          }
       	        					       }
       	        					     s += "<script>setTimeout(function() {$('select option[value="+areaguid+"]').change().attr('selected',true);}, 500);</sc"+"ript>  ";
       	        					     s += "</select>";
       	        					     return s;
       	        				     }
       	        				    
	       			            	 },
	       			            	 editrules : {
	       			            		 custom : true,
	       			            		 custom_func : function(value,colname){
	       			            			 if(value==''||value == 'undefined')
	       			            			 	return [false,"请选择小区！"];
	       			            			 return [true,""];
	       			            		 }
	       			            	 }
       			            	},
       			            	{
	       			            	 hidden:false,
	       			            	 label:'设备型号',
	       			            	 index : 'DTYPE',
	       			            	 name:'DTYPE',
	       			            	 width : 130,
	       			            	 editable : true,
	       			            	 edittype : 'select',
	       			            	 editoptions : {
	       			            		 value : {
	       			            			GATE01 : 'GATE01',
	       			            			IDT100 : 'IDT100',
	       			            			IDT400 : 'IDT400',
	       			            			泰宇:'泰宇'
	       			            		 }
	       			            	 },
	       			            	 editrules :  {
	       			            			custom : true,
	       			            		 	custom_func : function(value,colname){
		       			            			 if(value==''||value == 'undefined')
		       			            			 	return [false,"请选择设备类型！"];
		       			            			 return [true,""];
	       			            		 	}
	       			            	 }
       			             	},           
       			            	{
	       			            	 label:'设备编号',
	       			            	 name:'DCODE',
	       			            	 index : 'DCODE',
	       			            	 width : 104,
	       			            	 editable : true
      			             	}, 
      			             	{
	      			             	 label:'安装位置',
	       			            	 name:'DADDRESS',
	       			            	 index : 'DADDRESS',
	       			            	 width : 226,
	       			            	 editable : true,
	       			            	 edittype : 'text',
        	        			},
        	        			{
        	        				name : 'GPRSID',
        	        				index : 'GPRSID',
        	        				label : 'GPRS编号',
        	        				width : 127,
        	        				search: true,
        	        				editable : true,
        	        				
        	        			},
        			            {
        	        				name : 'DREMARK',
        	        				index : 'DREMARK',
        	        				label : '备注',
        	        				width : 249,
        	        				editable : true,
        	        				edittype : 'text',
        	        				
        	        			}],
        			
        			sortname : " ", //AREAGUID
        			sortorder : "asc",
					viewrecords : true,
					rowNum : 100,
					rowList : [ 10, 20, 30 ],
					pager : pager_selector,
					altRows : true,
					toppager : true,
					shrinkToFit : true,
					multiselect : true, //复选框
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
        				}, 0);;
        			},
        			editurl : $path_base + "/baseinfomanage/deviceinfomanage/operdeviceinfo"

        		});
        		
        		//20171223
        	//	$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		//
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
        			edit : false,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : true,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : false,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : true,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : true,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : false,
        			viewicon : 'ace-icon fa fa-search-plus grey'
        		}, {
        			width : 600,
        			closeAfterEdit: true,
        			dataheight : false,//the parameter control the scrolling content - i.e between the modal header and modal footer.
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
        			width : 600,
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
        				if (form.data('styled')) return false;
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_delete_form(form);
        				form.data('styled', true);
        			}
        		}, {
        			// search form
        			recreateForm : true,
        			//1223
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
        			// view record form
        			width : 600,
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		})
        	
        		function style_edit_form(form){
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
        		function enableTooltips(table){
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