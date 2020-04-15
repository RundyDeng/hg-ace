<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>

	<title>供热大数据智慧运行系统</title>
	<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
		
	<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
	<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />


	<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
	
.ui-dialog .ui-dialog-titlebar-close::before, .ui-jqdialog .ui-dialog-titlebar-close::before, .ui-dialog .ui-jqdialog-titlebar-close::before, .ui-jqdialog .ui-jqdialog-titlebar-close::before {

    content: "x";
    }
		
	</style>
</head>
<body>

	<div class="container-fluid" style="background-color: #f7f7f9;">
		
<style>
     .flip-clock-wrapper ul{
        margin: 3px;
    }
    #build_th th{
        min-width: 69px;
    }   
    .input-group {
   		float: left;
   		max-width: 10%;
   }
</style>
		
<br/>
		<div class="row" style="height: 30px;">
			<div class="form-inline">
			<div class="col-md-11" >
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">小区1</span>
					  <select id="community" onchange="building(this)" style="width: 100px;" class="form-control">
					  </select>
				</div>
				<div class="input-group" style="margin-right: 12px;">
					<span class="input-group-addon" id="basic-addon3" >楼栋1</span> <select
						id="build" class="form-control" style="width: 70px;"></select>
				</div>
				
				<div class="input-group" style="min-width: 170px;">
					  <span class="input-group-addon" id="basic-addon3" >开始时间</span>
<%
    Calendar c = Calendar.getInstance();
    String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
    c.add(Calendar.DATE,-7);
    String lastWeekDay = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
					  <input type="text" class="form-control" value="<%=lastWeekDay %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
				<div class="input-group" style="min-width: 170px;margin-right: 12px;">
					  <span class="input-group-addon" id="basic-addon3">结束时间</span>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date2" readonly="readonly" aria-describedby="basic-addon3">
				</div>
				
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3" >小区2</span>
					  <select id="community2"  onchange="building2(this)" class="form-control" style="width: 100px;">
					  </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon3">楼栋2</span> <select
						id="build2" class="form-control"  style="width: 70px;"></select>
				</div>
				
			</div>
			
			<div class="col-md-1" >
				<button type="button" class="btn btn-success" style="float: left; border-width: 0px;" id="build_data_search">查    询</button>
			</div>
		</div>
		</div>
		<br/>
		
		<div class="row" style="overflow: auto; margin-left: 1px; margin-right: 1px;">
		    
			      
			      <table id="build_table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr id="build_th">
					      
					    </tr>
					  </thead>
					  <tbody id="build_td">
                        
				      </tbody>
					</table>
			      
			      
 		 </div>
        
        <div class="row" style="margin-left: 1px; margin-right: 1px;word-break:break-all;">
            <div class="col-md-7" style="border:0px solid red;overflow-x: hidden;">
              
				<div id="3d-column" style="min-width:770px;margin-left: -120px;min-height: 450px;"></div>
            </div>
            <div class="col-md-5" style="border:0px solid red;min-height: 450px;">
            	
                <div id="3d-pie"></div>
            </div>
        </div>
         
		
	</div>
	
	
</body>
</html>

<script>
    
var _areaguid,_buildno;
var _areaguid2,_buildno2;

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
	           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
	          }
	       }
	    var sel = $('#build');
      	        					    
	    sel.empty().append(s);  
	});
};
var building2 = function(obj){
	_areaguid2 = obj.value;
	if(_areaguid2==''||_areaguid2=='null')
		return
	$.get('${contextPath}/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid2, function(data){
		
		var response = jQuery.parseJSON(data);
		var s = ' ';
	      if (response && response.length) {
	          for (var i = 0, l = response.length; i < l; i++) {
	           var ri = response[i];
	           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
	          }
	       }
	    var sel = $('#build2');
      	        					    
	    sel.empty().append(s);  
	});
};
       
    
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
	   			/* "${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js", */
                ,null ];
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
		     $('#community2').append(s);
		     var areaguid = '<%=(String) request.getSession().getAttribute("areaGuids")%>';
		     if(areaguid=='null'||areaguid=='')
				return;
		     $('#community option[value="'+areaguid+'"]').attr('selected',true);
		     $('#community2 option[value="'+areaguid+'"]').attr('selected',true);
		     var obj = [];
		     obj.value=areaguid;
		     building(obj);
		     building2(obj);
		}
	});

	$("#input_sel_date").datepicker({
    		dateFormat: 'yy-mm-dd',
    		defaultDate : new Date(),
	});
	
    $("#input_sel_date2").datepicker({
       dateFormat: 'yy-mm-dd',
        defaultDate: new Date()-7,
    });
    
    $('#build_data_search').click();
	
});
    
$('#build_data_search').click(function(){
	page = 1;
	var startDate = $('#input_sel_date').val();
    var endDate = $('#input_sel_date2').val();
    var areaguid = $('#community').val();
    var buildno = $('#build').val();
    var areaguid2 = $('#community2').val();
    var buildno2 = $('#build2').val();
	if(areaguid==null){
		areaguid='1361';
		buildno='10291';
		areaguid2='1361';
		buildno2='10291';
	}
    $.get('${contextPath}/dataanalysis/buildcomparisoncontr/getbuildcomparison?areaguid='+areaguid+'&startdate='+startDate+'&enddate='+endDate
    		+'&buildno='+buildno+'&buildno2='+buildno2+'&areaguid2='+areaguid2,function(response){
        var jsonData = jQuery.parseJSON(response);
        showTable(jsonData);
       
        showColumn(jsonData);
	    showPie(jsonData);
    })
	
}); 
	function getType(o)
	{
	    var _t;
	    return ((_t = typeof(o)) == "object" ? o==null && "null" || Object.prototype.toString.call(o).slice(8,-1):_t).toLowerCase();
	}
	function extend(destination,source)
	{
	    for(var p in source)
	    {
	        if(getType(source[p])=="array"||getType(source[p])=="object")
	        {
	            destination[p]=getType(source[p])=="array"?[]:{};
	            arguments.callee(destination[p],source[p]);
	        }
	        else
	        {
	            destination[p]=source[p];
	        }
	    }
	}
    
    
    
    function roundFix(cellvalue){
		if(cellvalue==''||cellvalue==undefined)
			return 0;
		return cellvalue.toFixed(2);
    }
	
    var array_build_name = new Array();
    var array_build_data_column = new Array();
    var array_build_data_pie = new Array();
    var array_build = new Array();
    var array_build_2 = new Array();
    var array_build_pie = [];
    var _sum = 0.0;
    var showTable = function(objs){
        array_build = [];
        array_build_2 = [];
        array_build_name = [];
        array_build_data_pie = [];
        array_build_data_column = [];
        array_build_name.push(null);
       
        array_build_data_column.push('平均每平米耗热(KWH/M2)');
        array_build_data_pie.push('各小区间耗热比');
        
        var th = '<th style="min-width: 170px;">分析项目</th>';
        var td1 = '<td>总耗热量(KWH)</td>';
        var td2 = '<td>分析对象(户数)</td>';
        var td3 = '<td>平均每平米耗热(KWH/M2)</td>';
        
        var pieTd = '<td>pie</td>';
        
        $(objs).each(function(i,obj){
            if(obj.BUILD_AVERAGE_ENERTY!=-1){
                _sum += parseFloat(roundFix(obj.BUILD_AVERAGE_ENERTY));
            }
        })
        $(objs).each(function(index,obj){
            array_build_name.push(obj.BUILDNAME);
            th += '<th>'+obj.BUILDNAME+'</th>';
            td1 += '<td>'+roundFix(obj.BUILD_ENERGY)+'</td>';
            td2 += '<td>'+obj.CLIENT_TOTLE+'</td>';
            
            if(obj.BUILD_AVERAGE_ENERTY==-1){
                td3 += '<td></td>';
                array_build_data_column.push(null);
                array_build_data_pie.push(0);
            }else{
                td3 += '<td>'+roundFix(obj.BUILD_AVERAGE_ENERTY)+'</td>';
                pieTd += '<td>'+parseFloat(roundFix(roundFix(obj.BUILD_AVERAGE_ENERTY)/_sum))+'</td>';
                array_build_data_column.push(roundFix(obj.BUILD_AVERAGE_ENERTY));
                array_build_data_pie.push(parseFloat(roundFix(roundFix(obj.BUILD_AVERAGE_ENERTY)/_sum)));
            }
        });
		
        //最后tr仅做测试用
        var td = '<tr>' + td1 + '</tr><tr>' + td2 + '</tr><tr>' + td3 + '</tr><tr style="display:none;">' + pieTd + '</tr>';
        
        $('#build_th').empty().append(th);
        $('#build_td').empty().append(td);
       
        array_build.push(array_build_name);
        array_build.push(array_build_data_column);
        array_build_2.push(array_build_name);
        array_build_2.push(array_build_data_pie);
		extend(array_build_pie,array_build_2);
    };
	
    
	var showPie = function(objs){
          var pencent=[];
		 $(objs).each(function(i,obj){
			 var item=[];
             item.push(obj.BUILDNAME);
             item.push(parseFloat(roundFix(roundFix(obj.BUILD_AVERAGE_ENERTY)/_sum)));
             pencent.push(item);
         })
	    $('#3d-pie').highcharts({
	    	
		 	exporting: {
                enabled:false
    		},
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'pie',
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
	            text: '小区楼栋每平米单耗数据饼状图'
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
	            name: '每平米单耗',
	            data: pencent
	            
	        }]
	    });
	}

	var showColumn = function(objs){
		  var buildname=[];
          var avr_=[];
		 $(objs).each(function(i,obj){
             buildname.push(obj.BUILDNAME);
             avr_.push(obj.BUILD_AVERAGE_ENERTY);              
         })
         
		 $('#3d-column').highcharts({
			 
			  chart: {
		            type: 'column'
		        },
		        title: {
		            text: '每平米单耗'
		        },
		       
		        xAxis: {
		            categories: buildname,
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: '每平米单耗(KWH/M2)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            '<td style="padding:0"><b>{point.y:.1f} KWH/M2</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: '每平米单耗',
		            data: avr_
		        }]
		    });
	}
 
</script>
