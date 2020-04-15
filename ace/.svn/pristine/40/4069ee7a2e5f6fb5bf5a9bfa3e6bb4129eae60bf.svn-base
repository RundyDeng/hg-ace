<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

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
			<div class="col-sm-7 " style="height: 274px;">

				<div class="widget-box" style="height: 98%;">
					<div class="widget-header widget-header-flat widget-header-small">
						<h5 class="widget-title">
							<i class="ace-icon fa fa-eye"></i> 数据统计
						</h5>
					</div>

					<div class="widget-body">
						<div class="widget-main" style="padding: 0px; padding-left: 0px;">

							<div>

								<div class="infobox-container" style="margin-top: 7px;">
									<!-- #section:pages/dashboard.infobox -->
									<div class="infobox infobox-green index_backgroud">
										<!-- <div class="infobox-icon">
						<i class="ace-icon fa fa-building"></i>
					</div> -->
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">2257</span>
											<div class="infobox-content">住户总数</div>
										</div>

										<!-- #section:pages/dashboard.infobox.stat -->
										<!-- <div class="stat stat-success">8%</div> -->

										<!-- /section:pages/dashboard.infobox.stat -->
									</div>

									<div class="infobox infobox-blue index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">2237</span>
											<div class="infobox-content">抄表总数</div>
										</div>

										<!-- <div class="badge badge-success">
						+32%
						<i class="ace-icon fa fa-arrow-up"></i>
					</div> -->
									</div>

									<div class="infobox infobox-pink index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">2206</span>
											<div class="infobox-content">抄表正常数</div>
										</div>
										<!-- <div class="stat stat-important">4%</div> -->
									</div>

									<div class="infobox infobox-red index_backgroud">
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">20</span>
											<div class="infobox-content">未超表数</div>
										</div>
									</div>

									<div class="infobox infobox-orange2 index_backgroud">
										<!-- #section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<!-- /section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">0</span>
											<div class="infobox-content">表故障数</div>
										</div>

										<!-- <div class="badge badge-success">
						7.2%
						<i class="ace-icon fa fa-arrow-up"></i>
					</div> -->
									</div>

									<div class="infobox infobox-blue2 index_backgroud">


										<div class="infobox-icon" style="margin-right: 20px;">
											<img src="${contextPath}/static/image/build.png"
												style="width: 130%;" />
										</div>

										<!-- <div class="infobox-progress">
						#section:pages/dashboard.infobox.easypiechart
						<div class="easy-pie-chart percentage" data-percent="10" data-size="46">
							<span class="percent">10</span>%
						</div>

						/section:pages/dashboard.infobox.easypiechart
					</div> -->

										<div class="infobox-data" style="min-width: 110px;">
											<span class="infobox-data-number">31</span>
											<div class="infobox-content">表无反应数</div>
										</div>
									</div>


								</div>


							</div>

							<div class="hr hr8 hr-double"></div>

							<div class="clearfix">
								<!-- #section:custom/extra.grid -->
								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x blue"></i> &nbsp; 小区数
									</span>
									<h4 class="bigger pull-right">10</h4>
								</div>

								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x purple"></i> &nbsp; 表正常率
									</span>
									<h4 class="bigger pull-right">91%</h4>
								</div>

								<div class="grid3">
									<span class="grey"> <i
										class="ace-icon fa fa-bullhorn fa-2x red"></i> &nbsp; 统计日期
									</span>
									<h6 class="bigger pull-right">2016-5-12</h6>
								</div>

								<!-- /section:custom/extra.grid -->
							</div>
						</div>
						<!-- /.widget-main -->
					</div>
					<!-- /.widget-body -->
				</div>
				<!-- /.widget-box -->


			</div>


			<div class="vspace-12-sm"></div>

			<div class="col-sm-5">
				<div class="widget-box">
					<div class="widget-header widget-header-flat widget-header-small">
						<h5 class="widget-title">
							<i class="ace-icon fa fa-eye"></i> 表数据概率分析
						</h5>

						<div class="widget-toolbar no-border">
							<div class="inline dropdown-hover">
								<button class="btn btn-minier btn-primary">
									本周 <i
										class="ace-icon fa fa-angle-down icon-on-right bigger-110"></i>
								</button>

								<ul
									class="dropdown-menu dropdown-menu-right dropdown-125 dropdown-lighter dropdown-close dropdown-caret">
									<li class="active"><a href="#" class="blue"> <i
											class="ace-icon fa fa-caret-right bigger-110">&nbsp;</i> 本周
									</a></li>

									<li><a href="#"> <i
											class="ace-icon fa fa-caret-right bigger-110 invisible">&nbsp;</i>
											上周
									</a></li>

									<li><a href="#"> <i
											class="ace-icon fa fa-caret-right bigger-110 invisible">&nbsp;</i>
											本月
									</a></li>

									<li><a href="#"> <i
											class="ace-icon fa fa-caret-right bigger-110 invisible">&nbsp;</i>
											上月
									</a></li>
								</ul>
							</div>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main">
							<!-- #section:plugins/charts.flotchart -->
							<div id="piechart-placeholder"></div>

							<!-- /section:plugins/charts.flotchart -->
							<div class="hr hr8 hr-double"></div>

							<div class="clearfix">
								<!-- #section:custom/extra.grid -->
								<div class="grid3">

									<span class="blue" style="position: relative; top: 10px;">未抄表率&nbsp;&nbsp;&nbsp;
									</span>
									<div class="easy-pie-chart percentage" data-percent="10"
										data-size="41">
										<span class="percent">10</span>%
									</div>
								</div>

								<div class="grid3">

									<span class="red" style="position: relative; top: 10px;">表故障率&nbsp;&nbsp;&nbsp;
									</span>
									<div class="easy-pie-chart percentage" data-percent="13"
										data-size="41">
										<span class="percent">13</span>%
									</div>
								</div>

								<div class="grid3">

									<span class="red" style="position: relative; top: 10px;">无反应率&nbsp;&nbsp;&nbsp;
									</span>
									<div class="easy-pie-chart percentage" data-percent="6"
										data-size="41">
										<span class="percent">6</span>%
									</div>
								</div>

								<!-- /section:custom/extra.grid -->
							</div>
						</div>
						<!-- /.widget-main -->
					</div>
					<!-- /.widget-body -->
				</div>
				<!-- /.widget-box -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->

		<!-- #section:custom/extra.hr -->
		<!-- <div class="hr hr32 hr-dotted"></div> -->

		<div class="row">
			<div class="col-xs-12">
				
				<!-- /.widget-box -->
			</div>
		</div>
		<!-- /.row -->

		<div class="hr hr32 hr-dotted"></div>
		<!-- /section:custom/extra.hr -->
		<div class="row">
			<div class="col-sm-5">
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
									<tr>
										<td class="hidden-480"><span
											class="label label-info arrowed-right arrowed-in">1</span></td>
										<td>2016-5-1</td>
										<td><b class="green">159.00045</b></td>
									</tr>
									<tr>
										<td class="hidden-480"><span
											class="label label-info arrowed-right arrowed-in">2</span></td>
										<td>2016-5-2</td>
										<td><s class="red">0</s></td>
									</tr>
									<tr>
										<td class="hidden-480"><span
											class="label label-info arrowed-right arrowed-in">3</span></td>
										<td>2016-5-3</td>
										<td><b class="green">14.00000</b></td>
									</tr>
									<tr>
										<td class="hidden-480"><span
											class="label label-info arrowed-right arrowed-in">4</span></td>
										<td>2016-5-4</td>
										<td><b class="green">158.10500</b></td>
									</tr>

								</tbody>
							</table>
						</div>
						<!-- /.widget-main -->
					</div>
					<!-- /.widget-body -->
				</div>
				<!-- /.widget-box -->
			</div>
			<!-- /.col -->

			<div class="col-sm-7">
				
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-caret-right orange"></i> 各小区信息统计
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
										<th><i class="ace-icon fa fa-caret-right blue"></i>小区</th>

										<th><i class="ace-icon fa fa-caret-right blue"></i>住房数</th>

										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>抄表数</th>
										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>正常数</th>
										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>表状态数</th>
										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>无反应</th>
										<th class="hidden-480"><i
											class="ace-icon fa fa-caret-right blue"></i>未抄表</th>
									</tr>
								</thead>



								<tbody>
									<tr>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>60</td>
									</tr>
									<tr>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>60</td>
									</tr>
									<tr>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>60</td>
									</tr>
									<tr>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>汉光小区</td>
										<td>4</td>
										<td>50</td>
										<td>60</td>
									</tr>

								</tbody>
							</table>
						</div>
						<!-- /.widget-main -->
					</div>
					<!-- /.widget-body -->
				</div>

			</div>

		</div>
		<!-- /.row -->

		<div class="hr hr32 hr-dotted"></div>

		<link rel="stylesheet"
			href="${contextPath}/static/assets/css/chartsreports/morris.css" />
		<div class="row">
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
			</div>
			
			
			<div class="col-lg-12">
			<!-- BEGIN PORTLET-->
				<div class="portlet solid bordered light-grey">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-signal"></i>服务器负载-实时监控
						</div>
						<!--
						<div class="tools">
							<div class="btn-group pull-right" data-toggle="buttons">
								<a href="" class="btn btn-danger btn-sm active">数据库</a>
								<a href="" class="btn btn-danger btn-sm">Web服务器</a>
							</div>
						</div>
						-->
					</div>
					<div class="portlet-body">
						<div id="load_statistics_loading">
							<img src="${contextPath}/static/assets/img/loading.gif"
								alt="loading" />
						</div>
						<div id="load_statistics_content" class="display-none">
							<div id="load_statistics" style="height: 108px;"></div>
						</div>
					</div>
				</div>
				<!-- END PORTLET-->
		</div>
</div>

		<!-- PAGE CONTENT ENDS -->
	</div>
	<!-- /.col -->
</div>
<!-- /.row -->

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
  <script src="${contextPath}/static/assets/js/excanvas.js"></script>
<![endif]-->
<script type="text/javascript">
	var scripts = [
			null,
			"${contextPath}/static/assets/js/jquery-ui.custom.js",
			"${contextPath}/static/assets/js/jquery.ui.touch-punch.js",
			"${contextPath}/static/assets/js/jquery.easypiechart.js",
			"${contextPath}/static/assets/js/jquery.sparkline.js",
			"${contextPath}/static/assets/js/flot/jquery.flot.js",
			"${contextPath}/static/assets/js/flot/jquery.flot.pie.js",
			"${contextPath}/static/assets/js/flot/jquery.flot.resize.js",
			"${contextPath}/static/assets/js/activities-serverload.js",
			"${contextPath}/static/assets/js/morris/raphael.min.js?rand="
					+ Math.random(1000),
			,
			"${contextPath}/static/assets/js/morris/morris.min.js?rand="
					+ Math.random(1000), null ]
	$('.page-content-area')
			.ace_ajax(
					'loadScripts',
					scripts,
					function() {
						// inline scripts related to this page
						jQuery(function($) {
							$('.easy-pie-chart.percentage')
									.each(
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

							// flot chart resize plugin, somehow manipulates default browser resize event to optimize it!
							// but sometimes it brings up errors with normal resize event handlers
							$.resize.throttleWindow = false;

							var placeholder = $('#piechart-placeholder').css({
								'width' : '90%',
								'min-height' : '150px'
							});
							var data = [ {
								label : "正常抄表",
								data : 70,
								color : "#68BC31"
							}, {
								label : "未抄表",
								data : 10,
								color : "#2091CF"
							}, {
								label : "无反应",
								data : 6,
								color : "#AF4E96"
							}, {
								label : "表故障",
								data : 13,
								color : "#DA5430"
							}, {
								label : "其他",
								data : 1,
								color : "#FEE074"
							} ]
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

							/**
							 * we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically so that's not needed actually.
							 */
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

							// Android's default browser somehow is confused when tapping on label which will lead to dragging the task
							// so disable dragging when clicking on label
							var agent = navigator.userAgent.toLowerCase();
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

							Index.initCharts(); // init activities-serverload.js's method

							/////////////////////////////////////温度曲线图数据
							Morris.Area({
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
							});

						})
					});
</script>
