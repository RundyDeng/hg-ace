<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>大数据应用与智慧运行系统</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="refresh" content="1800" />
<!-- bootstrap & fontawesome -->
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
<%-- <link rel="stylesheet" href="${contextPath}/static/bootstrap-4.0/css/bootstrap.css" /> --%>
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/font-awesome.css" />
<!-- text fonts -->
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ace-fonts.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/activities-serverload.css" />
<!-- ace styles -->
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet"
	href="${contextPath}/static/pageclock/compiled/flipclock_index.css" />
<%-- <link href="${contextPath}/static/clock/css/style.css" rel="stylesheet" /> --%>
<style>
.ui-dialog .ui-dialog-titlebar-close, .ui-jqdialog .ui-dialog-titlebar-close {
	display: none;
}
</style>

<!--[if lte IE 9]>
			<link rel="stylesheet" href="${contextPath}/static/assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${contextPath}/static/assets/css/ace-ie.css" />
		<![endif]-->
<!-- ace settings handler -->
<script src="${contextPath}/static/assets/js/ace-extra.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 8]>
		<script src="${contextPath}/static/assets/js/html5shiv.js"></script>
		<script src="${contextPath}/static/assets/js/respond.js"></script>
		<![endif]-->
</head>
<body class="no-skin">
	<!-- #section:basics/navbar.layout -->
	<div id="navbar" class="navbar navbar-default"><!-- background-color: #0275d8; -->
		<script type="text/javascript">
				try {
					ace.settings.check('navbar', 'fixed')
				} catch (e) {
				}
			</script>
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
				<a href="#" class="navbar-brand"> <small> <i
						class="fa fa-leaf"></i>&nbsp;大数据应用与智慧运行系统
				</small>
				</a>
				<!-- /section:basics/navbar.layout.brand -->
				<!-- #section:basics/navbar.toggle -->
				<!-- /section:basics/navbar.toggle -->
			</div>
			<!-- #section:basics/navbar.dropdown -->
			<div class="navbar-buttons navbar-header pull-right"
				role="navigation">
				<ul class="nav ace-nav">
					<li  style="padding-left: 10px;">
						<!-- <div id="time">    
<script>     
document.getElementById('time').innerHTML=new Date().toLocaleString();     

setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString();",1000);  

</script>    
</div> -->
						<style>
.flip-clock-wrapper ul {
	margin: 3px;
}
</style>
						<div class="clock" style="margin: 0px 10px 0px 0px;"></div>

					</li>
					<!-- #section:basics/navbar.user_menu -->
					<li class="light-blue"><a data-toggle="dropdown" href="#"
						class="dropdown-toggle"> <img class="nav-user-photo"
							src="${contextPath}/static/assets/avatars/user.jpg"
							alt="Jason's Photo" /> <span class="user-info"> <small>
									欢迎您, </small> <c:out value="${sessionScope.SESSION_SYS_USER.userName}" />
						</span> <i class="ace-icon fa fa-caret-down"></i>
					</a>
						<ul
							class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
							<!-- 
                                <li>
                                    <a href="#">
                                        <i class="ace-icon fa fa-cog"></i>
										设置
                                    </a>
                                </li>
                                -->
							<li><a data-url="page/sysuserprofile"
								href="home#page/sysuserprofile"> <i
									class="ace-icon fa fa-user"></i> 个人资料
							</a></li>
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
		<script type="text/javascript">
				try {
					ace.settings.check('main-container', 'fixed')
				} catch (e) {
				}

			</script>
		<!-- #section:basics/sidebar -->
		<div id="sidebar" class="sidebar responsive">
			<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'fixed')
					} catch (e) {
					}
				</script>
			<!-- 
                <div class="sidebar-shortcuts" id="sidebar-shortcuts">
                    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                        <button class="btn btn-success">
                            <i class="ace-icon fa fa-signal"></i>
                        </button>
                        <button class="btn btn-info">
                            <i class="ace-icon fa fa-pencil"></i>
                        </button>
                        <button class="btn btn-warning">
                            <i class="ace-icon fa fa-users"></i>
                        </button>
                        <button class="btn btn-danger">
                            <i class="ace-icon fa fa-cogs"></i>
                        </button>
                    </div>
                    <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                        <span class="btn btn-success">
                        </span>
                        <span class="btn btn-info">
                        </span>
                        <span class="btn btn-warning">
                        </span>
                        <span class="btn btn-danger">
                        </span>
                    </div>
                </div>
                -->
			<!-- /.sidebar-shortcuts -->
			<ul class="nav nav-list">
				<c:forEach var="authority" items="${authorityList}">
					<c:if test="${authority.subAuthorityList.size() > 0}">
						<li class=""><a href="<c:out value='${authority.dataUrl}'/>"
							class="dropdown-toggle"> <i
								class="<c:out value='${authority.menuClass}'/>"></i> <span
								class="menu-text"><c:out value="${authority.menuName}" /></span>
								<b class="arrow fa fa-angle-down"></b>
						</a> <b class="arrow"></b>
							<ul class="submenu">
								<c:forEach var="subAuthorityList"
									items="${authority.subAuthorityList}">
									<li class=""><a
										<c:if test="${subAuthorityList.subAuthorityList.size() > 0}">class="dropdown-toggle"</c:if>
										data-url="<c:out value='${subAuthorityList.dataUrl}'/>"
										href="home#<c:out value='${subAuthorityList.dataUrl}'/>">
											<i class="<c:out value='${subAuthorityList.menuClass}'/>"></i>
											<c:out value="${subAuthorityList.menuName}" /> <c:if
												test="${subAuthorityList.subAuthorityList.size() > 0}">
												<b class="arrow fa fa-angle-down"></b>
											</c:if>
									</a> <b class="arrow"></b>
										<ul class="submenu">
											<c:forEach var="subSubAuthorityList"
												items="${subAuthorityList.subAuthorityList}">
												<c:if test="${authority.subAuthorityList.size() > 0}">
													<li class=""><a
														data-url="<c:out value='${subSubAuthorityList.dataUrl}'/>"
														href="home#<c:out value='${subSubAuthorityList.dataUrl}'/>">
															<i
															class="<c:out value='${subSubAuthorityList.menuClass}'/>"></i>
															<c:out value="${subSubAuthorityList.menuName}" />
													</a> <b class="arrow"></b></li>
												</c:if>
											</c:forEach>
										</ul></li>
								</c:forEach>
							</ul></li>
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
			<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'collapsed')
					} catch (e) {
					}
				</script>
		</div>
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<!-- #section:basics/content.breadcrumbs -->
			<div class="breadcrumbs" id="breadcrumbs">
				<script type="text/javascript">
						try {
							ace.settings.check('breadcrumbs', 'fixed')
						} catch (e) {
						}
					</script>
				<ul class="breadcrumb">
					<li><i class="ace-icon fa fa-home home-icon"></i> <a
						href="${contextPath}/sys/sysuser/home"> 首页 </a></li>
				</ul>
				<div onclick="showOr()" style="float: left;">
					<img src="${contextPath}/static/image/clock_btm.png" />

				</div>
				<%-- <link rel="stylesheet" type="text/css"
					href="${contextPath}/static/trueclock/css/normalize.css" />
				<link rel="stylesheet" type="text/css"
					href="${contextPath}/static/trueclock/css/default.css"> --%>

					<div id="myclock" style="position: absolute;display:none;  z-index: 100;"></div><!-- pointer-events: none; -->

				<style>
.ace-settings-container {
	position: absolute;
	right: 0;
	top: 0px;
	z-index: 1029;
}

.btn.btn-app.ace-settings-btn {
	float: left;
	display: block;
	text-align: center;
	border-radius: 6px 0 0 6px;
	opacity: 1;
	vertical-align: top;
	margin: 0;
}
</style>
				<!-- #section:settings.box -->
				<div class="ace-settings-container" id="ace-settings-container">
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
							<!-- #section:settings.navbar -->
                                <div class="ace-settings-item" style="margin-top: 16px;">
                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
                                    <label class="lbl" for="ace-settings-navbar">
                                       	 固定导航栏
                                    </label>
                                </div>
                                <!-- /section:settings.navbar -->
							<!-- #section:settings.sidebar -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-sidebar" /> <label class="lbl"
									for="ace-settings-sidebar"> 固定侧边栏 </label>
							</div>
							<!-- /section:settings.sidebar -->
							<!-- #section:settings.breadcrumbs -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-breadcrumbs" /> <label class="lbl"
									for="ace-settings-breadcrumbs"> 固定面包屑导航 </label>
							</div>
							<!-- /section:settings.breadcrumbs -->
							<!-- #section:settings.rtl -->
							<div class="ace-settings-item" style="margin-bottom: 16px;">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-rtl" /> <label class="lbl"
									for="ace-settings-rtl"> 切换到左边 </label>
							</div>
							<!-- /section:settings.rtl -->
							<!-- #section:settings.container -->
							<!-- <div class="ace-settings-item">
                                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
                                    <label class="lbl" for="ace-settings-add-container">
                                    	切换到窄屏
                                    </label>
                                </div> -->
							<!-- /section:settings.container -->
						</div>
						<!-- /.pull-left -->
						<div class="pull-left width-50">
							<!-- #section:basics/sidebar.options -->
							
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
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2"
									id="ace-settings-highlight" /> <label class="lbl"
									for="ace-settings-highlight"> 菜单项突出 </label>
							</div>
							<!-- /section:basics/sidebar.options -->
						</div>
						<!-- /.pull-left -->
					</div>
					<!-- /.ace-settings-box -->
				</div>
				<!-- /.ace-settings-container -->
				<!-- /.breadcrumb -->
				<!-- #section:basics/content.searchbox -->
				<!-- 
                    <div class="nav-search" id="nav-search">
                        <form class="form-search">
                            <span class="input-icon">
                                <input type="text" placeholder="全文检索 ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
                                <i class="ace-icon fa fa-search nav-search-icon"></i>
                            </span>
                        </form>
                    </div>
                    -->
				<!-- /.nav-search -->
				<!-- /section:basics/content.searchbox -->
			</div>
			<!-- /section:basics/content.breadcrumbs -->
			<div class="page-content">

				<!-- /section:settings.box -->
				<div class="page-content-area" data-ajax-content="true">
					<!-- ajax content goes here -->
				</div>
				<!-- /.page-content-area -->
			</div>
			<!-- /.page-content -->
		</div>
		<!-- /.main-content -->
		<div class="footer">
			<div class="footer-inner">
				<!-- #section:basics/footer -->
				<div class="footer-content">
					<span class="bigger-120"> <span class="blue bolder">
							汉光开发部 </span> &copy; 2016
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
	<script
		src="${contextPath}/static/assets/js/ace/elements.colorpicker.js"></script>
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
	<script
		src="${contextPath}/static/assets/js/ace/ace.sidebar-scroll-1.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.submenu-hover.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.widget-box.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings-rtl.js"></script>
	<script src="${contextPath}/static/assets/js/ace/ace.settings-skin.js"></script>
	<script
		src="${contextPath}/static/assets/js/ace/ace.widget-on-reload.js"></script>
	<script
		src="${contextPath}/static/assets/js/ace/ace.searchbox-autocomplete.js"></script>
		
		
		
		
	
	<script src="${contextPath}/static/pageclock/compiled/flipclock.js"></script>
	
	
	
	<script src="${contextPath}/static/jquery-zqExtends.js"></script>
	
	
	<script>
			$(function(){
				var clock;
				
				$(document).ready(function() {
					clock = $('.clock').FlipClock({
						clockFace: 'TwentyFourHourClock',
						
					});
				});
			})
	</script>
	
	
	
	<script>
		
	var $path_base = "${contextPath}";
	//各校小区耗热总量
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

		$.get('${contextPath}/sys/todaydata/setSessionArea?AREAGUID='+ _default_status_areaguid ,function(){
			_go_back =  _get_back_html();
			$('#_back_default_area_areaguid').html(_default_status_areaguid);
			$('#_back_default_area').html('当前小区:'+_default_status_areaname);
			
		});
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


	</script>
	
	
	
	
	
	
	
	
	
	
	
		
		<!-- 以下部分到时候处理，，在ie8中不能使用 -->	
	<%-- <script language="javascript" type="text/javascript"
		src="${contextPath}/static/trueclock/js/jquery.thooClock.js"></script> --%>
	<!-- <script language="javascript">
		function showOr(){
			var obj=document.getElementById('myclock')
			if(obj.style.display=="none"){
				obj.style.display="";
			}else{
				obj.style.display="none";
			}
			
		}
	
		var intVal, myclock;

		/* $(window).resize(function(){
			window.location.reload()
		}); */

		$(document).ready(function(){
			 /* $('#clockshows').toggle(
					 function(){
							$('#myclock').hide();
						},
					function(){
						$('#myclock').show();
					}
					
			
			 )   */
			
			var audioElement = new Audio("");

			//clock plugin constructor
			$('#myclock').thooClock({
				size:280,//$(document).height()/1.4
				dialBackgroundColor:'antiquewhite',
				/*onAlarm:function(){
					//all that happens onAlarm
					$('#alarm1').show();
					alarmBackground(0);
					//audio element just for alarm sound
					document.body.appendChild(audioElement);
					var canPlayType = audioElement.canPlayType("audio/ogg");
					if(canPlayType.match(/maybe|probably/i)) {
						audioElement.src = 'alarm.ogg';
					} else {
						audioElement.src = 'alarm.mp3';
					}
					// erst abspielen wenn genug vom mp3 geladen wurde
					audioElement.addEventListener('canplay', function() {
						audioElement.loop = true;
						audioElement.play();
					}, false);
				},*/
				showNumerals:true,
				brandText:'汉光时间',
				//brandText2:'2016',
/* 				onEverySecond:function(){
					//callback that should be fired every second
				}, */
				/*//alarmTime:'15:10',
				offAlarm:function(){
					$('#alarm1').hide();
					audioElement.pause();
					clearTimeout(intVal);
					$('body').css('background-color','#FCFCFC');
				}*/
			});
			//$('#myclock canvas').css('pointer-events',' auto');
			
			var move=false;//移动标记
			var _x,_y;//鼠标离控件左上角的相对位置
			$("#myclock").mousedown(function(e){
			move=true;
			_x=e.pageX-parseInt($("#myclock").css("left"));
			_y=e.pageY-parseInt($("#myclock").css("top")); 
			});
			$(document).mousemove(function(e){
				if(move){
				var x=e.pageX-_x;//控件左上角到屏幕左上角的相对位置
				var y=e.pageY-_y;
				$("#myclock").css({"top":y,"left":x});
				}
				}).mouseup(function(){
				move=false;
				}); 
		});

			

		$('#turnOffAlarm').click(function(){
			$.fn.thooClock.clearAlarm();
		});
		

		/*$('#set').click(function(){
			var inp = $('#altime').val();
			$.fn.thooClock.setAlarm(inp);
		});*/

		
		function alarmBackground(y){
				var color;
				if(y===1){
					color = '#CC0000';
					y=0;
				}
				else{
					color = '#FCFCFC';
					y+=1;
				}
				$('body').css('background-color',color);
				intVal = setTimeout(function(){alarmBackground(y);},100);
		}
	</script> -->
</body>
</html>
