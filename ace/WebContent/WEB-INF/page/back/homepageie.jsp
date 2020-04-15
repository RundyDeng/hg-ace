<%@page import="core.util.MathUtils"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="core.util.MathUtils" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
		<link rel="stylesheet"
			href="${contextPath}/static/assets/css/chartsreports/morris.css" />
			
		<link rel="stylesheet"
			href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />
<!-- ajax layout which only needs content area -->
<!-- <div class="page-header">
	<h1>
		控制台
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
			概述&统计
		</small>
	</h1>
</div> -->
<!-- /.page-header -->
<style>
.index_backgroud {
	height: 78px;
}

.index_postion {
	position: absolute;
}

</style>


<% Map map = (Map)request.getAttribute("headMap");
											double zcsum = MathUtils.getBigDecimal(map.get("ZCSUM")).doubleValue();
											double totcbsum = MathUtils.getBigDecimal(map.get("TOTCBSUM")).doubleValue();
											double normalRate = 0;
											if(totcbsum!=0){
												normalRate = zcsum/totcbsum*100;
											}
%>

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<!-- <div class="alert alert-block alert-success">
			<button type="button" class="close" data-dismiss="alert">
				<i class="ace-icon fa fa-times"></i>
			</button>
			<strong class="green">
				供热大数据智慧运行系统
			</strong>
		</div> -->

		<div class="row">
			<div class="space-6"></div>
			<div class="col-sm-7 " style="height: 275px;">

				<div class="widget-box" style="height: 98%;">
					<div class="widget-header widget-header-flat widget-header-small">
						<h5 class="widget-title">
							<i class="ace-icon fa fa-eye"></i> 数据统计
						</h5>
						<div class="widget-toolbar no-border">
							<div class="inline dropdown-hover">
								<button class="btn btn-minier btn-primary" id="headStatisticMore">
									查看详情 
								</button>
							</div>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main" style="padding: 0px; padding-left: 0px;">

							<div>

								<div class="infobox-container" style="margin-top: 7px;">
									<div class="infobox infobox-green index_backgroud">
						
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id = "clientSum">${headMap.TOTZHSUM }</span>
											<div class="infobox-content">住户总数</div>
										</div>

									</div>

									<div class="infobox infobox-blue index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id="cbSum">${headMap.TOTCBSUM }</span>
											<div class="infobox-content">抄表总数</div>
										</div>

									</div>

									<div class="infobox infobox-pink index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id ="cbzcSum">${headMap.ZCSUM }</span>
											<div class="infobox-content">抄表正常数</div>
										</div>
										
									</div>

									<div class="infobox infobox-red index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id="wcbSum">${headMap.WCSUM }</span>
											<div class="infobox-content">未超表数</div>
										</div>
									</div>

									<div class="infobox infobox-orange2 index_backgroud">
										
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>
										
										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id="bgzSum">${headMap.GZSUM }</span>
											<div class="infobox-content">表故障数</div>
										</div>

									</div>

									<div class="infobox infobox-blue2 index_backgroud">


										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number" id="bwfySum">${headMap.WFYSUM }</span>
											<div class="infobox-content">表无反应数</div>
										</div>
									</div>
								</div>


							</div>

							<div class="hr hr8 hr-double"></div>

							<div class="clearfix">
								
								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x red"></i> &nbsp; 统计日期
									</span>
									<h6 class="bigger pull-right" id="statisticsDate">${headStatisticsDate }</h6>
								</div>
								
								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x blue"></i> &nbsp; 已统计小区数
									</span>
									<h4 class="bigger pull-right" id="statisticsArea">${headMap.AREASUM }</h4>
								</div>

								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x purple"></i> &nbsp; 表正常率
									</span>
									
									<h4 class="bigger pull-right" id ="normalRate">
										
										<fmt:formatNumber value="<%=normalRate %>" pattern="0.00" maxFractionDigits="2"/>&nbsp;%
									</h4>
								</div>

							</div>
						</div>					
					</div>			
				</div>
				
<!-- 数据统计结束 -->

			</div>


			<div class="vspace-12-sm"></div>

			<div class="col-sm-5">
				<div class="widget-box ui-sortable-handle">
					<div class="widget-header widget-header-flat widget-header-small">
						<h5 class="widget-title">
							<i class="ace-icon fa fa-eye"></i> 表数据概率分析
						</h5>
						<div class="widget-toolbar no-border">
							<ul class="nav nav-tabs" id="myTab">
								<li class="active">
									<a aria-expanded="true" data-toggle="tab" href="#index_Area">饼状图</a>
								</li>

								<li class="">
									<a aria-expanded="false" data-toggle="tab" href="#index_Donut">环形图</a>
								</li>

								
							</ul>
						</div>
						
					</div>

					<div class="widget-body">
						<div class="widget-main">
							<div class = "tab-content" style="padding: 0px;">
							
									<div id = "index_Area" class="tab-pane in active">
									
										<div id="piechart-placeholder" ></div>
										
										<div class="hr hr8 hr-double"></div>
			
										<div class="clearfix">
											<div class="grid3">
			
												<span class="blue" style="position: relative; top: 10px;">未抄表率&nbsp;&nbsp;&nbsp;
												</span>
												<div class="easy-pie-chart percentage" data-percent="<%=MathUtils.getNoRound(map.get("WCSUM"),map.get("TOTCBSUM")) %>"
													data-size="41">
													<span class="percent"><%=MathUtils.getNoRound(map.get("WCSUM"),map.get("TOTCBSUM")) %></span>%
												</div>
											</div>
			
			
											<div class="grid3">
			
												<span style="position: relative; top: 10px; color: #F38630;">无反应率&nbsp;&nbsp;&nbsp;
												</span>
												<div class="easy-pie-chart percentage" data-percent="<%=MathUtils.getNoRound(map.get("WFYSUM"),map.get("TOTCBSUM")) %>"
													data-size="41">
													<span class="percent"><%=MathUtils.getNoRound(map.get("WFYSUM"),map.get("TOTCBSUM")) %></span>%
												</div>
											</div>
											
											<div class="grid3">
			
												<span class="red" style="position: relative; top: 10px;">表故障率&nbsp;&nbsp;&nbsp;
												</span>
												<div class="easy-pie-chart percentage" data-percent="<%=MathUtils.getNoRound(map.get("GZSUM"),map.get("TOTCBSUM")) %>"
													data-size="41">
													<span class="percent"><%=MathUtils.getNoRound(map.get("GZSUM"),map.get("TOTCBSUM")) %></span>%
												</div>
											</div>
			
										</div>
									
									</div><!-- bingtu  end -->
									
									<div id="index_Donut" class="tab-pane" style="width : 88%;max-height : 210px;"><!-- style="width : 88%;max-height : 210px;" -->
										
									
									</div>
							</div>
							
						</div><!-- widget-main end -->
						
					</div>
					
				</div>
				
			</div>
			
		</div>
		
		<div class="hr hr32 hr-dotted"></div>

		<div class="row">
			<div class="col-sm-4">
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-caret-right orange"></i> 每日用热量
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse"> <i
								class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding">
							<table class="table table-bordered table-striped">
								<thead class="thin-border-bottom">
									<tr>
										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>序号</th>
										<th><i class="ace-icon fa fa-caret-right blue"></i>日期</th>

										<th><i class="ace-icon fa fa-caret-right blue"></i>用热量(KMH)
										</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="userEnergy" items="${dayEnergyList }" varStatus="num">
									
										<tr>
											<td class="hidden-480"><span
												class="label label-info arrowed-right arrowed-in">${num.index+1 }</span></td>
											<td>${userEnergy.DAY }</td>
											<td>
												<c:if test="${userEnergy.USERENERGY==0}">
													<b class="red">0</b>
												</c:if>
												<c:if test="${userEnergy.USERENERGY!=0}">
													<b class="green">${userEnergy.USERENERGY}</b>
												</c:if>
											</td>
										</tr>
									
									</c:forEach>
									
								</tbody>
							</table>
						</div>
						
					</div>
				</div>
			</div>

			<div class="col-sm-8">
				<div class="widget-box transparent">
				
					<!-- BEGIN PORTLET-->
				<%-- <div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-signal orange"></i> 服务器负载-实时监控
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse"> <i
								class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="widget-body">
						<div class="portlet-body">
							<div id="load_statistics_loading">
								<img src="${contextPath}/static/assets/img/loading.gif"
									alt="loading" />
							</div>
							<div id="load_statistics_content">
								<div id="load_statistics" style="height: 108px;"></div>
							</div>
						</div>
					</div>
				</div> --%>
				<!-- END PORTLET-->
					
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-caret-right orange"></i> 山东临沂市室外温度曲线变化图
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse"> <i
								class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>

					<div class="widget-body">
						<div id="line-example" style="height:310px;"></div>
					</div>
					
				</div>
				
				

			</div>

		</div>
		<div class="hr hr32 hr-dotted"></div>
		<div class="row">
			<div class="col-xs-12">
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-caret-right orange"></i> 各小区最新信息统计
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse"> <i
								class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding" style="height: 370px;">
							<table class="table table-bordered table-striped">
								<thead class="thin-border-bottom" >
									<tr>
										<th style="width:83.1px"><i class="ace-icon fa fa-caret-right blue"></i>序号</th>
										<th style="width:150px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>能源公司</th>
										<th style="width:115px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>供热站</th>
										<th style="width:145px"><i class="ace-icon fa fa-caret-right blue"></i>小区</th>
										<th style="width:106px"><i class="ace-icon fa fa-caret-right blue"></i>住房数</th>
										<th style="width:106px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>抄表数</th>
										<th style="width:106px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>正常数</th>
										<th style="width:106px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>表故障数</th>
										<th style="width:106px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>无反应</th>
										<th style="width:106px" class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>未抄表</th>
									</tr>
								</thead>
								<tbody style=" width: 98.8%;height: 360px;overflow-y: auto;position: absolute;">
									<c:forEach var="eachArea" items="${eachAreaMeterInfo }" varStatus="num">
										<tr>
											<td style="width:83.1px">${num.index+1 }</td>
											<td style="width:150px">${eachArea.FACTORYNAME }</td>
											<td style="width:115px">${eachArea.SECTIONNAME }</td>
											<td style="width:145px">${eachArea.AREANAME }</td>
											<td style="width:106px">${eachArea.TOTZHSUM }</td>
											<td style="width:106px">${eachArea.TOTCBSUM }</td>
											<td style="width:106px">${eachArea.ZCSUM }</td>
											<td style="width:106px">${eachArea.GZSUM }</td>
											<td style="width:106px">${eachArea.WFYSUM }</td>
											<td style="width:106px">${eachArea.WCBSUM }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		

		<div class="hr hr32 hr-dotted"></div>
<div class="hr hr32 hr-dotted"></div>
<!-- <div class="row">
	<div class="collapse" id="exCollapsingNavbar">
  <div class="bg-inverse p-a">
    <h4>以下信息只是演示</h4>
    <span class="text-muted">以后考虑加入.</span>
  </div>
</div>
<nav class="navbar navbar-light bg-faded">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
    &#9776;点击
  </button>
</nav>
</div> -->
		<%-- <div class="row">
			<div class="col-lg-12">
				<div class="panel">
					<div class="panel-heading">
						<h4 class="widget-title lighter" style="color: #4383B4;">
							<i class="ace-icon fa fa-caret-right orange"></i>&nbsp;&nbsp;各地区室外温度曲线图
						</h4>
					</div>
					<div class="panel-body">
						<div id="morris-area-chart"></div>
					</div>
				</div>
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-signal orange"></i> 服务器负载-实时监控
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse"> <i
								class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="widget-body">
						<div class="portlet-body">
							<div id="load_statistics_loading">
								<img src="${contextPath}/static/assets/img/loading.gif"
									alt="loading" />
							</div>
							<div id="load_statistics_content">
								<div id="load_statistics" style="height: 108px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="col-lg-12">
			
		</div>
</div> --%>

	</div>

</div>

<!--[if lte IE 8]>
  <script src="${contextPath}/static/assets/js/excanvas.js"></script>

<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->


<!--<script src="${contextPath}/static/html5/html5.js"></script>-->
<script type="text/javascript">
	$(function(){
		$('#myTab li').mouseover(function(){
			$('#myTab li').removeClass('active')
			$(this).addClass('active');
			//$(this).find('a').click();
			//上面这样写不能触发，估计要看源码才知道怎么回事
			var flag = $(this).find('a').attr('href')
			if('#index_Donut'==flag){
				$('#index_Donut text:last').attr('y','0');
				$('#index_Donut text:first').attr('y','0');
				$('#index_Area').hide();
				$('#index_Donut').show()//fadeIn('fast');
				//$('#myTab li:last').find('a').trigger('click');
			}else{
				$('#index_Donut').hide();
				$('#index_Area').show()//.fadeIn('fast');
				//document.getElementById('index_Area').style.display="";
			}
		})
	})
	
	//头部统计数据  之查看详情
	$('#headStatisticMore').click(function(){
		var statisticWin = window.open('${contextPath}/sys/sysuser/statisticInfo','_index_statistic','width=1300,height=670');
		statisticWin.focus();
	})

	//var ttt = "<%=request.getAttribute("headStatisticsDate") %>";
	//var ttt= <%=request.getAttribute("headStatisticsDate") %>;//为什么这里得到的数字和上面的不一样为何是1981？
	
	var scripts = [
			null,
			"${contextPath}/static/assets/js/jquery-ui.custom.js",
			"${contextPath}/static/assets/js/jquery.ui.touch-punch.js",
			"${contextPath}/static/assets/js/jquery.easypiechart.js",//渲染和制作饼图及动画效果
			"${contextPath}/static/assets/js/jquery.sparkline.js",//线状图插件
			"${contextPath}/static/assets/js/flot/jquery.flot.js",//Flot采用Canvas绘制图形
			"${contextPath}/static/assets/js/flot/jquery.flot.pie.js",//flot饼图？
			"${contextPath}/static/assets/js/flot/jquery.flot.resize.js",
			/* "${contextPath}/static/assets/js/activities-serverload.js", */
			"${contextPath}/static/assets/js/morris/raphael.js?rand="+ Math.random(1000),			
			"${contextPath}/static/assets/js/morris/morris.js?rand=" + Math.random(1000),
			"${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js",
			"${contextPath}/static/Highcharts-4.2.5/js/modules/exporting.js",
			null ];
	$('.page-content-area')
			.ace_ajax(
					'loadScripts',
					scripts,
					function() {
						// inline scripts related to this page
						jQuery(function($) {
							$('.easy-pie-chart.percentage').each(
											function() {
												var $box = $(this).closest(
														'.infobox');
												var barColor = $(this).data(
														'color')
														|| (!$box
																.hasClass('infobox-dark') ? $box
																.css('color')
																: 'rgba(255,255,255,0.95)');
												var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)'
														: '#E2E2E2';
												var size = parseInt($(this)
														.data('size')) || 50;
												$(this)
														.easyPieChart(
																{
																	barColor : barColor,
																	trackColor : trackColor,
																	scaleColor : false,
																	lineCap : 'butt',
																	lineWidth : parseInt(size / 10),
																	animate : /msie\s*(8|7|6)/
																			.test(navigator.userAgent
																					.toLowerCase()) ? false
																			: 1000,
																	size : size
																});
											})

							$('.sparkline')
									.each(
											function() {
												var $box = $(this).closest(
														'.infobox');
												var barColor = !$box
														.hasClass('infobox-dark') ? $box
														.css('color')
														: '#FFF';
												$(this)
														.sparkline(
																'html',
																{
																	tagValuesAttribute : 'data-values',
																	type : 'bar',
																	barColor : barColor,
																	chartRangeMin : $(
																			this)
																			.data(
																					'min') || 0
																});
											});

								$.resize.throttleWindow = false;
								var data2 = [ {
									label : "正常抄表",
									value : <%=map.get("ZCSUM") %>,
									
								}, {
									label : "未抄表",
									value : <%=map.get("WCSUM") %>,
									
								}, {
									label : "无反应",
									value : <%=map.get("WFYSUM") %>,
									
								}, {
									label : "表故障",
									value : <%=map.get("GZSUM") %>,
									
								} ]
								Morris.Donut({
									element:'index_Donut',
									data : data2,
									resize : true
								})
								//$('#index_Donut').css({"width":"88%","max-height":"210px"});
								//transform="matrix(1.6667,0,0,1.6667,-123.6667,-69.6667)"210
								
								/* $('#index_Donut path:last').data('mouseover') */

								$('#index_Donut svg').attr('height','210').attr('width','420');
								var data = [ {
									label : "正常抄表",
									data : <%=MathUtils.getNoRound(map.get("ZCSUM"),map.get("TOTCBSUM")) %>,
									color : "#69D2E7"
								}, {
									label : "未抄表",
									data : <%=MathUtils.getNoRound(map.get("WCSUM"),map.get("TOTCBSUM")) %>,
									color : "#E0E4CC"
								}, {
									label : "无反应",
									data : <%=MathUtils.getNoRound(map.get("WFYSUM"),map.get("TOTCBSUM")) %>,
									color : "#F38630"
								}, {
									label : "表故障",
									data : <%=MathUtils.getNoRound(map.get("GZSUM"),map.get("TOTCBSUM")) %>,
									color : "#DA5430"
								} ]
								

								 var placeholder = $('#piechart-placeholder').css({
									'width' : '90%',
									'min-height' : '150px'
								});
								
								function drawPieChart(placeholder, data, position) {
									$.plot(placeholder, data, {
										series : {
											pie : {
												show : true,
												tilt : 0.8,
												highlight : {
													opacity : 0.25
												},
												stroke : {
													color : '#fff',
													width : 2
												},
												startAngle : 2
											}
										},
										legend : {
											show : true,
											position : position || "ne",
											labelBoxBorderColor : null,
											margin : [ -30, 15 ]
										},
										grid : {
											hoverable : true,
											clickable : true
										}
									})
								}
								drawPieChart(placeholder, data); 

								placeholder.data('chart', data);
								placeholder.data('draw', drawPieChart); 
							

							// pie chart tooltip example
							var $tooltip = $(
									"<div class='tooltip top in'><div class='tooltip-inner'></div></div>")
									.hide().appendTo('body');
							var previousPoint = null;

							placeholder.on('plothover', function(event, pos,
									item) {
								if (item) {
									if (previousPoint != item.seriesIndex) {
										previousPoint = item.seriesIndex;
										var tip = item.series['label'] + " : "
												+ item.series['percent'] + '%';
										$tooltip.show().children(0).text(tip);
									}
									$tooltip.css({
										top : pos.pageY + 10,
										left : pos.pageX + 10
									});
								} else {
									$tooltip.hide();
									previousPoint = null;
								}

							});

			/* 				$('#index_Area').hide();
							$('#index_Donut').show(); */
							// Android's default browser somehow is confused when tapping on label which will lead to dragging the task
							// so disable dragging when clicking on label
/* 							var agent = navigator.userAgent.toLowerCase();
							if ("ontouchstart" in document
									&& /applewebkit/.test(agent)
									&& /android/.test(agent))
								$('#tasks').on(
										'touchstart',
										function(e) {
											var li = $(e.target).closest(
													'#tasks li');
											if (li.length == 0)
												return;
											var label = li.find('label.inline')
													.get(0);
											if (label == e.target
													|| $.contains(label,
															e.target))
												e.stopImmediatePropagation();
										});

							$('#tasks').sortable({
								opacity : 0.8,
								revert : true,
								forceHelperSize : true,
								placeholder : 'draggable-placeholder',
								forcePlaceholderSize : true,
								tolerance : 'pointer',
								stop : function(event, ui) {
									// just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
									$(ui.item).css('z-index', 'auto');
								}
							});
							$('#tasks').disableSelection();
							$('#tasks input:checkbox')
									.removeAttr('checked')
									.on(
											'click',
											function() {
												if (this.checked)
													$(this).closest('li')
															.addClass(
																	'selected');
												else
													$(this).closest('li')
															.removeClass(
																	'selected');
											});

							// show the dropdowns on top or bottom depending on window height and menu position
							$('#task-tab .dropdown-hover').on(
									'mouseenter',
									function(e) {
										var offset = $(this).offset();

										var $w = $(window)
										if (offset.top > $w.scrollTop()
												+ $w.innerHeight() - 100)
											$(this).addClass('dropup');
										else
											$(this).removeClass('dropup');
									});
 */
 
							//Index.initCharts(); // init activities-serverload.js's method

							/////////////////////////////////////温度曲线图数据
							/* Morris.Line({
								element : 'morris-area-chart',
								data : [ {
									period : '2010 Q1',
									兰州 : 2666,
									温州 : null,
									深圳 : 2647
								}, {
									period : '2010 Q2',
									兰州 : 2778,
									温州 : 2294,
									深圳 : 2441
								}, {
									period : '2010 Q3',
									兰州 : 4912,
									温州 : 1969,
									深圳 : 2501
								}, {
									period : '2010 Q4',
									兰州 : 3767,
									温州 : 3597,
									深圳 : 5689
								}, {
									period : '2011 Q1',
									兰州 : 6810,
									温州 : 1914,
									深圳 : 2293
								}, {
									period : '2011 Q2',
									兰州 : 5670,
									温州 : 4293,
									深圳 : 1881
								}, {
									period : '2011 Q3',
									兰州 : 4820,
									温州 : 3795,
									深圳 : 1588
								}, {
									period : '2011 Q4',
									兰州 : 15073,
									温州 : 5967,
									深圳 : 5175
								}, {
									period : '2012 Q1',
									兰州 : 10687,
									温州 : 4460,
									深圳 : 2028
								}, {
									period : '2012 Q2',
									兰州 : 8432,
									温州 : 5713,
									深圳 : 1791
								} ],
								xkey : 'period',
								ykeys : [ '兰州', '温州', '深圳' ],
								labels : [ '兰州', '温州', '广州' ],
								pointSize : 2,
								hideHover : 'auto',
								resize : true
							});*/
							
							/* $.get('${contextPath}/homePage/getTemperature',function(response){
								console.log(response)
								var da = jQuery.parseJSON(response);
								console.log(da)
								Morris.Line({
									  element: 'line-example',
									  data: da,
									  xkey: 'DDATE',
									  ykeys: ['SWWENDU'],
									  labels: ['温度'],
									  //xLabels : 'day',
									  smooth:true,
									  xLabelFormat : function(x){
										  return x.toTimeString().substr(0,8) +'\n'+ x.toLocaleDateString();//x.toLocaleDateString()+'</br>'+;	 
									  },
									  postUnits:'℃',//#1fda2f
									  //lineColors:['#7A92A3']									 
									  //xLabelAngle:90
									});
								
							})   */
							
							// Get the CSV and create the chart
						   $.get('${contextPath}/homePage/getTemperatureByHighCharts', function (csv) {
								    var browserName=navigator.userAgent.toLowerCase(); 
								    var dis = 3600*12*1000;
								    if(/msie/i.test(browserName) && !/opera/.test(browserName)){
								    	dis = 12;
								    }

							   $('#line-example').highcharts({
						            data: {
						                csv: csv
						            },
						            credits: {
						                enabled:false//关闭作者
						      		},
						      		exporting: {
						                enabled:false//关闭导出按钮
						    		},
						            //主标题
						            title: {
						                text: ''
						            },
						            /* //副标题
						            subtitle: {
						                text: 'Source: Google Analytics'
						            }, */
						            
						            //x轴
						             xAxis: {
						                tickInterval:dis,
						                tickWidth:5 ,  //刻度线的宽度
						                gridLineWidth: 0, //网格线的宽度
                                        tickColor: '#00FFFF',
                                        /* dateTimeLabelFormats:{
                                        	second: '%H:%M:%S',
                                        	minute: '%H:%M',
                                        	hour: '%H:%M',
                                        	day: '%e of %b',
                                        	month: '%b \'%y',
                                        	year: '%Y'
                                        }, */
						                labels: {  //轴标签（显示在刻度上的数值或者分类名称）
						                    align: 'center',  //轴标签的水平对其方式，可取的值："left", "center" or "right".默认是居中显示
						                    x: 3, //轴标签相对于轴刻度在水平方向上的偏移量
						                    y: 20,  //轴标签相对于轴刻度在y轴方向上的偏移量，默认根据轴标签字体大小给予适当的值
						                    formatter: function () {
						                    	 return  typeof this.value == 'string'?this.value.split(" ")[0]+'<br/>'+this.value.split(" ")[1]:new Date(this.value).toLocaleDateString()+'<br/>'+new Date(this.value).toLocaleTimeString();
				                            },
						                }
						            },

						            yAxis: [{ // left y axis
						                title: {
						                    text: null  //轴标题的显示文本。它可以包含类似的，基本的HTML标签。但是文本的旋转使用向量绘制技术实现,有些文本样式会清除。通过设置text为null来禁用轴标题
						                },
						                //gridLineWidth:0,
						                labels: {
						                    align: 'left',
						                    x: 3,
						                    y: 16,
						                    format: '{value} ℃'
						                },
						                showFirstLabel: false
						            }/* , { // right y axis
						                linkedTo: 0,
						                gridLineWidth: 0,
						                opposite: true,
						                title: {
						                    text: null
						                },
						                labels: {
						                    align: 'right',
						                    x: -3,
						                    y: 16,
						                    format: '{value} ℃'
						                },
						                showFirstLabel: false
						            } */],
						            //图例
						            /* legend: {
						                align: 'left',
						                verticalAlign: 'top',
						                y: 20,
						                floating: true,
						                borderWidth: 0
						            }, */
						          //数据提示框
			 			            tooltip: {
			 			                shared: true,
			 			                crosshairs: true,
			 			                formatter:function(){
			 			                	var dateFix =  typeof this.points[0].key == 'string'?this.points[0].key.split(" ")[0]:Highcharts.dateFormat('%Y-%m-%d', this.points[0].key);
			 			                	return '日期：'+ dateFix +'<br/> 温度：'+this.y+'℃';
			 			                 } 
			 			            },
			 			           legend: {
			 				        	enabled: false
			 				        },
			 				       plotOptions: { 
			 				    	   area: { 
			 				    		   fillColor: { 
			 				    			   linearGradient: { 
			 				    				   x1: 0, y1: 0, x2: 0, y2: 1
			 				    			   }, 
			 				    			   stops: [ 
			 				    				        [0, Highcharts.getOptions().colors[0]], 
			 				    				        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
			 				    				      ] 
			 				    			}, 
			 				    		   lineWidth: 1, 
			 				    		   marker: { enabled: false }, 
			 				    		   shadow: false, 
			 				    		   states: { hover: { lineWidth: 1 } }, 
			 				    		   threshold: null 
			 				    		 } 
			 				        },
						            //数据提示框
						            /* tooltip: {
						                shared: true,
						                crosshairs: true,
						                formatter:function(){
						                	return '日期：'+ Highcharts.dateFormat('%Y-%m-%d', this.x)
						                	+ '<br/>时间：' + Highcharts.dateFormat('%H:%M:%S', this.x)
						                	+'<br/> 温度：'+this.y+"℃";
						                 }
						            }, */
						            /* //数据点配置
						            plotOptions: {
						                series: {
						                    cursor: 'pointer',
						                    point: {
						                        events: {
						                            click: function (e) {
						                                hs.htmlExpand(null, {
						                                    pageOrigin: {
						                                        x: e.pageX || e.clientX,
						                                        y: e.pageY || e.clientY
						                                    },
						                                    headingText: this.series.name,
						                                    maincontentText: Highcharts.dateFormat('%A, %b %e, %Y', this.x) + ':<br/> ' +
						                                        this.y + ' visits',
						                                    width: 200
						                                });
						                            }
						                        }
						                    },
						                    marker: {
						                        lineWidth: 1
						                    }
						                }
						            }, */
						            series: [{ 
						            	type: 'area', 
						            	//pointInterval: 24 * 3600 * 1000, 
						            	}]
						        });
						    });
							
							

							/* Morris.Line({
								  element: 'line-example',
								  data: [
								    { y: '2016-5-11 07:00', 温度: 35,  湿度: 20 },
								    { y: '2016-5-11 10:00', 温度: 25,  湿度: 31 },
								    { y: '2016-5-11 13:00', 温度: 15,  湿度: 16},
								    { y: '2016-5-11 16:00', 温度: 5,  湿度: 30 },
								    { y: '2016-5-11 19:00', 温度: 25,  湿度: 10 },
								    { y: '2016-5-11 22:00', 温度: 10,  湿度: 10 },
								    { y: '2016-5-11 01:00', 温度: 5,  湿度: 9 }
								  ],
								  xkey: 'y',
								  ykeys: ['温度', '湿度'],
								  labels: ['温度', '湿度'],
								  //xLabels : 'hour'
								}); */
							
						})
					});
</script>









