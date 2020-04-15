<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>小区地图</title>
<script>
var basePath = '${contextPath}';
</script>

<style type="text/css">

#container {
    height: 620px;
}
.map-label-area {
    display: block;
    text-align: center;
    font-size: 12px;
    color: #fff;
    margin-top: 8px;
    line-height: 18px;
    text-decoration: none;
}
.areaInfoWin {
	font-size:12px;
	lineheight:1.8em;
	margin-bottom: 0.3rem;
}

/*bootstrap冲突*/
#container label {
	max-width: none;
}
</style>

</head>
<body>
	<div id="container"></div>
</body>
</html>

<script src="${contextPath }/static/bootstrap-4.0/js/bootstrap.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yTfvihLi2DyVzQ7T34SZ1SMYrzmgK0en"></script>

<script>
    $('.page-content-area').ace_ajax('loadScripts',['${contextPath }/static/BMap/lib/Heatmap_min.js'],function() {

        var currentCity = "大同市";
        var map = new BMap.Map("container",{minZoom: 9,maxZoom: 18,enableMapClick: false});
        map.setMapStyle({style:'googlelite'});
        var point = new BMap.Point(113.324242, 40.091451);
        map.centerAndZoom(point, 14);  
        //map.centerAndZoom(currentCity,13);

        function getBoundary(){       
    		var bdary = new BMap.Boundary();
    		bdary.get("山西省大同市", function(rs){ 
    			var count = rs.boundaries.length; 
    			if (count === 0) {
    				alert('未能获取当前市'); return ;
    			}
              	var pointArray = [];
    			for (var i = 0; i < count; i++) {
    				var ply = new BMap.Polygon(rs.boundaries[i], {strokeWeight: 4, strokeColor: "green", fillColor: ""}); //建立多边形覆盖物
    				map.addOverlay(ply);
    				pointArray = pointArray.concat(ply.getPath());
    			}    
    		});   
    	}
        getBoundary();
      
        var maxBoundLng,minBoundLng,maxBoundLat,minBoundLat;//
        var bdarys = new BMap.Boundary();
        bdarys.get("山西省大同市", function(rs){
          if(rs==null) return;
          var boundaryLngs = [];//边界经度坐标集合
          var boundaryLats = [];//边界纬度坐标集合
          var boundaryPointsStr = rs.boundaries[0].replace(/\s+/g,""); //行政区域的点
          var pointsStr = boundaryPointsStr.split(";");
          for(var i = 0; i < pointsStr.length; i++){
              var poi = pointsStr[i].split(",");
              boundaryLngs.push(poi[0]);
              boundaryLats.push(poi[1]);
          }
         maxBoundLng = Math.max.apply(null,boundaryLngs);
         minBoundLng = Math.min.apply(null,boundaryLngs);
         maxBoundLat = Math.max.apply(null,boundaryLats);
         minBoundLat = Math.min.apply(null,boundaryLats);
        });
        
      //小区标注加载完成后执行
        var custNext = function(){
            //控件添加，即map对象的事件
            map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
            map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
            map.enableContinuousZoom();    //启用连续缩放效果，默认禁用
            map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, offset: new BMap.Size(30,30)})); //地图平移缩放控件
            map.addEventListener("moveend",function(e){
                var cLng = map.getCenter().lng;
                var cLat = map.getCenter().lat;
                if(cLng<maxBoundLng && cLng>minBoundLng && cLat<maxBoundLat && cLat>minBoundLat){
                }else{
                    map.setCenter(currentCity);
                }
            });
            map.setCurrentCity(currentCity);
        }
        
        var verifyData = jQuery.parseJSON('${verify}');
        var heatPoints = [];
        
        for(var key in verifyData){
        	var v_points = verifyData[key].split(':');
        	var heatPoint = {};
        	heatPoint.lng = v_points[0];
        	heatPoint.lat = v_points[1];
        	heatPoint.count = v_points[2];
        	heatPoints.push(heatPoint);
        	//addMarker(new BMap.Point(v_points[0],v_points[1]),key);   添加标注
        }
        
        heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":40});
        map.addOverlay(heatmapOverlay);
        heatmapOverlay.setDataSet({data:heatPoints,max:500000});
        
        
        /* setTimeout(function(){
        	custNext();
        },0) */
        
    });
</script>