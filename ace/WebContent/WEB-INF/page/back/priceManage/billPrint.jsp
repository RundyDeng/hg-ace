<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>供热大数据智慧运行系统</title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
</head>
<body>
<%
String year;
Calendar c = Calendar.getInstance();
if(c.get(Calendar.MONTH)+1>=10){
	year=c.get(Calendar.YEAR)+"-"+(c.get(Calendar.YEAR)+1);
}else{

	year=(c.get(Calendar.YEAR)-1)+"-"+c.get(Calendar.YEAR);
}
%>
<form>
<table>
<tr>
<td>
<label>小区：</label>
<select id="selArea" name="selArea" style="width:100px"> </select>
<label>楼栋：</label>
<select id="selBuild" name="selBuild" style="width:100px"><option value="9999">请选择</option></select>
<label>单元：</label>
<select id="selUnit" name="selUnit" style="width:100px"><option value="9999">请选择</option></select>
<label>楼层：</label>
<select id="selFloor" name="selFloor" style="width:100px"><option value="9999">请选择</option></select>
<label>门牌：</label>
<select id="selDoorname" name="selDoorname" style="width:100px"><option value="9999">请选择</option></select>
<label>选择年度：</label>
<select id="selYears" name="selYears" style="width:100px">
<option value="2014-2015">2014-2015</option>
<option value="2015-2016">2015-2016</option>
<option value="2016-2017">2016-2017</option>
<option value="2017-2018">2017-2018</option>
<option value="2018-2019">2018-2019</option>
<option value="2019-2020">2019-2020</option>
<option value="2020-2021">2020-2021</option>
<option value="2021-2022">2021-2022</option>
<option value="2022-2023">2022-2023</option>
</select>&nbsp;&nbsp;&nbsp;
<button type="button" class="btn btn-primary" id="but_print">退费单打印</button>
</td>

</tr>
</table>
</form>
</body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
               "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
               "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	var value="<%=year %>";
	$("#selYears").children("option").each(function(){  
        var temp_value = $(this).val();  
       if(temp_value == value){  
             $(this).attr("selected","selected");  
       }  
  });
	$("#but_print").click(function () {  
		window.open('${contextPath}/priceMange/billprint/getBillData?areaguid='+$(select_area).val()+'&buildno='+$("#selBuild").val()+'&unitno='+$("#selUnit").val()+'&floorno='+$("#selFloor").val()+'&doorno='+$("#selDoorname").val()+'&years='+$("#selYears").val());
	});
	var select_area = "#selArea";
	var session_areaguid="<%=(String)request.getSession().getAttribute("areaGuids") %>";
	$.get('${contextPath}/baseinfomanage/setarea/getArea',
	         function(data) {
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
							 $.post("${contextPath}/priceMange/billprint/getBuild?areaguid="+$(select_area).val(), function (data) {  
						            /* 清空楼栋 */  
						            $("#selBuild option[value!='9999']").remove();  
						            /* 清空单元 */  
						            $("#selUnit option[value!='9999']").remove();  
						            /* 清空楼层 */  
						            $("#selFloor option[value!='9999']").remove();
						            /* 清空门牌 */  
						            $("#selDoorname option[value!='9999']").remove();
						            var jsonObj = eval("(" + data + ")");  
						            for (var i = 0; i < jsonObj.length; i++) {  
						                var $option = $("<option></option>");  
						                $option.attr("value", jsonObj[i].BUILDNO);  
						                $option.text(jsonObj[i].BUILDNAME);  
						                $("#selBuild").append($option);  
						            }  
						        });  
						}, 'json');
	 /* 根据小区楼栋 */  
    $(select_area).change(function () {  
        $.post("${contextPath}/priceMange/billprint/getBuild?areaguid="+$(select_area).val(), function (data) {  
            /* 清空楼栋 */  
            $("#selBuild option[value!='9999']").remove();  
            /* 清空单元 */  
            $("#selUnit option[value!='9999']").remove();  
            /* 清空楼层 */  
            $("#selFloor option[value!='9999']").remove();
            /* 清空门牌 */  
            $("#selDoorname option[value!='9999']").remove();
            var jsonObj = eval("(" + data + ")");  
            for (var i = 0; i < jsonObj.length; i++) {  
                var $option = $("<option></option>");  
                $option.attr("value", jsonObj[i].BUILDNO);  
                $option.text(jsonObj[i].BUILDNAME);  
                $("#selBuild").append($option);  
            }  
        });  
    });  
    /* 根据小区楼栋单元 */  
    $("#selBuild").change(function () {  
        $.post("${contextPath}/priceMange/billprint/getUnit?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val(), function (data) {  
          
            /* 清空单元 */  
            $("#selUnit option[value!='9999']").remove();  
            /* 清空楼层 */  
            $("#selFloor option[value!='9999']").remove();
            /* 清空门牌 */  
            $("#selDoorname option[value!='9999']").remove();
            var jsonObj = eval("(" + data + ")");  
            for (var i = 0; i < jsonObj.length; i++) {  
                var $option = $("<option></option>");  
                $option.attr("value", jsonObj[i].UNITNO);  
                $option.text(jsonObj[i].UNITNO);  
                $("#selUnit").append($option);  
            }  
        });  
    });  
    /* 根据小区楼栋单元楼层 */  
    $("#selUnit").change(function () {  
        $.post("${contextPath}/priceMange/billprint/getFloor?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val()+"&unitno="+$("#selUnit").val(), function (data) {  
           
            /* 清空楼层 */  
            $("#selFloor option[value!='9999']").remove();
            /* 清空门牌 */  
            $("#selDoorname option[value!='9999']").remove();
            var jsonObj = eval("(" + data + ")");  
            for (var i = 0; i < jsonObj.length; i++) {  
                var $option = $("<option></option>");  
                $option.attr("value", jsonObj[i].FLOORNO);  
                $option.text(jsonObj[i].FLOORNO);  
                $("#selFloor").append($option);  
            }  
        });  
    });  
    /* 根据小区楼栋单元楼层 */  
    $("#selFloor").change(function () {  
        $.post("${contextPath}/priceMange/billprint/getDoorName?areaguid="+$(select_area).val()+"&buildno="+$("#selBuild").val()+"&unitno="+$("#selUnit").val()+"&floorno="+$("#selFloor").val(), function (data) {  
          
            /* 清空门牌 */  
            $("#selDoorname option[value!='9999']").remove();
            var jsonObj = eval("(" + data + ")");  
            for (var i = 0; i < jsonObj.length; i++) {  
                var $option = $("<option></option>");  
                $option.attr("value", jsonObj[i].DOORNO);  
                $option.text(jsonObj[i].FCODE);  
                $("#selDoorname").append($option);  
            }  
        });  
    });  
	});
</script>