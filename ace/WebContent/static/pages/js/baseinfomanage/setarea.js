$('.page-content-area').ace_ajax('loadScripts', [], function() {
	var select_company = "#lbEnergyFactory";
	$.get($path_base + '/baseinfomanage/setarea/getEnergyFactory',
			function(data) {
				var dom = '';
				for (ea in data){
					if (ea == 0)
						dom += '<option  value="'+data[ea]['FACTORYID']+'">'
								+ data[ea]['FACTORYNAME'] + '</option>';
					else
						dom += '<option value="'+data[ea]['FACTORYID']+'">'
								+ data[ea]['FACTORYNAME'] + '</option>';
				}
				$(select_company).append(dom);
			}, 'json');
});

var commitSetting = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	_J_setAreaGuid(sel.value,$(sel).find('option[value="'+sel.value+'"]').html());
	$.ajax({
			url : $path_base + "/baseinfomanage/setarea/bindArea?areaguids=" + sel.value,
			type : 'Post',
			async: false,
			dataType : 'string',
			complete : function(response) {
				if(response.responseText==1){
					 _go_back = '<td title="返回上一页" onClick="javascript:history.back();" class="ui-pg-button ui-corner-all toppager-back">'
						+'<div class="ui-pg-div"><span class="'+_fa_icon+'"></span>返回</div></td>'
						+'<td class="area-info">默认小区:'+_default_status_areaname+'</td>';
				confirm	("小区列表设置OK，请点击确认");
						
			//	window.location.href= $path_base + "/sys/sysuser/home"
			//	window.location.href="${contextPath }/sys/sysuser/home#page/areainfo";
				}else
				alert("小区设置失败！");
			}
		});
	
};

var getHeatingStation = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	$.get($path_base + '/baseinfomanage/setarea/getHeatingStation?FACTORYID= ' + sel.value,
			function(data) {
				var dom = '';
				for (ea in data) {
					if (ea == 0)
						dom += '<option  value="'+data[ea]['SECTIONID']+'">'
								+ data[ea]['SECTIONNAME'] + '</option>';
					else
						dom += '<option value="'+data[ea]['SECTIONID']+'">'
								+ data[ea]['SECTIONNAME'] + '</option>';
				}
				$('#lbhot').empty().append(dom)
			}, 'json');
};

var getResidenceCommunity = function(sel){
	if(sel.value==''||sel.value==undefined) return;
	$.get($path_base + '/baseinfomanage/setarea/getResidenceCommunity?SECTIONID=' + sel.value,
			function(data) {
				var dom = '';
				for (ea in data) {
					if (ea == 0)
						dom += '<option  value="'+data[ea]['AREAGUID']+'">'
								+ data[ea]['AREANAME']
								+ '</option>';
					else
						dom += '<option value="'+data[ea]['AREAGUID']+'">'
									+ data[ea]['AREANAME']
								+ '</option>';
				}
				$('#lbFactorySection').empty().append(dom)
			}, 'json');
};

