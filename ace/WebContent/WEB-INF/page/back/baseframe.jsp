<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>承德热力集团能源监测平台供热计量管理系统</title>
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yTfvihLi2DyVzQ7T34SZ1SMYrzmgK0en"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 8]>
		<script src="${contextPath}/static/assets/js/html5shiv.js"></script>
		<script src="${contextPath}/static/assets/js/respond.js"></script>
		<![endif]-->
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try {
					ace.settings.check('main-container', 'fixed')
				} catch (e) {
				}

			</script>
		<div class="main-content">
			
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
	var _default_status_areaname = '<%=(String)request.getSession().getAttribute("areaName") %>';
	var _default_status_areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
	var _default_status_areaguid_during = '';
	var _fa_icon = "ui-icon ace-icon fa fa-long-arrow-left";
	function _get_back_html(){
		return '<td class="ui-pg-button ui-corner-all toppager-back" style="cursor: unset;">'
		+'<div class="ui-pg-div"><span class=""></span></div></td>'
		+'<td class="area-info" id="_back_default_area">当前小区:' + _default_status_areaname
		+'</td><td style="display:none;" id="_back_default_area_areaguid">' + _default_status_areaguid + '</td>';
	}
	var _go_back = _get_back_html();
	var _J_getAreaGuid = function(){
		$.get('${contextPath}/sys/todaydata/getSessionArea',function(response){
			  var data = jQuery.parseJSON(response);
			  _default_status_areaguid = data['areaguid'];
			  _default_status_areaname = data['areaname'];
		});
		return _default_status_areaguid;
	}		
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
	function onSearch_putDown_areaguid(sel_id){return $('#'+sel_id).val();}
	function onSearch_putDown_areaname(sel_id){return $('#' + sel_id + ' option[value="'+$('#'+sel_id).val()+'"]').html();}
	function getSelectElement(val){if(val!=='undefined') return $('td[class="columns"]:has(option:selected[value='+val+']) ~ td[class="data"] select');}
	function convertCN(cellvalue, options, rowdata){ if(cellvalue == 0) return '否'; else if(cellvalue == 1) return '是'; return cellvalue;}
	function emptyAndReset(e){ e.empty(); e.append("<option value=''>请选择</option>").attr("selected",true).change();}
	function appendEle(obj,sel,defa){ var val = obj[sel]; if(val=='' || val==null) $('#'+sel).val(defa); else $('#'+sel).val(val);}
	function roundFix(cellvalue) { if (cellvalue == '' || cellvalue == undefined) return 0; return cellvalue.toFixed(2);}
	
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

</body>
</html>
