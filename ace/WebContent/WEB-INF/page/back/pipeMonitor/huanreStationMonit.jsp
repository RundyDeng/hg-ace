<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
	href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />

<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />
 <style>
        html,body{text-align:center;margin:0px auto;}
 </style>
<body>
    <form id="form1" class="form-inline">
  <input type="show" id="watchtype" value="1"  /> <!--   //测试使用 -->
    <div>
    <div style=" width:100px; height:5px;"></div>
        <div id="searchTop" class="form-group" >
            <input type="button" class="btn btn-success" value="热表" onclick="gettmeter('hot',this)" />
            <input type="button" class="btn btn-success" value="电表" onclick="gettmeter('electric',this)" />
            <input type="button" class="btn btn-success" value="水表" onclick="gettmeter('water',this)" />
            <input type="button" class="btn btn-success" value="二次网温度" onclick="gettmeter('teamp',this)" />
        </div>
       		 <div style="border:0px solid red; height:33px;">
                                             分公司：&nbsp; <select id="sel_company" class="form-control"><option value="9999">-请选择-</option></select>&nbsp; 
                &nbsp;&nbsp; 换热站：&nbsp;<select id="sel_hrz" class="form-control"><option value="9999">-请选择-</option></select>&nbsp; 
                   &nbsp;&nbsp;表状态&nbsp;
                    <select id="selstate" class="form-control">
                        <option value="-1">-请选择-</option>
                        <option value="1">正常</option>
                        <option value="2">未抄表</option>
                    </select>&nbsp; &nbsp;
                                                     地址编号：&nbsp;<input type="text" value="" id="txtaddcode" class="txt" />&nbsp; 
                    <button type="button" class="btn btn-success" id="search" >搜索</button>
	                    <button type="button" class="btn btn-success" id="exportExcel" onclick="AutomateExcel()" >导出EXCEL</button>
                </div>           
        </div><br/>
        
     <!-- form里面的第二个div 数据 -->   
        <div class="row">
        <div  id="divDataContent" style="width:100%"> </div>
        </div>
    </form>
    
    
 <%
Calendar c = Calendar.getInstance();
String enddate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
c.add(Calendar.DATE, -7);
String startdate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
%>
<!-- 弹窗表格 -->
    <div id="modal-table" class="modal fade" tabindex="-1"  data-backdrop="static">
	<div class="modal-dialog" style="width:1000px;">
		<form id="informationForm" class="form-inline">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						换热站参数曲线
					</div>
				</div>
				<div class="modal-body" style="overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="buildname" name="areaname" type="hidden" />
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
	                     </div>
	                     <div class="form-group">
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
	                    </br>
	                    <div class="form-group">
	                    <button type="button" class="btn btn-success" value="SSLLIANG" >瞬时流量</button>
	                    <button type="button" class="btn btn-success" value="TEMP" >温度</button>
	                    <button type="button" class="btn btn-success" value="SSRELIANG" >瞬时热量</button>
	                    <button type="button" class="btn btn-success" value="PJLLIANG" >平均流量</button>
	                    <button type="button" class="btn btn-success" value="PJRELIANG" >平均热量</button>
	                    <button type="button" class="btn btn-success" value="DAYRELIANG" >当日累计热量</button>
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
						换热站历史数据查询
					</div>
				</div>
				<div class="modal-body" style="max-height: 450px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="buildnovalue"  type="hidden" />
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
	                         <button type="button" class="btn btn-success" id="searchhistory" >查询</button>
	                         <button type="button" class="btn btn-success" id="exportExcel2" >导出EXCEL</button>
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


 <div id="modal-dialog" class="modal fade" tabindex="-1"  data-backdrop="static">
	<div class="modal-dialog" style="width:1000px;">
		<form id="informationForm" class="form-inline">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						换热站参数曲线
					</div>
				</div>
				<div class="modal-body" style="overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="buildname2"  type="hidden" />
					<input id="buildno2"  type="hidden" />
					<input id="meterno2"  type="hidden" />
					<input id="lx2"  type="hidden" />
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
							
                           <div class="form-group">
							<label for="startdate">开始时间：</label>

	                     <input type="text"  class="form-control" value="<%=startdate %>" id="input_sel_sddate" readonly="readonly" aria-describedby="basic-addon3">
	                     <div class="form-group">
	                    <label for="enddate">结束时间：</label>
	                    <input type="text"  class="form-control" value="<%=enddate %>" id="input_sel_eddate" readonly="readonly" aria-describedby="basic-addon3">
	                    </div>
	                    <div class="form-group">
	                    <button type="button" class="btn btn-success" value="LJHDL" >累计电量</button>
	                    <button type="button" class="btn btn-success" value="RHDL" >日耗电量</button>
	                    </div>
	                    
	                     <div class="row">
	                     <div class="col-xs-12">
	                    <label id="labtext"></label>
	                   <div id="hd_charts"></div>
	                    </div>
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
//var buttonname="热表";
var scripts = [ null,"${contextPath}/static/assets/js/jquery-ui.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function(){
	var select_area = "#sel_company";
	$("#input_sel_sdate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_date").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_sddate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_eddate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	//导出换热站最新一次抄表数据
	$('#exportExcel').click(function(){
		var type=$("#watchtype").val();
		if(type=="1"){
		   exportExcel("hot");
		 
		}else{
		   exportExcel(type);
		}
		   });
	//导出查询历史数据
	$("#exportExcel2").click(function(){
		var titletext="抄表数据"
		var rows = '';
		var row = '';//标题部分
		$('#tabList2 thead th').each(function(index,value){
			index ==0 ? row+=value.innerHTML : row += '\t'+value.innerHTML;
		});
		rows += row;
		var $tb_tr = $('#tabList2 tbody tr');
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
		var form = "<form name='csvexportform' action='${contextPath}/homePage/excelTodayStatus?title="+encodeURIComponent(encodeURIComponent(titletext))+"' method='post'>";
    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
    	   OpenWindow = window.open('', '导出数据','width=500,height=300');
    	   OpenWindow.document.write(form);
    	   OpenWindow.document.close();
	});

	$.get('${contextPath}/pipeMonitor/huanreStationMonitContr/getarealist',
	         function(data) {
							var selopt='';
							for (i in data) {
									selopt += '<option value="'+data[i]['AREAGUID']+'">'
											+ data[i]['AREANAME']
											+ '</option>';
							}
						
							$(select_area).append(selopt);
						
							 $.post("${contextPath}/pipeMonitor/huanreStationMonitContr/getbuildlist?areaguid="+$(select_area).val(), function (data) {  
						            /* 清空楼栋   换热站 */  
						            $("#sel_hrz option[value!='9999']").remove();  
						          
						            var jsonObj = eval("(" + data + ")");  
						            
						            for (var i = 0; i < jsonObj.length; i++) {  
						                var $option = $("<option></option>");  
						                $option.attr("value", jsonObj[i].BUILDNO);  
						                $option.text(jsonObj[i].BUILDNAME);  
						                $("#sel_hrz").append($option);  
						            }  
						        });  
						}, 'json');

	 /* 根据小区楼栋 */  
    $(select_area).change(function () {  
        $.post("${contextPath}/pipeMonitor/huanreStationMonitContr/getbuildlist?areaguid="+$(select_area).val(), function (data) {  
            /* 清空楼栋 */  
            $("#sel_hrz option[value!='9999']").remove();  
            var jsonObj = eval("(" + data + ")");  
            for (var i = 0; i < jsonObj.length; i++) {  
                var $option = $("<option></option>");  
                $option.attr("value", jsonObj[i].BUILDNO);  
                $option.text(jsonObj[i].BUILDNAME);  
                $("#sel_hrz").append($option);  
            }  
        });  
    }); 
	 
    
    gettmeter("hot",$("#searchTop input:eq(0)"));
    $('#search').click(function(){
    	gettmeter($("#watchtype").val(), buttonname);
    });
    /* 按钮切换表格事件  */
    $('#searchhistory').click(function(){
			
		$.post("${contextPath}/pipeMonitor/huanreStationMonitContr/gethistorydata?buildno="+$("#buildnovalue").val()+"&meterno="+$("#meternovalue").val()+"&serdate="+$('#input_sel_date').val()+"&type="+$('#type').val(), function (response) {  
			
			var tabstr="<table id='tabList2' class='table table-striped table-bordered table-hover'><thead class='thead'>";
			if($("#type").val()=="hot"){
	     		tabstr+="<tr><th>序号</th><th>换热站名称</th><th>表号码</th><th>表状态</th><th>时间</th><th>瞬时流量(T/h)</th><th>累计流量(T)</th><th>进水温度(℃)</th><th>回水温度(℃)</th><th>瞬时热量(KW)</th><th>累计热量(MW*h)</th></tr></thead><tbody>";
		   }else if($("#type").val()=="electric"){
				tabstr+="<tr><th>序号</th><th>换热站名称</th><th>表号码</th><th>表状态</th><th>时间</th><th>累计电量(度)</th></tr></thead><tbody>"; 
		   }else if($("#type").val()=="water"){
				tabstr+="<tr><th>序号</th><th>换热站名称</th><th>表号码</th><th>表状态</th><th>时间</th><th>累计水量(吨)</th></tr></thead><tbody>"; 
		   }else{
			   tabstr+="<tr><th>序号</th><th>换热站名称</th><th>表号码</th><th>表状态</th><th>时间</th><th>累计温度(℃)</th></tr></thead><tbody>";  
		   }
	        var str="";
	     	var target = jQuery.parseJSON(response);//接收返回值
         	var data = target['data'];
	     	
         
         	 if(data.length>0){
         		if($("#type").val()=="hot"){
	  				for(var i=0 ; i<data.length ; i++){
	  			    var obj = data[i];
	  			    str+="<tr><td>"+(i+1)+"</td><td>"+obj["BUILDNAME"]+"</td><td>"+obj["METERID"]+"</td><td>"+obj["MSNAME"]+"</td><td>"+obj["DDATE"]+"</td><td>"+obj["METERSSLJ"]+"</td><td>"+obj["METERNLLJ"]+"</td><td>"+obj["METERJSWD"]+"</td><td>"+obj["METERHSWD"]+"</td><td>"+obj["METERSSRL"]+"</td><td>"+obj["METERNLRL"]+"</td></tr>";
	  				}
	         	}else if($("#type").val()=="electric"){
	         		for(var i=0 ; i<data.length ; i++){
	      			  var obj = data[i];
	      			  str+="<tr><td>"+(i+1)+"</td><td>"+obj["BUILDNAME"]+"</td><td>"+obj["METERID"]+"</td><td>"+obj["MSNAME"]+"</td><td>"+obj["DDATE"]+"</td><td>"+obj["METERNLLJ"]+"</td></tr>";
	      				}
	         	}else if($("#type").val()=="water"){
	         		for(var i=0 ; i<data.length ; i++){
	        			  var obj = data[i];
	        			  str+="<tr><td>"+(i+1)+"</td><td>"+obj["BUILDNAME"]+"</td><td>"+obj["METERID"]+"</td><td>"+obj["MSNAME"]+"</td><td>"+obj["DDATE"]+"</td><td>"+obj["METERNLLJ"]+"</td></tr>";
	        				}
	           }else{
	         	    	for(var i=0 ; i<data.length ; i++){
	          			  var obj = data[i];
	          			  str+="<tr><td>"+(i+1)+"</td><td>"+obj["BUILDNAME"]+"</td><td>"+obj["METERID"]+"</td><td>"+obj["MSNAME"]+"</td><td>"+obj["DDATE"]+"</td><td>"+obj["METERNLLJ"]+"</td></tr>";
	          				}
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
    
    
  //热源数据曲线事件++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	$('button').click(function(){
		
		var buttonname = $(this).val();
		var sDate=$("#input_sel_sdate").val();
		var eDate=$("#input_sel_edate").val();
		var sArr = sDate.split("-");
		var eArr = eDate.split("-");
		var sta_str = sArr[0]+"-10-15".split("-"); 
		var sta_date = new Date(sta_str[0], sta_str[1], sta_str[2]);
		var sRDate = new Date(sArr[0], sArr[1], sArr[2]);
		var eRDate = new Date(eArr[0], eArr[1], eArr[2]);
		var result = (eRDate-sRDate)/(24*60*60*1000);
		var y1='';
		var y2='';
		var dw='';
		var title1='';
		var title2='';
		Highcharts.setOptions({
	        colors: ['#058DC7', '#50B432', 'red', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
	    });
		
		
		
		if(buttonname!='' && buttonname!='LJHDL' && buttonname!='RHDL'){
		$.post("${contextPath}/pipeMonitor/huanreStationMonitContr/gettmeterchart?buildno="+$("#buildno").val()+"&meterno="+$("#meterno").val()+"&startdate="+$('#input_sel_sdate').val()+"&enddate="+$('#input_sel_edate').val()+"&hour1="+$('#hour1 option:selected').val()+"&hour2="+$('#hour2 option:selected').val()+"&buttonname="+buttonname, function (data) {  
			
			
			var chartdata1 = [];
    		var chartdata2 = [];
    		var xchart=[];
    		var jsonarray = eval("("+data+")");
    		
    		if( (sta_date>sRDate && sta_date<eRDate)||jsonarray==null){
    			alert("起始结束时间不在同一供暖季度内或查询数据为空，请重新选择条件查询！");
	    	}else{
	    		if(buttonname=='SSLLIANG'){
	    			y1='瞬时流量(m³)';
	    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
	    			title2='曲线图';
	    			dw='m³';
	    			for(var i=0;i<jsonarray.length;i++){
	    				chartdata1[i] = parseFloat(jsonarray[i].METERSSLJ);
	    				xchart[i] = jsonarray[i].DDATE;
	    			}

		    		}else if(buttonname=='TEMP'){
		    			y1='进水温度(℃)';
		    			y2='回水温度(℃)'
		    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
		    			title2='曲线图';
		    			dw='℃';
		    			for(var i=0;i<jsonarray.length;i++){
		    				chartdata1[i] = parseFloat(jsonarray[i].METERJSWD);
		    				chartdata2[i] = parseFloat(jsonarray[i].METERHSWD);
		    				xchart[i] =jsonarray[i].DDATE;
		    			}

			    		}else if(buttonname=='SSRELIANG'){
			    			y1='瞬时热量(KW)';
			    			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
			    			title2='曲线图';
			    			dw='KW';
			    			for(var i=0;i<jsonarray.length;i++){
							chartdata1[i] = parseFloat(jsonarray[i].METERSSRL);
							xchart[i] =jsonarray[i].DDATE;
						}
		    			}else if(buttonname=='PJLLIANG'){
		        			y1='平均流量(m³/h*㎡)';
		        			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
		        			title2='曲线图';
		        			dw='m³/h*㎡';
		        			for(var i=0;i<jsonarray.length;i++){
		    				chartdata1[i] = parseFloat(jsonarray[i].METERPJLL);
		    				xchart[i] =jsonarray[i].DDATE;
		    			}
	        			}else if(buttonname=='PJRELIANG'){
	            			y1='平均热量(w/h*㎡)';
	            			y2='瞬时热量(KWH*H)';
	            			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
	            			title2='曲线图';
	            			dw='w/h*㎡';
	            			for(var i=0;i<jsonarray.length;i++){
	        				chartdata1[i] = parseFloat(jsonarray[i].METERPJRL);
	        				chartdata2[i] = parseFloat(jsonarray[i].METERJHZB);
	        				xchart[i] =jsonarray[i].DDATE;
	        			}
            			}else if(buttonname=='DAYRELIANG'){
                			y1='当日耗热量(MWH)';
                			y2='当日计划供量(MWH)';
                			title1=$("#input_sel_sdate").val()+'至'+$("#input_sel_edate").val()+$("#buildname").val()+'换热站,热表表号:'+$("#meterno").val()+'曲线';
                			title2='曲线图';
                			dw='MWH';
                			for(var i=0;i<jsonarray.length;i++){
            				chartdata1[i] = parseFloat(jsonarray[i].METERDRLJRL);
            				chartdata2[i] = parseFloat(jsonarray[i].METERJHGR);
            				xchart[i] = jsonarray[i].DDATE;
            			}
                	}
    		 
    		 if(buttonname=='DAYRELIANG' || buttonname=='PJRELIANG' || buttonname=='TEMP'){
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
    		
    		 
    		 
    		 
    		 }else{
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
     		                text: y1
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
     		        }]
     		    });  
    		 }
    		}
		});
		
		}else if(buttonname=='LJHDL' || buttonname=='RHDL'){
			$.post("${contextPath}/pipeMonitor/huanreStationMonitContr/getdbhistorydata?buildno="+$("#buildno2").val()+"&meterno="+$("#meterno2").val()+"&startdate="+$('#input_sel_sddate').val()+"&enddate="+$('#input_sel_eddate').val(), function (data) {  
				
				
				var chartdata = [];
	    		var xchart=[];
	    		var jsonarray = eval("("+data+")");
	    		if( (sta_date>sRDate && sta_date<eRDate)||jsonarray==null){
	    			alert("起始结束时间不在同一供暖季度内或查询数据为空，请重新选择条件查询！");
	    		}else{
	    		if(buttonname=='LJHDL'){
	    			y1='累计电量(度)';
	    			title1=$("#input_sel_sddate").val()+'至'+$("#input_sel_eddate").val()+$("#buildname2").val()+'换热站,热表表号:'+$("#meterno2").val()+'曲线';
	    			title2='曲线图';
	    			dw='度';
	    			for(var i=0;i<jsonarray.length;i++){
	    				chartdata[i] = parseFloat(jsonarray[i].METERNLLJ);
	    				xchart[i] = jsonarray[i].DDATE;
	    			}
					
	    		   }else{
	    			   y1='日耗电电量(度)';
		    			title1=$("#input_sel_sddate").val()+'至'+$("#input_sel_eddate").val()+$("#buildname2").val()+'换热站,热表表号:'+$("#meterno2").val()+'曲线';
		    			title2='曲线图';
		    			dw='度';
		    			for(var i=0;i<jsonarray.length;i++){
		    				chartdata[i] = parseFloat(jsonarray[i].METERDAY);
		    				xchart[i] = jsonarray[i].DDATE;
		    			}  
	    		   }
	    /* Bootstrap modal 的 highcharts */		
	    		$('#hd_charts').highcharts({
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
    		                text: y1
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
    		            data: chartdata
    		        }]
    		    }); 
		        }
			});
		}
   });
  
});


var title = '抄表监测数据';
//导出查询历史数据
function exportExcel(type){
	   var areaguid=$('#sel_company').val();
	   var buildno=$('#sel_hrz').val();
	   var msid=$('#selstate').val();
	   var areacode=$('#txtaddcode').val();
	   var form = "<form name='csvexportform' action='${contextPath}/pipeMonitor/huanreStationMonitContr/exportoperlist?title="+title+"&areaguid="+areaguid+"&buildno="+buildno+"&msid="+msid+"&areacode="+areacode+"&type="+type+"' method='post'>";
 	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(1) + "'>";
 	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
 	   OpenWindow = window.open('', '导出数据','width=500,height=300');
 	   OpenWindow.document.write(form);
 	   OpenWindow.document.close();
	}
	
	
	
function gettmeter(type,object){
    buttonname = $(object).val();
    $("#watchtype").val(type);
	var time = new Date();
	 var month = time.getMonth() + 1;
	 var strDate = time.getDate();
	 if (month >= 1 && month <= 9) {
	     month = "0" + month;
	 }
	 if (strDate >= 0 && strDate <= 9) {
	     strDate = "0" + strDate;
	 }
	 var currentdate = time.getFullYear() + "年" + month + "月" + strDate+"日  ";
	 var hour=time.getHours();
	 
	 
	 if (hour >= 1 && hour <= 9) {
	     hour = "0" + hour;
	 }
	 $("#hour2 option:contains('"+hour+"')").attr("selected", true);
	 
	 
	 $.post("${contextPath}/pipeMonitor/huanreStationMonitContr/gettmeterlist?areaguid="+$("#sel_company").val()+"&buildno="+$("#sel_hrz").val()+"&msid="+$("#selstate").val()+"&addcode="+$("#txtaddcode").val()+"&type="+type, function (data) {  
	
		 var jsonarray = eval("("+data+")");
		 var result="<table id='tabList' class='table table-striped table-bordered table-hover'><thead class='thead'>";
		
		 switch (type)
		 {
		 case "hot":
			 result += "<tr><th colspan='2'>日期：</th><th colspan='2'>" + currentdate + "</th><th colspan='7'></th><th colspan='2'>室外温度(℃)</th><th colspan='1'>10</th></tr><tr ><th>序号</th><th>供热单位</th><th>名称</th><th>地址</th><th>供热<br/>面积<br/>(万平米)</th><th>热表编号</th>";
             result += "<th>抄表时间</th><th>热表状态</th><th>瞬时<br />流量<br/>(T/h)</th><th>累计<br />流量<br/>(T)</th><th>瞬时<br />热量<br/>(KW)</th><th>累计<br />热量<br/>(MW*h)</th><th>供水<br />温度<br/>(℃)</th><th>回水<br />温度<br/>(℃)</th></tr></thead><tbody>";
             for(var i=0;i<jsonarray.length;i++){	
            	 result += "<tr><td>"+(i+1)+"</td><td>"+jsonarray[i].BUILDSDAN+"</td><td><a href='javascript:$(\"#button-modal-table\").modal(\"toggle\");$(\"#type\").val(\"hot\");$(\"#lblbuildno\").text(\"" + jsonarray[i].BUILDNO +"\");$(\"#buildnovalue\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#lblmeterno\").text(\"" + jsonarray[i].METERID +"\");$(\"#meternovalue\").val(\"" +jsonarray[i].METERID +"\")'>"+jsonarray[i].BUILDNAME+"</a></td><td>"+jsonarray[i].ADDRESS+"</td><td>"+jsonarray[i].GRMJ+"</td>";
                 if (jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
            	 result+="<td>"+jsonarray[i].METERID+"</td><td>"+jsonarray[i].DDATE+"</td><td>"+jsonarray[i].MSNAME+"</td>";
                }else if(jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
                	 result+="<td></td><td></td><td>换热站未施工</td>";	
                } else if (jsonarray[i].REMK!= "3"){
                	 result+="<td></td><td></td><td>改建的换热站</td>";	
                }else{
                	result+="<td></td><td></td><td>已拆除的换热站</td>";	
                }
                 //返回数据
                if(jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERSSLJ+"</a></td>";
                	 result+=" <td>"+jsonarray[i].METERNLLJ+"</td><td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERSSRL+"</a></td><td>"+jsonarray[i].METERNLRL+"</td>";
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERJSWD+"</a></td>";
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERHSWD+"</a></td></tr>";
                }else{
                	result+=" <td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                }
            
             }
		     break;
		 case "electric":
			 result += "<tr ><th colspan='2'>日期：</th><th>" + currentdate + "</th><th colspan='4'></th><th colspan='1'>室外温度(℃)</th><td colspan='1'>10</th></tr><tr><th>序号</th><th>供热单位</th><th>名称</th><th>地址</th><th>供热<br/>面积<br/>(万平米)</th><th>电表编号</th><th>抄表时间</th><th>电表状态</th><th>累计<br />电量<br/>(度)</th></tr></thead><tbody>";
			  for(var i=0;i<jsonarray.length;i++){
				  result += "<tr><td>"+(i+1)+"</td><td>"+jsonarray[i].BUILDSDAN+"</td><td><a href='javascript:$(\"#button-modal-table\").modal(\"toggle\");$(\"#type\").val(\"electric\");$(\"#lblbuildno\").text(\"" + jsonarray[i].BUILDNO +"\");$(\"#buildnovalue\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#lblmeterno\").text(\"" + jsonarray[i].METERID +"\");$(\"#meternovalue\").val(\"" +jsonarray[i].METERID +"\")'>"+jsonarray[i].BUILDNAME+"</a></td><td>"+jsonarray[i].ADDRESS+"</td><td>"+jsonarray[i].GRMJ+"</td>";
	                 if (jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
	            		 result+="<td>"+jsonarray[i].METERID+"</td><td>"+jsonarray[i].DDATE+"</td><td>"+jsonarray[i].MSNAME+"</td>";
	                }else if(jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
	                	 result+="<td></td><td></td><td>换热站未施工</td>";	
	                } else if (jsonarray[i].REMK!= "3"){
	                	 result+="<td></td><td></td><td>改建的换热站</td>";	
	                }else{
	                	result+="<td></td><td></td><td>已拆除的换热站</td>";	
	                }
	                  if(jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
		                 result += "<td><a href='javascript:$(\"#modal-dialog\").modal(\"toggle\");$(\"#buildname2\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno2\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno2\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERNLLJ+"</a></td></tr>";
	                  }else{
	                	  result += "<td></td></tr>";
	                  }
		           }
			 break;
		 case "water":
			 result += "<tr ><th colspan='2'>日期：</th><th>" + currentdate + "</th><th colspan='4'></th><th colspan='1'>室外温度(℃)</th><th colspan='1'>10</th></tr><tr><th>序号</th><th>供热单位</th><th>名称</th><th>地址</th><th>供热<br/>面积<br/>(万平米)<th>水表编号</th></th><th>抄表时间</th><th>水表状态</th><th>累计<br />水量<br/>(吨)</th></tr></thead><tbody>";
			  for(var i=0;i<jsonarray.length;i++){
				  result += "<tr><td>"+(i+1)+"</td><td>"+jsonarray[i].BUILDSDAN+"</td><td><a href='javascript:$(\"#button-modal-table\").modal(\"toggle\");$(\"#type\").val(\"water\");$(\"#lblbuildno\").text(\"" + jsonarray[i].BUILDNO +"\");$(\"#buildnovalue\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#lblmeterno\").text(\"" + jsonarray[i].METERID +"\");$(\"#meternovalue\").val(\"" +jsonarray[i].METERID +"\")'>"+jsonarray[i].BUILDNAME+"</a></td><td>"+jsonarray[i].ADDRESS+"</td><td>"+jsonarray[i].GRMJ+"</td>";
	                 if (jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
	            	 result+="<td>"+jsonarray[i].METERID+"</td><td>"+jsonarray[i].DDATE+"</td><td>"+jsonarray[i].MSNAME+"</td>";
	                }else if(jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
	                	 result+="<td></td><td></td><td>换热站未施工</td>";	
	                } else if (jsonarray[i].REMK!= "3"){
	                	 result+="<td></td><td></td><td>改建的换热站</td>";	
	                }else{
	                	result+="<td></td><td></td><td>已拆除的换热站</td>";	
	                }
	                 if(jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
		                 result += "<td>"+jsonarray[i].METERNLLJ+"</td></tr>";
	                  }else{
	                	  result += "<td></td></tr>";
	                  }
			  }
			 break;
		 default:
			 result += "<tr><th colspan='2'>日期：</th><th colspan='2'>" + currentdate + "</th><th colspan='7'></th><th colspan='2'>室外温度(℃)</th><th colspan='1'>10</th></tr><tr ><th>序号</th><th>供热单位</th><th>名称</th><th>地址</th><th>供热<br/>面积<br/>(万平米)</th><th>热表编号</th>";
             result += "<th>抄表时间</th><th>热表状态</th><th>瞬时<br />流量<br/>(T/h)</th><th>累计<br />流量<br/>(T)</th><th>瞬时<br />热量<br/>(KW)</th><th>累计<br />热量<br/>(MW*h)</th><th>供水<br />温度<br/>(℃)</th><th>回水<br />温度<br/>(℃)</th></tr></thead><tbody>";
             for(var i=0;i<jsonarray.length;i++){	
            	 result += "<tr><td>"+(i+1)+"</td><td>"+jsonarray[i].BUILDSDAN+"</td><td><a href='javascript:$(\"#button-modal-table\").modal(\"toggle\");$(\"#type\").val(\"hot\");$(\"#lblbuildno\").text(\"" + jsonarray[i].BUILDNO +"\");$(\"#buildnovalue\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#lblmeterno\").text(\"" + jsonarray[i].METERID +"\");$(\"#meternovalue\").val(\"" +jsonarray[i].METERID +"\")'>"+jsonarray[i].BUILDNAME+"</a></td><td>"+jsonarray[i].ADDRESS+"</td><td>"+jsonarray[i].GRMJ+"</td>";
                 if (jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
            	 result+="<td>"+jsonarray[i].METERID+"</td><td>"+jsonarray[i].DDATE+"</td><td>"+jsonarray[i].MSNAME+"</td>";
                }else if(jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
                	 result+="<td></td><td></td><td>换热站未施工</td>";	
                } else if (jsonarray[i].REMK!= "3"){
                	 result+="<td></td><td></td><td>改建的换热站</td>";	
                }else{
                	result+="<td></td><td></td><td>已拆除的换热站</td>";	
                }
                 if(jsonarray[i].REMK!= "1" && jsonarray[i].REMK!= "2" && jsonarray[i].REMK!= "3" && jsonarray[i].REMK!= "4"){
                
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERSSLJ+"</a></td>";
                	 result+=" <td>"+jsonarray[i].METERNLLJ+"</td><td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERSSRL+"</a></td><td>"+jsonarray[i].METERNLRL+"</td>";
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERJSWD+"</a></td>";
                	 result+=" <td><a href='javascript:$(\"#modal-table\").modal(\"toggle\");$(\"#buildname\").val(\"" + jsonarray[i].BUILDNAME +"\");$(\"#buildno\").val(\"" + jsonarray[i].BUILDNO +"\");$(\"#meterno\").val(\"" + jsonarray[i].METERID +"\")'>"+jsonarray[i].METERHSWD+"</a></td></tr>";
                }else{
                	result+=" <td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                }
             }
		 }
		result+="</tbody></table>";
		$('#divDataContent').empty(); 
	    $('#divDataContent').append(result); 
	   
     });  
}
</script>
