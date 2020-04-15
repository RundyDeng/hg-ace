		var scripts = [ $path_base+"/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , $path_base+"/static/assets/js/jqGrid/i18n/grid.locale-cn.js"
		                , $path_base + '/static/assets/js/jquery-ui.js'
		               ]
		function openDetail(val){
			myWindow=window.open($path_base + '/baseinfomanage/clientinfo/clientDetail?CLIENTID='+val,'点击打开详情','width=800,height=500')
			myWindow.focus();
		}
		function openChangeMeterHistory(val){
			myWindow=window.open($path_base + '/baseinfomanage/clientinfo/changeMeterHistory?CLIENTID='+val,'换表历史','width=800,height=500')
			myWindow.focus();
		}
		$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	jQuery(function($) {
        		var da_search = "#da-search";
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";
        			
        		console.log(window.document)
        		console.log("adsfklasdfjlkj = "+$(".page-content").width());

        		$(window).on('resize.jqGrid', function() {
        			$(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
        		});
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
        				             { "field": "CLIENTNO", "op": "eq", "data": "" } , 
        				          //   { "field": "SFTR", "op": "eq", "data": ""},
        				          //   { "field": "ISYESJL", "op": "eq", "data": ""},
        				         ] 
        		};
        		function moreInfo(cellvalue, options, rowdata){
        			var clientid = options.rowId;
        		    return '<a href="javascript:void(0);" onClick="openDetail(' + clientid + ')" >详细信息/</a>'
        		      +'<a href="javascript:void(0);" onClick="openChangeMeterHistory(' + clientid + ')" >换表历史</a>';
        		}

        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : $path_base+"/baseinfomanage/clientinfo/getClientInfo",
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['TCLIENT_CLIENTID','小区编号','楼宇','单元','楼层','门牌',
        			            '小区名称','门牌号','用户编码', '表号','姓名','电话','地址','建筑面积',
        			            '使用面积','住户类型','位置','系数','计量单价',/*'用热状态','是否签约',*/'操作'
								],
        			colModel : [{
									name : 'CLIENTID',
									index : 'CLIENTID',
									label : '唯一ID',
									key : true,
									hidden : true,
									editable : false
								},
        			            {
	        			            hidden:true,
	       			            	label:'小区编号',
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
			            		            	if(_buildno==''){
			        	        					 emptyAndReset(getSelectElement("UNITNO"));
			            		            		 emptyAndReset(getSelectElement("FLOORNO"));
	        	        					         emptyAndReset(getSelectElement("DOORNO"));
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
       			            	},{
	       			            	 hidden:true,
	       			            	 label:'单元',
	       			            	 name:'UNITNO',
	       			            	 search:true,
	       			            	 stype:'select',
	       			            	 searchoptions : {
	       			            		dataEvents:[{
			            		             type:'change',
			            		             fn:function(e){ //20171108
			            		            	_unitno = $(e.target).val();
			            		    			if(_unitno=='') {
			            		    				
			            		            		 emptyAndReset(getSelectElement("FLOORNO"));
	        	        					         emptyAndReset(getSelectElement("DOORNO"));
			            		    			} //1108
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
       			             	},{
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
      			             	},{  hidden:true,
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌 ',
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					searchhidden:true,
        	        					sopt:['eq']
        	        				}
        	        			},{
      			             		name: '',
      			             		label: '小区名称',
      			             		formatter: function(){
      			             			var $_sel_obj = getSelectElement("AREAGUID");
      			             			var selAreaName = $_sel_obj.find('option[value="'+$_sel_obj.val()+'"]').html();
      			             			if(selAreaName==undefined) return _default_status_areaname;
      			             			return selAreaName;
      			             		}
      			             	},{
        	        				name : 'MENPAI',
        	        				index : 'MENPAI',
        	        				label : '门牌号',
        	        				search : false
        	        			},{
        	        				name : 'CLIENTNO',
        	        				index : 'CLIENTNO',
        	        				label : '用户编码',
        	        				sortable : false,
        	        				width:220,
        	        				search : true,
        	        				searchoptions:{
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			{
        	        				name : 'METERNO',
        	        				index : 'METERNO',
        	        				label : '热表号',
        	        				search : false
        	        			},
        	        			{
        	        				name : 'CLIENTNAME',
        	        				index : 'CLIENTNAME',
        	        				label : '姓名',
        	        				search : true,
        	        				searchoptions : {
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			{
        	        				name : 'MOBPHONE',
        	        				index : 'MOBPHONE',
        	        				label : '电话',
        	        				search : false
        	        			},
        	        			{
        	        				name : 'ADDRESS',
        	        				index : 'ADDRESS',
        	        				label : '地址',
        	        				width: 260,
        	        				search : false
        	        			},
        	        			{
        	        				name : 'HOTAREA',
        	        				index : 'HOTAREA',
        	        				label : '建筑面积',
        	        				search : false
        	        			},
        	        			{
        	        				name : 'UAREA',
        	        				index : 'UAREA',
        	        				label : '使用面积',
        	        				search : false
        	        			},
        	        			{
        	        				name : 'CLIENTCAT',
        	        				index : 'CLIENTCAT',
        	        				label : '住户类型',
        	        				search : false
        	        			},{
        	        				name : 'POSITION',
        	        				index : 'POSITION',
        	        				label : '位置',
        	        				width : 100,
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
        	        			{name : 'METERXISH',
        	        				index : 'METERXISH',
        	        				label : '系数',
        	        				formatter: roundFix,
        	        				sortable : false,
			        				width : 80,
        	        				search : false
        	        			},
        	        			{
        	        				name : 'PRICE',
        	        				index : 'PRICE',
        	        				label : '计量单价',
        	        				search : false
        	        			},/*{
        	        				name : 'SFTR',
        	        				index : 'SFTR',
        	        				label : '用热状态',
        	        				width : 100,
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
        	        			},
        	        			{
        	        				name : 'SFQY',//isyesjl
        	        				index : 'SFQY',
        	        				label : '是否签约',
        	        				width : 100,
        	        				formatter : convertCN,*/
        	        				/*	stype:'select',
        	        				searchoptions: {
        	        					value : {
        	        						0 : '否',
        	        						1 : '是'
        	        					}
        	        				},
        	        				search : true*/
        	        			/*	stype:'select',
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.ISYESJL;
        	        				},
        	        				searchoptions:{
        	        				
    			        					dataInit:function(elem){
    					            			 var opt = '<option value="" >请选择</option>' 
    					            				        +'<option value="否" >否</option>'
    					            			 			+ '<option value="是" >是</option>';
    					            			 			
    					            			 $(elem).append(opt);
    					         			},
    			        					sopt:['eq']
    			        				}*/
        	        			//},
        	        			{
			        				name : '',
			        				index : '',
			        				fixed : true,
			        				sortable : false,
			        				resize : false,
			        				formatter : moreInfo,
			        			}],
        			sortname : "CLIENTID,CLIENTNO",
        			sortorder : "asc",
        			shrinkToFit : true,
        			viewrecords : true,
        			rowNum : 20,
        			rowList : [20, 30,50],
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
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function() {style_search_filters($(this));},
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
        		if(true/* <shiro:hasPermission name="${ROLE_KEY}:hisdata:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:export">false</shiro:lacksPermission> */){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () { 
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
   				    	   rows = rows + "\n"; // end of line at the end
   				    	   var form = "<form name='csvexportform' action=$path_base + '/sys/hisdata/operateHisData?oper=excel' method='post'>";
   				    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
   				    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
   				    	   OpenWindow = window.open('', '');
   				    	   OpenWindow.document.write(form);
   				    	   OpenWindow.document.close(); */
   				    	   
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
				   				          '取消': function() {$(this).dialog('destroy');}
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
        			var form = "<form name='csvexportform' action='" + $path_base + "/baseinfomanage/clientinfo/operClientInfo?oper=excel&areaguid="+areaguid+"' method='post'>";
					   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			    	   OpenWindow = window.open('', '','width=200,height=100');
				       OpenWindow.document.write(form);
				       OpenWindow.document.close();
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