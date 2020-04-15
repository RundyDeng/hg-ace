<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<script src="${contextPath }/static/pages/js/baseinfomanage/setmeterfailure.js"></script>

<div class="row">
	<div class="col-xs-12">

		<div id="da-search"></div>

		<table id="grid-table"></table>

		<div id="grid-pager" style="display:none;"></div>

	</div>
</div>
