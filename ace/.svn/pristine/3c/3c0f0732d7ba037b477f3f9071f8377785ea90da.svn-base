<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>退补费分析</title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
		</style>
</head>
<body>
<form class="form-inline" align="center">
<div class="form-group">

	<label for="lbarea">小区选择：</label>
	<select id="selArea" name="selArea" style="width:100px"> </select>
</div>

	<button type="button" class="btn btn-success" id="searchdata" >小区退补费分析</button>
	
<br/>
    <div class="row">
    <div class="col-xs-12" style="text-align: center;" id="tabfee">
		
		</div>
     </div>
</form>
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	 $('#searchdata').click(function(){
		   $('#tabfee').empty();
			getfeeData();
		   });
	
	var select_area = "#selArea";
	var session_areaguid="<%=(String)request.getSession().getAttribute("areaGuids") %>";
	$.get('${contextPath}/baseinfomanage/setarea/getArea', function(data) {
							var selopt;
							for (i in data) {
								if (i == 0)
									selopt += '<option  value="'+data[i]['AREAGUID']+'">'
											+ data[i]['AREANAME']
											+ '</option>';
								else
									selopt += '<option value="'+data[i]['AREAGUID']+'">'
											+ data[i]['AREANAME']
											+ '</option>';

							}

							$(select_area).append(selopt);
							$(select_area).children("option").each(function(){  
						        var temp_value = $(this).val();  
						       if(temp_value == session_areaguid){  
						             $(this).attr("selected","selected");  
						       }  
						  });
							 
						}, 'json');
});
function getfeeData(){
	$.post("${contextPath}/priceMange/feeAnalysis/getfeedata?areaguid="+$('#selArea').val(), function (json) {  
		var productData=jQuery.parseJSON(json); 
		if (productData.length>0) {   
             var str = " <table id='operData' class='table table-bordered table-hover table-striped' style='margin-bottom: 0px;'>";
             str+="<tr>"
             for(var i=0 ; i<productData.length ; i++){
            			
 					var obj = productData[i];
 					str+="<td colspan='5'>"+obj['年份']+"</td>";
            	 }
             str+="</tr>";
             str+="<tr><td>分类</td><td><</td><td>平均耗热</td><td>></td><td>对比</td>";
             str+="<td>分类</td><td><</td><td>平均耗热</td><td>></td><td>对比</td>";
             str+="<td>分类</td><td><</td><td>平均耗热</td><td>></td><td>对比</td></tr>";
            // var mylx=new Array("户数(户)","面积(㎡)","应收费金额","总热量(kwh)","退补金额(元)","耗热(GJ/㎡.a)","耗热指标(w/㎡)");
            //户数 
             str+="<tr><td>户数(户)</td><td>"+productData[0]['户数2']+"</td><td></td><td>"+productData[0]['户数1']+"</td><td>"+(parseInt(productData[0]['户数1'])-parseInt(productData[0]['户数2'])).toString()+"</td>";
             str+="<td>户数(户)</td><td>"+productData[1]['户数2']+"</td><td></td><td>"+productData[1]['户数1']+"</td><td>"+(parseInt(productData[1]['户数1'])-parseInt(productData[1]['户数2'])).toString()+"</td>";
             str+="<td>户数(户)</td><td>"+productData[2]['户数2']+"</td><td></td><td>"+productData[2]['户数1']+"</td><td>"+(parseInt(productData[2]['户数1'])-parseInt(productData[2]['户数2'])).toString()+"</td></tr>";
            //面积
             str+="<tr><td>面积(㎡)</td><td>"+productData[0]['面积2']+"</td><td></td><td>"+productData[0]['面积1']+"</td><td>"+(parseFloat(productData[0]['面积1'])-parseFloat(productData[0]['面积2'])).toFixed(2).toString()+"</td>";
             str+="<td>面积(㎡)</td><td>"+productData[1]['面积2']+"</td><td></td><td>"+productData[1]['面积1']+"</td><td>"+(parseFloat(productData[1]['面积1'])-parseFloat(productData[1]['面积2'])).toFixed(2).toString()+"</td>";
             str+="<td>面积(㎡)</td><td>"+productData[2]['面积2']+"</td><td></td><td>"+productData[2]['面积1']+"</td><td>"+(parseFloat(productData[2]['面积1'])-parseFloat(productData[2]['面积2'])).toFixed(2).toString()+"</td></tr>";
             str+="<tr><td>应收费金额</td><td>"+productData[0]['应收费金额2']+"</td><td></td><td>"+productData[0]['应收费金额1']+"</td><td>"+(parseFloat(productData[0]['应收费金额1'])-parseFloat(productData[0]['应收费金额2'])).toFixed(2).toString()+"</td>";
             str+="<td>应收费金额</td><td>"+productData[1]['应收费金额2']+"</td><td></td><td>"+productData[1]['应收费金额1']+"</td><td>"+(parseFloat(productData[1]['应收费金额1'])-parseFloat(productData[1]['应收费金额2'])).toFixed(2).toString()+"</td>";
             str+="<td>应收费金额</td><td>"+productData[2]['应收费金额2']+"</td><td></td><td>"+productData[2]['应收费金额1']+"</td><td>"+(parseFloat(productData[2]['应收费金额1'])-parseFloat(productData[2]['应收费金额2'])).toFixed(2).toString()+"</td></tr>";
         
             str+="<tr><td>总热量(kwh)</td><td>"+productData[0]['总热量2']+"</td><td></td><td>"+productData[0]['总热量1']+"</td><td>"+(parseFloat(productData[0]['总热量1'])-parseFloat(productData[0]['总热量2'])).toFixed(2).toString()+"</td>";
             str+="<td>总热量(kwh)</td><td>"+productData[1]['总热量2']+"</td><td></td><td>"+productData[1]['总热量1']+"</td><td>"+(parseFloat(productData[1]['总热量1'])-parseFloat(productData[1]['总热量2'])).toFixed(2).toString()+"</td>";
             str+="<td>总热量(kwh)</td><td>"+productData[2]['总热量2']+"</td><td></td><td>"+productData[2]['总热量1']+"</td><td>"+(parseFloat(productData[2]['总热量1'])-parseFloat(productData[2]['总热量2'])).toFixed(2).toString()+"</td></tr>";
             str+="<tr><td>退补金额(元)</td><td>"+productData[0]['退补费金额2']+"</td><td></td><td>"+productData[0]['退补费金额1']+"</td><td>"+(parseFloat(productData[0]['退补费金额1'])-parseFloat(productData[0]['退补费金额2'])).toFixed(2).toString()+"</td>";
             str+="<td>退补金额(元)</td><td>"+productData[1]['退补费金额2']+"</td><td></td><td>"+productData[1]['退补费金额1']+"</td><td>"+(parseFloat(productData[1]['退补费金额1'])-parseFloat(productData[1]['退补费金额2'])).toFixed(2).toString()+"</td>";
             str+="<td>退补金额(元)</td><td>"+productData[2]['退补费金额2']+"</td><td></td><td>"+productData[2]['退补费金额1']+"</td><td>"+(parseFloat(productData[2]['退补费金额1'])-parseFloat(productData[2]['退补费金额2'])).toFixed(2).toString()+"</td></tr>";
         
             str+="<tr><td>耗热(GJ/㎡.a)</td><td>"+productData[0]['耗热2']+"</td><td>"+((parseFloat(productData[0]['耗热1'])+parseFloat(productData[0]['耗热2']))/2).toFixed(2).toString()+"</td><td>"+productData[0]['耗热1']+"</td><td>"+(parseFloat(productData[0]['耗热1'])-parseFloat(productData[0]['耗热2'])).toFixed(2).toString()+"</td>";
             str+="<td>耗热(GJ/㎡.a)</td><td>"+productData[1]['耗热2']+"</td><td>"+((parseFloat(productData[1]['耗热1'])+parseFloat(productData[1]['耗热2']))/2).toFixed(2).toString()+"</td><td>"+productData[1]['耗热1']+"</td><td>"+(parseFloat(productData[1]['耗热1'])-parseFloat(productData[1]['耗热2'])).toFixed(2).toString()+"</td>";
             str+="<td>耗热(GJ/㎡.a)</td><td>"+productData[2]['耗热2']+"</td><td>"+((parseFloat(productData[2]['耗热1'])+parseFloat(productData[2]['耗热2']))/2).toFixed(2).toString()+"</td><td>"+productData[2]['耗热1']+"</td><td>"+(parseFloat(productData[2]['耗热1'])-parseFloat(productData[2]['耗热2'])).toFixed(2).toString()+"</td></tr>";
             str+="<tr><td>耗热指标(w/㎡)</td><td>"+productData[0]['耗热指标2']+"</td><td>"+((parseFloat(productData[0]['耗热指标1'])+parseFloat(productData[0]['耗热指标2']))/2).toFixed(2).toString()+"</td><td>"+productData[0]['耗热指标1']+"</td><td>"+(parseFloat(productData[0]['耗热指标1'])-parseFloat(productData[0]['耗热指标2'])).toFixed(2).toString()+"</td>";
             str+="<td>耗热指标(w/㎡)</td><td>"+productData[1]['耗热指标2']+"</td><td>"+((parseFloat(productData[1]['耗热指标1'])+parseFloat(productData[1]['耗热指标2']))/2).toFixed(2).toString()+"</td><td>"+productData[1]['耗热指标1']+"</td><td>"+(parseFloat(productData[1]['耗热指标1'])-parseFloat(productData[1]['耗热指标2'])).toFixed(2).toString()+"</td>";
             str+="<td>耗热指标(w/㎡)</td><td>"+productData[2]['耗热指标2']+"</td><td>"+((parseFloat(productData[2]['耗热指标1'])+parseFloat(productData[2]['耗热指标2']))/2).toFixed(2).toString()+"</td><td>"+productData[2]['耗热指标1']+"</td><td>"+(parseFloat(productData[2]['耗热指标1'])-parseFloat(productData[2]['耗热指标2'])).toFixed(2).toString()+"</td></tr>";
         
             str+="</table>";
             $("#tabfee").append(str);
         }
	});
}
</script>
