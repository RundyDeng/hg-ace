<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
  <head>
<%-- <base href="<%=basePath%>"> --%>

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<!-- <script type="text/javascript" src="jquery-easyui-v1.4.4/jquery.min.js"></script> -->
<script src="${contextPath}/static/assets/js/jquery-ui.js"></script>
	<script type="text/javascript">
		setInterval(function(){
		    getMsgNum();
		},3000);
		
		function getMsgNum(){
		    $.ajax({
		        url:'PollingMsgServlet',
		        type:'post',
		        dataType:'json',
		        success:function(data){
		            if(data && data.msgNum){
		                $("#msgNum").html(data.msgNum);
		
		                $("#title").html(data.msg.title);
		                $("#content").html(data.msg.content);
		            } 
		        }
		    });
		}
		
	</script>
	
  </head>
	  <body>
		<div>
		  您有<span id="msgNum" style="color: red;">0</span>条消息!
		</div>
		<div>
		    <p id="title">title</p>
		    <p id="content">content</p>
		</div>
	  </body>
</html>






