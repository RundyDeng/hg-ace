<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath }/static/Validform_v5.3.2/style.css" />
<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery-ui.css" />


<style>
.has-success .control-label{
	color: #5cb85c;
}

.form-inline .control-label {
	margin-bottom: 0;
	vertical-align: middle;
}

.has-success .form-control-success {
	background:
		url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNoZWNrIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDYxMiA3OTIiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDYxMiA3OTIiIHhtbDpzcGFjZT0icHJlc2VydmUiPjxwYXRoIGZpbGw9IiM1Q0I4NUMiIGQ9Ik0yMzMuOCw2MTAuMWMtMTMuMywwLTI1LjktNi4yLTM0LTE2LjlMOTAuNSw0NDguOEM3Ni4zLDQzMCw4MCw0MDMuMyw5OC44LDM4OS4xYzE4LjgtMTQuMyw0NS41LTEwLjUsNTkuOCw4LjNsNzEuOSw5NWwyMjAuOS0yNTAuNWMxMi41LTIwLDM4LjgtMjYuMSw1OC44LTEzLjZjMjAsMTIuNCwyNi4xLDM4LjcsMTMuNiw1OC44TDI3MCw1OTBjLTcuNCwxMi0yMC4yLDE5LjQtMzQuMywyMC4xQzIzNS4xLDYxMC4xLDIzNC41LDYxMC4xLDIzMy44LDYxMC4xeiIvPjwvc3ZnPg==")
		no-repeat 97% /18px !important;
}
.has-error .form-control-error {
    background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNyb3NzIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDYxMiA3OTIiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDYxMiA3OTIiIHhtbDpzcGFjZT0icHJlc2VydmUiPjxwYXRoIGZpbGw9IiNEOTUzNEYiIGQ9Ik00NDcsNTQ0LjRjLTE0LjQsMTQuNC0zNy42LDE0LjQtNTEuOSwwTDMwNiw0NTEuN2wtODkuMSw5Mi43Yy0xNC40LDE0LjQtMzcuNiwxNC40LTUxLjksMGMtMTQuNC0xNC40LTE0LjQtMzcuNiwwLTUxLjlsOTIuNC05Ni40TDE2NSwyOTkuNmMtMTQuNC0xNC40LTE0LjQtMzcuNiwwLTUxLjlzMzcuNi0xNC40LDUxLjksMGw4OS4yLDkyLjdsODkuMS05Mi43YzE0LjQtMTQuNCwzNy42LTE0LjQsNTEuOSwwYzE0LjQsMTQuNCwxNC40LDM3LjYsMCw1MS45TDM1NC43LDM5Nmw5Mi40LDk2LjRDNDYxLjQsNTA2LjgsNDYxLjQsNTMwLDQ0Nyw1NDQuNHoiLz48L3N2Zz4=)
     no-repeat 97% /18px !important;
}

.form-control-success, .form-control-warning, .form-control-error {
	padding-right: 2.25rem !important;
	background-repeat: no-repeat !important;
	background-position: center right .59375rem !important;
	-webkit-background-size: 1.54375rem 1.54375rem !important;
	background-size: 1.54375rem 1.54375rem !important;
}

input[type="text"] {
	border-radius: .25rem !important;
	padding: .375rem .75rem;
}

.form-control {
	display: block;
	width: 100%;
	padding: .375rem .75rem;
	font-size: 1rem;
	line-height: 1.5;
	color: #55595c;
	background-color: #fff;
	background-image: none;
	border: .0625rem solid #ccc;
}

.page-content-area * {
	/* box-sizing: border-box; */
	/* box-sizing: content-box; */
	
}

.page-content-area .input-group .input-group-addon {
	border-radius: 4px !important;
	border-top-right-radius: 0 !important;
	border-bottom-right-radius: 0 !important;
}

.page-content-area input .form-control {
	border-radius: 4px !important;
	border-top-left-radius: 0 !important;
	border-bottom-left-radius: 0 !important;
}

.page-content-area input[type="text"] {
	border-radius: .25rem !important;
	padding: .375rem .75rem;
	height: 4rem;
	text-align: center;
}

.page-content-area div .input-group-addon {
	width: 230px;
}

.page-content-area .form-group {
	margin-bottom: 5px;
}

.page-content-area .card {
	border-radius: 4px;
	box-shadow: 0 4px 5px rgba(0, 0, 0, 0.05), 0 0 0 1px
		rgba(63, 63, 68, 0.1);
	background-color: #FFFFFF;
	margin-bottom: 30px;
	margin-top: 15px;
}

.page-content-area form {
	padding: 30px 0px;
}
</style>

<div class="alert alert-success" role="alert" style="position: absolute;left: 20%;top: 73%;z-index: 100;display:none;">
  <strong>保存成功！</strong> 参数故障设置成功！
</div>
<div class="alert alert-danger" role="alert" style="position: absolute;left: 20%;top: 73%;z-index: 100;display:none;">
  <strong>保存失败！</strong> 参数故障设置失败！
</div>
<!-- <div class="container-fluid">
	<form action="">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):</label>
				<input type="text" class="form-control form-control-success"
					id="inputSuccess1">
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):
					success</label> <input type="text"
					class="form-control form-control-success" id="inputSuccess1">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):</label>
				<input type="text" class="form-control form-control-success"
					id="inputSuccess1">
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):
					success</label> <input type="text"
					class="form-control form-control-success" id="inputSuccess1">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):</label>
				<input type="text" class="form-control form-control-success"
					id="inputSuccess1">
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):
					success</label> <input type="text"
					class="form-control form-control-success" id="inputSuccess1">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):</label>
				<input type="text" class="form-control form-control-success"
					id="inputSuccess1">
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):
					success</label> <input type="text"
					class="form-control form-control-success" id="inputSuccess1">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):</label>
				<input type="text" class="form-control form-control-success"
					id="inputSuccess1">
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-4 form-group has-success">
				<label class="control-label" for="inputSuccess1">瞬时流量合理上限值(m3/h):
					success</label> <input type="text"
					class="form-control form-control-success" id="inputSuccess1">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row">
			<div class="col-sm-offset-5">
				<button type="submit" class="btn btn-secondary">保存</button>
			</div>
		</div>
	</form>
</div> -->

<div class="container-fluid">
	<div class="card">
		<form id="setfaultparam" action="${contextPath}/warningmanage/setfaultparamforwarncontr/updatesetfaultpara">
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">非法用热瞬时流量上限值(m3/h):</div>
						<input type="text" class="form-control form-control-success" name="ffmeterssllmax" 
						 id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">非法用热瞬时流量下限值(m3/h):</div>
						<input type="text" class="form-control form-control-success" name="ffmeterssllmin" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">供水温度合理上限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="jswdmax" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">供水温度合理下限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="jswdmin" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">回水温度合理上限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="hswdmax" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">回水温度合理下限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="hswdmin" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">温差合理上限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="wcmax" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">温差合理下限值(℃):</div>
						<input type="text" class="form-control form-control-success" name="wcmin" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">瞬时流量合理上限值(m3/h):</div>
						<input type="text" class="form-control form-control-success" name="meterssllmax" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">瞬时流量合理下限值(m3/h):</div>
						<input type="text" class="form-control form-control-success" name="meterssllmin" 
							id="exampleInputAmount" placeholder="" datatype="n1-10" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-md-1"></div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">报警开始日期:</div>
						<input type="text" class="form-control form-control-success"
							 id="input_sel_date" readonly="readonly" name="sdate" 
							placeholder="" datatype="*1-100" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-5 form-group">
					<div class="input-group">
						<div class="input-group-addon">报警结束日期:</div>
						<input type="text" class="form-control form-control-success"
							 id="input_sel_date2" readonly="readonly" name="edate" 
							placeholder="" datatype="*1-100" errormsg="请输入数字！" nullmsg="不能为空！">
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="col-md-offset-5" style="margin-top: 20px;">
					<button type="submit" class="btn btn-secondary" id="setfaultsave"
						style="border-radius: 4px">保存</button>
				</div>
			</div>
		</form>

	</div>
</div>
<script>
	var scripts = ["${contextPath}/static/assets/js/jquery-ui.js",'${contextPath}/static/Validform_v5.3.2/Validform_v5.3.2.js']

	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		$("#input_sel_date").datepicker({
			dateFormat : 'yy-mm-dd',
		});

		$("#input_sel_date2").datepicker({
			dateFormat : 'yy-mm-dd',
		});
		
		$.get('${contextPath}/warningmanage/setfaultparamforwarncontr/getsetfaultpara',function(data){
			var obj = jQuery.parseJSON(data);
			$('#setfaultparam').zqFormReset(obj);
		})
		
		
		$('#setfaultparam').Validform({
			btnSubmit:"#setfaultsave", 
   			ajaxPost: true,
   			postonce: true,
   			showAllError: false,
   			tiptype:function(msg,o,cssctl){
   				if(!o.obj.is("form")){
   					//$('#exampleInputAmount')[0].outerHTML
   					//$('#exampleInputAmount').outerHTML
   					var thisObj = $(o.obj).parent().parent();
   					if(o.type==2){
   						$(o.obj).removeClass("form-control-error");
   						thisObj.removeClass("has-error");
   						$(o.obj).addClass("form-control-success");
   						thisObj.addClass("has-success");
   					}else{
   						$(o.obj).addClass("form-control-error");
   						thisObj.addClass("has-error");
   						$(o.obj).removeClass("form-control-success");
   						thisObj.removeClass("has-success");
   					}
   					
   				}	
   			},
   			beforeSubmit:function(curform){
   				$('#warning-setting').Validform();
   			},
   			callback:function(data){
   				var flag = typeof data;
   				var $al = $('.alert-success');
   				console.log(flag)
   				if(flag=='boolean'){
   					$('.alert-danger').hide();
   					$al.slideDown("slow");
   					setTimeout("$('.alert-success').slideUp('slow')",3000);
     	   		}else{
     	   			$('.alert-danger').slideDown("slow");
     	   		}
   			}
   		})
		
	});
</script>