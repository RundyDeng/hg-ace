<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
		<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
		
	<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
	<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
	
		<link rel="stylesheet" href="${contextPath}/static/bootstrap-4.0/css/bootstrap-datetimepicker.min.css" />
	<%-- <script
		src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js"></script>
	<script
		src="${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script
		src="${contextPath}/static/pageclock/compiled/flipclock.js"></script> --%>
		


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
<body onload="$('#build_data_search').click()">

<!-- 	<div class="container-fluid" style="background-color: #f7f7f9;"> -->
		
<style>
     .flip-clock-wrapper ul{
        margin: 3px;
    }
    #build_th th{
        min-width: 69px;
    }   
   
</style>
		
<br/>
	<img src="${contextPath}/static/image/gongrehaorefenxi.png" /> 
	<div align="center">吴忠热力：两个供暖季样本户数1283户，150天供热周期，80%样本介于0.31-0.51之间。
	</div>

<%-- <div class="container-fluid">
		<div class="row" style="height: 30px;">
			<!-- 选择小区 -->
			<div class="col-md-3 col-sm-4 col-xs-6">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">选择小区: </span>
					  <select id="search_areaname" class="form-control">
					  	
					  </select>
					  <!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			<!-- 选择时间 -->
			<div class="col-md-3 col-sm-3 col-xs-6">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">选择时间:</span>
					  				  
					
<%
	String today = (String)request.getParameter("day");
	if(today==""||today==null){
		Calendar c = Calendar.getInstance();
		
	    today = new SimpleDateFormat("yyyy").format(c.getTime()); 
	}
%>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				
				
					 <!--  <select id="input_sel_date" >
					  	<option value="2017">2017</option>
					  	<option value="2016">2016</option>
					  	<option value="2015">2015</option>
					  	<option value="2014">2014</option>
					  </select> -->
					  
				</div>
			</div>
			
			<!-- 对比时间 -->
			<div class="col-md-3 col-sm-3 col-xs-6">
			
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon4">对比时间:</span>
					  				  			
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date2" readonly="readonly" aria-describedby="basic-addon4">
				
					<!--   <select id="input_sel_date2" >
					  	<option value="2017">2017</option>
					  	<option value="2016">2016</option>
					  	<option value="2015">2015</option>
					  	<option value="2014">2014</option>
					  </select> -->
				</div>
				
			</div>
			
			<div class="col-md-3 col-md-offset-0 col-sm-2 col-sm-offset-0 col-xs-2 col-xs-offset-2" >
				<button style="border-width: 0px" type="button" class="btn btn-success" id="build_data_search">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
<!-- 				<button type="button" onClick = "javascript:history.back();" class="btn btn-success-outline">返&nbsp;&nbsp;回</button>
 -->			</div>
		</div>
</div>		
		<br/>
		
	<!-- 	<div class="row" style="overflow-x: auto; margin-left: 1px; margin-right: 1px;">
		    
			      表格 
			      <table id="build_table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead>
					    <tr id="build_th">
					      
					    </tr>
					  </thead>
					  <tbody id="build_td">
                        
				      </tbody>
					</table>
					      
 		 </div> -->
        <div class="container-fluid">
	        <div class="row" style="overflow-x: auto;margin-left: 1px; margin-right: 1px;word-break:break-all;">
	        	<!--柱状图  -->
	           <div class="col-md-6" style=" float:left ;border:0px solid red;">     
						<div id="3d-column" style="min-width:400px;margin-left: 0px;min-height: 450px;"></div>
	            </div>
	            
	             <!-- 柱状图2 -->
	            <div class="col-md-6" style=" float:left ;border:0px solid red;">
	            	
	                <div id="3d-pie" style="min-width:400px;margin-left: 0px;min-height: 450px;"></div>
	            </div>
	            
	        </div>	
        </div>
	</div>	 --%>
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
	   			"${contextPath}/static/bootstrap-4.0/js/bootstrap-datetimepicker.js", 
	   			/* "${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js", */
                null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	   	
	$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
		var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
		var urlParm = '<%=(String)request.getParameter("areaguid")%>';
		if(urlParm!='null') areaguid = urlParm;
		var flagName = '';
			var response = jQuery.parseJSON(data);
		      var s = '';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
		        	   s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';   
		          }
		       }
		      s += "<script>$('select option[value=\""+areaguid+"\"]').change().attr('selected',true);if('<%=(String)request.getParameter("areaguid")%>'!='null') $('#build_data_search').click();</sc"+"ript>  ";
		      $('#search_areaname').empty().append(s);
	})
	
 	$("#input_sel_date").datetimepicker({
 		  startView: 'decade',
 	        minView: 'decade',
 	        format: 'yyyy',
 	        maxViewMode: 2,
 	        minViewMode:2,
 	        autoclose: true
	});   

	
	
	$("#input_sel_date2").datetimepicker({
		  startView: 'decade',
	        minView: 'decade',
	        format: 'yyyy',
	        maxViewMode: 2,
	        minViewMode:2,
	        autoclose: true
	}); 
	
    
	$('#build_data_search').click(function(){
		page = 1;
		var _date = $('#input_sel_date').val();
		var start_date = parseInt(_date)-1;
		
		var _date2 = $('#input_sel_date2').val();
		var start_date2 = parseInt(_date2)-1;
		
       var areaguid = $('#search_areaname').val();
       
        if(areaguid==''||areaguid==null) return;
      
			
        $.get('${contextPath}/dataanalysis/heatSeasonanalysiscontr/getheatSeasonanalysis?areaguid='+areaguid+'&date='+_date+'&date2='+_date2,function(response){
            var productData = jQuery.parseJSON(response);
            
   //        alert(productData);
          
         //   图一
            var clstr = new Array();
            var serstr = new Array();
         //图二
            var clstr2 = new Array();
            var serstr2 = new Array();
            
            var slstr = [];
            var ydata = new Array();
            
            var ydata2 = new Array();
            var ydata3 = new Array();

       /*      var sum = 0;
            $.each(productData, function (i) {
                sum += Math.abs(Number(productData[i].平均温差));
            }); */
            
            /* 将数据遍历放到数组中 */
            
            var c2=0;
            $.each(productData, function (i) {
      			if( i<21 ){
                	clstr[i] = productData[i].section;
                	serstr[i]=Number( productData[i].count);
      			}else{
      				
      				clstr2[c2] = productData[i].section;
                	serstr2[c2]=Number( productData[i].count);
                	c2++;
      			}
      			
            });
            
           // alert(clstr);
            //alert(serstr);
                    
         //x轴
//        clstr=[0.03,0.07,0.11,0.15,0.19,0.23,0.27,0.31,0.35,0.39,0.43,0.47,0.51,0.55,0.59,0.63,0.67,0.71,0.75,0.79,0.83];
		//户数
//        serstr=[3, 20 ,31 , 31 , 45, 55,73,87,143,146,191,193,145,78,25,10,2,0,2,0,3];
		
	//	 serstr=[0 , 1 , 8, 8, 25, 24, 28, 24, 24, 9, 6, 0, 0, 0, 1, 0, 1, 0, 0, 0 , 1 ];
		
            InitLine(clstr, serstr,start_date,_date);
            
           // clstr=[0.07,0.11,0.15,0.19,0.23,0.27,0.31,0.35,0.39,0.43,0.47,0.51,0.55,0.59,0.63,0.67,0.71,0.75,0.79,0.83,0.87];
    	//	serstr=[0,7,16,42,61,71,135,222,309,244,106,48,8,5,2,7,0,0,0,0,0];
    			     
    	//      alert(clstr2);
          //    alert(serstr2);
              
              InitLine3(clstr2, serstr2 ,start_date2, _date2);
              	
          //  InitLine2(clstr, serstr, ydata2, ydata3);
            
            //InitPie(slstr);
            
            _J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
        })
		
	});
	
});


	function showTable(productData){
		var trs = "<tr><th style='min-width: 170px;'>分析项目</th>";
        $.each(productData, function (j, m) {
            trs += "<th style='min-width: 60px;'><a href='${contextPath}/sys/sysuser/home#page/todaydata?buildno="+m.BUILDNO+"&day="+$('#input_sel_date').val()+"'>" + m.楼栋号 + /* "栋"+ */ "</a></th>";

        });
        trs += "</tr>"
        var td = "<tr><td>平均进水温度(℃)</td>";
        $.each(productData, function (i, n) {
            td += "<td>" + n.平均进水温度 + "</td>";

        });
        td += "</tr>";
        var tds = "<tr><td>平均回水温度(℃)</td>";
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
	
/* 	function InitPie(m) {
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
	            data: m
	        }]


	    });

	} */
	function InitLine(a, b, start, end) {
	    $('#3d-column').highcharts({
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'column'
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: start + "-" + end + "供热季 GJ/㎡.a频率"
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: a,
	            gridLineWidth: 0,
	            
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '用户数量 (户)'
	            },
	            gridLineWidth: 0,
                lineWidth: 1,
                tickWidth: 1,
                tickInterval: 50
	        },

	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	       // tooltip:'null',
	        tooltip: {
	            shared: true,
	            useHTML: true,
	            headerFormat: '<small>{point.key}</small>',
	            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y}</b></td></tr></tbody></table>',
	            footerFormat: '',
	            valueDecimals: 0
	        }, 
	        series: [
	        	{ name: '频率',
	            data: b ,
	            dataLabels: {
                    enabled: true,
                    // rotation: -90,
                    color: '#FFFFFF',
                    align: 'center',
                //    format: '{point.y:.0f}', // one decimal
                    y: 5, // 10 pixels down from the top
                    style: {
                        fontSize: '10px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
	        }
	        	/* ,
	                         { name: '平均回水温度',
	                             data: c
	                         },
	                         { name: '平均温差',
	                             data: d
	                         } */],
	                         

	    });
	}
	
	function InitLine3(a, b,start,end) {
	    $('#3d-pie').highcharts({
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'column'
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: start + "-" + end + "供热季 GJ/㎡.a频率"
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: a,
	            gridLineWidth: 0,
	            
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '用户数量 (户)'
	            },
	            gridLineWidth: 0,
                lineWidth: 1,
                tickWidth: 1,
                tickInterval: 50
	        },

	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	       // tooltip:'null',
	        tooltip: {
	            shared: true,
	            useHTML: true,
	            headerFormat: '<small>{point.key}</small>',
	            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y}</b></td></tr></tbody></table>',
	            footerFormat: '',
	            valueDecimals: 0
	        }, 
	        series: [
	        	{ name: '频率',
	            data: b ,
	            dataLabels: {
                    enabled: true,
                    // rotation: -90,
                    color: '#FFFFFF',
                    align: 'center',
                //    format: '{point.y:.0f}', // one decimal
                    y: 5, // 10 pixels down from the top
                    style: {
                        fontSize: '10px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
	        }
	        	/* ,
	                         { name: '平均回水温度',
	                             data: c
	                         },
	                         { name: '平均温差',
	                             data: d
	                         } */],
	                         

	    });
	}
   
	
	function InitLine2(a, b, c, d) {
	    $('#3d-pie').highcharts({
	        chart: {
	        	backgroundColor: 'rgb(247, 247, 249)',
	            type: 'column'
	        },
	        credits: {
		          enabled: false  
		        },
	        title: {
	            text: '15-16供热季 GJ/㎡.a频率'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: a,
	            gridLineWidth: 0,
	            
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '用户数量 (户)'
	            },
	            gridLineWidth: 0,
                lineWidth: 1,
                tickWidth: 1,
                tickInterval: 50
	        },

	       plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	     //   tooltip:'null',
	    tooltip: {
	            shared: true,
	            useHTML: true,
	            headerFormat: '<small>{point.key}</small>',
	            pointFormat: '<table><tbody><tr><td style="color:{series.color};padding:0">{series.name}: </td><td style="padding:0"><b>{point.y}</b></td></tr></tbody></table>',
	            footerFormat: '',
	            valueDecimals: 0
	        }, 
	        series: [
	        	{ name: '频率',
	            data: b,
	            dataLabels: {
                    enabled: true,
                    // rotation: -90,
                    color: '#FFFFFF',
                    align: 'center',  
                    format: '{point.y:.0f}', // one decimal
                    y: 5, // 10 pixels down from the top
                    style: {
                        fontSize: '5px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
	        }
	        	/* ,
	                         { name: '平均回水温度',
	                             data: c
	                         },
	                         { name: '平均温差',
	                             data: d
	                         } */],
	                         

	    });
	}
</script>
