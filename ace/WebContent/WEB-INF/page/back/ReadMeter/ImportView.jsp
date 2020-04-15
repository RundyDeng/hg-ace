<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery.gritter.css" />
	
 

<div align="left"> 
 <h3> 批量数据导入操作:</h3>
    <form action="${contextPath}/readmeter/importdata/loanData" method="POST" enctype="multipart/form-data" onsubmit="return saveReport();">  
        <table class="table" id="queryCondition"  style="width:50%">
            <tbody class="tbd">
            <tr>
                <td align="left" style="padding-right: 2px">
                    <input type="file" name="myfiles" id="myfiles" style="display: none;" onchange="document.getElementById('filePath').value=this.value">
                    <div class="input-group" >
                        <input type="text" name="filePath" id="filePath" class="form-control" > 
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-sm btn-info blue" id="btn_check">
                                <i class="icon-edit">请选择文件</i>
                            </button>
                        </span>
                  </div>
                </td>
                
                <td align="left" style="padding-left: 2px">
                    <button type="submit" class="btn btn-sm btn-info blue" id="uploadexcel">
                        <i class="upload-icon icon-cloud-upload bigger-110">导  入</i>
                    </button>
                </td> 
                
            </tr>
            </tbody>
        </table>
    </form>
    <form id="showDataForm"></form>
  </div>
  
 </br>
 </br> 
<div class="Description">
	说明：<br />
	1，批量导入时注意表格格式一致。<br />
	2，导入成功后查询当日数据显示。<br />
</div>
<script type="text/javascript">
var scripts = [null,"${contextPath}/static/assets/js/bootstrap-tag.js"
               ,"${contextPath}/static/assets/js/jquery.hotkeys.js"
               ,"${contextPath}/static/assets/js/bootstrap-wysiwyg.js"
               ,"${contextPath}/static/assets/js/jquery.gritter.js",null];
	
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {	
	  $('#btn_check').click(function() {
		  $('#myfiles').trigger('click');
      });
      $("#filePath").click(function() {
    	  $("#myfiles").trigger('click');
      });
      
      function saveReport(){ 
    	/* // jquery 表单提交  */
    	$("#showDataForm").ajaxSubmit(function(message) { 
    	if(message==true){
    		alert("上传成功");
    	}
    	}); 
    	return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转 
    } 
	
});

</script>

