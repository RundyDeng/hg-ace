<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<div class="row">
	<div class="col-xs-12">
		 <div class="box">
			<div class="row">
						<div class="col-md-10" style="padding-left: 19px;"><h4>小区信息详情</h4></div>
						<div class="col-md-2" style="padding-top: 10px;">
							 <!-- <div title="返回上一页" style="cursor:pointer;" onClick="javascript:history.back();" >
								<div class="ui-pg-div"><span class="ui-icon ace-icon fa fa-long-arrow-left"></span>返回</div>
							</div>  -->
						</div>
			</div>
			<div class="con">
			
			
				<table style="width: 100%;" class="table table" cellpadding="0"
					cellspacing="0">
					<tbody>
					
						<tr>
							<th>小区名称：</th>
							<td colspan="3"><span id="lblAreaName">${result.AREANAME}</span></td>
						</tr>
						<tr>
							<th>分 公 司：</th>
							<td><span id="lblgs">${result.FACTORYNAME}</span></td>
							<th>热力站：</th>
							<td><span id="lblrlz">${result.SECTIONNAME}</span></td>
						</tr>
						<tr>
							<th>地&nbsp;&nbsp; 址：</th>
							<td><span id="lblAddress">${result.AREAPLACE}</span></td>
							<th>联系人：</th>
							<td><span id="LblLinkMan">${result.LINKMAN}</span></td>
						</tr>
						<tr>
							<th>电&nbsp;&nbsp; 话：</th>
							<td><span id="lblTel">${result.TELEPHONE}</span></td>
							<th>GPRS：</th> 
							<td ><span id="lblGprs" > </span></td>
						</tr>
						 <tr>
							<th>小区概况：</th>
							<td colspan="3"><span id="lblSMEMO">${result.SMEMO }</span></td>
						</tr>
						
					
						<tr >
							<td colspan="4"  >&nbsp;
							<img id="img" src="${contextPath}/static/image/${result.IMAGEMAP}"
								style="border-width: 0px;" heigth="100%" >
							</td>
							
					<%-- 		<td colspan="4"  >&nbsp;
							<img id="img" src="${contextPath}/static/image/${result.IMAGEMAP2}"
								style="border-width: 0px;" heigth="100%" >
							</td>
						</tr> --%>
						
						
					</tbody>
				</table>
			</div>
		</div>


	</div>
</div>

	
 <script type="text/JavaScript" src="http://api.map.baidu.com/api?v=2.0&ak=m9OCmiQj80nR17gYi4fSeEhf"></script>
 <script type="text/javascript">
 
 var r = 1;
 function preperation() {				
 	setInterval(change, 200, context);
 }
 function change(context) {
 	context.clearRect(0, 0, 200, 200);
 	context.strokeStyle = 'red';
 	context.beginPath();
 	context.arc(100, 100, r++, 0, 2 * Math.PI);
 	context.closePath();
 	context.stroke();
 	r++;
 	if(r >= 25) {
 		r = 1;
 	}			
 }
 
 
 
 
 
 function change(context) {
		context.clearRect(0, 0, 200, 200);//每次清空画布
		var grad = context.createRadialGradient(100, 100, 1, 100, 100, r);
		grad.addColorStop(0, 'rgba(168,84,93,0)');//按照需求进行调整
		grad.addColorStop(0.5, 'rgba(172,55,73,0)');
		grad.addColorStop(1, 'red');
		context.strokeStyle = 'red';
		context.fillStyle = grad;
		context.beginPath();
		context.arc(100, 100, r++, 0, 2 * Math.PI);
		context.closePath();
		context.stroke();
		context.fill();
	 
		grad = context.createRadialGradient(150, 150, 1, 150, 150, r);
		grad.addColorStop(0, 'rgba(231,241,2,0)');
		grad.addColorStop(0.5, 'rgba(231,241,2,0)');
		grad.addColorStop(1, 'yellow');
		context.strokeStyle = 'yellow';
		context.fillStyle = grad;
		context.beginPath();
		context.arc(150, 150, r++, 0, 2 * Math.PI);
		context.closePath();
		context.stroke();
		context.fill();
		r++;
		if(r >= 25) {
			r = 1;
		}
	}
 
 
	 var positionType=null;
	 function  getLocation(){ saveUinfos('city','province','area',0,0);
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
	if(this.getStatus() == BMAP_STATUS_SUCCESS){
	alert('您的位置：'+r.point.lng+','+r.point.lat+" "+r.address.province+" "+r.address.district);
	   
	}
	else {
	alert('定位失败');
	history.go(-1); 
	}        
	},{enableHighAccuracy: true});
	 }
	 
	var scripts = ["${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js",
			"${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	});
	
</script>  









