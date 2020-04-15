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
</style>
		
<br/>
		<div class="row" style="height: 30px;">
			<div class="col-md-3">
				<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">供热站: </span>
					  <select id="search_areaname" class="form-control">
					  	<option value="1">新民供热站</option>
					  	<option value="2">金星供热站</option>
					  </select>
				</div>
			</div>
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3">起止时间：</span>
<%
	Calendar c = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today=sdf.format(c.getTime());
	c.add(Calendar.DATE, -7);
	String ago = sdf.format(c.getTime());
%>
					  <input type="text" class="form-control" value="<%=ago %>" id="input_sel_date" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			<div class="col-md-3">
				<div class="input-group" >
					  <span class="input-group-addon" id="basic-addon3"> 结束时间：</span>
					  <input type="text" class="form-control" value="<%=today %>" id="input_sel_date2" readonly="readonly" aria-describedby="basic-addon3">
				</div>
			</div>
			<div class="col-md-3">
				<button type="button" class="btn btn-success" style="float: right;" id="statistic_search">查询</button>
			</div>
		</div>
		
		<br/>
		
		<div class="row">
		    <div class="col-md-12" style="text-align: center;">
			      <table class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;">
					  <thead id="tHead"></thead>
					  <tbody id="tBody"></tbody>
				  </table>
		    </div>
		    
 		 </div>
		
	</div>
</body>
</html>

<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	<%-- $.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
		var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
		var flagName = '';
			var response = jQuery.parseJSON(data);
		      var s = '<option value="">所有小区</option>';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           if(ri['AREAGUID']==areaguid){
			        	   flagName = ri['AREANAME'];
			           }
		        	   s += '<option value="' + ri['AREANAME'] + '">' + ri['AREANAME'] + '</option>';   
		          }
		       }
		      $('#search_areaname').empty().append(s);
	}) --%>
	
	$("#input_sel_date").datepicker({dateFormat: 'yy-mm-dd'});
	$("#input_sel_date2").datepicker({dateFormat: 'yy-mm-dd'});
	
	$('#statistic_search').click(function(){
		loadTable();
	});
	
});
    
	
	function roundFix(cellvalue){
		if(cellvalue==''||cellvalue==undefined)
			return 0;
		return cellvalue.toFixed(2);
	}
	
	var loadTable = function(){
		var tHead = "#tHead";
		var tBody = "#tBody";
		
		var shortHead = "<tr><th>供热站</th><th>起始耗热(MW*H)</th><th>结束耗热(MW*H)</th><th>耗热(MW*H)</th></tr>";
		var longHead = "<tr><th>供热站</th><th>起始耗热(MW*H)</th><th>结束耗热(MW*H)</th><th>耗热(MW*H)</th>" 
					+ "<th>换热站</th><th>起始耗热(MW*H)</th><th>结束耗热(MW*H)</th><th>耗热(MW*H)</th><th>总耗热(MW*H)</th><th>网损</th>"
					+ "<th>小区</th><th>耗热</th><th>总耗热</th><th>网损</th></tr>";
					
		var shortTbody = "<tr><th>新民供热站</th><th>198844</th><th>205005</th><th>6161</th></tr>";
		var longTbody = '<tr align=\"center\"><td rowspan=\"15\" style=\"vertical-align: middle;\">金星供热站</td><td rowspan=\"15\" style=\"vertical-align: middle;\">14351.7</td><td rowspan=\"15\" style=\"vertical-align: middle;\">14351.7</td><td rowspan=\"15\" style=\"vertical-align: middle;\">0</td><td>中达换热站</td><td>142612</td><td>143960</td><td>1348</td><td rowspan=\"15\" style=\"vertical-align: middle;\">91896499.3</td><td rowspan=\"15\" style=\"vertical-align: middle;\">负无穷大</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>金星锅炉房</td><td>380183.03</td><td>380183.03</td><td>0</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>明珠花园二期换热站</td><td>5344.7</td><td>5400.4</td><td>55.7</td><td>明珠花园二区</td><td>31.43</td><td>31.43</td><td>0.44</td></tr><tr align=\"center\"><td>工行小区换热站</td><td>13574</td><td>13733.9</td><td>159.9</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>塔寺换热站</td><td>25672.6</td><td>25839.8</td><td>167.2</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>金星花园北口换热站</td><td>9390.7</td><td>9390.7</td><td>0</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>利北（黄河医院）</td><td>13847.7</td><td>13847.7</td><td>0</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>东方御园换热站</td><td>5172.3</td><td>5268.4</td><td>96.1</td><td>东方御园</td><td>32.46</td><td>32.46</td><td>0.66</td></tr><tr align=\"center\"><td>绿地园换热站</td><td>16506.1</td><td>16593.9</td><td>87.8</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>明珠花园换热站</td><td>36220.1</td><td>36457.5</td><td>237.4</td><td>明珠花园一区</td><td>89.02</td><td>89.02</td><td>0.63</td></tr><tr align=\"center\"><td>二汽服务站换热站</td><td>23395.5</td><td>23593.8</td><td>198.3</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>金星花园南口</td><td>707520.1</td><td>707520.1</td><td>0</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>幼儿园</td><td>918590.1</td><td>923415</td><td>4824.9</td><td></td><td></td><td></td><td></td></tr><tr align=\"center\"><td>华港佳苑换热站</td><td>1010335</td><td>1018411</td><td>8076</td><td>华港佳苑</td><td>87.01</td><td>87.01</td><td>0.99</td></tr><tr align=\"center\"><td>谦益花园换热站</td><td>128320</td><td>92009568</td><td>91881248</td><td>谦益花园</td><td>58.2</td><td>58.20</td><td>1.00</td></tr>';
		if($("#search_areaname").val() == "2"){
			$(tHead).empty().append(longHead);
			$(tBody).empty().append(longTbody);
		}else{
			$(tHead).empty().append(shortHead);
			$(tBody).empty().append(shortTbody);
		}
		
		/* $.get(url,function(response){
			var data = jQuery.parseJSON(response);
		}); */
	}
	
</script>
