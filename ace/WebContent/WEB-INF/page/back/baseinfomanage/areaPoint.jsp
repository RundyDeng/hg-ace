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

#r-result {
   // width: 100%;
}

.tangram-suggestion-main {
	overflow-y: auto;
	height: 430px;
	overflow-x: hidden;
}
</style>
<body>
	<div id="tree" style="width: 20%; float: left; height: 500px; overflow: auto;border: 1px solid rgb(221, 221, 221);"></div>  
	<div id="container" style="float: right; WIDTH: 80%; HEIGHT: 500px; display: none;" title="地图打点">
	</div>
	<div id="r-result"  style="display: none;">
        <input type="text" id="suggestId" placeholder="请输入" size="20" value="百度" style="width:150px;"/>
        <input type="text" id="currentAreaGuid" hidden/>
    </div>
    <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>

</body>
</html>

<script>
	var basePath = '${contextPath}';
</script>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yTfvihLi2DyVzQ7T34SZ1SMYrzmgK0en"></script>
<script src="${contextPath}/static/pages/js/bootstrap-treeview.js"></script>
<script>
$('.page-content-area').ace_ajax('loadScripts',[],function() {
	
	$.get('${contextPath}/homePage/getAreaTree', function(response){
		var tree = jQuery.parseJSON(response);
		$('#tree').treeview({
			data: tree,
			levels: 2,
			enableLinks: false,
			onNodeSelected: function(event, data) {
				var curNodeId = data.nodeId;
				if(data.nodes==null){
					//data.text小区名    data.menuId 小区areaguid
					$('#suggestId').val(data.text);
					$('#container').show();
					$('#r-result').show();
					$('#currentAreaGuid').val(data.menuId);
					ac.show();
				}else{
					$('#tree').treeview('expandNode', [ curNodeId, { levels: 1, silent: true } ]);
					ac.hide();
					$('#r-result').hide();
					$('#container').hide();
				}
			}
		});         
	});
    function G(id) {
        return document.getElementById(id);
    }
	var currentCity = "大同市";
    var map = new BMap.Map("container",{minZoom: 9,maxZoom: 18,enableMapClick: false});
    map.setMapStyle({style:'googlelite'});
    map.centerAndZoom(currentCity,15);
	
    var ac = new BMap.Autocomplete( //建立一个自动完成的对象
            {
                "input": "suggestId",
                "location": currentCity
            });
   
    ac.addEventListener("onhighlight", function (e) { //鼠标放在下拉列表上的事件
        var str = "";
        var _value = e.fromitem.value; //上一条记录的信息的结果数据
        var value = "";
        if (e.fromitem.index > -1) { //高亮的记录，所属返回结果的index   -1表示上一条记录为空，即没有上一条记录
                         //所在省             城市          区域（哪个区）      //街道            //商业名？
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {  //当前高亮的记录信息
            _value = e.toitem.value;
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }
        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
        G("searchResultPanel").innerHTML = str;
    });
    
    ac.addEventListener("onconfirm", function (e) { //鼠标点击下拉列表后的事件
        var _value = e.item.value;
        myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
        G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
        setPlace();//选中以后设置地图和覆盖物等
    });

    function setPlace() {
        map.clearOverlays(); //清除地图上所有覆盖物
        function myFun() {
            var pp = local.getResults().getPoi(0).point; //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 18);
            var t_marker = new BMap.Marker(pp);
            var t_menu = new BMap.ContextMenu();
            t_menu.addItem(new BMap.MenuItem("以当前标注位置保存小区！",function(){
            	//$('#currentAreaGuid').val()   当前小区的areaguid
            	if($('#currentAreaGuid').val()=="") return;
           		var _curPoint = t_marker.getPosition();
           		$.post("${contextPath}/baseinfomanage/areaPointContr/setAreaPoint", 
           			    {
	           				areaGuid: $('#currentAreaGuid').val(),
	           			    point: _curPoint 
           			    },
		  			   function(response){
           			    	response=='true' ? alert("设定成功！") : alert("设定失败!");
           			   }
           		);
            }));
            t_marker.addContextMenu(t_menu);
            map.addOverlay(t_marker); //添加标注
        }
        var local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: myFun
        });
        //local.searchInBounds(myValue, new BMap.Boundary().get("山西省大同市"));
        local.search(myValue);
    }
    
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

    function AreaSearchControl(){
        this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
        this.defaultOffset = new BMap.Size($('#tree').width()+15,30);
    }
    AreaSearchControl.prototype = new BMap.Control();
    AreaSearchControl.prototype.initialize = function(map) {
        var div = document.getElementById('r-result');
        return div;
    }
    
    var areaSearchControl = new AreaSearchControl();
    map.addControl(areaSearchControl);
    
    map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    map.enableContinuousZoom();    //启用连续缩放效果，默认禁用
    map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, offset: new BMap.Size(30,30)})); //地图平移缩放控件
    
    
    
    var m_menu = new BMap.ContextMenu();
    var m_menuItem = new BMap.MenuItem("设定当前点为此小区坐标！",function(e){
    	if($('#currentAreaGuid').val()=="") return;
   		$.post("${contextPath}/baseinfomanage/areaPointContr/setAreaPoint", 
   			    {
       				areaGuid: $('#currentAreaGuid').val(),
       			    point: e 
   			    },
  			   function(response){
   			    	response=='true' ? alert("设定成功！") : alert("设定失败!");
   			   }
   		); 
    })

    m_menu.addItem(m_menuItem);
    map.addContextMenu(m_menu);
});
</script>

