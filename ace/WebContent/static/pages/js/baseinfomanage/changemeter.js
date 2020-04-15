var _areaguid,_buildno,_unitno,_floorno,_doorno;
		function emptyVal(){
			$('#CLIENTNO').val('');
			$('#TDOOR_METER_METERNO').val('');
			$('#PRODUSHU').val('');
			$('#TMODIFYMETER_METERID').val('');
			$('#DISHU').val('');
		}

		var building = function(obj){
			emptyVal()
			_areaguid = obj.value;
			if(_areaguid==''||_areaguid=='null') {
				 emptyAndReset($('#build'));	        	        					    
	     		 emptyAndReset($('#unit'));
				 emptyAndReset($('#floor'));
				 emptyAndReset($('#door')); 
				return;
				}
			$.get($path_base + '/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
			          }
			       }
			    var sel = $('#build');
			    emptyAndReset(sel);	        	        					    
     		    emptyAndReset($('#unit'));
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door')); 
			    sel.append(s);  
			});
		};

		var uniting = function(obj){
			emptyVal()
			_buildno = obj.value;
			if(_buildno=='') {
				        	        					    
	     		 emptyAndReset($('#unit'));
				 emptyAndReset($('#floor'));
				 emptyAndReset($('#door')); 
				 return;
			}
			$.get($path_base + '/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['UCODE'] + '">' + ri['UCODE'] + '单元</option>';
			          }
			       }
			    var sel =  $("#unit");
			    emptyAndReset(sel);
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});
		};
		
		var flooring = function(obj){
			emptyVal()
			_unitno = obj.value;
			if(_unitno==''){
			
				 emptyAndReset($('#floor'));
				 emptyAndReset($('#door')); 
				return;
			}
			$.get($path_base + '/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['FLOORNO'] + '">' + ri['FLOORNO'] + '层</option>';
			          }
			       }
			    var sel =  $('#floor');
			    emptyAndReset(sel);
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});    	
		};
		
		var dooring = function(obj){
			emptyVal()
			_floorno = obj.value;
			if(_floorno==''){
				
				 emptyAndReset($('#door')); 
				return;
			}
				
			$.get($path_base + '/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           
			           s += '<option value="' + ri['DOORNO'] + '">' + ri['FCODE'] + '</option>';
			          }
			       }
			    var sel =  $('#door');
			    emptyAndReset(sel);	      
			    sel.append(s);  
			});
		};
		
		var oldInfo = function(obj){
			_doorno = obj.value;//门牌
			if(_doorno==''){
				emptyAndReset($('#TDOOR_METER_METERNO')); 
				emptyAndReset($('#PRODUSHU')); 
				emptyAndReset($('#TMODIFYMETER_METERID')); 
				emptyAndReset($('#DISHU')); 
				emptyAndReset($('#CLIENTNO')); 
			}
			emptyVal();
			if(_doorno=='') return;
			$.get($path_base + '/sys/todaydata/getChangeMeterData?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno+"&doorno="+_doorno,
					function(data){ 
				
						if(data==undefined||data=='') return;
						var obj = jQuery.parseJSON(data);
						appendEle(obj,'CLIENTNO');
						appendEle(obj,'TDOOR_METER_METERNO');//旧表号码
						appendEle(obj,'PRODUSHU',0);//换表前底数
						appendEle(obj,'TMODIFYMETER_METERID');//新表号码
						appendEle(obj,'DISHU');//新表底数 
					}
			)
		};


		$(function(){
			$.ajax({
				url : $path_base + '/sys/todaydata/getAreaDownList',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					var response = data;
				      var s = '<option value="">请选择</option>';
				      if (response && response.length) {
				          for (var i = 0, l = response.length; i < l; i++) {
				           var ri = response[i];
				           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
				          }
				       }
				      
				     $('#community').append(s);
				     var areaguid = _J_getAreaGuid();
				     if(areaguid=='null'||areaguid=='') return;
				     $('#community option[value="'+areaguid+'"]').attr('selected',true);
				     var obj = [];
				     obj.value=areaguid;
				     building(obj);
				}
			});
			
			$.get($path_base + '/baseinfomanage/meterFaultInfoContr/getMeterFaultInfo',function(response){
				var $data = jQuery.parseJSON(response).rows;
				var strHtml = '<option value="">请选择</option>';
				for(var i=0;i<$data.length;i++){
					var obj = $data[i];
					strHtml += '<option value="'+obj['DEVICECHILDTYPENO']+'">'+obj['DEVICECHILDTYPENAME']+'</option>';
				}
				$('#ddlBiaoLeiXing').empty().append(strHtml);
			})
				
		});
		
		var modifyMeter = function(){
			if($('#TDOOR_METER_METERNO').val()==''){//之前的表号
				alert("请先选择一个有热表的用户！");
				return;
			}
			if($('#ddlBiaoLeiXing').val()==''){//之前的表号
				alert("请先选择表类型！");
				return;
			}
			if($('#DISHU').val()==''){
				alert("请输入底数！");
				return;
			}
			if($('#TMODIFYMETER_METERID').val()==''){
				alert("请输入新表号！");
				return; 
			}
			
			$.ajax({
				url : $path_base + '/baseinfomanage/changemeter/noJqgirdEdit?prometerid=' + $('#TDOOR_METER_METERNO').val()
						+ '&produshu=' +$('#PRODUSHU').val()+"&meterid=" + $('#TMODIFYMETER_METERID').val() + "&dishu="+$('#DISHU').val()
						+ '&areaguid=' +_areaguid + "&clientno=" +$('#CLIENTNO').val()+"&biaoleixin="+$('#ddlBiaoLeiXing').val(),
				type : 'POST',
				dataType : 'json',
				success : function(data){
					if(data==false) {
						confirm("数据保存失败！");
					}
					else{
						alert("保存数据成功!");
					}
					var obj = [];
				    obj.value=$('#door').val();
					oldInfo(obj);
				}
			});
			
		}
		
		var scripts = [$path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js"
		                , $path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js"];
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
			
        	$('#btnSearch').click(function(){
        		_areaguid,_buildno,_unitno,_floorno,_doorno;
        		var _devicetypeNo = $('#ddlBiaoLeiXing').val();
        		var sendData = '{"groupOp":"AND","rules":[{"field":"AREAGUID","op":"eq","data":"'+_areaguid+'"},'
        		                                          +'{"field":"BUILDNO","op":"eq","data":"'+_buildno+'"},'
        		                                          +'{"field":"UNITNO","op":"eq","data":"'+_unitno+'"},'
        		                                          +'{"field":"FLOORNO","op":"eq","data":"'+_floorno+'"},'
        		                                          +'{"field":"DOORNO","op":"eq","data":"'+_doorno+'"}'
        		                                          +']}';
        		jQuery("#grid-table").setGridParam({
        			postData:{filters : sendData}
        		}).trigger("reloadGrid");
        		_J_setAreaGuid(onSearch_putDown_areaguid('community'),onSearch_putDown_areaname('community'));
        	})
        	
        	jQuery(function($) {
        		var da_search = "#da-search";
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";
        		$(window).on('resize.jqGrid', function(){
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
		
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : $path_base + "/baseinfomanage/changemeter/getChangeMeter",
        			mtype:'POST',
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:32,
        			colNames : ['操作','小区编号','楼宇','单元','楼层',/* '小区' *//* '', */ '用户编码', '门牌', '旧表号', 
        			            '旧表底数(KWH)','新表号','新表底数(KWH)','更改时间','操作人'],
        			colModel : [{
			        				name : '',
			        				index : '',
			        				label : '操作',
			        				width : 50,
			        				viewable : false,
			        				fixed : true,
			        				sortable : false,
			        				resize : false,
			        				formatter : 'actions',
			        				formatoptions : {
			        					keys : true,
			        					delbutton : false,//disable delete button
			        					delOptions : {
			        						recreateForm : true,
			        						beforeShowForm : beforeDeleteCallback
			        					}
			        				}
			        			},
        			            {
	        			            hidden:true,
	       			            	label:'小区名',
	       			            	index:'AREAGUID',
	       			            	name:'AREAGUID',
        			            },
        			            {
	       			            	 hidden:true,
	       			            	 label:'楼宇',
	       			            	 name:'BUILDCODE',
       			            	},
       			            	{
	       			            	 hidden:true,
	       			            	 label:'单元',
	       			            	 name:'UCODE',
       			             	},          
       			            	{
	       			            	 hidden:true,
	       			            	 label:'楼层',
	       			            	 name:'FLOORNO',
      			             	}, 
      			              {
        	        				name : 'USERCODE',//用户编号
        	        				index : 'USERCODE',//过滤里面的field
        	        				label : '用户编号',
        	        				width : 120,
        	        			}, {
        	        				name : 'FCODE',
        	        				index : 'FCODE',
        	        				label : '门牌 ',
        	        				formatter:function(cellvalue,option,rowObject){
        	        					return rowObject.BUILDNAME+"-"+rowObject.UNITNO+'单元'+rowObject.FLOORNO+'层'+rowObject.FCODE;
        	        				},
        	        				width : 137,
        	        			},  {
        	        				name : 'PROMETERID',
        	        				index : 'PROMETERID',
        	        				key : true,
        	        				label : '换表前表号',
        	        				width : 80,
        	        				
        	        			}, {
			        				name : 'PRODUSHU',
			        				index : 'PRODUSHU',
			        				label : '换表前底数',

			        			}, {
			        				name : 'METERID',
			        				index : 'METERID',
			        				label : '换表后表号',
			        				editable : true,
									editrules : {
										number : true
									}
			        			}, {
			        				name : 'DISHU',
			        				index : 'DISHU',
			        				label : '换表后底数',
									editable : true,
									editrules : {
										number : true
									}
			        			}, {
			        				name : 'DDATE',
			        				index : 'DDATE',
			        				label : '修改日期',
			        				sortable : false,
			        				sorttype : 'date',
			        				formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'},
			        				stype:'text',
			        				searchoptions : {
			        					sopt : ['ge','le'],
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
			        				name : 'USERNAME',
			        				index : 'USERNAME',
			        				label : '操作人'
			        			} ],
			        			sortname : "DDATE",
			        			sortorder : "desc",
			        			viewrecords : false,
			        			rowNum : 10000,
			        			altRows : true,
			        			shrinkToFit:true,
			        			multiselect : false,
			        	        multiboxonly : true,
			        	        ondblClickRow: function(rowid){
			        				jQuery(grid_selector).viewGridRow(rowid,{});
			        			},
			        			loadComplete : function(data) {
									
			        				var table = this;
			        				setTimeout(function(){
			        					updatePagerIcons(table);
			        					enableTooltips(table);
			        				}, 0);
			        			},
			        			editurl : $path_base + "/baseinfomanage/changemeter/operChangeMeter"
			        		});

        		$(window).triggerHandler('resize.jqGrid');
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		
        		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { 
        			edit : false, add : false, del : false, search :false, refresh : false, view : false,
        		}, {}, {}, {}, {}, {})
        	
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
        		
        		function assertElement(ele){
        			try{
        				ele.cloneNode(true);
        				if(ele.nodeType!=1&&ele.nodeType!=9) return false;
        			}catch(e){
        				throw new Error("ele参数不合法");
        			}
        				return false;
        		}
        		$(document).one('ajaxloadstart.page', function(e) {
        			$(grid_selector).jqGrid('GridUnload');
        			$('.ui-jqdialog').remove();
        		});
        		 $(pager_selector + ' #grid-pager_left span').css({'text-indent':0});
        		var navTable = $(pager_selector + ' #grid-pager_left').clone(true);
        		$(pager_selector + ' #grid-pager_left').empty();
        		 $(da_search).append(navTable); 
        		
        	});
        });