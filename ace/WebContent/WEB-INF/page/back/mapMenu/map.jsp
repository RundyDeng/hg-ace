<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
<head>  
    <title></title>  
    <meta charset="utf-8" />  
    <!--引用百度地图API-->  
    <style type="text/css">  
        html,body{margin:0;padding:0;}  
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}  
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}  
    </style>  
   <!--  <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>   -->
    <script type="text/javascript" src="js/arrow.js"></script>  
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=b245ae8390f2ecdc0e5706241c28fc7b"></script>
  
</head>  
  
<body>  
<!--百度地图容器-->  
<div style="height:550px;border:#ccc solid 1px;" id="dituContent"></div>  

<div>
	<img src="http://ohd0dbp8h.bkt.clouddn.com/cadss.gif" alt="闪烁效果">
</div>
</body>  
<script type="text/javascript">  
    //创建和初始化地图函数：  
    function initMap(){  
        createMap();//创建地图  
        setMapEvent();//设置地图事件  
        addMapControl();//向地图添加控件  
        addPolyline();//向地图中添加线  
    }  
  
    //创建地图函数：  
    function createMap(){  
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图  
        var point = new BMap.Point(117.972,41.025);//定义一个中心点坐标  
        map.centerAndZoom(point,15);//设定地图的中心点和坐标并将地图显示在地图容器中  
        window.map = map;//将map变量存储在全局  
    }  
  
    //地图事件设置函数：  
    function setMapEvent(){  
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)  
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小  
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)  
        map.enableKeyboard();//启用键盘上下左右键移动地图  
    }  
  
    //地图控件添加函数：  
    function addMapControl(){  
        //向地图中添加缩放控件  
        var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});  
        map.addControl(ctrl_nav);  
        //向地图中添加比例尺控件  
        var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});  
        map.addControl(ctrl_sca);  
    }  
  
    //标注线数组  
    var plPoints = [{weight:1,color:"blue",opacity:0.6,points:   // white
    	["117.989|41.028",
    	 "117.987|41.027",
    	 "117.984|41.0266",
    	 "117.980|41.026",
    	 "117.972|41.025",
    	 "117.962|41.021",
    	 "117.956|41.018",
    	 "117.955|41.017",
    	 "117.954|41.016",
    	 "117.953|41.015", 
    	 "117.952|41.014",
    	 "117.951|41.013",
    	 "117.950|41.012",
    	 "117.949|41.011",
    	 "117.948|41.010",
    	 "117.947|41.009",
    	 "117.946|41.008"
    	 
    	 
    	 
    	 
    	 
    	 
    	 ]}  
    ];  
    //向地图中添加线函数  
    function addPolyline(){  
        for(var i=0;i<plPoints.length;i++){  
  var json = plPoints[i];  
            var points = [];  
            for(var j=0;j<json.points.length;j++){  
                var p1 = json.points[j].split("|")[0];  
                var p2 = json.points[j].split("|")[1];  
                points.push(new BMap.Point(p1,p2));  
            }  
            var line = new BMap.Polyline(points,{strokeWeight:json.weight,strokeColor:json.color,strokeOpacity:json.opacity});  
            map.addOverlay(line);  
            addArrow(line);  
  
        }  
    }  
  
    initMap();//创建和初始化地图  

    
function addArrow(line){ //绘制标注的函数  
    var linePoint=line.getPath();//线的坐标串  
    var arrowCount=linePoint.length;  
    var end = new BMap.Marker(linePoint[linePoint.length-1]);  // 创建标注  
    map.addOverlay(end);               // 将标注添加到地图中  
    end.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画  
    var myIcon = new BMap.Icon("http://api0.map.bdimg.com/images/stop_icon.png", new BMap.Size(11,11));  
    for(var i =0;i<arrowCount;i++){ //在拐点处添加标注  
        var marker = new BMap.Marker(linePoint[i],{icon:myIcon});  // 创建标注  
        map.addOverlay(marker);              // 将标注添加到地图中  
        var label = new BMap.Label("管道"+(i+20)+"号",{offset:new BMap.Size(5,10)});  
        label.setStyle({  
            color : "black",  
            fontSize : "15px",  
            height : "10px",  
            lineHeight : "15px",  
            backgroundColor:"rgba(255, 255, 255, 0.5) none repeat scroll 0 0 !important",//设置背景色透明  
            border:"0.1px solid red"  
        });  
        marker.setLabel(label);  
    }  
}  
</script>
</html>  




