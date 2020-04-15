<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>小区图形</title>

</head>
<style>
#tree ul[class="list-group"]:first-child {
	margin-left: 0px;
	margin-right: 3px;
	margin-left: -10px;
}
.page-content {
	padding-left: 0px; 
	padding-right: 0px;
}
.page-content-area {
	overflow-x: hidden;
	padding-left: 0px; 
	margin-right: 10px;"
}
.list-group-item.node-tree{
	overflow-x: hidden;
	white-space: nowrap;
}

</style>
<body>
	<div id="tree" style="width: 16%; float: left; height: 500px; overflow: auto;border: 1px solid rgb(221, 221, 221);"></div>  
	<form style="width: 84%; float: right;">
		<div style="WIDTH: 800px; HEIGHT: 500px;" id="dialogEditHES"
			title="换热站">
			<table border=0 cellSpacing=0 cellPadding=0 width="100%">
				<tbody>
					<tr>
						<td vAlign="top"></td>
					</tr>
				</tbody>
			</table>
		</div>

	</form>

</body>
</html>

<script>
	var basePath = '${contextPath}';
</script>

<script src="${contextPath}/static/pages/js/bootstrap-treeview.js"></script>
<script>
$('.page-content-area').ace_ajax('loadScripts',[],function() {
	var curAreaName = $(window.parent.document.getElementById('sidebar')).find('a[data-addtab="areagif"]').attr("data-oth");
	$.post('${contextPath}/homePage/getAreaTree', {areaName: curAreaName} , function(response){
		var tree = jQuery.parseJSON(response);
		$('#tree').treeview({
			data: tree,
			//levels: 2,
			enableLinks: false,
			onNodeSelected: function(event, data) {
				var curNodeId = data.nodeId;
				if(data.nodes==null){
					var no = (Math.random() * 3 + 1).toString().replace(/\.\S+/,'');
					$('td[vAlign="top"]').empty().append(eval("_"+no+"huan"));
					$('#gif-areaname').html(data.text);
				}else{
					$('#tree').treeview('expandNode', [ curNodeId, { levels: 1, silent: true } ]);
				}
			},
		});       
		var _cur_nodeid = $('.node-checked').attr('data-nodeid');
		$('li[data-nodeid="'+_cur_nodeid+'"]').click();
		/* var _cur_nodeid = $('.node-checked.node-selected').attr('data-nodeid');
		$('#tree').treeview('toggleNodeSelected', [ _cur_nodeid, { silent: true } ]); */
		$(window.parent.document.getElementById('sidebar')).find('a[data-addtab="areagif"]').attr("data-oth","");
		
	});

	
	var _1huan = '<div style="POSITION: relative" id="hesParam"> \
			        <img id="hesImg" src="' + basePath + '/static/image/1huan.gif" width=1000 height=500> \
			        <div style="POSITION: absolute; PADDING-BOTTOM: 10px; BACKGROUND-COLOR: rgb(255,255,255); PADDING-LEFT: 10px; PADDING-RIGHT: 10px; HEIGHT: 30px; FONT-SIZE: 25px; TOP: 15px; FONT-WEIGHT: bold; PADDING-TOP: 10px; LEFT: 350px" id="gif-areaname">中兴路站</div> \
			        <div style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 45px; LEFT: 100px" id="TitleDiv"></div>  \
			        <div style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 10px; LEFT: 710px" id="DDateDiv">最近采集时间&nbsp;&nbsp;' + new Date().toLocaleDateString() + '&nbsp;&nbsp;</div>  \
			        <div style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 412px; LEFT: 25px" id="TElectriNJRLdiv">总有功电量&nbsp;&nbsp;0&nbsp;&nbsp;kwh</div>  \
			        <div style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 435px; LEFT: 25px" id="Meterljbsdiv">补水累积量&nbsp;&nbsp;0&nbsp;&nbsp;T</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 75px; LEFT: 235px" id="Meterssll_9957" sytle="font-size:16px;">-0.01</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 98px; LEFT: 235px" id="Meterslrl_9957" sytle="font-size:16px;">0</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 127px; LEFT: 50px" id="MeterJSWD_9957" sytle="font-size:16px;">-37.5</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 267px; LEFT: 50px" id="MeterHSWD_9957" sytle="font-size:16px;">22.21</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 105px; LEFT: 49px" id="MeterGY_9957" sytle="font-size:16px;">0.04</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 244px; LEFT: 51px" id="MeterHY_9957" sytle="font-size:16px;">0.1</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 123px; LEFT: 235px" id="MeterNJRL_9957" sytle="font-size:16px;">0</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 86px; LEFT: 678px" id="Meterssll_9958" sytle="font-size:16px;">0.06</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 108px; LEFT: 679px" id="Meterslrl_9958" sytle="font-size:16px;">0</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 133px; LEFT: 874px" id="MeterJSWD_9958" sytle="font-size:16px;">23.38</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 270px; LEFT: 874px" id="MeterHSWD_9958" sytle="font-size:16px;">21.61</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 111px; LEFT: 873px" id=MeterGY_9958 sytle="font-size:16px;">-0.4</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 246px; LEFT: 873px" id="MeterHY_9958" sytle="font-size:16px;">0.04</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 26px; FONT-SIZE: 120%; TOP: 310px; LEFT: 140px" id="MeterFMKD_9958" sytle="font-size:16px;">76.03</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 129px; LEFT: 680px" id="MeterNJRL_9958" sytle="font-size:16px;">1.21</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 24px; FONT-SIZE: 120%; TOP: 387px; LEFT: 760px" id="MeterBSpump1_9958" sytle="font-size:16px;">0</div>  \
			        <div style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 23px; FONT-SIZE: 120%; TOP: 324px; LEFT: 595px" id="MeterXHpump1_9958" sytle="font-size:16px;">0</div>  \
			      </div> \
			     ';

	var _2huan = '<DIV style="POSITION: relative"> \
		            <IMG src="' + basePath + '/static/image/2huan.gif" width=1000 height=500> \
		            <DIV style="POSITION: absolute; PADDING-BOTTOM: 10px; BACKGROUND-COLOR: rgb(255,255,255); PADDING-LEFT: 10px; PADDING-RIGHT: 10px; HEIGHT: 30px; FONT-SIZE: 25px; TOP: 15px; FONT-WEIGHT: bold; PADDING-TOP: 10px; LEFT: 350px" id="gif-areaname">粮市站</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 45px; LEFT: 100px"></DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 10px; LEFT: 710px">最近采集时间&nbsp;&nbsp;' + new Date().toLocaleDateString() + '&nbsp;&nbsp;</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 412px; LEFT: 25px">总有功电量&nbsp;&nbsp;0&nbsp;&nbsp;kwh</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 435px; LEFT: 25px">补水累积量&nbsp;&nbsp;0&nbsp;&nbsp;T</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 141px; LEFT: 87px" sytle="font-size:16px;">-100</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 163px; LEFT: 87px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 245px; LEFT: 26px" sytle="font-size:16px;">-37.5</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 319px; LEFT: 25px" sytle="font-size:16px;">19.64</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 224px; LEFT: 26px" sytle="font-size:16px;">0.01</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 296px; LEFT: 25px" sytle="font-size:16px;">-0.4</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 185px; LEFT: 87px" sytle="font-size:16px;">1.96</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 50px; LEFT: 596px" sytle="font-size:16px;">-125.02</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 69px; LEFT: 596px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 89px; LEFT: 867px" sytle="font-size:16px;">19.97</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 161px; LEFT: 868px" sytle="font-size:16px;">17.65</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 69px; LEFT: 867px" sytle="font-size:16px;">0.13</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 142px; LEFT: 867px" sytle="font-size:16px;">0.15</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 197px; LEFT: 228px" sytle="font-size:16px;">97.57</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 87px; LEFT: 595px" sytle="font-size:16px;">16.61</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 248px; LEFT: 737px" sytle="font-size:16px;">25.9</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 206px; LEFT: 601px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 258px; LEFT: 597px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 278px; LEFT: 596px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 296px; LEFT: 870px" sytle="font-size:16px;">18.87</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 372px; LEFT: 871px" sytle="font-size:16px;">17.97</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 280px; LEFT: 870px" sytle="font-size:16px;">0.02</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 352px; LEFT: 871px" sytle="font-size:16px;">0.09</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 21px; FONT-SIZE: 120%; TOP: 406px; LEFT: 223px" sytle="font-size:16px;">98.19</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 296px; LEFT: 597px" sytle="font-size:16px;">18.23</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 456px; LEFT: 738px" sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 414px; LEFT: 600px" sytle="font-size:16px;">0</DIV>\
		          </DIV>\
		         ';
	var _3huan = '<DIV style="POSITION: relative" >\
	                <IMG  src="' + basePath + '/static/image/3huan.gif" width=1000 height=500>\
	                <DIV style="POSITION: absolute; PADDING-BOTTOM: 10px; BACKGROUND-COLOR: rgb(255,255,255); PADDING-LEFT: 10px; PADDING-RIGHT: 10px; HEIGHT: 30px; FONT-SIZE: 25px; TOP: 15px; FONT-WEIGHT: bold; PADDING-TOP: 10px; LEFT: 350px" id="gif-areaname">承市之光</DIV>\
	                <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 45px; LEFT: 100px" ></DIV>\
	                <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 10px; LEFT: 710px" >最近采集时间&nbsp;&nbsp;' + new Date().toLocaleDateString() + '&nbsp;&nbsp;</DIV>\
	                <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 412px; LEFT: 25px" >总有功电量&nbsp;&nbsp;0&nbsp;&nbsp;kwh</DIV>\
	                <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 435px; LEFT: 25px" >补水累积量&nbsp;&nbsp;0&nbsp;&nbsp;T</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 147px; LEFT: 103px"   sytle="font-size:16px;">-3</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 167px; LEFT: 103px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 49px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 248px; LEFT: 42px"   sytle="font-size:16px;">22.89</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 46px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 330px; LEFT: 44px"   sytle="font-size:16px;">22.76</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 47px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 230px; LEFT: 44px"   sytle="font-size:16px;">0.05</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 47px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 308px; LEFT: 44px"   sytle="font-size:16px;">0.04</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 188px; LEFT: 104px"   sytle="font-size:16px;">0.04</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 28px; LEFT: 619px"   sytle="font-size:16px;">-14.68</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 47px; LEFT: 620px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 70px; LEFT: 867px"   sytle="font-size:16px;">23.01</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 112px; LEFT: 866px"   sytle="font-size:16px;">23.2</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 50px; LEFT: 867px"   sytle="font-size:16px;">0.42</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 13px; FONT-SIZE: 120%; TOP: 97px; LEFT: 866px"   sytle="font-size:16px;">0.4</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 20px; FONT-SIZE: 120%; TOP: 141px; LEFT: 246px"   sytle="font-size:16px;">101.03</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 65px; LEFT: 619px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 184px; LEFT: 724px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 147px; LEFT: 580px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 48px; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 169px; LEFT: 621px"   sytle="font-size:16px;">34.78</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 49px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 188px; LEFT: 619px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 210px; LEFT: 866px"   sytle="font-size:16px;">23.05</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 252px; LEFT: 866px"   sytle="font-size:16px;">23.67</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 193px; LEFT: 867px"   sytle="font-size:16px;">0.35</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 233px; LEFT: 865px"   sytle="font-size:16px;">0.33</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 21px; FONT-SIZE: 120%; TOP: 281px; LEFT: 246px"   sytle="font-size:16px;">100.3</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 48px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 208px; LEFT: 620px"   sytle="font-size:16px;">16.93</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 20px; FONT-SIZE: 120%; TOP: 324px; LEFT: 724px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 288px; LEFT: 577px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 306px; LEFT: 619px"   sytle="font-size:16px;">-2.68</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 327px; LEFT: 619px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 345px; LEFT: 865px"   sytle="font-size:16px;">23.04</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 388px; LEFT: 867px"   sytle="font-size:16px;">23.78</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 327px; LEFT: 865px"   sytle="font-size:16px;">0.27</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 371px; LEFT: 867px"   sytle="font-size:16px;">0.26</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 21px; FONT-SIZE: 120%; TOP: 415px; LEFT: 250px"   sytle="font-size:16px;">102.9</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 347px; LEFT: 619px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 461px; LEFT: 722px"   sytle="font-size:16px;">0</DIV>\
	                <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 428px; LEFT: 581px"   sytle="font-size:16px;">0</DIV>\
	              </DIV>\
	             ';
	var _4huan = '<DIV style="POSITION: relative" >\
		            <IMG  src="' + basePath + '/static/image/4huan.gif" width=1000 height=500>\
		            <DIV style="POSITION: absolute; PADDING-BOTTOM: 10px; BACKGROUND-COLOR: rgb(255,255,255); PADDING-LEFT: 10px; PADDING-RIGHT: 10px; HEIGHT: 30px; FONT-SIZE: 25px; TOP: 15px; FONT-WEIGHT: bold; PADDING-TOP: 10px; LEFT: 350px" id="gif-areaname">银星丽苑</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 45px; LEFT: 100px" ></DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 22px; FONT-SIZE: 16px; TOP: 10px; LEFT: 710px" >最近采集时间&nbsp;&nbsp;' + new Date().toLocaleDateString() + '&nbsp;&nbsp;</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 412px; LEFT: 25px" >总有功电量&nbsp;&nbsp;0&nbsp;&nbsp;kwh</DIV>\
		            <DIV style="POSITION: absolute; BACKGROUND: #ffffff; HEIGHT: 16px; FONT-SIZE: 12px; TOP: 435px; LEFT: 25px" >补水累积量&nbsp;&nbsp;0&nbsp;&nbsp;T</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 20px; FONT-SIZE: 120%; TOP: 167px; LEFT: 93px"   sytle="font-size:16px;">3</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 187px; LEFT: 93px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 256px; LEFT: 19px"   sytle="font-size:16px;">-37.5</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 306px; LEFT: 19px"   sytle="font-size:16px;">-37.5</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 235px; LEFT: 20px"   sytle="font-size:16px;">-0.4</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 284px; LEFT: 20px"   sytle="font-size:16px;">-0.4</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 59px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 206px; LEFT: 85px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 29px; LEFT: 553px"   sytle="font-size:16px;">23</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 50px; LEFT: 554px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 64px; LEFT: 873px"   sytle="font-size:16px;">-25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 98px; LEFT: 876px"   sytle="font-size:16px;">-25.01</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 43px; LEFT: 871px"   sytle="font-size:16px;">-0.25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 84px; LEFT: 873px"   sytle="font-size:16px;">-0.25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 57px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 67px; LEFT: 547px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 153px; LEFT: 714px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 34px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 128px; LEFT: 605px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 131px; LEFT: 549px"   sytle="font-size:16px;">50</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 58px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 149px; LEFT: 545px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 169px; LEFT: 876px"   sytle="font-size:16px;">-49.99</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 201px; LEFT: 874px"   sytle="font-size:16px;">-87.5</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 151px; LEFT: 877px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 187px; LEFT: 873px"   sytle="font-size:16px;">-24.99</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 224px; LEFT: 245px"   sytle="font-size:16px;">0.6</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 63px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 169px; LEFT: 540px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 42px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 257px; LEFT: 725px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 36px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 231px; LEFT: 599px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 238px; LEFT: 546px"   sytle="font-size:16px;">23</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 15px; FONT-SIZE: 120%; TOP: 257px; LEFT: 544px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 270px; LEFT: 873px"   sytle="font-size:16px;">-25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 13px; FONT-SIZE: 120%; TOP: 304px; LEFT: 877px"   sytle="font-size:16px;">-25.01</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 250px; LEFT: 872px"   sytle="font-size:16px;">-0.25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 291px; LEFT: 877px"   sytle="font-size:16px;">-0.25</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 20px; FONT-SIZE: 120%; TOP: 327px; LEFT: 244px"   sytle="font-size:16px;">1</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 21px; FONT-SIZE: 120%; TOP: 360px; LEFT: 714px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 36px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 333px; LEFT: 603px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 342px; LEFT: 548px"   sytle="font-size:16px;">50</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 18px; FONT-SIZE: 120%; TOP: 359px; LEFT: 548px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 376px; LEFT: 874px"   sytle="font-size:16px;">-49.99</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 409px; LEFT: 876px"   sytle="font-size:16px;">-87.5</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 356px; LEFT: 874px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 16px; FONT-SIZE: 120%; TOP: 395px; LEFT: 875px"   sytle="font-size:16px;">-24.99</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 433px; LEFT: 246px"   sytle="font-size:16px;">0.6</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 14px; FONT-SIZE: 120%; TOP: 378px; LEFT: 547px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 23px; FONT-SIZE: 120%; TOP: 463px; LEFT: 715px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 17px; FONT-SIZE: 120%; TOP: 438px; LEFT: 584px"   sytle="font-size:16px;">0</DIV>\
		            <DIV style="Z-INDEX: 100; POSITION: absolute; TEXT-ALIGN: center; WIDTH: 52px; BACKGROUND: #e9f6ff; HEIGHT: 19px; FONT-SIZE: 120%; TOP: 122px; LEFT: 243px"   sytle="font-size:16px;">1</DIV>\
		          </DIV>\
	       		  ';

});
</script>

