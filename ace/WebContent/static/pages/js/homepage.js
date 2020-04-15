

var checkInLay = false;
var btnHover = false;

function showOrHidePicFloat(){
	if(checkInLay == true && btnHover == true) $('#home-pic-float').stop().slideDown("slow");
	if(checkInLay == false && btnHover == false) $('#home-pic-float').stop().slideUp();
}

$(function(){
	/*$('#down-pic-float').hover(
			function(){
				$('#home-pic-float').slideDown("slow");
				btnHover = true;
			},
			function(){
				btnHover = false;
				setTimeout("showOrHidePicFloat();",100);
			}
	);
	$('#home-pic-float').hover(
			function(){
				checkInLay = true;
				showOrHidePicFloat();
			},
			function(){
				checkInLay = false;
				setTimeout("showOrHidePicFloat();",100);
			}
	);*/
})


function roundFix(cellvalue) {
	if (cellvalue == '' || cellvalue == undefined) return 0;
	return cellvalue.toFixed(2);
}

var end = 50;
var mid = 1;
var currentPosition = 0;
var runId;
function goPosition() {
	runId = setInterval("runTo()", 10);
}
function runTo() {
	currentPosition = document.documentElement.scrollTop || document.body.scrollTop;
	currentPosition += mid;
	if (currentPosition < end) {
		window.scrollTo(0, currentPosition);
	} else {
		clearInterval(runId);
	}
}



var scripts = [ 
        $path_base + '/static/assets/js/jquery-ui.js',
		$path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		$path_base + "/static/Highcharts-4.2.5/js/highcharts.js",
		$path_base + "/static/Highcharts-4.2.5/js/modules/data.js",
		$path_base + "/static/Highcharts-4.2.5/highslide-full.min.js",
		$path_base + "/static/Highcharts-4.2.5/highslide.config.js",
		$path_base + "/static/Highcharts-4.2.5/js/highcharts-3d.js",
		$path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js",
		$path_base + "/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		$path_base + '/static/Highcharts-4.2.5/js/modules/exporting.js',
		$path_base + "/static/assets/js/jquery.gritter.js"];
$('.page-content-area').ace_ajax('loadScripts',scripts,function() {
	Highcharts.theme = {  
			chart: { backgroundColor: null, style: { fontFamily: "Dosis, sans-serif" } }, 
			title: { style: { fontSize: '16px', fontWeight: 'bold', textTransform: 'uppercase' } }, 
			tooltip: { borderWidth: 0, backgroundColor: 'rgba(219,219,216,0.8)', shadow: false }, 
			legend: { itemStyle: { fontWeight: 'bold', fontSize: '13px' } }, 
			xAxis: { gridLineWidth: 1, labels: { style: { fontSize: '12px' } } }, 
			yAxis: { minorTickInterval: 'auto', title: { style: { textTransform: 'uppercase' } }, labels: { style: { fontSize: '12px' } } }, 
			plotOptions: { candlestick: { lineColor: '#404048' } },
			background2: '#F0F0EA',
			lang: {printChart: "打印图形",downloadJPEG: "下载JPEG文件",downloadPDF: "下载PDF文件",downloadPNG: "下载PNG文件",downloadSVG: "下载SVG文件"}
	};
	Highcharts.setOptions(Highcharts.theme);
	
	//	$('#zq-preloaderbar').addClass('active');
	//	setTimeout("goPosition()", 200);  //屏幕滑动上去，面包屑存在时
			
		function roundFix(cellvalue) {
			if (cellvalue == '' || cellvalue == undefined) return 0;
			return cellvalue.toFixed(2);
		}
		//季度耗热图
		var showColumn = function(objs) {
			$('#3d-columnxs').highcharts({
				exporting : {enabled : false},
				chart : {
					backgroundColor : '#fff',
					type : 'column',
					options3d : {enabled : true,alpha : 5,beta : 25,depth : 70}
				},
				title : {text : ''},
				credits : {enabled : false},
				plotOptions : {column : {depth : 60}},
				tooltip : {
					formatter : function() {return '<b>' + this.key + '</b><br/><b>本季度用热：' + this.y + 'KWH</b><br/>'}
				},
				xAxis : {
					title : {
						text : '年度各小区用热总量',
						y : 10,
						
						style : {"fontWeight" : "bold","font-size" : "15px"}
					},
					labels : {align : 'center',x : 3,y : 20,}
				},
				yAxis : {title : {text : '年度总用热量',style : {"font-size" : "14px"}}},
				series : [{data : objs,colorByPoint : true}],
				legend : {enabled : false}
			});
		}
		//当日耗热图
		var everyEnergyShowColumn = function(objs) {
			$('#energy-left-highchart').highcharts({
				exporting : {enabled : false},
				chart : {
					backgroundColor : '#fff',
					type : 'column',
				},
				title : {text : ''},
				credits : {enabled : false},
				plotOptions : {column : {depth : 60}},
				tooltip : {
					formatter : function() {return '<b>' + this.key + '</b><br/><b>日总用热量：' + this.y + 'KWH</b><br/>'}
				},
				xAxis : {
					title : {
						text : '各小区日用热量',
						y : 10,
						style : {"fontWeight" : "bold","font-size" : "15px"}
					},
					
					labels : {align : 'center',x : 3,y : 20,}
				},
				yAxis : {title : {text : '日总用热量',style : {"font-size" : "14px"}}},
				series : [{data : objs,colorByPoint : true}],
				legend : {enabled : false}
			});
		}
        //小区每日用热统计
        $.get($path_base + '/homePage/getareauseenergy',function(response){
        	
        	var hcData = jQuery.parseJSON(response.replace(/AREANAME/g,'name').replace(/AREA_ENERGY/g,'y'));
        	var data = jQuery.parseJSON(response);
        	var tbodyStr = '';
        	$(data).each(function(index,obj){
        		tbodyStr += '<tr><td>' + (index+1) + '</td><td><a title="用热量统计" data-addtab="builddatastatis" url="builddatastatis?areaguid='+obj['AREAGUID']+'&day='+obj['DDATE']+'" '
        				 +' href="'+$path_base+'/sys/sysuser/home#page/builddatastatis?areaguid='+obj['AREAGUID']+'&day='+obj['DDATE']+'">' + obj['AREANAME'] + '</a></td><td>' + obj['DDATE'] + '</td><td>' + obj['AREA_ENERGY'] + '</td></tr>'; 
        	});
        	
        	$('#everyday-energy tbody').append(tbodyStr);
        	everyEnergyShowColumn(hcData.slice(0,20));
        	yearEnergy(data);
        })
		
		function yearEnergy(conv){
        	$.get($path_base + '/homePage/getareaenergy',function(response){
    			//小区年度耗热统计
    			var jsonData = jQuery.parseJSON(response);
    			var tbodyStr = '';
    			$(jsonData).each(function (index, val) { 
    				$(conv).each(function(j,v2){
    					if(v2.AREAGUID == val.AREAGUID){
    						tbodyStr += '<tr><td>' + (index+1) + '</td><td>' + v2['AREANAME'] + '</td><td>' + v2['CUSTOMER'] + '</td><td>' + v2['AREA'] + '</td><td>2017-2018</td><td>' + val['y'] + '</td></tr>'; 
    					}
    				});
    			});
    			$('#quarter-energy tbody').append(tbodyStr);
    			showColumn(jsonData.slice(0,20));
    			
    		//	yearEnergy(jsonData); 2018110
    		});
        }
		
/*  ------------------ 各小区最新信息统计     8.25新增的     */
		
			/*var newestAreaData;//全部数据
			var newestAreaDataLte;//截取后的数据*/
			$('#area-newspaper').css('width',$(".page-content #area-newspaper").width());
		    $('#chart-switch').click(function(){
		    	var parentWinWidth = $('#area-newspaper').parent().width();
		    	if(this.innerHTML=='完整显示'){
		    		var columnWidth = newestAreaData.length*40;
		            if(parentWinWidth<columnWidth)  $('#area-newspaper').css('width',columnWidth);
		            	else $('#area-newspaper').css('width','auto');
		            handleAreaColumn(newestAreaData);
		            this.innerHTML='局部显示';
		    	}else{
		    		var columnWidth = newestAreaDataLte.length*40;
		            if(parentWinWidth<columnWidth)  $('#area-newspaper').css('width',columnWidth);
		            	else $('#area-newspaper').css('width','auto');
		            handleAreaColumn(newestAreaDataLte);
		            this.innerHTML='完整显示';
		    	}
		    });
			$('#area-newspaper-switch').click(function(){//各小区最新信息统计
				if(this.innerHTML=='显示表格'){
					$('#area-newspaper').fadeOut('fast');
					$('#area-newspaper-table').fadeIn('slow');
					$('#chart-switch').hide();
					this.innerHTML='切换图表'
				}else{
					$('#area-newspaper-table').fadeOut('fast');
					$('#area-newspaper').fadeIn('slow');
					$('#chart-switch').show();
					this.innerHTML='显示表格';
				}
			});
			$('#energy-left-highchart').hover(
					function(){
						$('#everyday-energy').parent().parent().css('overflow','visible');
					},
					function(){
						$('#everyday-energy').parent().parent().css('overflow','hidden');
					}
			);
					
			$('#switch-table-energy').click(function(){//耗热量统计
				if(this.innerHTML=='显示表格'){
					//日耗热部分
					$('#energy-left-highchart').parent().css('margin-top',0);
					$('#energy-left-highchart').hide();
					$('#everyday-energy').show("slow");
					//年耗热部分 
					$('#quarter-energy').parent().css('margin-top','27px');
					$('#3d-columnxs').hide();
					$('#quarter-energy').show('slow');
					this.innerHTML='切换图表'
				}else{
					//日耗热部分
					$('#energy-left-highchart').parent().css('margin-top','-50px');
					$('#everyday-energy').hide();
					$('#energy-left-highchart').show("slow");
					//年耗热部分
					$('#quarter-energy').parent().css('margin-top',0);
					$('#quarter-energy').hide();
					$('#3d-columnxs').show("slow");
					this.innerHTML='显示表格';
				}
			});
			
			function InitLine(a, b, c, d) {
			    $('#area-newspaper').highcharts({
			        chart: {backgroundColor: '#fff',type: 'column'},
			        credits: {enabled: false},
			        title: {text: ''},
			        subtitle: {text: '小区楼栋进回水温度统计分析'},
			        xAxis: {categories: a},
			        yAxis: {min: 0,title: {text: '平均温度 (℃)'}},
			        plotOptions: {
			            column: {pointPadding: 0.2,borderWidth: 0}
			        },
			        tooltip: {
			            shared: true,
			            useHTML: true,
			            headerFormat: '<small>{point.key}</small>',
			            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y} ℃</b></td></tr></tbody></table>',
			            footerFormat: '',
			            valueDecimals: 2
			        },
			        colors: ["#f7a35c","#7cb5ec",  "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
			        series: [{ name: '平均进水温度',data: b},
		                     { name: '平均回水温度',data: c},
		                     { name: '平均温差',data: d}]
	
			    });
			}
		
			function handleAreaColumn(productData){
				var clstr = new Array();
	            var serstr = new Array();
	            var slstr = [];
	            var ydata = new Array();
	            var ydata2 = new Array();
	            var ydata3 = new Array();

	            var sum = 0;
	            $.each(productData, function (i) {
	                sum += Math.abs(Number(productData[i].平均温差));
	            });
	            $.each(productData, function (i) {
	                clstr[i] = productData[i].小区名;
	                serstr[i] = Number(productData[i].平均进水温度);
	                ydata2[i] = Number(productData[i].平均回水温度);
	                ydata3[i] = Math.abs(Number(productData[i].平均温差));

	                var item = [];
	                item.push(productData[i].小区名);
	                item.push(Number(((Math.abs(Number(productData[i].平均温差)) / sum) * 100).toFixed(2)));
	                slstr.push(item);

	            });
	            
	            InitLine(clstr, serstr, ydata2, ydata3);
			} 
			
		   function newspaper_showTable(productData){
			   var tbodyStr = '';
			   $(productData).each(function(index,obj){
				   tbodyStr += '<tr><td>' + (index+1) + '</td><td>' + obj["能源公司"] + '</td><td>' + obj["换热站"] + '</td><td>'+obj["DAY"]+'</td><td>'
				   			+'<a title="最新信息统计" data-addtab="buildtemperature" url="buildtemperature?areaguid='+obj["小区编号"]+'&day='+obj["DAY"]+'" href="'
				   			+$path_base+'/sys/sysuser/home#page/buildtemperature?areaguid='+obj["小区编号"]+'&day='+obj["DAY"]+'">'
				   			+ obj["小区名"] + '</a></td><td>' + obj["住户数"] + '</td><td>' + obj["供热面积"] + '</td><td>'
				   			+ obj["平均进水温度"] + '</td><td>' + obj["平均回水温度"] + '</td><td>' + obj["平均温差"] + '</td></tr>'
			   });
			   $('#area-newspaper-table table tbody').append(tbodyStr);
		   }
			
	       $.get($path_base + '/homePage/getstatisticeacharea',function(response){
	            var productData = jQuery.parseJSON(response);
	            newestAreaData = productData;
	            newspaper_showTable(productData);
	            productData = productData.slice(0,20);//取少部分显示
	            newestAreaDataLte = productData;
	            handleAreaColumn(productData);
	        });
	        
	        //故障部分    #getwarninginfo
	 /*       jQuery('#getwarninginfo').jqGrid({
				url : $path_base + '/homePage/getwarninginfo',
				datatype : "json",
				height : 380,
				rownumbers:true,
				colNames : ['<i class="ace-icon fa fa-caret-right orange"></i>  小区名称','<i class="ace-icon fa fa-caret-right orange"></i>  地址',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  故障名称','<i class="ace-icon fa fa-caret-right orange"></i>  瞬时流量',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  进水温度','<i class="ace-icon fa fa-caret-right orange"></i>  回水温度',
				            '<i class="ace-icon fa fa-caret-right orange"></i>  温差','<i class="ace-icon fa fa-caret-right orange"></i>  抄表时间'],
				colModel : [{name : '小区名称',width : 124,sortable:false},
			 	           {name:'门牌',width : 114,sortable:false},
				            {name:'异常情况',width : 270,sortable:false,formatter:function(cellVal){if(cellVal==null) return ""; return cellVal.replace(/,$/,'');}},
				            {name:'瞬时流量',width: 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('瞬时流量过低')!=-1) return getOverlowStr(cel,obj,'MeterLS');
				            	if(obj['异常情况'].indexOf('瞬时流量过高')!=-1) return getOvertopStr(cel,obj,'MeterLS');
				            	return cel;
				            }},
				            {name:'供水温度',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('供水温度过低')!=-1) return getOverlowStr(cel,obj,'MeterJSWD');
				            	if(obj['异常情况'].indexOf('供水温度过高')!=-1) return getOvertopStr(cel,obj,'MeterJSWD');
				            	return cel;
				            }},
				            {name:'回水温度',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	if(obj['异常情况'].indexOf('回水温度过低')!=-1) return getOverlowStr(cel,obj,'MeterHSWD');
				            	if(obj['异常情况'].indexOf('回水温度过高')!=-1) return getOvertopStr(cel,obj,'MeterHSWD');
				            	return cel;
				            }},
				            {name:'温差',width : 100,sortable:false,formatter:function(cel,op,obj){
				            	setTimeout(function sss() {
				    	        	var warLenth = obj['异常情况'].split(',').length - 1;
				                	var $curRow = $('#' + op.rowId);
				                	if(warLenth == 1) $curRow.addClass("list-group-item-success");
				                	if(warLenth == 2) $curRow.addClass('list-group-item-info');
				                	if(warLenth == 3) $curRow.addClass('list-group-item-warning');
				                	if(warLenth == 4) $curRow.addClass('list-group-item-danger');
				    	        },0);
				            	
				            	if(obj['异常情况'].indexOf('温差过低')!=-1) return getOverlowStr(cel,obj,'MeterWC');
				            	if(obj['异常情况'].indexOf('温差过高')!=-1) return getOvertopStr(cel,obj,'MeterWC');
				            	return cel;
				            }},
				            {name:'抄表时间',width : 110,sortable:false}],
				scroll : 1,
				rowNum : 12,
				shrinkToFit : false
			});
	        
	   	$(window).on('resize.jqGrid', function() {
	   		$('#getwarninginfo').jqGrid('setGridWidth', $(".page-content").width()-25);
	   	});
	   	$(window).triggerHandler('resize.jqGrid');
	   	
	   	$('#warning-more').click(function(){
	   		window.location.href="#page/searchfaultparamwarn";
	   	});
	   	*/
	
/*自定义按钮*/
	   	var load_customer_btn = function(){
	   		$.get($path_base + '/homePage/getCustomerBtn', function (response) {
		        var objs = jQuery.parseJSON(response);
		        var str = ''; 
		        $(objs).each(function (index, val) {
		        	var cur_url = val["DATA_URL"].replace('page/','');
		        	str += '<div class="col-sm-3">\
			                    <div class="panel mini-box" data-addtab="'+ cur_url +'" url="'+ cur_url +'" title="' +  val["MENU_NAME"] + '"> \
			                            <span class = "btn-icon btn-icon-round btn-icon-lg-alt ' + val["BG_CLASS"] + '" > \
			                                <i class="'+ val["MENU_CLASS"].replace(/\s+\S*$/,'') +'"></i> \
			                            </span> \
			                            <div class="box-info"> \
			                                <p class="size-custom-but">' + val["MENU_NAME"] + '</p> \
			                                    <p class="text-muted"> \
			                                        <span style="float: left;">'+ val["PARENT_NAME"] +'</span> \
			                                    </p> \
			                            </div> \
                                        <p class="lastspan"> \
	                                        <span style="float: right;" title="删除"> \
	                                            <a href="javascript:;" data-btn-id=\'' + val["ID"] + '\' style="float: right;"><i class="fa fa-trash-o red cust-font-size"></i>删除</a> \
	                                        </span> \
	                                        <span style="float: right;" title="修改"> \
	                                            <a href="javascript:;" onclick=\'javascript:$("#modal-table").modal("toggle");$("#cust-btn-id").val('+val["ID"]+');$("#but-seq").val('+val["SEQ"]+');\' style="float: right;"><i class="fa fa-edit cust-font-size" style="cursor: copy;"></i>编辑</a> \
	                                        </span> \
        			                    </p> \
			                    </div> \
			                </div> \
			            ';
		        });
	
		        
		        $('#home-customer-btns').empty().append(str);
		        if(str!=''){
		        	var newBtn = '<span style="float: right;" title="新增自定义按钮"> \
			                        	<a href="javascript:;" onclick=\'javascript:$("#modal-table").modal("toggle");\' style="float: right;"><i class="fa fa-plus-square green cust-font-size" style="cursor: cell;"></i>新增</a> \
				                    </span> \
		        				 ';
		        	$('#home-customer-btns .col-sm-3:last .panel.mini-box .lastspan').append(newBtn);
		        }else{//未设置自定义按钮
		        	var noBtn =  '<div class="col-sm-3">\
					        		<div class="panel mini-box" onClick=\'javascript:$("#modal-table").modal("toggle");$("#but-seq").val(1);\'> \
				                        <span class = "btn-icon btn-icon-round btn-icon-lg-alt green" > \
				                            <i class="fa fa-plus-square"></i> \
				                        </span> \
				                        <div class="box-info"> \
					                            <p class="size-custom-but">新增</p> \
		        								<p class="text-muted">自定义按钮</p> \
				                        </div> \
				                    <div> \
						          </div> \
						        ';
		        	$('#home-customer-btns').append(noBtn);
		        }
		        
		        //data-btn-id  删除的 id
		        $('#home-customer-btns p span a[data-btn-id]').click(function(){
		        	var btnId = $(this).attr("data-btn-id");
		    	  	var r = confirm("确认要删除自定义按钮？");
		    	  	if(r == true){
		    	  		$.get($path_base + "/homePage/delCustBtn?id=" + btnId,function(response){
		    	  			if(response == true){
		    	  				load_customer_btn();
		    	  			}else alert("删除失败！");
		    	  		})
		    	  	}
		        });
		        $('.col-sm-3 .panel.mini-box a').click(function(e){e.stopPropagation();})
		        if ((navigator.userAgent.indexOf('MSIE') >= 0) 
		        		&& (navigator.userAgent.indexOf('Opera') < 0)){
		        	$('.col-sm-3 .panel.mini-box a').remove();
		        }
		    });
	   	}
	   	
	   	
/*  自定义按钮模态   */
		var treeflag = 0;
		$("#modal-table").on('shown.bs.modal', function() {
			var remoteDateSource = function(options, callback) {
    			var parent_id = null;
    			if (!('text' in options || 'type' in options)) {
    				parent_id = 0;
    			} else if ('type' in options && options['type'] == 'folder') {
    				if ('additionalParameters' in options && 'children' in options.additionalParameters)
    					parent_id = options.additionalParameters['id'];
    			}
    			if (parent_id !== null) {
    				$.ajax({
    					url : $path_base + '/sys/authority/getHomeBtnTreeList',
    					data : {
    						id : parent_id,
    						//roleKey : $("#roleKeyId").val()
    					},
    					type : 'POST',
    					dataType : 'json',
    					complete : function(response) {
    						var returninfo = eval("(" + response.responseText + ")");
    						if (returninfo.status == "OK") {
    							callback({
    								data : returninfo.data
    							});
    						}
    					}
    				});
    			}
    		};
    		$('#authorityTree').ace_tree({
    			dataSource : remoteDateSource,
    			multiSelect : false,
    			loadingHTML : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
    			'open-icon' : 'ace-icon fa fa-check',
    			'close-icon' : 'ace-icon fa fa-times',
    			cacheItems : false,
    			folderSelect : false
    		});
		    if(treeflag > 0){
		    	$('#authorityTree').tree('render');
		    }
		    treeflag++;
		});
		$('#submitButton').on('click', function() {
			var output = '';
			output = $('input[name="xxii"]:checked').val();
			if(output == undefined){
				$.gritter.add({
	                title: "自定义主页按钮",
	                text: "请选择一个菜单",
	                class_name: "gritter-error gritter-center"
	            });  
    			return;
			}
			var bgClass = '';
			bgClass = $('input[name="btn_bg_class"]:checked').val();
			if(bgClass == undefined){
				$.gritter.add({
	                title: "自定义主页按钮",
	                text: "请选择按钮背景色",
	                class_name: "gritter-warning gritter-center"
	            });  
    			return;
			}
				
			var _post_data = {
				/*seq : $("#but-seq").val(),*/
				menuCode : output,
				/*id : $("#cust-btn-id").val(),*/
				bgClass: bgClass
			};
			if($("#but-seq").val() != '') _post_data.seq = $("#but-seq").val();
			if($("#cust-btn-id").val() != '') _post_data.id = $("#cust-btn-id").val();
			$.ajax({
				url : $path_base + "/homePage/setCustomerBtn",
				data : _post_data,
				type : 'POST',
				dataType : 'json',
				complete : function(response) {
					$("#modal-table").modal("toggle");
					load_customer_btn();
					$('input[name="btn_bg_class"]:checked').attr('checked',false).parent().parent().removeClass('active');
				}
			});
		});
		$('#cancelBtn').click(function(){$('input[name="btn_bg_class"]:checked').attr('checked',false).parent().parent().removeClass('active');});
		
		/*加载自定义按钮*/
		load_customer_btn();
	   	
});

//故障部分    #getwarninginfo
var waringHomeTo = function(clientNO,date,btn,meterid){
	var url = $path_base + '/sys/sysuser/home#page/clientCharts?clientno='+clientNO+'&date='+date+'&btn='+btn+'&meterid='+meterid;
	document.location.href = url;
 }
var getOverlowStr = function(cel,obj,btn){
	return '<b class="green" title="参数过低" data-addtab="clientCharts" url="clientCharts?clientno='+obj['CLIENTNO']+'&date='+obj['抄表时间']+'&btn='+btn+'&meterid='+obj['METERID'] + '" '
	+ 'onClick="waringHomeTo(\''+obj['CLIENTNO']+'\',\''+obj['抄表时间']+'\',\''+btn+'\',\''+obj['METERID']+'\');">'+cel+' <li class="fa fa-arrow-down"></li></b>';
}
var getOvertopStr = function(cel,obj,btn){
	return '<b class="red" title="参数过高" data-addtab="clientCharts" url="clientCharts?clientno='+obj['CLIENTNO']+'&date='+obj['抄表时间']+'&btn='+btn+'&meterid='+obj['METERID'] + '" '
	+' onClick="waringHomeTo(\''+obj['CLIENTNO']+'\',\''+obj['抄表时间']+'\',\''+btn+'\',\''+obj['METERID']+'\');">'+cel+' <li class="fa fa-arrow-up"></li></b>';
}


