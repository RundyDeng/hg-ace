<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<script src="${contextPath }/static/pages/js/baseinfomanage/setarea.js"></script>



<div class="row">
	<div class="col-xs-12">
		<div class="list" id="can">
			<div class="item">
				<div class="box">
					<div class="row">
						<div class="col-md-5" style="padding-left: 19px;"><h4>小区选择</h4></div>
						<div class="col-md-7" style="padding-top: 10px;">
							<!-- <div title="返回上一页" style="cursor:pointer;" onClick="javascript:history.back();" >
								<div class="ui-pg-div"><span class="ui-icon ace-icon fa fa-long-arrow-left"></span>返回</div>
							</div> -->
						</div>
					</div>
					<div class="con" style="width:100px;">
						<table class="table table" cellpadding="0" cellspacing="1">
							<tbody>
							
								<tr>
									<th>分公司列表：</th>
									<th>&gt;&gt;</th>
									<th>热力站列表</th>
									<th>&gt;&gt;</th>
									<th>小区列表（点击选择）：</th>
								</tr>
								<tr>
									<td id="selEnergyFactory" style="padding: 0px;">
										<!-- EnergyFactory公司信息表，用于存储公司基础信息 --> <select size="4"
										name="lbEnergyFactory" onClick="getHeatingStation(this);"
										id="lbEnergyFactory" style="height: 200px; width: 180px;">
									</select>
									</td>
									<td style="padding-top: 90px;">&gt;&gt;</td>
									<td style="padding: 0px;"><select size="4" name="lbhot"
										onClick="getResidenceCommunity(this);" id="lbhot"
										style="height: 200px; width: 180px;">
									</select></td >
									<td style="padding-top: 90px;">&gt;&gt;</td>
									<td style="padding: 0px;">
										<select size="4" name="lbFactorySection"
											onClick="commitSetting(this)" id="lbFactorySection" 
											style="height: 200px; width: 180px;">
										</select>
									</td>
								</tr>
	
	
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>


