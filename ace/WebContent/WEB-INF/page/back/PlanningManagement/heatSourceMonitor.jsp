<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>

<title></title>
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
<link rel="stylesheet"
			href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />
<style>
th[colspan] {
	text-align: center;
}
</style>
</head>

<body>
	<div class="container-fluid">

		<div class="row" id="tabview">

		
		</div>
<%
Calendar c = Calendar.getInstance();
String enddate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
c.add(Calendar.DATE, -7);
String startdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
	</div>
	<div id="modal-table" class="modal fade" tabindex="-1"  data-backdrop="static">
	<div class="modal-dialog" style="width:1000px;">
		<form id="informationForm" class="form-inline">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						热源参数曲线
					</div>
				</div>
				<div class="modal-body" style="overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="areaname" name="areaname" type="hidden" />
					<input id="buildno" name="buildno" type="hidden" />
					<input id="meterno" name="meterno" type="hidden" />
					<input id="lx" name="lx" type="hidden" />
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
							
                           <div class="form-group">
							<label for="startdate">开始时间：</label>

	                     <input type="text"  class="form-control" value="<%=startdate %>" id="input_sel_sdate" readonly="readonly" aria-describedby="basic-addon3">
	                     <select id="hour1" class="form-control">
                         <option value ="00">00</option>
                         <option value ="01">01</option>
                         <option value="02">02</option>
                         <option value="03">03</option>
                         <option value ="04">04</option>
                         <option value ="05">05</option>
                         <option value="06">06</option>
                         <option value="07">07</option>
                          <option value ="08">08</option>
                         <option value ="09">09</option>
                         <option value="10">10</option>
                         <option value="11">11</option>
                         <option value ="12">12</option>
                         <option value ="13">13</option>
                         <option value="14">14</option>
                         <option value="15">15</option>
                         <option value="16">16</option>
                         <option value="17">17</option>
                          <option value ="18">18</option>
                         <option value ="19">19</option>
                         <option value="20">20</option>
                         <option value="21">21</option>
                         <option value ="22">22</option>
                         <option value ="23">23</option>
                         </select><label for="labhour1">时</label>&nbsp;&nbsp;&nbsp;
	                     </div><div class="form-group">
	                    <label for="enddate">结束时间：</label>
	                    <input type="text"  class="form-control" value="<%=enddate %>" id="input_sel_edate" readonly="readonly" aria-describedby="basic-addon3">
	                     <select id="hour2" class="form-control">
                         <option value ="00">00</option>
                         <option value ="01">01</option>
                         <option value="02">02</option>
                         <option value="03">03</option>
                         <option value ="04">04</option>
                         <option value ="05">05</option>
                         <option value="06">06</option>
                         <option value="07">07</option>
                          <option value ="08">08</option>
                         <option value ="09">09</option>
                         <option value="10">10</option>
                         <option value="11">11</option>
                         <option value ="12">12</option>
                         <option value ="13">13</option>
                         <option value="14">14</option>
                         <option value="15">15</option>
                         <option value="16">16</option>
                         <option value="17">17</option>
                          <option value ="18">18</option>
                         <option value ="19">19</option>
                         <option value="20">20</option>
                         <option value="21">21</option>
                         <option value ="22">22</option>
                         <option value ="23">23</option>
                         </select><label for="labhour2">时</label>
	                    </div>
	                    <div class="form-group">
	                    <button type="button" class="btn btn-success" value="LLIANG" >流量</button>
	                    <button type="button" class="btn btn-success" value="TEMP" >温度</button>
	                    <button type="button" class="btn btn-success" value="RELIANG" >热量</button>
	                    </div>
	                     <div class="row">
	                     <div class="col-xs-12">
	                    <label id="labtext"></label>
	                   <div id="reyuan_charts"></div>
	                    </div>
	                    </div>
	                    </div>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</form>
	</div><!-- /.modal-dialog -->
</div>
<div id="button-modal-table" class="modal fade" tabindex="-1" data-backdrop="static">
	<div class="modal-dialog" style="width:1100px;">
		<form id="authorityForm" class="form-inline">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						热源历史数据查询
					</div>
				</div>
				<div class="modal-body" style="max-height: 450px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="buildvalue"  type="hidden" />
					<input id="meternovalue" type="hidden" />
					<input id="type" type="hidden" />
					<div class="widget-box widget-color-blue2">
						<div class="widget-body" >
							<div class="widget-main padding-8" >
							 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
							 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
								 <div class="form-group">
							    <label for="startdate">选择时间：</label>

	                          <input type="text"  class="form-control" value="<%=enddate %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
	                          &nbsp;&nbsp;&nbsp;
	                          </div>
	                           <div class="form-group">
	                         <button type="button" class="btn btn-success" id="search" >查询</button>
	                         <button type="button" class="btn btn-success" id="exportExcel" >导出EXCEL</button>
	                           </div>
	                            <div class="form-group">
	                          (表编号:<label id="lblmeterno"></label> 换热站编号: <label id="lblbuildno"></label>)
	                           </div>
	                            <div class="row"> <div class="col-xs-12">
	                            <div id="List_tableview" style="width:1000px"></div>
	                           </div>
	                           </div>  
							</div>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</form>
	</div><!-- /.modal-dialog -->
</div>
</body>
</html>
<script>
var scripts = [null,"${contextPath}/static/assets/js/jquery-ui.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",null  ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	getstr();
	$("#input_sel_sdate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_date").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	var title = '历史数据';
	//导出查询历史数据
	$("#exportExcel").click(function(){
		var rows = '';
		var row = '';//标题部分
		$('#tabList thead th').each(function(index,value){
			index ==0 ? row+=value.innerHTML : row += '\t'+value.innerHTML;
		});
		rows += row;
		var $tb_tr = $('#tabList tbody tr');
		$tb_tr.each(function(index,value){
			rows +='\n';
			
			$(value).find('td').each(function(i,v){
				if(v.innerHTML!=''){
					i==0 ? rows += v.innerHTML : rows += '\t' + v.innerHTML;
				}else{
					i==0 ? rows += v.innerHTML : rows += '\t ';
				}
			});
		});
		if(row==rows){
			alert("没有数据");
			return;
		}
		var form = "<form name='csvexportform' action='${contextPath}/homePage/excelTodayStatus?title="+encodeURIComponent(encodeURIComponent(title))+"' method='post'>";
    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
    	   OpenWindow = window.open('', '导出数据','width=500,height=300');
    	   OpenWindow.document.write(form);
    	   OpenWindow.document.close();
	});
	
	gettimeview();
	//查询热源历史数据
	$('#search').click(function(){
		$.post("${contextPath}/planningmanagement/heatSourceMonitor/getHeatSourceHistory?buildno="+$("#buildvalue").val()+"&meterno="+$("#meternovalue").val()+"&serdate="+$('#input_sel_date').val()+"&type="+$('#type').val(), function (response) {  
			var tabstr="<table id='tabList' class='table table-striped table-bordered table-hover'><thead class='thead'>";
	     	tabstr+="<tr><th>序号</th><th>换热站名称</th><th>表号码</th><th>表状态</th><th>时间</th><th>瞬时流量(T/h)</th><th>累计流量(T)</th><th>进水温度(℃)</th><th>回水温度(℃)</th><th>瞬时热量(KW)</th><th>累计热量(MW*h)</th></tr></thead><tbody>";
	     	var str="";
	     	var target = jQuery.parseJSON(response);
         	var data = target['data'];
         	 if(data.length>0){
  				for(var i=0 ; i<data.length ; i++){
  			    var obj = data[i];
  			    str+="<tr><td>"+(i+1)+"</td><td>"+obj["BUILDNAME"]+"</td><td>"+obj["METERID"]+"</td><td>"+obj["MSNAME"]+"</td><td>"+obj["DDATE"]+"</td><td>"+obj["METERSSLJ"]+"</td><td>"+obj["METERNLLJ"]+"</td><td>"+obj["METERJSWD"]+"</td><td>"+obj["METERHSWD"]+"</td><td>"+obj["METERSSRL"]+"</td><td>"+obj["METERNLRL"]+"</td></tr>";
  				}
         	 }
         	tabstr+=str;
	     	tabstr+="</tbody></table>";
	     	 $('#List_tableview').empty(); 
		 		if(data.length>0){
		 			$('#List_tableview').append(tabstr); 
		 		} 
		});	
		
	});
	//热源数据曲线事件
	$('button').click(function(){
		var buttonname = $(this).val();
		if(buttonname!=''){
		var sDate=$("#input_sel_sdate").val();
		var eDate=$("#input_sel_edate").val();
		var sArr = sDate.split("-");
		var eArr = eDate.split("-");
		var sRDate = new Date(sArr[0], sArr[1], sArr[2]);
		var eRDate = new Date(eArr[0], eArr[1], eArr[2]);
		var result = (eRDate-sRDate)/(24*60*60*1000);
		var y1='';
		var y2='';
		var dw='';
		var title1='';
		var title2='';
		$.post("${contextPath}/planningmanagement/heatSourceMonitor/getHeatSourceHistroy?buildno="+$("#buildno").val()+"&meterno="+$("#meterno").val()+"&startdate="+$('#input_sel_sdate').val()+"&enddate="+$('#input_sel_edate').val()+"&hour1="+$('#hour1 option:selected').val()+"&hour2="+$('#hour2 option:selected').val(), function (data) {  
			var chartdata1 = [];
    		var chartdata2 = [];
    		var xchart=[];
    		var jsonarray = eval("("+data+")");
    		if(result>180 ||jsonarray.length==0 ){
    			alert("起始结束时间不在同一供暖季度内或查询数据为空，请重新选择条件查询！");
    		}else{
    		if(buttonname=='LLIANG'){
    			y1='瞬时流量(m³)';
    			y2='应供流量(m³)'
    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#areaname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
    			title2='曲线图';
    			dw='m³';
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata1[i] = parseFloat(jsonarray[i].YGLL);
    				chartdata2[i] = parseFloat(jsonarray[i].SGLL);
    				xchart[i] = jsonarray[i].DDATE;
    			}

    		}else if(buttonname=='TEMP'){
    			y1='进水温度(℃)';
    			y2='回水温度(℃)'
    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#areaname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
    			title2='曲线图';
    			dw='℃';
    			for(var i=0;i<jsonarray.length;i++){
    				chartdata1[i] = parseFloat(jsonarray[i].GW);
    				chartdata2[i] = parseFloat(jsonarray[i].HW);
    				xchart[i] =jsonarray[i].DDATE;
    			}

    		}else{
    			y1='瞬时热量(KWH)';
    			y2='应供热量(KWH)'
    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#areaname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
    			title2='曲线图';
    			dw='KWH';
    			for(var i=0;i<jsonarray.length;i++){
				chartdata1[i] = parseFloat(jsonarray[i].YGRL);
				chartdata2[i] = parseFloat(jsonarray[i].SGRL);
				xchart[i] =jsonarray[i].DDATE;
			}
    			}
    		 Highcharts.setOptions({
    		        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    		    });
    		$('#reyuan_charts').highcharts({
    		        title: {
    		            text: title1,
    		            x: -20 //center
    		        },
    		        credits: {
    		            enabled:false
    		        },
    		        subtitle: {
    		            text: title2,
    		            x: -20
    		        },
    		        xAxis: {
    		        	tickInterval: 10,
    		            categories:xchart,
    		            labels:{
    		            	 rotation: -45   //45度倾斜
    	                   
    	                 }
    		        },
    		        yAxis: {
    		            title: {
    		                text: y1+'/'+y2
    		            },
    		            labels: {
    	                    align: 'left',
    	                    x: 3,
    	                    y: 16,
    	                    format: '{value:.,0f}'
    	                },
    		        },
    		     
    		        tooltip: {
    		            valueSuffix: dw,
    		            shared: true
    		        },
    		        legend: {
    	                align: 'left',
    	                verticalAlign: 'top',
    	                y: 20,
    	                floating: true,
    	                borderWidth: 0
    	            },
    		        series: [{
    		            name: y1,
    		            data: chartdata1
    		        },{ name:y2,
    		        	data: chartdata2
    		        
    		        }]
    		    }); 
    		}
		});
		}
});
});

function gettimeview(){
	 setInterval("getTime()",1000); 
}
function getstr(){
	var time = new Date();
	 var month = time.getMonth() + 1;
	 var strDate = time.getDate();
	 if (month >= 1 && month <= 9) {
	     month = "0" + month;
	 }
	 if (strDate >= 0 && strDate <= 9) {
	     strDate = "0" + strDate;
	 }
	 var a = new Array("日", "一", "二", "三", "四", "五", "六");  
	 var week = time.getDay();  
	 var str = "星期"+ a[week];  
	 var currentdate = time.getFullYear() + "年" + month + "月" + strDate+"日  "+str;
	 var hour=time.getHours();
	 if (hour >= 1 && hour <= 9) {
	     hour = "0" + hour;
	 }
	 $("#hour2 option:contains('"+hour+"')").attr("selected", true);
	 $.get('${contextPath}/planningmanagement/heatSourceMonitor/getHeatSourceMonitor',function(response){
     	var tabstr="<table class='table table-striped table-bordered table-hover'><thead class='thead'>";
     	tabstr+="<tr><th colspan='3' style='min-width: 200px;'><strong><label id='date'>"+currentdate+"</label></strong></th>";
     	tabstr+="<th colspan='8'><strong>系统时钟:<label id='time'></label></strong></th><th colspan='4'>当前室外温度:0℃</th></tr>";
     	tabstr+="<tr><th>序号</th><th>电厂</th><th>采集时间</th><th>供温(℃)</th><th>回温(℃)</th><th>供压(Mpa)</th><th>回压(Mpa)</th><th>应供流量(T/h)</th><th>实供流量(T/h)</th><th>流量比率(%)</th><th>应供热量(MW)</th><th>实供热量(MW)</th><th>热量比率(%)</th><th>当日热量(MW*h)</th><th>累计热量(MW*h)</th></tr></thead><tbody>";
     	var str =""; 
     	     var target = jQuery.parseJSON(response);
         	 var data = target['data'];
             var YGLLD = 0;
             var SGLLD = 0;
             var YGRLD = 0;
             var SGRLD = 0;
             var DRLLD = 0;
             var LJRLD = 0;
             var YGLLT = 0;
             var SGLLT = 0;
             var YGRLT = 0;
             var SGRLT = 0;
             var DRLLT = 0;
             var LJRLT = 0;
             var j=1;
             var mainkey="";
             if(data.length>0){
 				for(var i=0 ; i<data.length ; i++){
 			    var obj = data[i];
             	if(mainkey=="电" && obj['MAINAREANAME'].indexOf("电")<=0){
             		str+=getSum((i + j), "国电电力小计", YGLLD, SGLLD, YGRLD, SGRLD, DRLLD, LJRLD);
             		j++;
             	}
             	if(mainkey=="唐" && obj['MAINAREANAME'].indexOf("唐")<=0){
             		str+=getSum((i + j), "大唐小计", YGLLD, SGLLD, YGRLD, SGRLD, DRLLD, LJRLD);
             		j++;
             	}
             	if(obj['MAINAREANAME'].indexOf("电")>0){
             		 YGLLD += parseFloat(obj['YGLL']);
                      SGLLD += parseFloat(obj['SGLL']);
                      YGRLD += parseFloat(obj['YGRL']);
                      SGRLD += parseFloat(obj['SGRL']);
                      DRLLD +=  parseFloat(obj['DRLL']);
                      LJRLD +=  parseFloat(obj['LJRL']);
                      mainkey = "电";

             	 }else if(obj['MAINAREANAME'].indexOf("唐")>0){
             		 YGLLT += parseFloat(obj['YGLL']);
                      SGLLT += parseFloat(obj['SGLL']);
                      YGRLT += parseFloat(obj['YGRL']);
                      SGRLT += parseFloat(obj['SGRL']);
                      DRLLT +=  parseFloat(obj['DRLL']);
                      LJRLT +=  parseFloat(obj['LJRL']);
                      mainkey = "唐";
             	 }
                  str +="<tr><th scope='row'>"+(i+j)+"#</th><td><a href='javascript:$(\"#button-modal-table\").modal(\"toggle\");$(\"#type\").val(\"hot\");$(\"#lblbuildno\").text(\"" + obj['BUILDNO'] +"\");$(\"#buildvalue\").val(\"" + obj['BUILDNO'] +"\");$(\"#lblmeterno\").text(\"" + obj['METERNO'] +"\");$(\"#meternovalue\").val(\"" + obj['METERNO'] +"\")'>"+obj['MAINAREANAME']+obj['GONGRENENGLI']+"</a></td><td>"+obj['DDATE']+"</td><td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"wd\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>";
                  str+= obj['GW']+"</a></td><td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"wd\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>"+obj['HW']+"</a></td><td>"+obj['GY']+"</td><td>"+obj['HY']+"</td>";
                  str+=" <td> <a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"YGLL\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>"+obj['YGLL']+"</a></td>";
                  str+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"YGLL\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>"+obj['SGLL']+"</a></td>";
                  str+=" <td>"+obj['LLBL']+"</td><td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"YGRL\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>"+obj['YGRL']+"</a></td>";
                  str+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#areaname\").val(\"" + obj['MAINAREANAME'] +"\");$(\"#lx\").val(\"YGRL\");$(\"#buildno\").val(\"" + obj['BUILDNO'] +"\");$(\"#meterno\").val(\"" + obj['METERNO'] +"\")'>"+obj['SGRL']+"</a></td><td>"+obj['RLBL']+"</td><td>"+obj['DRLL']+"</td><td>"+obj['LJRL']+"</td></tr>";
                  if (i == (data.length-1))
                  {
                      switch (mainkey)
                      {
                          case "电":
                              j++;
                              str += getSum((i + j), "国电电力小计", YGLLD, SGLLD, YGRLD, SGRLD, DRLLD, LJRLD);
                               break;
                          case "唐":
                              j++;
                              str += getSum((i + j), "大唐小计", YGLLT, SGLLT, YGRLT, SGRLT, DRLLT, LJRLT);                                
                              break;
                          default: break;
                      }
                      j++;
                      str += getSum((i + j), "总计", (YGLLT + YGLLD), (SGLLT + SGLLD), (YGRLT+YGRLD), (SGRLT + SGRLD), (DRLLT + DRLLD), (LJRLT + LJRLD));

                  }

 				}
 				tabstr+=str;
 				tabstr+="</tbody></table>"
             }
             
         $('#tabview').empty(); 
 		if(data.length>0){
 			$('#tabview').append(tabstr); 
 		} 
 });
}
 function getTime()
{
var time = new Date();
$("#time").html(time.toLocaleTimeString());
} 
 function getSum(number,name,YGLL,SGLL,YGRL,SGRL,DRLL,LJRL)
 {
     var result = "";
     result += "<tr><th scope='row'>"+number+"#</th><td>"+name+"</td><td colspan='5'></td><td>" + YGLL + "</td><td>" + SGLL + "</td><td>" + ((parseFloat(SGLL) / parseFloat(YGLL)) * 100).toFixed(2)+ "</td><td>" + YGRL + "</td><td>" + SGRL + "</td><td>" + ((parseFloat(SGRL) / parseFloat(YGRL)) * 100).toFixed(2) + "</td><td>" + DRLL + "</td><td>" + LJRL + "</td></tr>";
     return result;
 }


</script>