<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

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
        			if(cellvalue==0||cellvalue==undefined) return 0;
					return cellvalue.toFixed(2);
				}
        		var _areaguid,_buildno,_unitno,_floorno;
        		var template1 = { 
        				"groupOp": "AND", 
        				"rules": [ 
									 { "field": "AREAGUID", "op": "eq", "data": "" } , //小区
									 { "field": "BUILDNO", "op": "eq", "data": "" } , //楼宇
									 { "field": "UNITNO", "op": "eq", "data": "" } , //单元
									 { "field": "FLOORNO", "op": "eq", "data": "" } , //楼层
									 { "field": "DOORNO", "op": "eq", "data": "" } , //门牌
        				       //     { "field": "CLIENTNO", "op": "eq", "data": "" } , 
        				        //     { "field": "ISSTOP", "op": "eq", "data": "" } , //ISSTOP 
        				             { "field": "AUTOID","op": "eq","data":""}
        
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
        		
        		var checkSearch = false;
				var flag = true;
				
				
        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/monitordata/meterconditioncontr/getmetercondition",
        			datatype : "json",
        			height : 450,
        			rownumbers:true,
        			rownumWidth:40,
        			colNames : ['','小区编号','单元','楼层','门牌','用户编码', '抄表批次'
        			            
        			            ,'用户编码','住户','地址','门牌','热表号','用热状态','热表状态','累计热量(kwh)','累计流量(t)'
        			            ,'瞬时流量(t/h)','瞬时热量(kw)','进水温度(℃)','回水温度(℃)','温差(℃)','时数(h)','抄表时间','抄表批次'
        			            ,'问题说明'
								],
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
			        					//editformbutton:true, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
			        				}
			        			},{
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
	        	        					      sel.append(s);
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
			            		    			
			            		    			if(_unitno==''){
			            		    			
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
			            		    			if(_floorno==''){
			        	        					emptyAndReset(getSelectElement("DOORNO"));
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
      			             	}, 
      			             	{
        	        				name : 'DOORNO',
        	        				index : 'DOORNO',
        	        				label : '门牌 ',
        	        				width : 80,
        	        				hidden : true,
        	        				search : true,
        	        				stype:'select',
        	        				searchoptions:{
        	        					searchhidden : true,
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			{
        	        				name : 'AUTOID',
        	        				index : 'AUTOID',
        	        				label : '抄表批次',
        	        				width : 100,
        	        				hidden:true,
        	        				search : true,
        	        				stype : 'select',
        	        				searchoptions : {
        	        					dataInit:function(elem){
	    			            			 var opt =  '<option value="1" >1</option>'
	    			            			 			+ '<option value="2" >2</option>';
	    			            			 
	    			            			 $(elem).append(opt);
	    			         			},
        	        					searchhidden : true,
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			 {
            	        			
        	        				name : 'CLIENTNO',
        	        				index : 'CLIENTNO',
        	        				label : '用户编码',
        	        				width : 100,
        	        				sortable : false,
        	        				search : true,
        	        				searchoptions:{
        	        					searchhidden : true,
        	        					sopt:['eq']
        	        				}
        	        			},
        	        			{
        	        				name : 'UNAME',
        	        				index : 'UNAME',
        	        				label : '住户',
        	        				width : 87,
        	        				search : false
        	        			},{
        	        				name : 'ADDRESS',
        	        				index : 'ADDRESS',
        	        				label : '地址',
        	        				width : 87,
        	        				search : false
        	        			},
        	        			{
        	        				name : 'MENPAI',
        	        				index : 'MENPAI',
        	        				width : 90,
        	        				search : false
        	        			},
        	        			{
        	        				name : 'METERNO',
        	        				index : 'METERNO',
        	        				key : true,
        	        				width : 97,
        	        				search : false
        	        			},
        	        			{	
        	        				hidden:true,
        	        				name : 'ISSTOP',
        	        				index : 'ISSTOP',
        	        				width : 80,
        	        				search : true,
        	        				stype:'select',
        	        				formatter : function(cellvalue, options, rowObject){
        	        					return rowObject.ISSTOP;
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
        	        				name : 'MSNAME',
        	        				index : 'MSNAME',
        	        				search : false,
        	        				width : 80
        	        			},
        	        			{
        	        				name : 'METERNLLJ',
        	        				index : 'METERNLLJ',
        	        				width : 102,
        	        				formatter: roundNum,
        	        				search : false
        	        				
        	        			},
        	        			{
        	        				name : 'METERTJ',
        	        				index : 'METERTJ',
        	        				formatter: roundNum,
        	        				search : false,
        	        				width : 102
        	        			},
        	        			{
			        				name : 'METERLS',
			        				index : 'METERLS',
			        				formatter: roundNum,
			        				width : 102,
			        				search : false
			        			},{
			        				name : 'METERGL',
			        				formatter: roundNum,
			        				width : 102,
			        				search : false
			        			},{
			        				name : 'METERJSWD',
			        				formatter: roundNum,
			        				width : 102,
			        				search : false
			        			},{
			        				name : 'METERHSWD',
			        				formatter: roundNum,
			        				width : 102,
			        				search : false
			        			},{
			        				name : 'METERWC',
			        				formatter: roundNum,
			        				width : 102,
			        				search : false
			        			},{
			        				name : 'COUNTHOUR',
			        				search: false,
			        				formatter: roundNum,
			        				width : 100
			        			},{
			        				name : 'DDATE',
			        				index : 'DDATE',
			        				label : '抄表时间',
			        				sorttype : 'date',
			        				formatter:"date",
			        				formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'},
			        				/* unformat : pickDate, */
			        				stype:'text',
			        				width : 150
			        			},{
			        				name : '',
			        				label : '抄表批次',
			        				search : false,
			        				width : 70,
			        				formatter : function(clv,op,rowo){
			        					return rowo.AUTOID;
			        				}
			        			},{
			        				name : 'REMARK',
			        				search : false,
			        				editable : true,
			        				edittype : 'text',
			        				edtioptions : {
			        					size : '20'
			        				},
			        				editrules : {
			        					
			        				}
			        			}],
        			sortname : "BUILDNO,UNITNO,DOORNAME",
        			sortorder : "asc",
        			shrinkToFit : false,
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
        			loadComplete : function() {
        				var table = this;
        				setTimeout(function(){
        					styleCheckbox(table);
        					updateActionIcons(table);
        					updatePagerIcons(table);
        					enableTooltips(table);
        				}, 0);
        			},
        			editurl : "${contextPath}/monitordata/meterconditioncontr/updatemetercondition?areaguid="+_areaguid

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
        			edit : <shiro:hasPermission name="${ROLE_KEY}:hisdata:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:edit">false</shiro:lacksPermission>,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : <shiro:hasPermission name="${ROLE_KEY}:hisdata:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:add">false</shiro:lacksPermission>,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : <shiro:hasPermission name="${ROLE_KEY}:hisdata:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:delete">false</shiro:lacksPermission>,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : <shiro:hasPermission name="${ROLE_KEY}:hisdata:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:search">false</shiro:lacksPermission>,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : <shiro:hasPermission name="${ROLE_KEY}:hisdata:view">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:hisdata:view">false</shiro:lacksPermission>,
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
        			onSearch:function(e){
        				checkSearch = true
        			},
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
        		if(<shiro:hasPermission name="${ROLE_KEY}:metercondition:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:metercondition:export">false</shiro:lacksPermission>){
    				jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
   					   caption : "导出",
   				       title : "导出Excel",
   				       buttonicon : "ace-icon fa fa-file-excel-o green", 
   				       onClickButton : function () {
   				    	
   				    	 submitExcel();
   				       } 
   					});        			
        		}
        		
        		function submitExcel(){
        			$.get('${contextPath}/monitordata/meterconditioncontr/updatemetercondition?oper=excel&flag=1',function(data){
       				   if(data!="true"){
       					   alert(data);
       				   }else{
	       				   var form = "<form name='csvexportform' action='${contextPath}/monitordata/meterconditioncontr/updatemetercondition?oper=excel&areaguid="+_areaguid+"' method='post'>";
	 					   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
	 			    	   form = form + "</form><script>document.getElementById('export_excel').contentWindow.document.getElementsByTagName('form')[0].submit();</sc" + "ript>";
	 			    	   var childDom = document.getElementById('export_excel').contentWindow.document.getElementsByTagName('body');
	 			    	   //document.getElementById('export_excel').contentWindow.document.getElementsByTagName('form')[0].submit()
	 			    	   $(childDom).empty().append(form).empty();
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
