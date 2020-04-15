<%@page import="java.util.Map"%>
<%@ page import="core.util.MathUtils" %> 
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<script src="${contextPath}/static/assets/js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet"
	href="${contextPath}/static/assets/fromNet/base.css" />


<html>
<head>
<title>住户详细信息</title>
</head>
<body style='background-image: url(""); background-color: rgb(255, 255, 255); height: 100%;'>
<div class="list">
                    <div class="item">
                        <div class="box">
                            <div class="tit">
                                <h3 class="icon4">
                                    住户信息编辑记录</h3>
                            </div>
                            <div class="con">
                                <table class="table table" cellpadding="0" cellspacing="0" width="100%">
                                    <tbody><tr>
                                        <th colspan="2" align="left" height="25px">
                                            请选择条件查询：
                                        </th>
                                    </tr>
                                    </tbody><caption>
                                        <br>
                                        
                                        </caption><tbody><tr>
                                            <td height="25px">
                                                <input id="RadioButton1" name="group001" value="RadioButton1" type="radio"><label for="RadioButton1">按住户号查询</label>
                                                &nbsp;&nbsp;
                                                <input name="TextBox1" id="TextBox1" class="input" enablemultistyle="true" type="text">
                                                &nbsp; &nbsp;&nbsp;&nbsp;
                                                <input id="RadioButton3" name="group001" value="RadioButton3" type="radio"><label for="RadioButton3">按记录人查询</label>
                                                &nbsp;&nbsp;
                                                <input name="TextBox3" id="TextBox3" class="input" enablemultistyle="true" type="text">
                                                &nbsp; &nbsp;&nbsp;&nbsp;
                                                <input id="RadioButton2" name="group001" value="RadioButton2" type="radio"><label for="RadioButton2">按姓名查询</label>
                                                &nbsp;&nbsp;
                                                <input name="TextBox2" id="TextBox2" class="input" enablemultistyle="true" type="text">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="25px">
                                                <input id="RadioButton4" name="group001" value="RadioButton4" type="radio"><label for="RadioButton4">按备注查询</label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input name="TextBox4" id="TextBox4" class="input" enablemultistyle="true" type="text">
                                                 &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 开始时间&nbsp;
                                                <input name="startdate" id="startdate" class="Wdate" onfocus="WdatePicker({skin:'whyGreen',firstDayOfWeek:1})" style="width: 120px" value="2016-04-12" type="text">
                                                 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间 &nbsp;
                                                <input name="enddate" id="enddate" class="Wdate" onfocus="WdatePicker({skin:'whyGreen',firstDayOfWeek:1})" style="width: 120px" value="2016-05-12" type="text">
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                                <input name="Button16" value="查  询" id="Button16" class="button2" onmouseover="this.className='button2over'" onmouseout="this.className='button2'" type="submit">
                                                &nbsp;<input name="btnOutput" value="导出到Excel" id="btnOutput" class="button2" onmouseover="this.className='button2over'" onmouseout="this.className='button2'" type="submit">
                                                &nbsp;<!-- <input name="btnprv" value="返回上一页" id="btnprv" class="button2" onmouseover="this.className='button2over'" onmouseout="this.className='button2'" type="submit"> -->
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div>
		<table class="table table" mouseovercssclass=".table .hover" selectedcssclass="tdbgselected" id="GridView1" style="width:100%;" border="0" cellpadding="0" cellspacing="1">
			<tbody><tr class=".table th" style="height:25px;white-space:nowrap;" align="center">
				<th scope="col">序号</th><th scope="col">用户编码</th><th scope="col">姓名</th><th scope="col">记录人</th><th scope="col">日期</th><th scope="col">备注</th><th scope="col">操作</th>
			</tr><tr class="tdbg" align="center">
				<td>
                                                                1
                                                            </td><td>50001</td><td>董久光</td><td>szhg</td><td style="white-space:nowrap;">2016-5-6 10:48:47</td><td>成功修改住户数据！内容：,手机:124，地址：1栋1单元2层201号</td><td>
                                                                <a href="javascript:ViewData('ClientView.aspx?id=50001')">
                                                                住户详细</a>
                                                            </td>
			</tr><tr class="tdbg" align="center">
				<td>
                                                                2
                                                            </td><td>50001</td><td>董久光</td><td>szhg</td><td style="white-space:nowrap;">2016-5-6 10:48:27</td><td>成功修改住户数据！内容：，地址：1栋1单元2层201号</td><td>
                                                                <a href="javascript:ViewData('ClientView.aspx?id=50001')">
                                                                住户详细</a>
                                                            </td>
			</tr>
		</tbody></table>
	</div>
                                                

	
                                                
                                            </td>
                                        </tr>
                                    
                                </tbody></table>
                            </div>
                            <div style="clear: both">
                            </div>
                        </div>
                    </div>
                </div>
</body>
</html>

<script>
	
</script>