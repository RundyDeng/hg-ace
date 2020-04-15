<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<!-- <meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="viewport"
		content="width=device-width, 
	                                     initial-scale=1.0, 
	                                     maximum-scale=1.0, 
	                                     user-scalable=no"> -->
<title>供热大数据智慧运行系统</title>
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
	href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />

<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
<%-- <script
		src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script
		src="${contextPath}/static/pageclock/compiled/flipclock.js"></script> --%>



<style type="text/css">
.table-bordered, .table-bordered td, .table-bordered th {
	border: 1px solid #c6cbce;
}

tbody th {
	font-weight: unset;
}

.ui-dialog .ui-dialog-titlebar-close::before, .ui-jqdialog .ui-dialog-titlebar-close::before,
	.ui-dialog .ui-jqdialog-titlebar-close::before, .ui-jqdialog .ui-jqdialog-titlebar-close::before
	{
	content: "x";
}

td{
	text-align:center;

}

</style>
</head>
<body>

<!-- 	<div class="container-fluid" style="background-color: #f7f7f9;">
 -->
		<style>
/*      .flip-clock-wrapper ul{
        margin: 3px;
    }
    #build_th th{
        min-width: 69px;
    }   
    */
.flip-clock-wrapper ul {
	margin: 3px;
}

#build_th th {
	min-width: 69px;
}

.input-group {
	float: left;
	max-width: 10%;
}
</style>

		<br />
		
			<img src="${contextPath}/static/image/zhuhuhaorezhibiaofenxi.png" /> 
			
		<div align="center">	同一用户不同室外温度的热耗指标对比分析</div>

	<%-- 	<div class="container-fluid">
		<div class="row" style="height: 30px; margin-left: 3px">
			<!-- 选择小区 -->
			<!-- <div class="col-md-3">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">选择小区: </span>
					  <select id="search_areaname" class="form-control">
					  	
					  </select>
					  <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3">
				</div>
			</div> -->

			<!-- 小区 -->
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon3">小区</span> <select
					id="community" onchange="building(this)" style="width: 90px;"
					class="form-control">
				</select>
			</div>
			<!-- 楼栋 -->
			<div class="input-group" style="margin-right: 12px;">
				<span class="input-group-addon" id="basic-addon3">楼宇</span> <select
					id="build" onchange="uniting(this)" class="form-control"
					style="width: 90px;"></select>
			</div>
			<!-- 单元 -->
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon3">单元</span> <select
					id="unit" onchange="flooring(this)" class="form-control"
					style="width: 90px;">
				</select>
			</div>

			<!-- 楼层 -->
			<div class="input-group" style="margin-right: 12px;">
				<span class="input-group-addon" id="basic-addon3">楼层</span> <select
					id="floor" onchange="dooring(this)" class="form-control"
					style="width: 90px;"></select>
			</div>

			<!-- 门牌 -->
			<div class="input-group" style="margin-right: 12px;">
				<span class="input-group-addon" id="basic-addon3">门牌</span> <select
					id="door" onchange="oldInfo(this)" class="form-control"
					style="width: 90px;"></select>
			</div>

			<!--开始时间 -->
			<div class="input-group" style="min-width: 180px;">
				<span class="input-group-addon" id="basic-addon3">开始时间</span>
				<%
					Calendar c = Calendar.getInstance();
					String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
					c.add(Calendar.DATE, -5);
					String lastWeekDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
				%>
				<input type="text" class="form-control" value="<%=today%>"
					id="input_sel_date" readonly="readonly"
					aria-describedby="basic-addon3">
			</div>


			<!-- 查询 -->
			<!-- 返回 -->
			<div class="col-md-1">
				<button type="button" class="btn btn-success"
					style="float: left; border-width: 0px;" id="build_data_search">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
			<!-- 	<button type="button" onClick="javascript:history.back();"
					style="border-width: 0px; margin-left: 5px;"
					class="btn btn-success-outline">返&nbsp;&nbsp;回</button> -->
			</div>
		</div>
</div>


		<br />
		
	<div class="container-fluid"> 
		<div class="row"
			style="overflow-x: auto; margin-top: 20px; margin-left: 10px; margin-right: 0px; word-break: break-all;">
			<!--  -->
			<div class="col-md-6"
				style=" border: 0px solid red; ">

				<div id="3d-column"
					style="min-width: 570px; margin-left: -20px; min-height: 450px;"></div>
			</div>

		 	<!-- 表格  -->
			<div class="col-md-6"
				style=" border: 0px solid red; min-height: 450px; min-width: 570px;">

				<div id="3d-pie"
					style="overflow: auto; margin-left: 1px; margin-right: 1px;">
					
					<table id="build_table2"
						class="table table-bordered table-hover table-striped"
						style="margin-bottom: 0px; ">
				<!-- 		<thead>
					    <tr id="build_th">
					      
					    </tr>
					  </thead>
					  <tbody id="build_td"> 
                        
				      </tbody>-->
					</table>
				</div>
			</div>
		</div>
	</div>
</div> --%>

</body>
</html>

<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                //"${contextPath}/static/old/highcharts.js",
                 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
	   			/* "${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js", */
                null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	   	
	$.ajax({
		url : '${contextPath}/sys/todaydata/getAreaDownList',
		type : 'POST',
		dataType : 'json',
		success : function(data){
			var response = data;
		      var s = '';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
		           var ri = response[i];
		           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
		          }
		       }
		     $('#community').append(s);
	
		     var areaguid = '<%=(String) request.getSession().getAttribute("areaGuids")%>';
		     if(areaguid=='null'||areaguid=='')
				return;
		     
		     $('#community option[value="'+areaguid+'"]').attr('selected',true);
	
		     var obj = [];
		     obj.value=areaguid;
		     building(obj);
		}
	});

	

	$("#input_sel_date").datepicker({
			dateFormat: 'yy-mm-dd',
			defaultDate : new Date(),
	});

/* 查询监听 */
	$('#build_data_search').click(function(){
		
		page = 1;
		/* 小区 */
		var areaguid = $('#community').val();
	
		/* 楼栋 */
		var buildno = $('#build').val();
	
		/* 单元 */
		var unit = $('#unit').val();

		/* 楼层 */
		var floor = $('#floor').val();

		/* 门牌 */
		var door=$('#door').val();
		
		
		 /*日期  */
		var _date = $('#input_sel_date').val();
	    

     if(areaguid==''||areaguid==null){
    		alert("请选择小区！");
    	 return;
     }
     if(buildno==''||buildno==null){
    		alert("请选择楼宇！");
    	 return;
     }
     if(unit==''||unit==null){
 		alert("请选择单元！");
    	 return;
     }
     if(floor==''||floor==null){
 		alert("请选择楼层！");
    	 return;
     }
     if(door==''||door==null){
  		alert("请选择门牌！");
     	 return;
      }
		
     if(_date==''||_date==null){
   		alert("请选择开始时间！");
      	 return;
     }
     
     
	    $.get('${contextPath}/dataanalysis/useheatindexanalysiscontr/getuseheatindexanalysis?areaguid='+areaguid
	    		+'&buildno='+buildno
	    		+'&unit='+unit
	    		+'&floor='+floor
	    		+'&door='+door
	    		+'&date='+_date,function(response){
	        var productData = jQuery.parseJSON(response);
	        
	   //     alert(productData);
	      //  showTable(productData);
	      
/* 	        var data=[{"user":1124308,"date":"一月5日","outdoor":-1.5,"area":134.74,"average":24.6,"hourheat":4.2,"heatindex":45},
	        	{"user":1124308,"date":"一月6日","outdoor":-7.3,"area":134.74,"average":24.3,"hourheat":3.7,"heatindex":33},
	        	{"user":1124308,"date":"一月7日","outdoor":-5.8,"area":134.74,"average":22.2,"hourheat":4.8,"heatindex":45},
	        	{"user":1124308,"date":"一月8日","outdoor":-7.2,"area":134.74,"average":22.1,"hourheat":4.8,"heatindex":43},
	        	{"user":1124308,"date":"一月9日","outdoor":-5.6,"area":134.74,"average":22.5,"hourheat":4.4,"heatindex":41},
	        	{"user":1124308,"date":"一月10日","outdoor":-10,"area":134.74,"average":22.8,"hourheat":6,"heatindex":49}]; */
	        
	        tabledata(productData);

	        var clstr = new Array();
	        var serstr = new Array();
	        var slstr = [];
	        var ydata = new Array();
	        var ydata2 = new Array();
	        var ydata3 = new Array();
	        

	   /*      var sum = 0;
	        $.each(productData, function (i) {
	            sum += Math.abs(Number(productData[i].平均温差));
	        }); */
	        $.each(productData, function (i) {
	           /*  clstr[i] = productData[i].楼栋号;
	            serstr[i] = Number(productData[i].平均进水温度);
	            ydata2[i] = Number(productData[i].平均回水温度);
	            ydata3[i] = Math.abs(Number(productData[i].平均温差)); */

	         	//date 日期
	            clstr[i] = productData[i].date;
	        	//平均室温
	            serstr[i] = Number(productData[i].average);
	        	//室外温度
	            ydata2[i] = Number(productData[i].outdoor);
	        	//热指标
	            ydata3[i] = Math.abs(Number(productData[i].heatindex)); 
	            
	        /*     var item = [];
	            item.push(productData[i].楼栋号);
	            item.push(Number(((Math.abs(Number(productData[i].平均温差)) / sum) * 100).toFixed(2)));
	            slstr.push(item); */

	        }); 
	        
	      
	        InitLine(clstr, serstr, ydata2, ydata3);
	       // InitPie(slstr);
	        
	        _J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
	    })
		
	});

	
	
});


var _areaguid,_buildno,_unitno,_floorno,_doorno;

var building = function(obj){
	
	_areaguid = obj.value;
	if(_areaguid==''||_areaguid=='null')
		return
	$.get('${contextPath}/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
		
		var response = jQuery.parseJSON(data);
		
		var s = ' ';
	      if (response && response.length) {
	          for (var i = 0, l = response.length; i < l; i++) {
	           var ri = response[i];
	           s += '<option value="' + ri['BUILDCODE'] + '">' + ri['BUILDNAME'] + '</option>';
	          }
	       }
	    var sel = $('#build');
	    
	    emptyAndReset(sel);	        	        					    
		    emptyAndReset($('#unit'));
	    emptyAndReset($('#floor'));
	    emptyAndReset($('#door')); 
	    sel.append(s);  
	    
	   //     $('#build option[value="'+BUILDNAME+'"]').attr('selected',true);
	});
};

var uniting = function(obj){
	_buildno=obj.value;
	if(_buildno==''){
		return;
	}
	$.get('${contextPath}/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
			+"&BUILDCODE="+_buildno, function(data){
		
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
}

var flooring = function(obj){
	
	_unitno = obj.value;
	if(_unitno=='')
		return;
	$.get('${contextPath}/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
			+"&BUILDCODE="+_buildno+"&UCODE="+_unitno, function(data){
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
	_floorno = obj.value;
	if(_floorno=='')
		return;
	$.get('${contextPath}/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
			+"&BUILDCODE="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno, function(data){
		
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
	if(_doorno=='')
		return;
	$('#meterid').val('');
	$('#client').val('');
	/* $.get('${contextPath}/sys/todaydata/getRemainInfo?AREAGUID='+_areaguid
			+"&BUILDCODE="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno+"&doorno="+_doorno,
		function(){}
	) */
};

function tabledata(data){
	var trs="<tr><td colspan=7 align=\"center\" ><b>热表数据分析用户热耗指标</b></td><tr>";
	trs+="<tr><td>用户</td><td>日期</td><td>室外<br/>温度</td><td>面积</td><td>平均<br/>室温</td><td>小时热量<br/>(kW)</td><td>热指标<br/>(w/㎡h)</td></tr>";
	$.each(data,function(a,b){
		trs+="<tr><td>"+b.user+"</td>"+"<td>"+b.date+"</td>"+"<td>"+b.outdoor+"</td>"+"<td>"+b.area+"</td>"
		+"<td>"+b.average+"</td>"+"<td>"+b.hourheat+"</td>"+"<td>"+b.heatindex+"</td></tr>";
	});
	$("#build_table2").empty().append(trs);
}



 function showTable(productData){
		var trs = "<tr><th style='min-width: 170px;'>用户</th>";
        $.each(productData, function (j, m) {
        	   trs += "<th style='min-width: 60px;'><a href='${contextPath}/sys/sysuser/home#page/todaydata?buildno="+m.BUILDNO+"&day="+$('#input_sel_date').val()+"'>" + m.楼栋号 + /* "栋"+ */ "</a></th>"; 
        });
        
       
        trs += "</tr>";
        var td = "<tr><td>平均进水温度 (℃)";
        $.each(productData, function (i, n) {
            td += "<td>" + n.平均进水温度 + "</td>";

        });
        td += "</tr>";
        var tds = "<tr><td>平均回水温度 (℃)</td>";
        $.each(productData, function (a, b) {
            tds += "<td>" + b.平均回水温度 + "</td>";

        });
        tds += "</tr>";
        var tb = "<tr><td>平均温差(℃)</td>";
        $.each(productData, function (c, d) {
            tb += "<td>" + d.平均温差 + "</td>";

        });
        tb += "</tr>";
        var tbs = "<tr><td>分析对象(户)</td>";
        $.each(productData, function (c, d) {
            tbs += "<td>" + d.户数 + "</td>";

        });
        tbs += "</tr>";
        tbody = trs + td + tds + tb + tbs;

        $("#build_table").empty().append(tbody);
	} 
	
	function InitPie(m) {
	    $('#3d-pie').highcharts({
	    	
		 	exporting: {
                enabled:false
    		},
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: '小区楼栋平均温差数据饼状图'
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '平均温差',
	        }]


	    });
	}
	
	
	
	function InitLine(a, b, c, d) {
	    $('#3d-column').highcharts({
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'line'
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: '热耗指标分析'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: a,
	            gridLineWidth: 0
	            
	        },
	        yAxis: [{
	            min: 0,
	            title: {
	                text: ''
	            },
	           tickInterval: 10,
	           gridLineWidth: 0
	         
	        },{
	        	min:-15,
	        	title:{
	        		text:''
	        	},
	        	opposite: true,
	        	tickInterval: 5
	        }],

	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            },
	            series:{
	            	dataLabels:{
	            		enabled:true,
	            		format:'{y}'
	            	}
	            }
	        },
	        tooltip:'null',
	        /* tooltip: {
	            shared: true,
	            useHTML: true,
	            headerFormat: '<small>{point.key}</small>',
	            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y} ℃</b></td></tr></tbody></table>',
	            footerFormat: '',
	            valueDecimals: 2
	        }, */
	        series: [{ name: '室内温度',
	            data: b
	        },
	                         { name: '室外温度',
	                             data: c,
	                             yAxis:1
	                         },
	                         { name: '燃指标',
	                             data: d
	                         }],
	                         

	    });
	}
   
</script>
