<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*,java.text.*"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>承德热力集团能源监测平台供热计量管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="refresh" content="3600" /> <!-- 20180320 一小时刷新一次浏览器 -->
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/font-awesome.css" />
<!-- text fonts -->
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace-fonts.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/activities-serverload.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="${contextPath}/static/pageclock/compiled/flipclock_index.css" />


<%-- <link href="${contextPath}/static/clock/css/style.css" rel="stylesheet" /> --%>

<!--[if lte IE 9]>
			<link rel="stylesheet" href="${contextPath}/static/assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${contextPath}/static/assets/css/ace-ie.css" />
		  <link rel="stylesheet" href="${contextPath}/static/pages/css/index-ie.css"/>
		<![endif]-->
<!-- ace settings handler -->

<script src="${contextPath}/static/assets/js/ace-extra.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yTfvihLi2DyVzQ7T34SZ1SMYrzmgK0en"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 8]>
		<script src="${contextPath}/static/assets/js/html5shiv.js"></script>
		<script src="${contextPath}/static/assets/js/respond.js"></script>
		<link rel="stylesheet" href="${contextPath}/static/pages/css/index-ie.css"/>
		<![endif]-->
<!-- customer -->
<link rel="stylesheet" href="${contextPath}/static/pages/css/index.css"/>
<link rel="stylesheet" href="${contextPath}/static/bootstrap-4.0/theme/css/bootstrap-addtabs.css" type="text/css" media="screen"/>
</head>


<style>
.page-content-area-t .page-content-area,.tab-pane {
	display:none;
}
.page-content-area-t .page-content-area.active,.tab-pane.active {
    display: block;
}

.breadcrumbs-fixed + .page-content {
    padding-top: 42px;
}


.profile-header.home-backimg {
	height: 183px;
}
body.mob-safari #zxtq,body.mob-safari .col-sm-3.top-size {
	display: none;
}
body.zq-skin.mob-safari .breadcrumbs-fixed{
	position: fixed;
    right: 0;
    left: 0;
    top: auto;
    z-index: 1024;
}
body.zq-skin.mob-safari .breadcrumbs #ace-settings-container {
	display:none;
}
body.zq-skin.mob-safari .main-content{
	margin-top: 0px;
}
body.zq-skin.mob-safari .page-content {
	margin: 0px;
	padding: 0px;
	margin-top: 36px;
}
.zq-skin.mob-safari .col-sm-5.top-size{
	margin-top: 8px;
}
.zq-skin.mob-safari .profile-header.home-backimg {
	height: 137px
}
.zq-skin.mob-safari div[role="navigation"] {
	display: none;
}
.zq-skin.mob-safari .navbar-fixed-top + .main-container {
padding-top: 60px;
}
.col-sm-5.top-size > div > div {
	white-space: nowrap;
}
</style>


<style>
#tabs .breadcrumbs .nav::before,.nav::after{
	display: none;
	content: " ";
}
.zq-skin .breadcrumbs .nav > li[class="active"]:not(.hide)::before {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: #2CC185;
        content: '';
        -webkit-transition: -webkit-transform 0.3s;
        transition: transform 0.3s;
        z-index: 11;
    }
.zq-skin .breadcrumbs .nav > li > a {
    padding: 10px 15px;
    margin-right: 0px;
}
.zq-skin .breadcrumbs .nav > li.active > a:hover, .nav-tabs > li.active > a:focus {
    border: 0;
}
.zq-skin .breadcrumbs .nav > li > a, .nav-tabs > li > a:focus {
    border-color: #fff;
    border: 0;
}
.breadcrumbs {
    line-height: 30px;
}
.breadcrumbs .nav-tabs > li.active > a,.breadcrumbs .nav-tabs > li.active > a:hover,.breadcrumbs .nav-tabs > li.active > a:focus {
    line-height: 22px;
}
.breadcrumbs .nav-tabs > li.active > a,.breadcrumbs .nav-tabs > li.active > a:hover,.breadcrumbs .nav-tabs > li.active > a:focus {
    box-shadow: 0;
}

</style>

<body class="zq-skin" onload="start();">
	
	<!-- #section:basics/navbar.layout -->
	<div id="navbar" class="navbar navbar-default"><!-- background-color: #0275d8; -->
		<div id="zq-preloaderbar" class="preloaderbar">
			<span class="bar"></span>
		</div>
		
		<div class="navbar-container" id="navbar-container">
			<!-- #section:basics/sidebar.mobile.toggle -->
			<button type="button" class="navbar-toggle menu-toggler pull-left"
				id="menu-toggler" data-target="#sidebar">
				<span class="sr-only"> Toggle sidebar </span> <span class="icon-bar">
				</span> <span class="icon-bar"> </span> <span class="icon-bar"> </span>
			</button>
			<!-- /section:basics/sidebar.mobile.toggle -->
			<div class="navbar-header pull-left">
				<!-- #section:basics/navbar.layout.brand -->
				<a href="javascript:;" class="navbar-brand"  > <small>
				 <!-- <i class="fa fa-leaf"></i> -->
					<img class="png" src="${contextPath}/static/assets/avatars/cdrl.png" >
						&nbsp;承德热力集团能源监测平台供热计量管理系统
				</small>
				</a><!-- src="${contextPath}/static/assets/avatars/cdrl.png" -->
				<!--  <i> class="fa fa-leaf"  -->
				<!-- /section:basics/navbar.layout.brand -->
				<!-- #section:basics/navbar.toggle -->
				<!-- /section:basics/navbar.toggle --><!-- <img class="png" src="images/logo.png" title="系统首页"> -->
			&nbsp&nbsp&nbsp&nbsp
				<%
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String now = sdf.format(date);
				%>
				<p class="navbar-brand" style="font-size: 2.0em;color: rgba(255, 255, 255, 0.69);">
				<small><%=now %></small>
				</p>
			
			
			</div>
			<!-- #section:basics/navbar.dropdown -->
			
			<%-- <div class="navbar-header pull-center">
				<%
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String now = sdf.format(date);
				%>
				<p class="navbar-brand" style="font-size: 2.0em;color: rgba(255, 255, 255, 0.69);">
				<small><%=now %></small>
				</p>
			</div> --%>
			
			
			<div class="navbar-buttons navbar-header pull-right"
				role="navigation">
				<ul class="nav ace-nav">
				
						<!-- 消息任务提醒 -->
					   <li class="dropdown tasks-menu"  onclick="javascript:$(this).children('.dropdown-menu').toggle();">
			              <i class="fa fa-bell-o icon-animated-vertical icon-only" style="font-size: 1.33333em;color: rgba(255, 255, 255, 0.69);"  ></i>
			              <span class="badge badge-danger">2</span>
				         <ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header">
								<i class="fa fa-bell-o"></i>　有【2】条消息待审核
							</li>
							
							<%-- <li>
								<a href="${contextPath}/sys/approval/getAppInfo">
									<c:forEach var="ap" items="${obj}"> 
									<img alt="Alex's Avatar" class="msg-photo" src="${contextPath}/static/avatars/avatar.png" />
									<span class="msg-body">
										<span class="msg-title">
											<span class="blue"><c:out value="${obj.username}" /></span>
											<c:out value="${obj.content}" />
										</span>
										<span class="msg-time">
											<i class="fa fa-clock-o"></i> <span><c:out value="${obj.ddate}" /></span>
										</span>
									</span>
									</c:forEach> 
								</a>
							</li> --%>
							
							<li>
								<a href="javascript:;">
									<img alt="Susan's Avatar" class="msg-photo" src="${contextPath}/static/avatars/avatar3.png" />
									<span class="msg-body">
										<span class="msg-title">
											<span class="blue">cdrl:</span>
											修改小区信息
										</span>
										<span class="msg-time">
											<i class="fa fa-clock-o"></i> <span>上午 10:36 </span>
										</span>
									</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<img alt="Bob's Avatar" class="msg-photo" src="${contextPath}/static/avatars/avatar4.png" />
									<span class="msg-body">
										<span class="msg-title">
											<span class="blue">张三:</span>
											修改住户编码a03023信息：是否停热:1;
										</span>
										<span class="msg-time">
											<i class="fa fa-clock-o"></i> <span>下午 3:15 </span>
										</span>
									</span>
								</a>
							</li>
							
							<li>
								<a data-url="page/approval" href="${contextPath }/sys/sysuser/home#page/approval"
								data-addtab="approval" title="查看所有内容" url="approval" >
									
									<i class="fa fa-hand-o-right red"></i>　点击查看所有内容
								</a>
							</li>									
						</ul>  
         			 </li> 
		
				
					<li id="nav-lifa">
					<i class="fa fa-navicon" style="font-size: 1.33333em;color: rgba(255, 255, 255, 0.69);" 
						  data-toggle="tooltip" data-placement="bottom" title="紧凑左侧栏"></i>
					</li>

					
					<!-- <li class="btn-group" onclick="javascript:$(this).children('.dropdown-menu').toggle();">
						<i class="fa fa-spin fa-circle-o-notch" style="font-size: 1.33333em;color: rgba(255, 255, 255, 0.69);" 
						 data-toggle="tooltip" data-placement="bottom" title="常用功能" >
						</i>
						<div class="dropdown-menu dropdown-caret">
						    	没有记录
  					    </div>
					</li> //20180305-->
					
					<!-- #section:basics/navbar.user_menu -->
					<li class="light-blue" style="width:150px;border-left: 0.1px solid RGBA(225, 225, 225, 0.36);"><a data-toggle="dropdown" href="#"
						class="dropdown-toggle"> <img class="nav-user-photo"
							src="${contextPath}/static/assets/avatars/avatar7.jpg"
							alt="Jason's Photo" /> <span class="user-info"> <small>
									欢迎您, </small> <c:out value="${sessionScope.SESSION_SYS_USER.userName}" />
						</span> <i class="ace-icon fa fa-caret-down"></i>
					</a>
						<ul
							class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
							<li>
								<a data-url="page/sysuserprofile" href="home#page/sysuserprofile" data-addtab="sysuserprofile" title="个人资料" url="sysuserprofile"> 
									<i class="ace-icon fa fa-user"></i> 个人资料
								</a>
							</li>
							<li class="divider"></li>
							<li><a href="${contextPath}/sys/sysuser/logout"> <i
									class="ace-icon fa fa-power-off"></i> 退出
							</a></li>
						</ul></li>
					<!-- /section:basics/navbar.user_menu -->
				</ul>
			</div>
			<!-- /section:basics/navbar.dropdown -->
		</div>
		<!-- /.navbar-container -->
	</div>
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<div id="sidebar" class="sidebar responsive">

			<ul class="nav nav-list">
				<c:forEach var="authority" items="${authorityList}">
					<c:if test="${authority.subAuthorityList.size() > 0}">
						<li class="">
								<a href="<c:out value='${authority.dataUrl}'/>" class="dropdown-toggle" > 
									<i class="<c:out value='${authority.menuClass}'/>"></i> 
									<span class="menu-text">
										<c:out value="${authority.menuName}" />
									</span>
									<b class="arrow fa fa-angle-down"></b>
								</a> 
								<b class="arrow"></b>
								<ul class="submenu">
									<c:forEach var="subAuthorityList" items="${authority.subAuthorityList}">
										<li class="">
												<a <c:if test="${subAuthorityList.subAuthorityList.size() > 0}">class="dropdown-toggle"</c:if>
													data-url="<c:out value='${subAuthorityList.dataUrl}'/>"
 												 	<%-- href="home#<c:out value='${subAuthorityList.dataUrl}'/>" --%>
 												 	href="javascript:void(0);"
 												 	data-addtab="<c:out value='${subAuthorityList.menuCode}'/>"
 												 	url="<c:out value='${fn:replace(subAuthorityList.dataUrl,"page/","")}'/>"
 												 	
												 >
													<i class="<c:out value='${subAuthorityList.menuClass}'/>"></i>
													<c:out value="${subAuthorityList.menuName}" /> 
													
													<c:if test="${subAuthorityList.subAuthorityList.size() > 0}">
														<b class="arrow fa fa-angle-down"></b>
													</c:if>
												</a> 
												<b class="arrow"></b>
												<ul class="submenu">
													<c:forEach var="subSubAuthorityList" items="${subAuthorityList.subAuthorityList}">
														<c:if test="${authority.subAuthorityList.size() > 0}">
															<li class="">
																<a data-url="<c:out value='${subSubAuthorityList.dataUrl}'/>"
																	<%-- href="home#<c:out value='${subSubAuthorityList.dataUrl}'/>" --%>
																	href="javascript:void(0);"
																>
																	<i class="<c:out value='${subSubAuthorityList.menuClass}'/>"></i>
																	<c:out value="${subSubAuthorityList.menuName}" />
																</a> 
																<b class="arrow"></b></li>
														</c:if>
													</c:forEach>
												</ul>
										</li>
									</c:forEach>
								</ul>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			<!-- /.nav-list -->
			<!-- #section:basics/sidebar.layout.minimize -->
			<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
				<i class="ace-icon fa fa-angle-double-left"
					data-icon1="ace-icon fa fa-angle-double-left"
					data-icon2="ace-icon fa fa-angle-double-right"></i>
			</div>
			<!-- /section:basics/sidebar.layout.minimize -->

		</div>
		<!-- /section:basics/sidebar -->
		<div class="main-content" id="tabs">
			<!-- #section:basics/content.breadcrumbs -->
			<div class="breadcrumbs breadcrumbs-fixed home-backimg" id="breadcrumbs" style="padding:0px;margin: 0px; opacity: 0.9;background-clip: content-box;">
				<ul class="nav nav-tabs" role="tablist">
		            <li id="eternal-home" role="presentation" class="active">
		                <a href="#home" aria-controls="home" id="tab-home" role="tab" data-toggle="tab">主页</a>
		            </li>
		        </ul>
		        <!-- #section:settings.box -->
				<div class="ace-settings-container" id="ace-settings-container" style="z-index: -1;">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn"
						id="ace-settings-btn">
						<i class="ace-icon fa fa-cog bigger-130"></i>
					</div>
					<div class="ace-settings-box clearfix" id="ace-settings-box">
						<div class="pull-left width-50">
							<!-- #section:settings.skins -->
							<div class="ace-settings-item">
                                    <div class="pull-left">
                                        <select id="skin-colorpicker" class="hide">
                                        	<option data-skin="zq-skin" value="#00BCD4">
                                                #00BCD4
                                            </option>
                                            <option data-skin="no-skin" value="#438EB9">
                                                #438EB9
                                            </option>
                                            <option data-skin="skin-1" value="#222A2D">
                                                #222A2D
                                            </option>
                                            <option data-skin="skin-2" value="#C6487E">
                                                #C6487E
                                            </option>
                                            <option data-skin="skin-3" value="#D0D0D0">
                                                #D0D0D0
                                            </option>
                                        </select>
                                    </div>
                                    <span>
                                        &nbsp; 
                                       	 选择皮肤
                                    </span>
                                </div>
                                
							<!-- /section:settings.skins -->
							
						</div>
						<!-- /.pull-left -->
						<div class="pull-left width-50">
							<!-- #section:basics/sidebar.options -->
							<div class="ace-settings-item" style="display: none;">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-breadcrumbs" /> <label class="lbl"
									for="ace-settings-breadcrumbs"> 固定面包屑导航 </label>
							</div>
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-hover" /> <label class="lbl"
									for="ace-settings-hover"> 鼠标滑过显示子菜单 </label>
							</div>
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-compact" /> <label class="lbl"
									for="ace-settings-compact"> 紧凑侧边栏 </label>
							</div>
							<!-- <div class="ace-settings-item" style="margin-bottom: 14px;">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-highlight" /> <label class="lbl"
									for="ace-settings-highlight" > 菜单项突出 </label>
							</div> -->
							<!-- /section:basics/sidebar.options -->
						</div>
						<!-- /.pull-left -->
					</div>
					<!-- /.ace-settings-box -->
				</div>
				<!-- /.ace-settings-container -->
			</div>
			<!-- /section:basics/content.breadcrumbs -->
			<div class="page-content" style="padding-bottom: 10px; overflow-x:hidden;">

				<!-- /section:settings.box -->
				<div class="page-content-area-t">
					<div class="page-content-area tab-pane active home" data-ajax-content="true" role="tabpanel" id="home">
					</div>
				</div>
				<!-- /.page-content-area -->
			</div>
			<!-- /.page-content -->
		</div>
		<!-- /.main-content -->
		<div class="footer" style="padding-top: 0rem;">
			<div class="footer-inner">
				<!-- #section:basics/footer -->
				<div class="footer-content"  style="background: #efefef;border-top: 3px double #FFF; padding: 0px;">
					<span class="bigger-120"> <span class="blue bolder">
							深圳汉光电子技术有限公司 </span> &copy; 2017-2020
					</span>
				</div>
				<!-- /section:basics/footer -->
			</div>
		</div>
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->
	<iframe id="export_excel" style="display:none;"></iframe>
</body>

</html>


	
	
<!-- basic scripts -->
	<!--[if !IE]> -->
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${contextPath}/static/assets/js/jquery.js'>" + "<"+"/script>");
	</script>
	<!-- <![endif]-->
	<!--[if IE]>
			<script type="text/javascript">
			 	window.jQuery || document.write("<script src='${contextPath}/static/assets/js/jquery1x.js'>"+"<"+"/script>");
			</script>
		<![endif]-->
	<script type="text/javascript">
		if ('ontouchstart' in document.documentElement)
			document.write("<script src='${contextPath}/static/assets/js/jquery.mobile.custom.js'>" + "<"+"/script>");
	</script>
	<script src="${contextPath}/static/assets/js/bootstrap.js"></script>
	<!-- ace scripts -->
	<script src="${contextPath}/static/assets/js/ace/elements.scroller.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.colorpicker.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.fileinput.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.typeahead.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.wysiwyg.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.spinner.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.treeview.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.wizard.js"></script>
	<script src="${contextPath}/static/assets/js/ace/elements.aside.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.ajax-content.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.touch-drag.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.sidebar.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.sidebar-scroll-1.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.submenu-hover.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.widget-box.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings-rtl.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings-skin.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.widget-on-reload.js"></script>

	<script src="${contextPath}/static/assets/js/ace/ace.searchbox-autocomplete.js"></script>
	<script src="${contextPath}/static/pageclock/compiled/flipclock.js"></script>
	
	<script src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	
	<script src="${contextPath}/static/jquery-zqExtends.js"></script>
	<script src="${contextPath}/static/bootstrap-4.0/theme/js/bootstrap-addtabs.js"></script>
<%--tools start --%>
	<script>
		var $path_base = "${contextPath}";
		/* //各校小区耗热总量 */
		<%-- var _J_get_pageHomeCommunity = function(){
			return '<%=request.getServletContext().getAttribute("pagehomecommunity") %>';
		} --%>
	
		var _default_status_areaname = '<%=(String)request.getSession().getAttribute("areaName") %>';
		var _default_status_areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
		var _default_status_areaguid_during = '';
		
		var _fa_icon = "ui-icon ace-icon fa fa-long-arrow-left";
		function _get_back_html(){
			return '<td title="返回上一页" onClick="javascript:history.back();" class="ui-pg-button ui-corner-all toppager-back">'
			+'<div class="ui-pg-div"><span class="' + _fa_icon + '"></span>返回</div></td>'
			+'<td class="area-info" id="_back_default_area">当前小区:' + _default_status_areaname
			+'</td><td style="display:none;" id="_back_default_area_areaguid">' + _default_status_areaguid + '</td>';
		}
		var _go_back = _get_back_html();
	
		
		//得到默认小区
		var _J_getAreaGuid = function(){
			$.get('${contextPath}/sys/todaydata/getSessionArea',function(response){
				  var data = jQuery.parseJSON(response);
				  _default_status_areaguid = data['areaguid'];
				  _default_status_areaname = data['areaname'];
			});
			return _default_status_areaguid;
		}		
		
		//设定小区
		var _J_setAreaGuid = function(set_areaguid,set_areaname){
			if(set_areaguid==undefined||set_areaname==undefined){
				_default_status_areaguid = getSelectElement('AREAGUID').val();
				_default_status_areaname = getSelectElement('AREAGUID').find('option[value="'+_default_status_areaguid+'"]').html();
			}else{
				_default_status_areaguid = set_areaguid;
				_default_status_areaname = set_areaname;
			}

			$.get('${contextPath}/sys/todaydata/setSessionArea?AREAGUID='+ _default_status_areaguid ,function(response){
				if(response=='ok'){
					_go_back =  _get_back_html();
					$('#_back_default_area_areaguid').html(_default_status_areaguid);
					$('#_back_default_area').html('当前小区:'+_default_status_areaname);
				}
				
			});
		}
		
		function onSearch_putDown_areaguid(sel_id){
			return $('#'+sel_id).val();
		}
		function onSearch_putDown_areaname(sel_id){
			return $('#' + sel_id + ' option[value="'+$('#'+sel_id).val()+'"]').html();
			
		}
		function getSelectElement(val){
			if(val!=='undefined')
				return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');
		}
		function convertCN(cellvalue, options, rowdata){
			if(cellvalue == 0)
				return '否';
			else if(cellvalue == 1)
				return '是';
			return cellvalue;
		}
		function emptyAndReset(e){
			e.empty();
			e.append("<option value=''>请选择</option>").attr("selected",true).change();
		}
		function appendEle(obj,sel,defa){
			var val = obj[sel];
			if(val=='' || val==null){			
				$('#'+sel).val(defa);	
			}else
			$('#'+sel).val(val);
		}
		function roundFix(cellvalue) {
			if (cellvalue == '' || cellvalue == undefined) return 0;
			return cellvalue.toFixed(2);
		}

	</script>
<%--tools end --%>

<script type="text/javascript">
$(function () {
    try {
		ace.settings.check('navbar', 'fixed')
	} catch (e) {
	}
	try {
		ace.settings.check('sidebar', 'fixed')  //collapsed
	} catch (e) {
	}
	try {
		ace.settings.check('breadcrumbs', 'fixed')
	} catch (e) {
	}
	
	var clock;
	$(document).ready(function() {
		clock = $('.clock').FlipClock({
			clockFace : 'TwentyFourHourClock',
		});
		$(window).resize(function() {
			$(window).width() < 999 ? $('body').addClass("mob-safari") : $('body').removeClass("mob-safari")
		});
		$(window).width() < 999 ? $('body').addClass("mob-safari") : $('body').removeClass("mob-safari")
	});
	if(!$('#ace-settings-breadcrumbs')[0].checked){
		$('#ace-settings-breadcrumbs').click();
	};
	
	$('[data-toggle="tooltip"]').tooltip();
	var flag = 0;
	$('#nav-lifa').click(function() {
		if (flag == 0) {
			$('#ace-settings-compact').click();
			flag = 1;
		} else {
			$('#ace-settings-hover').click();
			flag = 0;
		}
	});
	$('.nav.nav-tabs').click(function(e){
		$(e.target).attr("aria-controls") == 'home' ? $('#breadcrumbs').addClass('home-backimg') : $('#breadcrumbs').removeClass('home-backimg');
	})
}) 
/*  window.onunload = function (){
	window.location='${contextPath}/sys/sysuser/home';
}  */
Date.prototype.format_tmp = function(format) {
       var date = {
              "M+": this.getMonth() + 1,
              "d+": this.getDate(),
              "h+": this.getHours(),
              "m+": this.getMinutes(),
              "s+": this.getSeconds(),
              "q+": Math.floor((this.getMonth() + 3) / 3),
              "S+": this.getMilliseconds()
       };
       if (/(y+)/i.test(format)) {
              format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
       }
       for (var k in date) {
              if (new RegExp("(" + k + ")").test(format)) {
                     format = format.replace(RegExp.$1, RegExp.$1.length == 1
                            ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
              }
       }
       return format;
}

</script>






