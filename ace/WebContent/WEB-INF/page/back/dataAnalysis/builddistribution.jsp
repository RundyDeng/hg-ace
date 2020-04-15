<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-cn">
<head>

<title>供热大数据智慧运行系统</title>
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet"
	href="${contextPath}/static/pageclock/compiled/flipclock_statistic.css" />

<link rel="stylesheet" href="${contextPath}/static/litdatepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />

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

#floatMessage {
	position: absolute;
	display: none;
}
</style>
</head>
<body>

	<div class="container-fluid" style="background-color: #f7f7f9;">
		<br />
		<div class="row" style="height: 30px;">
			<div class="col-md-3">
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon3">选择小区: </span> 
					<select id="community" onchange="building(this)" class="form-control"></select>
					<!-- <input type="text" class="form-control" id="search_areaname"  aria-describedby="basic-addon3"> -->
				</div>
			</div>
			<div class="col-md-3">
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon3">选择楼宇：</span> <select
						id="build" class="form-control"></select>
				</div>
			</div>
			<div class="col-md-3"></div>
			<div class="col-md-2">
				<button type="button" class="btn btn-success" id="build_data_search">查&nbsp;&nbsp;询</button>
			</div>
		</div>
		<br />
		<div class="row" style="overflow: auto; margin-left: 1px; margin-right: 1px;overflow-x:auto;">
		
			<table id="dis_table" class="table table-bordered table-hover table-striped" style="margin-bottom: 0px;width:auto;">
				<thead>
					<tr id="dis_th">  </tr>
				</thead>

				<tbody id="dis_td">  </tbody>
			</table>

		</div>

	</div>
	<%--rgba(0, 255, 255, 0.54) --%>
	<div id="floatMessage" style="background-color: antiquewhite;
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#6600FFFF,endColorstr=#9900FFFF);
			 padding: 10px;border-radius: 10px;box-shadow: 5px 5px 10px gray;">
	</div>

</body>
</html>

<script>
    
var _areaguid,_buildno;

var building = function(obj){
	_areaguid = obj.value;
	if(_areaguid==''||_areaguid=='null') return;
	$.get('${contextPath}/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
		var response = jQuery.parseJSON(data);
		var s = ' ';
	      if (response && response.length) {
	          for (var i = 0, l = response.length; i < l; i++) {
	           var ri = response[i];
	           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
	          }
	       }
	    var sel = $('#build');
	    sel.empty().append(s);  
	});
};
    
    
var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
                "${contextPath}/static/pageclock/compiled/flipclock.js"
                ,null ];
var page = 1;          
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	   	
	$.ajax({
		url : '${contextPath}/sys/todaydata/getAreaDownList',
		type : 'POST',
		dataType : 'json',
		success : function(data){
			var response = data;
		      var s = '';
		      if (response && response.length) {
		          for (var i = 0, l = response.length; i < l; i++) {
		           var ri = response[i];
		           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
		          }
		       }
		     $('#community').append(s);
		     var areaguid = '<%=(String) request.getSession().getAttribute("areaGuids")%>';
		     if(areaguid=='null'||areaguid=='') return;
		     $('#community option[value="'+areaguid+'"]').attr('selected',true);
		     var obj = [];
		     obj.value=areaguid;
		     building(obj);
		}
	});
	function eleXY(ele){
		var _obj = {};
		_obj.left = ele.offsetParent ? ele.offsetLeft + eleXY(ele.offsetParent).left : ele.offsetLeft;
		_obj.top = ele.offsetParent ? ele.offsetTop + eleXY(ele.offsetParent).top : ele.offsetTop;
		return _obj;
	}
	$('#build_data_search').click(function(){
		var areaguid = $('#community').val();
        var buildno = $('#build').val();
		if(areaguid==''||buildno=='') return;
		var ifWin = eleXY($(window.parent.document).find('#builddistribution')[0]);
		var result = {};
        $.get('${contextPath}/dataanalysis/builddistributioncontr/getBuildDistribution?buildno='+buildno+'&areaguid='+areaguid,function(response){
            var resObj = jQuery.parseJSON(response);
            var data = resObj.ROWS;
            var unitInfo = resObj.UNITINFO; 
           
            result = data;
            var thead = '<th style="width: 100px;"></th>';
            var unitFlag = [];
            var maxDoorByFloor = 0;//层的用户总数
            $(unitInfo).each(function(j,unif){
        		thead += '<th style="text-align: center;" colspan="'+unif.MAXDOOR+'">第' + (j+1) + '单元</th>';
        		unitFlag[j] = unif.MAXDOOR;
        		maxDoorByFloor += unif.MAXDOOR;
        	});
            
            $('#dis_table').css('min-width',maxDoorByFloor*80 + 100);//设定table宽度
            $('#dis_th').empty().append(thead);
            
            var s = '';
            $(data).each(function(index,obj){
            	
            	s += '<tr><td style="text-align: center;line-height: 60px;" data-rel="">第'+(index+1)+'层</td>';
            	var cellno = 0;
            	$(unitFlag).each(function(i,unitInfo){//
            		for(var k=1;k<=unitInfo;k++){
            			//是否停热    0否，1是
            			var verifyStop = 0;
            			if(obj!=null)
            				verifyStop = obj[cellno]!=null ? obj[cellno].ISYESTR : 0;
            			if(verifyStop==1){
            				s += '<td style="padding-bottom: 0px;height:80px;width:80px;background-image:url(${contextPath}/static/image/house2.gif);" data-rel="'+index+','+cellno+'">'+(index+1)+'0'+k/* +'</td>' */;
            			}else{
            				s += '<td style="padding-bottom: 0px;height:80px;width:80px;background-image:url(${contextPath}/static/image/house1.gif);" data-rel="'+index+','+cellno+'">'+(index+1)+'0'+k/* +'</td>' */;	
            			}
            			if(obj!=null&&obj[cellno]==null)
            				s += '<font style="font-size: 11px;display: block;padding-top: 32px;color: rgba(0, 111, 255, 0.8);">无数据</font>';
            				s += '</td>';
            				
            			cellno++;
            		}
            	});
                s += '</tr>';
            })
            $('#dis_td').empty().append(s);
            
            function getTop(e){
           		var offset=e.offsetTop;
            	if(e.offsetParent!=null) 
            		offset+=getTop(e.offsetParent);
            	return offset;
            }
            function getLeft(e){
            	var offset=e.offsetLeft;
            	if(e.offsetParent!=null) 
            		offset+=getLeft(e.offsetParent);
            	return offset;
            }
         
            var checkHover = 0;
            $('#dis_td tr td').hover(function(e){
            	
            	var params = $(this).attr('data-rel').split(',');
            	if(params=='') return;
				var x = params[0];
				var y = params[1];
				var obj = result[x][y];
   				if(obj==null){
   					checkHover = 0;
   					return;
   				}else{
   					checkHover = 1;
   				}
   					
            	str = '<p>最新抄表日期:'+ obj.NEWEST +'</p><p>用户名:'+ obj.CLIENTNAME + '</p><p>住房面积:'+obj.HOTAREA+'</p><p>表ID:' + obj.METERID + '</p>'
            		+ '<p>累计热量:' + roundFix(obj.METERNLLJ) + 'kwh</p><p>累计流量:' + roundFix(obj.METERTJ) + 't</p>';
            		
            	$('#floatMessage').append(str);
            	$(this).find('img').stop().fadeTo('slow', 0.5);
            	toJudge(e,ifWin);
            	$("#floatMessage").fadeIn('fast');
            	
            },function(e){
            	if(checkHover == 0)
            		return;
            	$(this).find('img').stop().fadeTo('slow', 1);
                $("#floatMessage").empty();
               
				var dis_td = document.getElementById("dis_td");
                var x=e.clientX; 
                var y=e.clientY; 

                var disX1 = getLeft(dis_td) - window.pageXOffset;
                var disY1 = getTop(dis_td) - window.pageYOffset;
                var disX2 = disX1 + dis_td.offsetWidth; 
                var disY2 = disY1 + dis_td.offsetHeight;  
                if( x <= disX1 || x >= disX2 || y <= disY1 || y >= disY2){
                    $("#floatMessage").hide();
                }  
            });
            
            $("#dis_td tr td").mousemove(function (e) {
                toJudge(e,ifWin);
            });
            
            _J_setAreaGuid(onSearch_putDown_areaguid('community'),onSearch_putDown_areaname('community'));
            
        });
        
	});
});

	


function getYOffset() {  
    var scrollY;  
    if (window.pageYOffset) {  
    	scrollY = window.pageYOffset; 
    	} else if (document.compatMode && document.compatMode != 'BackCompat'){
    		scrollY = document.documentElement.scrollTop;
    		} else if (document.body) { 
    			scrollY = document.body.scrollTop; 
    			}   
    return scrollY;   
}  

var x = 180;
var y = 110;
var toJudge = function (e,ifWin) {
	var leftSpace = document.documentElement.clientWidth - window.pageXOffset - e.clientX - 60;    
    var divWidth = $("#floatMessage").width();
    if (leftSpace < divWidth) {
        var xx = divWidth + x + 60;
        $("#floatMessage").css({
            top: (e.clientY + getYOffset() - y + ifWin.top) + 'px',
            left: (e.clientX - xx + ifWin.left) + 'px'
        });
    } else {
        $("#floatMessage").css({
            top: (e.clientY + getYOffset() - y + ifWin.top) + 'px',
            left: (e.clientX - x + ifWin.left) + 'px'
        });
    };
}
    
 
</script>
