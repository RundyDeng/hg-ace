<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>


<!doctype html>  
<html>  
<head>  
    <meta charset="utf-8">  
    <title>xx信息查询</title>  
    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>  
    <script type="text/javascript" src="/js/ai/ai-lib.js"></script>  
    <script src="/js/cheat-order.js"></script> 
    
  <style type="text/css">
		.table-bordered, .table-bordered td, .table-bordered th{
			border: 1px solid #c6cbce;
		}
		tbody th{
			font-weight: unset;
		}
		</style>      
</head>  
  
<body>  
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" /> 模板管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align=center valign=middle id=TableTitle>
            	<td width="250px">模板名称</td>
				<td width="250px">所用流程</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer" datakey="documentTemplateList">
        	<s:iterator value="#ftList">
				<tr class="TableDetail1 template">
						<td><s:property value="name"/></td>
						<td><s:property value="processKey"/></td>
						<td><a onClick="return delConfirm()" href="#">删除</a>
							<a href="saveUI.html">修改</a>
							<s:a action="formTemplateAction_download.action?ftid=%{ftid}">下载</s:a>
						</td>
				</tr>
			</s:iterator>
        </tbody>
    </table>

<div class="Description">
	说明：<br />
	1，模板文件是扩展名的文件（.xls.rd文档）。<br />
	2，如果是添加：必须要选择模板文件。<br />
	3，如果是修改：只是在 需要更新模板文件时 才选择一个文件。
</div>
</body>  
</html>  


<script>

</script> 
