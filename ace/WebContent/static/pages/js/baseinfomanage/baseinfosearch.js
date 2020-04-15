var scripts = [$path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , $path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js"
		                , $path_base + '/static/assets/js/jquery-ui.js'//10-02
		                ]
		
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
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
									 { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									 { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									 { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									 { "field": "DOORNO", "op": "eq", "data": "" } , //门牌
        				             { "field": "METERID", "op": "eq", "data": "" }
        				         ] 
        		};
        		
				var flag = true;
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : $path_base + "/baseinfomanage/badeInfoSearchContr/getBaseInfoSearch",
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['小区编号','楼宇','单元','楼层','门牌',//'用户编码',
        			            '唯一ID','小区号','小区名称','楼宇号','楼宇名称','单元号','楼层号','门牌','热表号',
        			            '用户编码','表序','交换机地址','通讯类型','设备备注','表类型','故障参数'
								], //'表序','集中器地址','通道号','交换机地址',
        			colModel : [{
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
	    			         				var areaguid = _J_getAreaGuid();
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
			            		            	if(_buildno=='') {
			            		            		       	        					    
			        	        					 emptyAndReset(getSelectElement("UNITNO"));
			        	        					 emptyAndReset(getSelectElement("FLOORNO"));
			        	        					 emptyAndReset(getSelectElement("DOORNO"));
			            		            		return;
			            		            		}
			            		    			$.get($path_base + '/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
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
			            		    			if(_unitno=='') {
			            		    				     	        					    
			        	        					
			        	        					emptyAndReset(getSelectElement("FLOORNO"));
			        	        					emptyAndReset(getSelectElement("DOORNO"));
			            		            		
			            		    				return;
			            		    				}
			            		    			$.get($path_base + '/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
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
			            		    			if(_floorno==''){
			            		    				emptyAndReset(getSelectElement("DOORNO"));
			            		    				return;
			            		    			}	
			            		    			$.get($path_base + '/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
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
      			             	}, 
      			             	{
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				hidden : true,
        	        				label : '门牌 ',
        	        				width : 76,
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					searchhidden : true,
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			{
        	        				name : 'WYID',
        	        				label : '唯一ID',
        	        			//	hidden : true,
        	        				width : 90,
        	        			},
        	        			{
        	        				label : '小区号',
									formatter:function(cV,op,rowDate){
										return rowDate.AREAGUID;
									},        	     
        	        				width : 61
        	        			},
        	        			{
        	        				label : '小区名称',
									formatter:function(c,o,r){
										return r.AREANAME;
									},
									width : 140
        	        			
        	        			},
        	        			{
        	        				label : '楼宇号',
        	        				width : 90,
        	        				formatter:function(c,o,r){
										return r.BUILDCODE;
									}
        	        			},
        	        			{
        	        				label : '楼宇名称',
									formatter:function(c,o,r){
										return r.BUILDNAME;
									},
									width : 91
        	        			},
        	        			{
        	        				name : '',
        	        				index : '',
        	        				label : '单元号',
        	        				formatter : function(c,o,r){
        	        					return r.UNITNO;
        	        				},
        	        				width : 61
        	        			},
        	        			{
        	        				name : '',
        	        				index : '',
        	        				label : '楼层号',
        	        				formatter : function(c,o,r){
        	        					return r.FLOORNO;
        	        				},
        	        				width : 65
        	        			},
        	        			{
        	        				name : 'DOORNAME',
        	        				index : 'DOORNAME',
        	        				label : '门牌',
        	        				width : 82
        	        			},{
        	        				name : 'METERID',
        	        				index : 'METERID',
        	        				label : '热表号',
        	        				width : 100 ,
        	        				searchable : true,
        	        				sType : 'text',
        	        				searchOptions:{
        	        					sopt : ['eq']
        	        				},
        	        				wdith : 100
        	        			},{
        	        				name : 'CLIENTNO',
        	        				index : 'CLIENTNO',
        	        				label : '用户编码',
        	        				width : 120
        	        			},
        	        			{
			        				name : 'METERSEQ',
			        				index : 'METERSEQ',
			        				label:'表序',
			        				width : 63,
			        				
			        			},
        	        			/*{
			        				name : 'POOLADDR',
			        				index : 'POOLADDR',
			        				label:'集中器地址',
			        				wdith : 89
			        			},
        	        			{
			        				name : 'CHANNELNO',
			        				index : 'CHANNELNO',
			        				label:'通道号',
			        				width : 71,
			        				
			        			},*/
        	        			{
			        				name : 'GPRSID',
			        				index : 'GPRSID',
			        				label:'交换机地址',
			        				width : 108,
			        				
			        			},
        	        			{
			        				name : 'COMMTYPE',
			        				index : 'COMMTYPE',
			        				label:'通讯类型',
			        				width : 77,
			        				
			        			},
        	        			{
			        				name : 'REMARK',
			        				index : 'REMARK',
			        				label:'设备备注',
			        				width : 130,
			        				
			        			},
        	        			{
			        				name : 'DEVICETYPECHILDNO',
			        				index : 'DEVICETYPECHILDNO',
			        				label : '表类型',
			        				width : 75,
			        				
			        			},
        	        			{
			        				name : 'NO1',
			        				index : 'NO1',
			        				label : '故障参数', 
			        				width : 107,
			        				
			        			}],
        			sortname : "WYID,CLIENTNO",
        			sortorder : "asc",
        			shrinkToFit : false,
        			viewrecords : true,
        			rowNum : 20,
        			rowList : [  20, 30,50 ],
        			pager : pager_selector,
        			toppager : true,
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
        			edit : false,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : false,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : false,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : true,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : false,
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
        			}
        		}, {
        			// search form
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
        			// view record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		})
        		// add custom button to export the data to excel
        		if(true){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () { 
   				    	$("#sel_dialog").dialog({
   				    		title : '选择需要导出的小区',
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
						   				          },
				   				          '取消': function() {
						   				              $(this).dialog('destroy');
						   				          }
				   				      },
				   			focus: function(event, ui) {
								$.get($path_base + '/sys/todaydata/getAreaDownList',function(data){
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
	        					    	  var areaguid = _J_getAreaGuid();
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
        			var areaguid = $('#areainfo').val();
	       				   var form = "<form name='csvexportform' action='" + $path_base + "/baseinfomanage/badeInfoSearchContr/updateBaseInfoSearch?oper=excel&areaguid="+areaguid+"' method='post'>";
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
        	});
        });