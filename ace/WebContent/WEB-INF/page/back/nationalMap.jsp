<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@page import="core.util.MathUtils"%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=b245ae8390f2ecdc0e5706241c28fc7b"></script>
<style type="text/css">


  *{margin:0px; padding:0px;}
  body{ width:100%;height:100%;}
  #Main{width:100%;height:100%;margin:0px auto 0px; position:relative;}
  #Main .title{height:50px; background:#3397e4;color:#fff; font-size:26px; text-align:center;
				line-height:50px;font-weight:bold;}
  #Main #Map{height:550px;}

  #Main .Search{width:415px;height:40px;background:#fff; position:absolute; top:50px;					
  left:180px; box-shadow:0px 0px 20px #000;} 
  #Main .Search input.txt{width:315px;height:40px; border:0px;float:left; text-indent:10px;}
  #Main .Search input.but{width:100px;height:40px; background:#690; border:0px;
						float:left; color:#fff;font-size:14px; font-family:"微软雅黑";}

  #Main .Menu{width:110px;height:120px; background:#fff; box-shadow:0px 0px 10px #000;}
  #Main .Menu ul li{list-style-type:none; height:30px; font-size:12px; line-height:30px;
			text-align:Center; border-bottom:1px dotted #ccc;}
  #Main .Menu ul li:hover{background:#3397e4;color:#fff;}
  </style>
</head>
<body>
<div id="Main">
		<div class="title">统计</div>

		地图开始
		<div id="Map"></div>
		地图结束

		搜索开始
		<div class="Search">
			<input id="cityName" placeholder="请输入城市的名称" type="text" class="txt"/>
			<input id="query" value="搜  索" type="button" class="but"/>
		</div>
	
	</div>
 </body>
</html>
<script>
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js",
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts.js",
                "${contextPath}/static/Highcharts-4.2.5/grouped-categories.js", 
                "${contextPath}/static/Highcharts-4.2.5/js/highcharts-3d.js",
	   			"${contextPath}/static/Highcharts-4.2.5/js/modules/data.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide-full.min.js",
	   			"${contextPath}/static/Highcharts-4.2.5/highslide.config.js", 
                null ];
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		var map, toolBar, mouseTool, contextMenu;
		//初始化地图对象，加载地图
		map = new AMap.Map("Map", {
			resizeEnable: true,
			zoom:5,
           center: [103.767626,36.100745]  
		});
		var lnglats = [
        [[113.33003,40.089614],'大同',142180,137116,5064], //坐标，地名，住户数，采集器数
        [[110.99039,35.041108],'运城',4297,4214,83],
        [[106.196549,38.0025],'吴忠',3875,3852,25],
        [[114.063952,22.549683],'深圳',120000,11820,280],
        [[117.213794,39.093145],'天津',69868,69285,583],
        [[119.5772,39.968401],'秦皇岛富阳',25562,24527,1035],
        [[119.593063,39.944562],'秦皇岛大热力',15286,13054,2232],
        [[118.361271,35.111718],'临沂',6089,2806,3283],
        [[117.128954,36.657502],'济南',14129,13597,532],
        [[120.392611,36.072135],'青岛',24102,23519,583],
        [[103.8926,36.041371],'兰州热力总公司',17970,15629,577],
        [[103.830678,36.065513],'兰州城投集团',2672,2371,1],
        [[113.933533,35.310174],'新乡',16687,16004,683],
        [[111.20799,34.777734],'三门峡',5236,4819,417],
        [[121.455549,37.471076],'烟台',24689,24234,455]

    ];
    var infoWindow = new AMap.InfoWindow({offset: new AMap.Pixel(0, -30)});
    for (var i = 0, marker; i < lnglats.length; i++) {
        var marker = new AMap.Marker({
            position: lnglats[i][0],
            map: map
        });
        marker.content = '<h3>'+lnglats[i][1]+'</h3><div>用户数:'+lnglats[i][2]+'</div><div>正常数:'+lnglats[i][3]+'</div><div>故障数:'+lnglats[i][4]+'</div>';
        marker.on('click', markerClick);
        marker.emit('click', {target: marker});
    }
    function markerClick(e) {
        infoWindow.setContent(e.target.content);
        infoWindow.open(map, e.target.getPosition());
    }
	  //设置城市
		document.getElementById('query').onclick = function(){
			var cityName = document.getElementById('cityName').value;
			if(!cityName){
				cityName = '北京市';
			}
			map.setCity(cityName);
		};
		//地图中添加地图操作ToolBar插件、鼠标工具MouseTool插件
		map.plugin(["AMap.ToolBar","AMap.MouseTool"], function(){		
			toolBar = new AMap.ToolBar(); 
			map.addControl(toolBar);	
	        mouseTool = new AMap.MouseTool(map); 	
		});			
		//自定义右键菜单内容
		var menuContent = document.createElement("div");
		menuContent.innerHTML = "<div class='Menu'>"+
			"<ul>"+
				"<li class='hover' onclick='zoomMenu(0)'>缩小</li>"+
				"<li onclick='zoomMenu(1)'>放大</li>"+
				"<li onclick='distanceMeasureMenu()'>测量距离</li>"+
				
			+"<ul>"
		+"</div>"
		//创建右键菜单
		contextMenu = new AMap.ContextMenu({isCustom:true,content:menuContent});//通过content自定义右键菜单内容		
		//地图绑定鼠标右击事件——弹出右键菜单
		AMap.event.addListener(map, 'rightclick', function(e){
			contextMenu.open(map, e.lnglat);
			contextMenuPositon = e.lnglat; //右键菜单位置
		});
	    contextMenu.close();
		//右键菜单缩放地图
		function zoomMenu(tag){
			if(tag === 0){	map.zoomOut();}
			if(tag === 1){	map.zoomIn();}
		       contextMenu.close();
		}		
		//右键菜单距离量测
		function distanceMeasureMenu(){
			mouseTool.rule();
		       contextMenu.close();
		}
	});
	</script> 