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

/*自定义控件样式开始*/
#areaDown {
    background-color: #fff;
    width: 150px; 
    position: relative;
    padding: 4px;
    border: 1px solid rgb(203, 203, 203);
    box-shadow: 1px 1px 2px 1px rgba(0, 0, 0, 0.02);
    padding-left: 10px;
}
#areaDown:hover {
    color: #c00;
}
#areaDown em {
    width: 10px;
    height: 5px;
    background: url(${contextPath }/static/BMap/img/down_icon.png) no-repeat;
    position: absolute;
    right: 6px;
    top: 14px;
    transition: transform 1s;
}
#areaDown em[class="up"] {
    background: url(${contextPath }/static/BMap/img/up_icon.png) no-repeat; 
}
#areaData {
    width: 150px;
    height: 500px;
    padding-top: 10px;
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(203, 203, 203);
    box-shadow: 1px 1px 2px 1px rgba(0, 0, 0, 0.3);
    overflow: auto;
}
#areaData p {
    padding-left: 5px;
    margin-bottom: 0.3rem;
}
#areaData p:hover {
    background-color: aliceblue;
    cursor: pointer;
}
/*自定义控件样式结束*/

/*bootstrap冲突*/
#container label {
	max-width: none;
}
</style>

</head>
<body>
	<div id="container"></div>
    <div id="areaContro" class="areaContro" style="display:none;">
        <div id="areaDown">
            <span>小区列表</span>
            <em class="up"></em>
        </div>
        <div id="areaData">
        </div>
    </div>
</body>
</html>

<script src="${contextPath }/static/bootstrap-4.0/js/bootstrap.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yTfvihLi2DyVzQ7T34SZ1SMYrzmgK0en"></script>

<script>
    $('.page-content-area').ace_ajax('loadScripts',['${contextPath }/static/BMap/lib/MarkerClusterer.js','${contextPath }/static/BMap/lib/TextIconOverlay.js'],function() {
    	var markers = [];  //地图上显示的标注集合
        
        var onMapAreaForSearchable = [];  //经过排除后，可以准确定位的小区列表
        var onMapPointForSearchable = []; //与上面是一对，即处理后的小区的对应的点
        var areaLength = 0;
        
        var currentCity = "大同市";
        var map = new BMap.Map("container",{minZoom: 9,maxZoom: 18,enableMapClick: false});
        map.setMapStyle({style:'googlelite'});
        map.centerAndZoom(currentCity,15);

        function getBoundary(){       
    		var bdary = new BMap.Boundary();
    		bdary.get("山西省大同市", function(rs){ 
    			var count = rs.boundaries.length; 
    			if (count === 0) {
    				alert('未能获取当前市');
    				return ;
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
    	//setTimeout(function(){getBoundary();}, 0);
        
        //服务--地理编码   >>由市名得到点坐标
    /*    var myGeo = new BMap.Geocoder();        
        myGeo.getPoint("大同市",function(point){
            console.log(point)// lng: 113.290509, lat: 40.113744 
            map.centerAndZoom(point,15);
        });*/


        var MymarkerClusterer = function(){
            var markerClusterer = new BMapLib.MarkerClusterer(map, {markers: markers});
            markerClusterer.setGridSize(80);//设置网格大小    聚合计算时网格的像素大小，默认60
            map.addEventListener("zoomend", function(e){
            });
        }
        //服务--本地搜索   ---数据接口
        var localSearch_options = {
            onSearchComplete: function(results){
                if(local.getStatus() == BMAP_STATUS_SUCCESS){
                    var s = [];
                    for(var i = 0; i < results.getCurrentNumPois(); i++){
                        var poi = results.getPoi(i);
                        if(poi.city == currentCity && poi.province == "山西省" 
                           && poi.tags != undefined && poi.tags.join(",").indexOf("小区") != -1){
                            addMarker(poi.point,results.keyword);
                            break;
                        }
                    }
                }
                --areaLength;
                if(areaLength == 0){
                    custNext();
                    MymarkerClusterer();
                }
            }
        }
        var local = new BMap.LocalSearch(currentCity,localSearch_options);
        var searchEachArea = function(objs){
            //markers = [];
            onMapAreaForSearchable = [];
            onMapPointForSearchable = [];
            for(var i =0; i < objs.length; i++){
            	local.search(objs[i]);
            }
        }
        
        //自定义函数创建标注
        function addMarker(point,areaname){
            if(areaname == undefined) areaname = "";
            var myIcon = new BMap.Icon("${contextPath}/static/BMap/img/bg.png", new BMap.Size(74, 74),{
            });
            var marker = new BMap.Marker(point, {
                icon: myIcon,
                title: areaname
            });
            onMapAreaForSearchable.push(areaname);
            onMapPointForSearchable.push(point);
            var myLabel = new BMap.Label("<a class='map-label-area' href='javascript:;'>大同<br>"+ areaname +"<br>开发部</a>",{
            });
            myLabel.setStyle({          
                color: "yellow",
                fontSize: "14px",
                border: "0",
                height: "74px",
                width: "74px",
                overflow: "hidden",
                textAlign: "cneter",    
                lineHeight: "120px",    
                background: "url(${contextPath}/static/BMap/img/bg.png) no-repeat -1px -1px",
                cursor: "pointer"
            });
            /*var areaMessage = '<p class="areaInfoWin" style="font-size: 16px; margin-bottom: 8px;"><b>小区: ' + areaname + '</b></p> \
            <p class="areaInfoWin">数据更新时间: ' + jsonData[areaname].DDATE + '</p> \
            <p class="areaInfoWin">总面积: ' + jsonData[areaname].AREA + '</p> \
            <p class="areaInfoWin">用户总数: ' + jsonData[areaname].CUSTOMER + '<p> \
            <p class="areaInfoWin">当日耗热量: ' + jsonData[areaname].AREA_ENERGY + '<p> \
           ';
            var infoWindow = new BMap.InfoWindow(areaMessage);*/
            marker.addEventListener("mouseover",function(e){
                myLabel.setStyle({backgroundPosition: "0px -88px"});
                //marker.setZIndex(100);//设置覆盖物的zIndex。//为何没用？
                marker.setTop(true);
            });
            marker.addEventListener("mouseout",function(e){
                myLabel.setStyle({backgroundPosition: "-1px -1px"});
                marker.setTop(false);
            });
            marker.addEventListener("click", function(){
                //map.openInfoWindow(infoWindow, point); 单击显示详情- - 
                var bar_a = $(window.parent.document.getElementById('sidebar')).find('a[data-addtab="areagif"]')[0];
                //以下这样$()后 click不能调用？为何
                $(bar_a).attr("data-oth",areaname);
                bar_a.click();
            });
            
            markers.push(marker);
            map.addOverlay(marker);
            setTimeout(function(){
                marker.setIcon(new BMap.Icon('${contextPath}/static/BMap/img/transparent.gif', new BMap.Size(74, 74)));
                marker.setLabel(myLabel);
            },300);
        }
        
        /*自定义控件*/
        function AreaSearchControl(){
            this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
            this.defaultOffset = new BMap.Size(30,30);
        }
        AreaSearchControl.prototype = new BMap.Control();
        AreaSearchControl.prototype.initialize = function(map) {
            var div = document.getElementById('areaContro');
            return div;
        }
        
        function areaDownInit(){
            var areaListHtml = '';
            for(var i=0; i < onMapAreaForSearchable.length; i++){
                areaListHtml += '<p data-poi="' + onMapPointForSearchable[i].lng + ',' +  onMapPointForSearchable[i].lat +  '">' + onMapAreaForSearchable[i] + '</p>';
            }
            $('#areaData').empty().append(areaListHtml);
            $('#areaData p').click(function(){
                var dbPara = $(this).attr("data-poi").split(",");
                var currentPoint = new BMap.Point(dbPara[0],dbPara[1]);
                map.panTo(currentPoint);
                map.setZoom(18);
            })
            $("#areaDown").click(function(){
                if($("#areaDown em").attr("class") == "up"){
                    $("#areaData").slideUp("slow");
                    $("#areaDown em").removeClass("up");
                }else{
                    $("#areaData").slideDown("slow");
                    $("#areaDown em").addClass("up");
                }
            })
            $("#areaDown").click();//自己弹出来了，妮玛- -
        }
        
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
       
        /*//判断点是否在多边形的内部  -- 没必要
        function checkPointInPolygon(points, point){
        }*/
        
      //小区标注加载完成后执行
        var custNext = function(){
            areaDownInit();
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
            var areaSearchControl = new AreaSearchControl();
            map.addControl(areaSearchControl);
            $("#areaContro").show();
        }
        
      	var areaNames = [];//小区名集合
        var jsonData = jQuery.parseJSON('${result}');
        var verifyData = jQuery.parseJSON('${verify}');
    	/* for(var key in jsonData){
    		areaNames.push(key);
        	for(var key2 in verifyData){
        		if(key2 == key){
        			areaNames.pop();
        		}
        	}
        } */
        //areaLength = areaNames.length;
        markers = [];
        for(var key in verifyData){
        	var v_points = verifyData[key].split(':');
        	addMarker(new BMap.Point(v_points[0],v_points[1]),key);
        }
        setTimeout(function(){
        	custNext();
            MymarkerClusterer();
        },1000)
        /*    没有小区坐标的根据小区名搜索定位   */
        //searchEachArea(areaNames); 
    });
</script>