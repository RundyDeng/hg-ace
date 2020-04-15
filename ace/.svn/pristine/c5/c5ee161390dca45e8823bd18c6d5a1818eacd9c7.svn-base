<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>收费时间设置</title>
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />
<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
</head>
<body>
<form>
<%
String enddate,startdate,year;
Calendar c = Calendar.getInstance();
if(c.get(Calendar.MONTH)+1>=10){
	enddate =(c.get(Calendar.YEAR)+1)+"-"+"04-15";
	startdate = c.get(Calendar.YEAR)+"-"+"10-15";
	year=c.get(Calendar.YEAR)+"-"+(c.get(Calendar.YEAR)+1);
}else{
	enddate =c.get(Calendar.YEAR)+"-"+"04-15";
	startdate = (c.get(Calendar.YEAR)-1)+"-"+"10-15";
	year=(c.get(Calendar.YEAR)-1)+"-"+c.get(Calendar.YEAR);
}

%>
<div class="row">
 <div class="col-xs-8">
     <div >
         <table  cellpadding="0" cellspacing="1">
               <tr>
                   <td>
                       <label><h3> 收费时间设置(按CTRL多选) </h3></label>
                            </td> </tr></table>
              </div>
 <div>
 <table style="width: 100%;" class="table table" cellpadding="0" cellspacing="0">
 <tr>
            <td rowspan="4" valign="middle" >
                      <br/><br/><br/><br/><br/><br/><br/><br/><br/>
                                                                      小区列表
                    </td>
                   <td rowspan="4">
                   <select size="4" name="selArea" onClick="" id="selArea" style="height: 400px; width: 180px;" multiple="multiple"></select>
  </td>
        <td><br/><br/> 年度：</td>
      <td>
      <br/><br/>
      <select id="years" >
      <option value="2015-2016">2015-2016</option>
      <option value="2016-2017">2016-2017</option>
      <option value="2017-2018">2017-2018</option>
      <option value="2018-2019">2018-2019</option>
      <option value="2019-2020">2019-2020</option>
      <option value="2020-2021">2020-2021</option>
      <option value="2021-2022">2021-2022</option>
      <option value="2022-2023">2022-2023</option>
      <option value="2023-2024">2023-2024</option>
      </select>
       </td>
      </tr>
    <tr>
     <td> <br/><br/>开始日期：</td> <td>
     <br/><br/>
     <input type="text"  class="form-control"  style="width:120px" value="<%=startdate %>" id="input_sel_sdate" readonly="readonly" aria-describedby="basic-addon3">
      </td>
        </tr>
        <tr>
           <td><br/><br/> 结束日期：</td>
                <td>
                <br/><br/>
     <input type="text"  class="form-control" style="width:120px" value="<%=enddate %>" id="input_sel_edate" readonly="readonly" aria-describedby="basic-addon3">
        </td>
             </tr>
             <tr>
                <td> &nbsp; </td>
                  <td>
                   <button type="button" class="btn btn-success" id="setCharge" >设   置</button>
                   
                     </td>
                      </tr>
      
 </table>
 </div>
 </div>
 <div class="col-xs-4">
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
	
	var value="<%=year %>";
	$("#years").children("option").each(function(){  
	               var temp_value = $(this).val();  
	              if(temp_value == value){  
	                    $(this).attr("selected","selected");  
	              }  
	         });
	
	$("#input_sel_sdate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	$("#input_sel_edate").datepicker({
		dateFormat: 'yy-mm-dd',
		defaultDate : new Date(),
   });
	//设置小区收费年份与日期
	$('#setCharge').click(function(){
		var areaguids="";
		var bdate="<%=startdate %>";
		var adate="<%=enddate %>";
		 $.each($('#selArea').val(), function(i,val){      
		     areaguids+=val+",";
		  });  
		 $.ajax({
 			url : '${contextPath}/priceMange/setChargeDate/setchargedate',
 			type : 'POST',
 			data:  "areaguid=" + areaguids + "&years="+value+"&bdate="+bdate+"&adate="+adate,
 			dataType : 'json',
 			success : function(data){
 				if(data==true){
                     alert('设置成功');
                 }else{
                     alert('设置失败');
                 }
 			}
 			
 		});
		
		
	});
	var select_area = "#selArea";
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

							$(select_area).append(selopt)

						}, 'json');
});


</script>