<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<div class="container-fluid" style="background-color: #f7f7f9;">
		<form>
			<fieldset class="form-group">
				<legend>选择数据表</legend>
				<select id="chot-sel" multiple class="form-control" style="width: 310px;">
					<option value="">表一（2018-2019年度）</option>
					<!-- <option>表二（2014-2015年度）</option> -->
					<option value="2013">表二（2017-2018年度）</option> <!-- 2013/10/1   2014/9/30 -->
					<option value="2012">表三（2016-2017年度）</option>
					<option value="2011">表四（2015-2016年度）</option>
					<option value="2010">表五（2014-2015年度）</option>
				</select>
			</fieldset>
			
			<button type="button" id="choose-table" class="btn btn-primary">保存</button>
		</form>
</div>

<script>
$('.page-content-area').ace_ajax('loadScripts', [], function() {
	$('#choose-table').click(function(){
		$.get('${contextPath}/sys/chooseTableContr/updateChooseTable?tab=' + $('#chot-sel').val(),function(response){
			if(response==1)
				alert("设置成功！");
		});
	});
});
</script>