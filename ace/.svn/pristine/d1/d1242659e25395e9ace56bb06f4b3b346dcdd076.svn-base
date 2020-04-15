<%@page import="core.util.MathUtils"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="core.util.MathUtils"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/chartsreports/morris.css" />
<link rel="stylesheet"
	href="${contextPath}/static/Highcharts-4.2.5/highslide.css" />
<%--  <link rel="stylesheet" href="${contextPath}/assets/aa.css" /> --%>

<link rel="stylesheet" href="${contextPath }/static/pages/css/homepage.css" />
<script src="${contextPath }/static/pages/js/homepage.js"></script>

<%
	Map map = (Map) request.getAttribute("headMap");
	double zcsum = MathUtils.getBigDecimal(map.get("ZCSUM")).doubleValue();
	double totcbsum = MathUtils.getBigDecimal(map.get("TOTCBSUM")).doubleValue();
	double normalRate = 0;
	if (totcbsum != 0) {
		normalRate = zcsum / totcbsum * 100;
	}
%>
<div class="row">
	<div id="content" class="content-container">
		<div class="page page-profile ng-scope">

			<div>
				<header class="profile-header"
					style="background: url('${contextPath}/static/1.jpg') no-repeat center center fixed">
					<div style="height: 260px;">
						<div class="row">
							<div class="col-sm-3 top-size">
								<div class="profile-img">
									<img alt=""
										src="${contextPath}/static/assets/avatars/avatar7.jpg"
										class="img-circle">
								</div>
								<div class="profile-social">
									<a href="home?ub=xn#page/sysuserprofile"
										class="btn-icon btn-icon-round btn-instagram"><i
										class="fa fa-edit"></i></a>
								</div>
							</div>
							<div class="col-sm-5 top-size">
								<div class="row">
									<div class="col-xs-12 padding-0" style="margin-bottom: 10px;">
										<b>您好： ${sessionScope.SESSION_SYS_USER.userName}
											，欢迎使用汉光供热大数据智慧运行系统！</b>
									</div>
								</div>
								<%-- <div class="row">
									<div class="col-xs-4 padding-0"><img src="${contextPath}/static/image/tt.png">地址管理范围</div>
									<div class="col-xs-8 padding-0">--金宏电热--</div>
								</div> --%>
								<div class="row" style="margin-bottom: 2px;">
									<div class="col-xs-4 padding-0">
										<i class="fa fa-check pink"></i>当前供暖季：
									</div>
									<div class="col-xs-2 padding-0">
										<b>2015-2016</b>
									</div>
									<div class="col-xs-4 padding-0">
										<%-- <img src="${contextPath}/static/image/tt.png"> --%>
										<i class="fa fa-send-o light-green"></i>管理小区数量：
									</div>
									<div class="col-xs-2 padding-0">
										<b>${headMap.AREASUM }个</b>
									</div>
								</div>
								<div class="row" style="margin-bottom: 2px;">
									<div class="col-xs-4 padding-0">
										<i class="fa fa-lastfm grey"></i>管理住户数量：
									</div>
									<div class="col-xs-2 padding-0">
										<b>${headMap.TOTZHSUM }户</b>
									</div>
									<div class="col-xs-4 padding-0">
										<i class="fa fa-rss blue"></i>安装热表数量：
									</div>
									<div class="col-xs-2 padding-0">
										<b>${headMap.TOTCBSUM }个</b>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-4 padding-0">
										<i class="fa fa-share green"></i>安装阀门数量：
									</div>
									<div class="col-xs-2 padding-0">
										<b>0个</b>
									</div>
									<div class="col-xs-4 padding-0">
										<i class="fa fa-smile-o orange"></i>安装集中器数量：
									</div>
									<div class="col-xs-2 padding-0">
										<b>142台</b>
									</div>
								</div>
							</div>
							
							<div enable=false class="col-sm-4" id="zxtq"
								style="padding-left: 60px; padding-top: 30px;">
								<iframe disabled="disabled"
									src="http://www.thinkpage.cn/weather/weather.aspx?uid=U9E8140050&cid=CHBJ000000&l=zh-CHS&p=SMART&a=1&u=C&s=5&m=2&x=1&d=0&fc=FFFFFF&bgc=&bc=&ti=0&in=1&li="
									frameborder="0" scrolling="no" width="240" height="160"
									allowTransparency="true"></iframe>
							</div>

						</div>

					</div>

					<div class="profile-info">
						<ul class="list-unstyled list-inline">
							<li><i class="fa fa-check"></i> 统计日期 <span
								class="text-muted">(39)</span></li>
							<li><i class="fa fa-image"></i> 统计小区 <span
								class="text-muted">(63) </span></li>
							<li><i class="fa fa-bookmark"></i>表正常率<span
								class="text-muted">(55) </span></li>
							<li><i class="fa fa-video-camera"></i> 总耗热量 <span
								class="text-muted">(34) </span></li>
						</ul>
					</div>
				</header>
			</div>

			<div class="row ui-section" style="margin-bottom: 0px;">
				<div class="col-sm-3">
					<div class="panel mini-box" onClick="javascript:document.location='home?ub=xn#page/setarea'">
						<span title="修改" class="btn-icon btn-icon-round btn-icon-lg-alt bg-danger">
							<i class="fa fa-home"></i>
						</span>
						<%-- <span class=""> <img src="${contextPath}/assets/sss.png"
							style="width: 40%;" />
						</span> --%>
						<div class="box-info">
							<p class="size-custom-but">小区设置</p>
							<p class="text-muted">
								<span style="float: left;">基础信息管理</span>
								<span style="float: right;">
									<a href="home?ub=xn#page/sysuserprofile" style="float: right;"><i class="fa fa-edit"></i></a>
								</span>
							</p>
						</div>
						
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel mini-box" onClick="javascript:document.location='home?ub=xn#page/todaydata'"><!--  onClick="getStatic('gzsum');" -->
						<span class="btn-icon btn-icon-round btn-icon-lg-alt bg-warning">
							<i class="fa fa-newspaper-o"></i>
						</span>
						<div class="box-info">
							<p class="size-custom-but" title="当日数据查询">当日数据查询</p>
							<p class="text-muted">
								<span style="float: left;">数据监测</span>
								<span style="float: right;">
									<a href="home?ub=xn#page/sysuserprofile" style="float: right;"><i class="fa fa-edit"></i></a>
								</span>
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel mini-box" onClick="javascript:document.location='home?ub=xn#page/builddistribution'"><!-- getStatic('wcbsum'); -->
						<span class="btn-icon btn-icon-round btn-icon-lg-alt bg-success">
							<i class="fa fa-building-o"></i>
						</span>
						<div class="box-info">
							<p class="size-custom-but">楼宇分布图</p>
							<p class="text-muted">
								<span style="float: left;">数据分析</span>
								<span style="float: right;">
									<a href="home?ub=xn#page/sysuserprofile" style="float: right;"><i class="fa fa-edit"></i></a>
								</span>
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel mini-box" onClick="javascript:document.location='home?ub=xn#page/searchfaultparamwarn'"><!-- onClick="getStatic('wfysum');" -->
						<span class="btn-icon btn-icon-round btn-icon-lg-alt bg-info">
							<i class="fa fa-warning"></i>
						</span>
						<div class="box-info">
							<p class="size-custom-but" title="故障参数查询">参数故障查询</p>
							<p class="text-muted">
								<span style="float: left;">告警管理</span>
								<span style="float: right;">
									<a href="home?ub=xn#page/sysuserprofile" style="float: right;"><i class="fa fa-edit"></i></a>
								</span>
							</p>
						</div>
					</div>
				</div>
			</div>


			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="card">
							<div class="row">
								<div class="col-sm-5">
									<div class="header">
										<h4 class="title h-tit-style">表数据概率分析</h4>
										<%-- <p class="category">${headStatisticsDate }统计  小区${headMap.AREASUM }</p> --%>
									</div>
								</div>

								<div class="col-sm-7">
									<!-- <div class="header">
																			<h4 class="title h-tit-style">2016年度各小区耗热总量</h4>
	                                                                    </div> -->
								</div>
							</div>
							<div class="row">
								<div class="col-sm-5">
									<div class="table-responsive">
										<table class="table">
											<tbody>
												<tr>
													<td class="meter-img" style="width: 19%;">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td style="width: 21%;">住户总数</td>
													<td class="text-right" style="width: 20%;">${headMap.TOTZHSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<!-- <progress class="progress progress-striped progress-warning" value="75" max="100">75%</progress> -->
													</td>
												</tr>
												<tr>
													<td class="meter-img">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td>抄表总数</td>
													<td class="text-right">${headMap.TOTCBSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<!-- <progress class="progress progress-striped progress-warning" value="75" max="100">75%</progress> -->
													</td>
												</tr>
												<tr>
													<td class="meter-img">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td>正常抄表</td>
													<td class="text-right">${headMap.ZCSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<progress
															class="progress progress-striped progress-success"
															value='<fmt:formatNumber value="<%=normalRate%>" pattern="0.00" maxFractionDigits="2"/>'
															max="100">
															<fmt:formatNumber value="<%=normalRate%>" pattern="0.00"
																maxFractionDigits="2" />
															%
														</progress>
													</td>
												</tr>
												<tr>
													<td class="meter-img">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td>未抄表</td>
													<td class="text-right">${headMap.WCSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<progress class="progress progress-striped progress-info"
															value='<%=MathUtils.getNoRound(map.get("WCSUM"), map.get("TOTCBSUM"))%>'
															max="100"></progress>
													</td>
												</tr>
												<tr>
													<td class="meter-img">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td>表故障</td>
													<td class="text-right">${headMap.GZSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<progress
															class="progress progress-striped progress-danger"
															value='<%=MathUtils.getNoRound(map.get("GZSUM"), map.get("TOTCBSUM"))%>'
															max="100"></progress>
													</td>
												</tr>
												<tr>
													<td class="meter-img">
														<div class="flag">
															<img src="${contextPath}/static/image/q.png" />
														</div>
													</td>
													<td>无反应</td>
													<td class="text-right">${headMap.WFYSUM }</td>
													<td class="text-right"
														style="width: 40%; margin-left: 20px; padding-left: 70px; padding-top: 12px;">
														<progress
															class="progress progress-striped progress-warning"
															value='<%=MathUtils.getNoRound(map.get("WFYSUM"), map.get("TOTCBSUM"))%>'
															max="100"></progress>
													</td>
												</tr>
											</tbody>
										</table>
									</div>


								</div>
								<div class="col-sm-7" style="margin-top: -30px;">
									<div class="widget-box transparent"
										style="overflow: hidden; max-height: 330px;">
										<div class="widget-body">
											<div id="3d-columnxs"
												style="min-width: 720px; margin-left: -60px; min-height: 350px;"></div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="card">
							<div class="row">
								<div class="col-sm-5">
									<div class="header">
										<h4 class="title h-tit-style">每日用热量</h4>
										<!-- <p class="category">03-24    3-31</p> -->
									</div>
								</div>
								<div class="col-sm-7"></div>
							</div>
							<div class="row">
								<div class="col-sm-5">
									<div class="table-responsive">
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
												<c:forEach var="userEnergy" items="${dayEnergyList }"
													varStatus="num">

													<tr>
														<td class="hidden-480"><span
															class="label label-info arrowed-right arrowed-in">${num.index+1 }</span></td>
														<td>${userEnergy.DAY }</td>
														<td><c:if test="${userEnergy.USERENERGY==0}">
																<b class="red">0</b>
															</c:if> <c:if test="${userEnergy.USERENERGY!=0}">
																<b class="green">${userEnergy.USERENERGY}</b>
															</c:if></td>
													</tr>

												</c:forEach>

											</tbody>
										</table>
									</div>


								</div>
								<div class="col-sm-7"
									style="margin-bottom: 0px; margin-top: -20px;">
									<div class="widget-box transparent">

										<div class="widget-body">
											<div id="line-example" style="height: 320px;"></div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="card">
							<div class="row">
								<div class="col-sm-12">
									<div class="header">
										<h4 class="title h-tit-style">
											<i class="ace-icon fa fa-caret-right orange"></i> 各小区最新信息统计
										</h4>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">

									<div class="widget-body">
										<div class="widget-main no-padding" style="height: 370px;">
											<table class="table table-bordered table-striped">
												<thead class="thin-border-bottom">
													<tr>
														<th style="width: 83.1px"><i
															class="ace-icon fa fa-caret-right blue"></i>序号</th>
														<th style="width: 150px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>能源公司</th>
														<th style="width: 115px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>供热站</th>
														<th style="width: 145px"><i
															class="ace-icon fa fa-caret-right blue"></i>小区</th>
														<th style="width: 106px"><i
															class="ace-icon fa fa-caret-right blue"></i>住房数</th>
														<th style="width: 106px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>抄表数</th>
														<th style="width: 106px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>正常数</th>
														<th style="width: 106px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>表故障数</th>
														<th style="width: 106px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>无反应</th>
														<th style="width: 106px" class="hidden-480"><i
															class="ace-icon fa fa-caret-right blue"></i>未抄表</th>
													</tr>
												</thead>
												<tbody
													style="width: 98.8%; height: 320px; overflow-y: auto; position: absolute;">
													<c:forEach var="eachArea" items="${eachAreaMeterInfo }"
														varStatus="num">
														<!-- detail(1,'+obj['AREAGUID']+',\''+obj['AREANAME']+'\') -->
														<tr>
															<td style="width: 83.1px">${num.index+1 }</td>
															<td style="width: 150px">${eachArea.FACTORYNAME }</td>
															<td style="width: 115px">${eachArea.SECTIONNAME }</td>
															<td style="width: 145px">${eachArea.AREANAME }</td>
															<td style="width: 106px">${eachArea.TOTZHSUM }</td>
															<td style="width: 106px">${eachArea.TOTCBSUM }</td>
															<td style="width: 106px">${eachArea.ZCSUM }</td>
															<td style="width: 106px">${eachArea.GZSUM }</td>
															<td
																style="width: 106px; color: #00a5ff; cursor: pointer;"
																onclick="detail(999,'${eachArea.AREAGUID }','${eachArea.AREANAME }')"><b>${eachArea.WFYSUM }</b></td>
															<td
																style="width: 106px; color: #00a5ff; cursor: pointer;"
																onclick="detail(1,'${eachArea.AREAGUID }','${eachArea.AREANAME }')"><b>${eachArea.WCBSUM }</b></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- </section> -->
	</div>
</div>


<div id="detail_dialog" style="display: none; overflow: auto;">
	<table id="grid-table"
		class="table table-bordered table-hover table-striped"
		style="margin-bottom: 0px;">
		<thead>
			<tr>
				<th>住户</th>
				<th>地址</th>
				<th>表编号</th>
				<th>热表状态</th>
				<th>瞬时热量(KW)</th>
				<th>累计热量(KWH)</th>
				<th>瞬时流量(t/h)</th>
				<th>累计流量(t)</th>
				<th>进水温度</th>
				<th>回水温度</th>
				<th>温差</th>
				<th>问题说明</th>
			</tr>
		</thead>
		<tbody id="detail_tbody">

		</tbody>

	</table>

	<div id="grid-pager"></div>
</div>
