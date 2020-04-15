<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>

<html lang="zh">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>系统更新日志</title>
   <link rel="stylesheet" href="${contextPath}/static/assets/css/style.css" />
    
</head>
<body>
    <div class="content">
        <div class="wrapper">
            <div class="light">
                <i></i>
            </div>
            <hr class="line-left">
            <hr class="line-right">
            <div class="main" id="updatelog">
            
               </div>
        </div>
    </div>


   

</body>
</html>
 <script>

    var scripts = [
       			null,"${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",null ]
       	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
       	 $(".main .year .list").each(function(e, target) {
       	     var $target = $(target),
       	     $ul = $target.find("ul");
       	     $target.height($ul.outerHeight()), $ul.css("position", "absolute");
       	 });
       	 $(".main .year>h2>a").click(function(e) {
       	     e.preventDefault();
       	     $(this).parents(".year").toggleClass("close");
       	 });
         var tbody = "<h1 class='title'> 供热大数据智慧运行系统更新日志</h1>";
         var ErrorMessage = '对不起,查询的数据为空,请检查相关条件是否完整.';
         $.ajax({
             type: "POST", //用POST方式传输
             dataType: "json", //数据格式:JSON
             url: '${contextPath}/baseinfomanage/webupdatelog/getyearinfo', //目标地址
             data: "p=1",
             async: false,
             success: function(json) {
                 //alert("ok");
                 if (json != null) {

                     var productData = json;
                     $.each(productData, function(i, n) {
                         var trs = "";
                         trs = "<div class='year'> <h2> <a href='#'>" + n.年份 + "<i></i></a></h2><div class='list'><ul>";
                         tbody += trs;
                         fn_ajax(n.年份);
                         tbody += "</ul></div></div>"
                     });
                     //tbody += trs;
                     //tbody += "</div>"
                     $("#updatelog").append(tbody);

                 }
                 else {
                     alert(ErrorMessage);
                 }
             }
         });
         function fn_ajax(year) {
             $.ajax({
                 type: "POST", //用POST方式传输
                 dataType: "json", //数据格式:JSON
                 url: '${contextPath}/baseinfomanage/webupdatelog/getloginfo', //目标地址
                 data: "Year=" + year,
                 async: false,
                 success: function(json) {
                     if (json != null) {

                         var productData = json;
                         $.each(productData, function(i, n) {
                             var str = "";
                             str += " <li class='cls highlight'><p class='date'>" + n.日期 + "</p><p class='intro'>" + n.TITLE + "</p> <p class='version'>&nbsp;</p><div class='more'>" + n.CONTENT + "</div></li>";
                             tbody += str;



                         });


                     }
                 }
             });

         }	
       	});
       
    </script>
