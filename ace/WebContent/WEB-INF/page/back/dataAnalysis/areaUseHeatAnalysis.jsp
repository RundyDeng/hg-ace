<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个大数据智慧运行系统</title>
	<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
		<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
		
	<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
	<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
</head>

	<div class="container-fluid" style="background-color: #f7f7f9;">
		
<style>
     .flip-clock-wrapper ul{
        margin: 3px;
    }
    #build_th th{
        min-width: 69px;
    }   
</style>
		
<br/>
		<div class="row" style="height: 30px;">
			<div class="col-md-3">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">选择小区: </span>
					  <select id="search_areaname" class="form-control">
					  </select>
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">起始时间：</span>
<%
String edate = "";
String sdate = "";
String attrDate= (String)request.getParameter("sdate");
if(attrDate!=""&&attrDate!=null){
 	edate = (String)request.getParameter("edate");
 	sdate = (String)request.getParameter("sdate");
}else{
	Calendar c = Calendar.getInstance();
	edate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	c.add(Calendar.DATE, -7);
	sdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
}
%>
					  <input type="text" class="form-control" value="<%=sdate %>" id="input_sel_sdate" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			
			<div class="col-md-3">
			<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">结束时间：</span>

					  <input type="text" class="form-control" value="<%=edate %>" id="input_sel_edate" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			
			<div class="col-md-2">
				<button type="button" class="btn btn-success" id="build_data_search">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
			</div>
		</div>
		
		<br/>
		
		<div class="row" style="margin-left: 1px; margin-right: 1px;word-break:break-all;">
        	<div id="container" style="min-width:400px;height:400px"></div>
        </div>
        
        
	</div>
	<div id="divload" style="top: 50%; right: 50%; position: absolute; padding: 0px;
                            margin: 0px; z-index: 999; display: none">
       <img src="${contextPath}/static/image/spinner3-greenie.gif" />正在加载,请稍后......
      </div>
	
	
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                "${contextPath}/static/Highcharts-4.2.5/grouped-categories.js", 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
                null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	  $('#container').highcharts({
	      
      	chart: {
  			renderTo: "container",
  			type: "column"
  		},
  		title: {
  			text: '同一小区、不同面积、不同户型、不同楼层 耗热对比'
  		},
  		subtitle: {

  			text: '1:面积75~95平米,2:95~125平米,3:大于125平米    11:边底  12：边中  13：边顶   21：中底  22：中中  23：中顶'

  			},
  			 yAxis: {
 	            min: 0,
 	            title: {
 	                text: '平均耗热(GJ/M2)'
 	            }
 	        },
  		exporting:{
              enabled:false
          },
          credits: {
              enabled: false
          },
  plotOptions: {
  			column: {
  				stacking: 'normal',
  				dataLabels: {
  					enabled: false,
  					color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
  				}
  			}
  		},
  		series: [{
  			 name: '汇总',
  						color: '#FF3300',
  						type: 'column',
  			data: [0.44, 0.37, 0.46, 0.43, 0.48, 0.39, 0.41, 0.44, 0.37,0.39,0.43,0.42,0.44,0.42,0.40,0.38,0.36,0.43]
  		}],
  		xAxis: {
  		    categories: [{
  		        name: "1",
  		        categories: ["11", "12", "13","21","22","23"]
  		    }, {
  		        name: "2",
  		        categories: ["11", "12", "13","21","22","23"]
  		    }, {
  		        name: "3",
  		        categories: ["11", "12", "13","21","22","23"]
  		    }]
  		}
	    });    
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
	
	$("#input_sel_sdate").datepicker({
    		dateFormat: 'yy-mm-dd',
    	
	});
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		
});
    
	$('#build_data_search').click(function(){
		$("#divload").show(); 
	
		var _sdate = $('#input_sel_sdate').val();
		var _edate = $('#input_sel_edate').val();
        var areaguid = $('#search_areaname').val();
        if(areaguid==''||areaguid==null) {
        	areaguid='<%=(String)request.getSession().getAttribute("areaGuids") %>';
        };

            $('#container').highcharts({
		      
            	chart: {
        			renderTo: "container",
        			type: "column"
        		},
        		title: {
        			text: '同一小区、不同面积、不同户型、不同楼层 耗热对比'
        		},
        		subtitle: {

        			text: '1:面积75~95平米,2:95~125平米,3:大于125平米    11:边底  12：边中  13：边顶   21：中底  22：中中  23：中顶'

        			},
        			 yAxis: {
        	 	            min: 0,
        	 	            title: {
        	 	                text: '平均耗热(GJ/M2)'
        	 	            }
        	 	        },
        		exporting:{
                    enabled:false
                },
                credits: {
                    enabled: false
                },
        plotOptions: {
        			column: {
        				stacking: 'normal',
        				dataLabels: {
        					enabled: false,
        					color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
        				}
        			}
        		},
        		series: [{
        			 name: '汇总',
        						color: '#FF3300',
        						type: 'column',
        			data: [0.44, 0.37, 0.46, 0.43, 0.48, 0.39, 0.41, 0.44, 0.37,0.39,0.43,0.42,0.44,0.42,0.40,0.38,0.36,0.43]
        		}],
        		xAxis: {
        		    categories: [{
        		        name: "1",
        		        categories: ["11", "12", "13","21","22","23"]
        		    }, {
        		        name: "2",
        		        categories: ["11", "12", "13","21","22","23"]
        		    }, {
        		        name: "3",
        		        categories: ["11", "12", "13","21","22","23"]
        		    }]
        		}
		    });    
        	$("#divload").hide(); 
	});
	
});


</script>
