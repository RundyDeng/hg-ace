<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page import="core.util.MathUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<script src="${contextPath}/static/assets/js/jquery.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="${contextPath}/static/assets/fromNet/base.css" />


<html>
<head>
<title>住户详细信息</title>
</head>
<body
	style='background-image: url(""); background-color: rgb(255, 255, 255); height: 100%;'>
	<div class="box">
		<div class="tit">
			<h3 class="icon4">换表记录</h3>
		</div>
		<div class="con">
			<table class="table table" width="100%" cellpadding="0"
				cellspacing="0">
				<tbody>
					<tr>
						<th>住户号： <input name="tbName" id="tbName" class="input"
							enablemultistyle="true" type="text" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')">
						</th>
						<td><input name="Button16" value="查  询" id="Button16"
							class="button2" onmouseover="this.className='button2over'"
							onmouseout="this.className='button2'" type="button" onClick="openHis();">
							&nbsp;<!-- <input name="btnOutput" value="导出到Excel" id="btnOutput"
							class="button2" onmouseover="this.className='button2over'"
							onmouseout="this.className='button2'" type="submit"> --></td>
					</tr>

					<tr>
						<td colspan="2">
							<div>
								<table rules="all" id="GridView1"
									style="border-color: #C8D1D0; width: 100%; border-collapse: collapse;"
									border="1" cellspacing="0">
									<tbody>
										<tr>
											<th scope="col">序号</th>
											<th scope="col">用户编码</th>
											<th scope="col">记录人</th>
											<th scope="col">前表号</th>
											<th scope="col">前读数</th>
											<th scope="col">后表号</th>
											<th scope="col">后读数</th>
											<th scope="col">日期</th>
											<th scope="col">操作</th>
										</tr>
										
										<c:forEach var="obj" items="${list}" varStatus="num">
											<tr>
												<td>${num.index +1 }</td>
												<td>${obj.USERCODE }</td>
												<td>${obj.USERNAME }</td>
												<td>${obj.PROMETERID }</td>
												<td>${obj.PRODUSHU }</td>
												<td>${obj.METERID }</td>
												<td>${obj.DISHU }</td>
												<td>${obj.DDATE }</td>
												<td><a
													href="javascript:openDetail('${CLIENTID }')">住户详细</a>
												</td>
											</tr>
										</c:forEach>
										
									
									</tbody>
								</table>
							</div>




							<div></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<script type="text/javascript">
	function openDetail(val){
		myWindow=window.open('${contextPath}/baseinfomanage/clientinfo/clientDetail?CLIENTID='+val,'点击打开详情','width=800,height=500')
		
		myWindow.focus();

	}
	function openHis(){
		var clientno = $('#tbName').val();
		 var reg = /^\d+$/;
		 if (!clientno.match(reg)){
		        alert('请输入数字！');
		        return;
		    }else{    
		    	
		    }    
		/* if(clientno==''){
			alert('请输入数字！')
			return ;
		} */
		document.location.href='${contextPath}/baseinfomanage/clientinfo/changeMeterHistoryClientNO?CLIENTNO='+clientno;
		
	}
	</script>