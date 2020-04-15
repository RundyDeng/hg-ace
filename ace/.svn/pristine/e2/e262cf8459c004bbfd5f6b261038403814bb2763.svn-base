<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet"
	href="${contextPath}/static/assets/css/jquery.gritter.css" />

<div class="tab-content no-border no-padding">
	<div id="id-message-new-navbar" class="message-navbar clearfix" style="height:50px;">
		<div class="message-bar">
			<font>文件上传</font>
		</div>
	</div>


	<div class="message-container">
		<form id="id-message-form" class="form-horizontal message-form col-xs-12" method="POST">
			<!-- #section:pages/inbox.compose -->
			<div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right"
						for="form-field-recipient-zq">资料名称:</label>

					<div class="col-sm-6 col-xs-12">
						<div class="input-icon block col-xs-12 no-padding">
							<input type="text" class="col-xs-12" name="upFileName"
								id="form-field-recipient-zq" placeholder="文件名" />
								<i class="ace-icon fa fa-file"></i>
						</div>
					</div>
					<div class="col-sm-1"></div>
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right"
						for="form-field-subject-zq">资料类型:</label>

					<div class="col-sm-6 col-xs-12">
						<div class="input-icon block col-xs-12 no-padding">
							<input maxlength="100" type="text" class="col-xs-12"
								name="fileType" id="form-field-subject-zq" placeholder="类型" disabled="disabled" /><i
								class="ace-icon fa fa-tags"></i>
						</div>
					</div>
					<div class="col-sm-1"></div>
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right"> <span
						class="inline space-24 hidden-480"></span> 
						资料描述:
					</label>

					<!-- #section:plugins/editor.wysiwyg -->
					<div class="col-sm-6 col-xs-12">
						<!-- <div class="wysiwyg-editor"></div> -->
						<div  class="wysiwyg-editor" id="fileClasses" contenteditable="true" ></div>
					</div>
					<!-- /section:plugins/editor.wysiwyg -->
					<div class="col-sm-1"></div>
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group no-margin-bottom">
					<label class="col-sm-2 control-label no-padding-right">附件:</label>

					<div class="col-sm-6">
						<div id="form-attachments">
							<!-- #section:custom/file-input -->
							<input type="file" name="attachment[]" />
							<!-- /section:custom/file-input -->
						</div>
						<div id="form-attachments-tip"></div>
					</div>
					<div class="col-sm-4"></div>
				</div>

				<div class="col-sm-10">
					<div class="align-right">
						<!-- 
					<button id="id-add-attachment" type="button" class="btn btn-sm btn-danger">
						<i class="ace-icon fa fa-paperclip bigger-140"></i>
						添加附件
					</button>
					-->
						<button id="id-submit-attachment" type="submit"
							class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-paperclip bigger-140"></i> 提交附件
						</button>
					</div>
				</div>
				<div class="col-sm-1"></div>

			</div>

			<div class="space"></div>
			<div id="form-field-attachmentpaths" style="display: none;"></div>
		</form>
	</div>
	<!-- /section:pages/inbox.compose -->
	
</div>


<script type="text/javascript">
	var scripts = [null,"${contextPath}/static/assets/js/bootstrap-tag.js"
	               ,"${contextPath}/static/assets/js/jquery.hotkeys.js"
	               ,"${contextPath}/static/assets/js/bootstrap-wysiwyg.js"
	               ,"${contextPath}/static/assets/js/jquery.gritter.js",null]
	          
	$(".page-content-area").ace_ajax("loadScripts", scripts, function() {
	  	
	});
</script>

<script type="text/javascript">
	jQuery(function($) {
		var $form = $("#id-message-form");
		// you can have multiple files, or a file input with "multiple" attribute
		var file_input = $form.find("input[type=file]");
		var upload_in_progress = false;
		//  /ace/static/assets/js/ace/elements.fileinput.js
		file_input.ace_file_input({
			//style : "well",zz
			btn_choose : "选择或拖拽上传",
			btn_change : "变更文件",
			droppable : true,
			thumbnail : "large",
			maxSize : 20971520,// bytes
			//allowExt : [ "jpeg", "jpg", "png", "gif" ],
			//allowMime : [ "image/jpg", "image/jpeg", "image/png", "image/gif" ],
			denyExt :  ["exe"],
			before_remove : function() {
				if (upload_in_progress)
					return false;// if we are in the middle of uploading a file, don"t allow resetting file input
				return true;
			},
			preview_error : function(filename, code) {
				// code = 1 means file load error
				// code = 2 image load error (possibly file is not an image)
				// code = 3 preview failed
			}
		});
		//非回调
		file_input.on("file.error.ace", function(ev, info) {
			if (info.error_count["ext"] || info.error_count["mime"])
				$.gritter.add({
	                title: "系统信息",
	                text: "文件格式不正确！不能上传可执行文件！",
	                class_name: "gritter-warning gritter-center"
	            });
			if (info.error_count["size"])
				$.gritter.add({
	                title: "系统信息",
	                text: "文件大小不能超过20mb！",
	                class_name: "gritter-warning gritter-center"
	            });
			// you can reset previous selection on error
			// ev.preventDefault();
			// file_input.ace_file_input("reset_input");
		});
		var ie_timeout = null;// a time for old browsers uploading via iframe
		$form.on("submit", function(e) {
			e.preventDefault();
			var files = file_input.data("ace_input_files");
			if (!files || files.length == 0)
				return false;// no files selected
			var deferred;
			if ("FormData" in window) {
				// for modern browsers that support FormData and uploading files via ajax we can do >>> var formData_object = new FormData($form[0]);
				// but IE10 has a problem with that and throws an exception and also browser adds and uploads all selected files, not the filtered ones. and drag&dropped files won"t be uploaded as well
				// so we change it to the following to upload only our filtered files and to bypass IE10"s error and to include drag&dropped files as well
				formData_object = new FormData();// create empty FormData object
				/**
				$.each($form.serializeArray(), function(i, item) {// serialize our form (which excludes file inputs)
					formData_object.append(item.name, item.value);// add them one by one to our FormData
				});
				**/
				// and then add files
				$form.find("input[type=file]").each(function() {
					var field_name = $(this).attr("name");
					// for fields with "multiple" file support, field name should be something like `myfile[]`
					var files = $(this).data("ace_input_files");
					if (files && files.length > 0) {
						for (var f = 0; f < files.length; f++) {
							formData_object.append(field_name, files[f]);
						}
					}
				});
                formData_object.append("upFileName",$('#form-field-recipient-zq').val());
                formData_object.append("fileType",$('#form-field-subject-zq').val());
                formData_object.append("fileClasses",$('#fileClasses').html());
				upload_in_progress = true;
				file_input.ace_file_input("loading", true);
				deferred = $.ajax({
					url : "${contextPath}/filetransmit/fileuploadcontr/updateFileUpload",
					type : $form.attr("method"),
					processData : false,// important
					contentType : false,// important
					dataType : "json",
					data : formData_object,
					xhr : function() {
						var req = $.ajaxSettings.xhr();
						if (req && req.upload) {
							req.upload.addEventListener("progress", function(e) {
								if (e.lengthComputable) {
									var done = e.loaded || e.position, total = e.total || e.totalSize;
									var percent = parseInt((done / total) * 100) + "%";
								}
							}, false);
						}
						return req;
					},
					beforeSend : function() {
					},
					success : function() {
					}
				})
			} else {
				// for older browsers that don"t support FormData and uploading files via ajax.we use an iframe to upload the form(file) without leaving the page
				deferred = new $.Deferred; // create a custom deferred object
				var temporary_iframe_id = "temporary-iframe-" + (new Date()).getTime() + "-" + (parseInt(Math.random() * 1000));
				var temp_iframe = $("<iframe id='" + temporary_iframe_id + "' name='" + temporary_iframe_id + "' frameborder='0' width='0' height='0' src='about:blank' style='position:absolute; z-index:-1; visibility: hidden;'></iframe>").insertAfter($form);
				$form.append("<input type='hidden' name='temporary-iframe-id' value='" + temporary_iframe_id + "' />");
				temp_iframe.data("deferrer", deferred);
				// we save the deferred object to the iframe and in our server side response.we use "temporary-iframe-id" to access iframe and its deferred object
				$form.attr({
					method : "POST",
					enctype : "multipart/form-data",
					target : temporary_iframe_id
				});
				upload_in_progress = true;
				file_input.ace_file_input("loading", true);// display an overlay with loading icon
				$form.get(0).submit();
				// if we don"t receive a response after 30 seconds, let"s declare it as failed!
				ie_timeout = setTimeout(function() {
					ie_timeout = null;
					temp_iframe.attr("src", "about:blank").remove();
					deferred.reject({
						"status" : "fail",
						"message" : "Timeout!"
					});
				}, 30000);
			}
			// deferred callbacks, triggered by both ajax and iframe solution
			deferred.done(function(result) {// success
				alert('上传成功!');
				var res = result;//the `result` is formatted by your server side response and is arbitrary
				if(res.status == "OK"){
					$("#form-attachments-tip").append(res.originalFilename+" ");
					$("#form-field-attachmentpaths").append(res.url+",");
				}
			}).fail(function(result) {// failure
				alert("上传失败！");
			}).always(function() {// called on both success and failure
				if (ie_timeout)
					clearTimeout(ie_timeout)
				ie_timeout = null;
				upload_in_progress = false;
				file_input.ace_file_input("loading", false);
			});
			deferred.promise();
		});
		// when "reset" button of form is hit, file field will be reset, but the custom UI won"t.so you should reset the ui on your own
		$form.on("reset", function() {
			$(this).find("input[type=file]").ace_file_input("reset_input_ui");
		});
		if (location.protocol == "file:")
			alert("For uploading to server, you should access this page using 'http' protocal, i.e. via a webserver.");
	});
</script>
