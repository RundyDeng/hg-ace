<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />

<style type="text/css">
.table-bordered, .table-bordered td, .table-bordered th {
	border: 1px solid #c6cbce;
}
tbody th {
	font-weight: unset;
}
.ui-dialog .ui-dialog-titlebar-close::before, .ui-jqdialog .ui-dialog-titlebar-close::before,
	.ui-dialog .ui-jqdialog-titlebar-close::before, .ui-jqdialog .ui-jqdialog-titlebar-close::before
	{
	content: "x";
}
.flip-clock-wrapper ul {
	margin: 3px;
}
#build_th th {
	min-width: 69px;
}
.popover {
	border-radius: 4px;
	box-shadow: unset;
	background-color: #fff;
	border-color: rgba(187, 192, 197, 0.68);
}
#pg_grid-tabl_toppager {
	display: none;
}
#grid-table_toppager {
	display:none;
}
</style>

<div class="container-fluid" style="background-color: #f7f7f9;">
	<br />
	<div class="row" style="height: 30px;">
		<div class="col-md-3">
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon3">报警类型: </span> 
				<select id="warn-type" class="form-control">
					<option value="1">供热参数异常报警</option>
					<option value="2">采集设备异常报警</option>
					<option value="3">非法用热异常报警</option>
				</select>
			</div>
		</div>
		<div class="col-md-3">
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon3">选择小区: </span> 
				<select
					id="search_areaname" class="form-control">
				</select>
			</div>
		</div>
		<div class="col-md-3">
				<%
					Calendar c = Calendar.getInstance();
					String today = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
				%>
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon3">选择时间：</span> 
				<input id="input_sel_date" readonly="readonly"
					type="text" class="form-control" value="<%=today%>"
					aria-describedby="basic-addon3">
			</div>
		</div>
		<div class="col-md-2" style="height: 42px;">
			<button type="button" class="btn btn-success" style="float: right;display:none;" id="build_data_search">查询</button>
		</div>
		<div class="col-md-1"></div>
	</div>
	<div id="warn-popover" class="row" style="height: 30px;margin-bottom: 20px;">
		<div class="col-md-6" style="margin-left: 15px;">
				<div style="display: block;margin-top: 2px;min-width: 310px;z-index: 1;" class="popover fade bottom in" role="tooltip">
					<div style="left: 50%;" class="arrow"></div>
					<!-- <h5 style="padding-top: 4px; padding-bottom: 4px;" class="popover-title">选择参数类型</h5> -->
					<div class="popover-content">
						<button value="METERGL" type="button" style="padding: 0px;" class="btn btn-secondary">瞬时流量</button>
						<button value="MeterJSWD" type="button" style="padding: 0px;" class="btn btn-secondary">供水温度</button>
						<button value="MeterHSWD" type="button" style="padding: 0px;" class="btn btn-secondary">回水温度</button>
						<button value="MeterWC" type="button" style="padding: 0px;" class="btn btn-secondary">温差报警</button>
					</div>
				</div>
		</div>
		<div class="col-md-6"></div>
	</div>
	<br/>
	<div class="row">
		<div class="col-md-12">
			<table id="grid-table" style="background-color: #fff;" style="width: 100%;"></table>
			<div id="grid-pager" style="width: 100%;"></div>
		</div>
	</div>
</div>

<script>
var scripts = ['${contextPath}/static/assets/js/jquery-ui.js',"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js","${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js"];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";	
/*初始化小区下拉*/
	$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
		var areaguid = '<%=(String) request.getSession().getAttribute("areaGuids")%>';
		var flagName = '';
		var response = jQuery.parseJSON(data);
		var s = '';
	    if (response && response.length) {
			for (var i = 0, l = response.length; i < l; i++) {
				var ri = response[i];
				s += '<option value="' + ri['AREAGUID'] + '">'+ ri['AREANAME']+ '</option>';
			}
		}
		s += "<script>$('select option[value=\"" + areaguid + "\"]').change().attr('selected',true);</sc"+"ript>  ";
		$('#search_areaname').empty().append(s);
	});
	$("#input_sel_date").datepicker({dateFormat : 'yy-mm-dd'});
	
/*各按钮查询*/	
	$('#warn-type').change(function(){
		if(this.value == 1){
			$('#warn-popover').fadeIn();
			$('#build_data_search').fadeOut();
		}
		if(this.value != 1){
			$('#warn-popover').fadeOut();
			$('#build_data_search').fadeIn();
		}
	});
	$('#warn-popover button').click(function(){
		var paraUrl = '${contextPath}/warningmanage/searchfaultparamwarncontr/getsearchfaultpara?warnpara='+this.value
					+'&areaguid='+$('#search_areaname').val()+'&date='+$('#input_sel_date').val();
		jQuery(grid_selector).GridUnload();
		//firstGrid.setGridParam({url:paraUrl}).trigger("reloadGrid");
		jQuery(grid_selector).jqGrid({
			subGrid : false,
			url : paraUrl,
			datatype : "json",
			height : 380,
			rownumbers:true,
			//供热参数异常报警
			colNames : ['小区名称','门牌','瞬时热量','累计热量','瞬时流量','累计流量','供水温度','回水温度','温差','抄表时间'],
			colModel : [{name : '小区名称',width : 50},
		 	           {name:'门牌',width : 80},
		 	            {name:'瞬时热量',width : 60},
			            {name:'累计热量',width : 60},
			            {name:'瞬时流量',width : 88},
			            {name:'累计流量',width: 70},
			            {name:'供水温度',width : 50},
			            {name:'回水温度',width : 50},
			            {name:'温差',width : 50},
			            {name:'抄表时间',width : 50}],
			viewrecords : true,
			toppager : true,
			rowNum : 20,
			rowList : [ 20, 30, 50 ],
			pager : pager_selector,
	  	  	multiboxonly : true,
			loadComplete : loadSult
		});
		$(window).triggerHandler('resize.jqGrid');
		
		_J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
	});
	$('#build_data_search').click(function(){
		jQuery(grid_selector).GridUnload();
		var typeFlag = $('#warn-type').val();
		var paraUrl = '${contextPath}/warningmanage/searchfaultparamwarncontr/getsearchfaultdeviceorenergy?warntype=' + typeFlag
					+ '&areaguid=' + $('#search_areaname').val() + '&date=' + $('#input_sel_date').val();
		if(typeFlag==3){//非法用热
			jQuery(grid_selector).jqGrid({
				url:paraUrl,
				datatype : "json",
				height : 380,
				rownumbers:true,
				colNames : ['小区名称','门牌','集中器地址','通道号','表号','是否停热','瞬时热量','累计热量','瞬时流量','累计流量','抄表时间'],
				colModel : [{name : '小区名称',width : 50},
				            {name:'门牌',width : 100},
				            {name:'集中器地址',width : 60},
				            {name:'通道号',width : 88},
				            {name:'表号',width: 70},
				            {name:'是否停热',width : 50},
				            {name:'瞬时热量',width : 50},
				            {name:'累计热量',width : 50},
				            {name:'瞬时流量',width : 50},
				            {name:'累计流量',width : 50},
				            {name:'抄表时间',width : 100}],
				viewrecords : true,
				rowNum : 20,
				rowList : [ 20, 30, 50 ],
				pager : pager_selector,
				loadComplete : loadSult
			}).trigger("reloadGrid");;
			$(window).triggerHandler('resize.jqGrid');
		}
		if(typeFlag==2){//异常报警
			jQuery(grid_selector).jqGrid({
				url:paraUrl,
				datatype : "json",
				height : 380,
				rownumbers:true,
				colNames : ['小区名称','楼栋名称','设备号码','设备状态'],
				colModel : [{name : '小区名称',width : 50},
				            {name:'楼栋名称',width : 80},
				            {name:'设备号码',width : 60},
				            {name:'',width : 130,formatter:function(){return '设备路径寻址失败,请检查设备是否通电或卡是否欠费！'}}],
				viewrecords : true,
				rowNum : 20,
				rowList : [ 20, 30, 50 ],
				pager : pager_selector,
				loadComplete : loadSult
			}).trigger("reloadGrid");;
			$(window).triggerHandler('resize.jqGrid');
		}
		
		_J_setAreaGuid(onSearch_putDown_areaguid('search_areaname'),onSearch_putDown_areaname('search_areaname'));
	});
		
/*jqgrid*/
	$(window).on('resize.jqGrid', function() {
		$(grid_selector).jqGrid('setGridWidth', $(".page-content").width()-25);
	});
	var parent_column = $(grid_selector).closest('[class*="col-"]');
    $(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
      	if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
       		setTimeout(function() {
       			$(grid_selector).jqGrid('setGridWidth', parent_column.width());
       		}, 0);
       	}
    });
    var loadSult = function(data) {
		if(data.rows==null||data.rows.length==0)
			$('.ui-jqgrid-htable').css('width','auto');
		else
			$('.ui-jqgrid-htable').css('width','100%');
		var table = this;
		setTimeout(function(){updatePagerIcons(table);}, 0);
	};
    $(window).triggerHandler('resize.jqGrid');
    function updatePagerIcons(table) {
    	var replacement = {
    		'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
    		'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
    		'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
    		'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
    	};
    	$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
    		var icon = $(this);
    		var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			if ($class in replacement) icon.attr('class', 'ui-icon ' + replacement[$class]);
		});
  	};
});
</script>
