var _areaguid,_buildno,_unitno,_floorno,_doorno;
		
		var building = function(obj){
			emptyVal()
			_areaguid = obj.value;
			if(_areaguid==''||_areaguid=='null'){
				    emptyAndReset($('#build'));	        	        					    
	     		    emptyAndReset($('#unit'));
				    emptyAndReset($('#floor'));
				    emptyAndReset($('#door')); 
				    return;
			}
				
			$.get($path_base + '/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
			          }
			       }
			    var sel = $('#build');
			    emptyAndReset(sel);	        	        					    
     		    emptyAndReset($('#unit'));
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door')); 
			    sel.append(s);  
			});
		};

		var uniting = function(obj){
			emptyVal()
			_buildno = obj.value;
			if(_buildno==''){
				      	        					    
	     		    emptyAndReset($('#unit'));
				    emptyAndReset($('#floor'));
				    emptyAndReset($('#door')); 
				    return;
			}
			$.get($path_base + '/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno, function(data){
				
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['UCODE'] + '">' + ri['UCODE'] + '单元</option>';
			          }
			       }
			    var sel =  $("#unit");
			    emptyAndReset(sel);
			    emptyAndReset($('#floor'));
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});
		};
		
		var flooring = function(obj){
			emptyVal()
			_unitno = obj.value;
			if(_unitno=='') {
				
				    emptyAndReset($('#floor'));
				    emptyAndReset($('#door')); 
				    return;
			}
			$.get($path_base + '/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['FLOORNO'] + '">' + ri['FLOORNO'] + '层</option>';
			          }
			       }
			    var sel =  $('#floor');
			    emptyAndReset(sel);
			    emptyAndReset($('#door'));
			    sel.append(s);  
			});    	
		};
		
		var dooring = function(obj){
			emptyVal()
			_floorno = obj.value;
			if(_floorno==''){
				
				    emptyAndReset($('#door')); 
				    return;
			}
			$.get($path_base + '/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['DOORNO'] + '">' + ri['FCODE'] + '</option>';
			          }
			       }
			    var sel =  $('#door');
			    emptyAndReset(sel);	      
			    sel.append(s);  
			});
		};
		
		var oldInfo = function(obj){
			_doorno = obj.value;//门牌
			if(_doorno==''){
			    emptyAndReset($('#TDOOR_METER_METERNO')); 
			    emptyAndReset($('#plan_meterno1')); 
			    return;
			}
			emptyVal();
			$.get($path_base + '/sys/todaydata/getChangeMeterData?AREAGUID='+_areaguid
					+"&BUILDNO="+_buildno+"&UCODE="+_unitno+"&FLOORNO="+_floorno+"&doorno="+_doorno,
					function(data){
						var obj = jQuery.parseJSON(data);
						appendEle(obj,'CLIENTNO');
						appendEle(obj,'TDOOR_METER_METERNO');//旧表号码
						appendEle(obj,'PRODUSHU',0);//换表前底数
						appendEle(obj,'TMODIFYMETER_METERID');//新表号码
						appendEle(obj,'DISHU');//新表底数 comMeterSeq1
						$('#comMeterSeq1').empty().append('<option>'+obj['TDOOR_METER_METERNO']+'</option>');
						$('#plan_meterno2').val(obj['TDOOR_METER_METERNO']);
						$('#ddlBiaoLeiXing option[value="'+obj['DEVICETYPECHILDNO']+'"]').attr('selected',true);
					}
			)
		};
		function emptyVal(){
			$('#CLIENTNO').val('');
			$('#TDOOR_METER_METERNO').val('');
			$('#PRODUSHU').val('');
			$('#TMODIFYMETER_METERID').val('');
			$('#DISHU').val('');
			$('#comMeterSeq1').empty();
			$('#plan_meterno2').empty();
		}

		$(function(){
			$.ajax({
				url : $path_base + '/sys/todaydata/getAreaDownList',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					var response = data;
				      var s = '<option value="">请选择</option>';
				      if (response && response.length) {
				          for (var i = 0, l = response.length; i < l; i++) {
				           var ri = response[i];
				           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
				          }
				       }
				     $('#community').append(s);
				     var areaguid = _J_getAreaGuid();
				     if(areaguid=='null'||areaguid=='')
						return;
				     $('#community option[value="'+areaguid+'"]').attr('selected',true);
				     var obj = [];
				     obj.value=areaguid;
				     building(obj);
				}
			});
			
			$.get($path_base + '/baseinfomanage/meterFaultInfoContr/getMeterFaultInfo',function(response){
				var $data = jQuery.parseJSON(response).rows;
				var strHtml = '<option value="">请选择</option>';
				for(var i=0;i<$data.length;i++){
					var obj = $data[i];
					strHtml += '<option value="'+obj['DEVICECHILDTYPENO']+'">'+obj['DEVICECHILDTYPENAME']+'</option>';
				}
				$('#ddlBiaoLeiXing').empty().append(strHtml);
			})
				
		});
		
		var scripts = [ $path_base + "/static/assets/js/jqGrid/jquery.jqGrid.js", null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() { });
		
//下面部分的选择
var _areaguid2,_buildno2,_unitno2,_floorno2,_doorno2;
		var building2 = function(obj){
			emptyVal2()
			_areaguid2 = obj.value;
			if(_areaguid2==''||_areaguid2=='null'){
				    emptyAndReset( $('#build2'));	        	        					    
	     		    emptyAndReset($('#unit2'));
				    emptyAndReset($('#floor2'));
				    emptyAndReset($('#door2'));
				    return;
			}
				
			$.get($path_base + '/sys/todaydata/getBuildDownList?AREAGUID='+_areaguid2, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['BUILDNO'] + '">' + ri['BUILDNAME'] + '</option>';
			          }
			       }
			    var sel = $('#build2');
			    emptyAndReset(sel);	        	        					    
     		    emptyAndReset($('#unit2'));
			    emptyAndReset($('#floor2'));
			    emptyAndReset($('#door2')); 
			    sel.append(s);  
			});
		};
		var uniting2 = function(obj){
			emptyVal2()
			_buildno2 = obj.value;
			if(_buildno2==''){
				  	        					    
	     		    emptyAndReset($('#unit2'));
				    emptyAndReset($('#floor2'));
				    emptyAndReset($('#door2'));
				    return;
			}
				
			$.get($path_base + '/sys/todaydata/getUnitNODownList?AREAGUID='+_areaguid2
					+"&BUILDNO="+_buildno2, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['UCODE'] + '">' + ri['UCODE'] + '单元</option>';
			          }
			       }
			    var sel =  $("#unit2");
			    emptyAndReset(sel);
			    emptyAndReset($('#floor2'));
			    emptyAndReset($('#door2'));
			    sel.append(s);  
			});
		};
		var flooring2 = function(obj){
			emptyVal2()
			_unitno2 = obj.value;
			if(_unitno2==''){
				
				    emptyAndReset($('#floor2'));
				    emptyAndReset($('#door2'));
				    return;	
			}
			$.get($path_base + '/sys/todaydata/getFloorNoDownList?AREAGUID='+_areaguid2
					+"&BUILDNO="+_buildno2+"&UCODE="+_unitno2, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['FLOORNO'] + '">' + ri['FLOORNO'] + '层</option>';
			          }
			       }
			    var sel =  $('#floor2');
			    emptyAndReset(sel);
			    emptyAndReset($('#door2'));
			    sel.append(s);  
			});    	
		};
		var dooring2 = function(obj){
			emptyVal2()
			_floorno2 = obj.value;
			if(_floorno2==''){
				
				    emptyAndReset($('#door2'));
				    return;
			}
			$.get($path_base + '/sys/todaydata/getDoorNoDownList?AREAGUID='+_areaguid2
					+"&BUILDNO="+_buildno2+"&UCODE="+_unitno2+"&FLOORNO="+_floorno2, function(data){
				var response = jQuery.parseJSON(data);
				var s = ' ';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
			           var ri = response[i];
			           s += '<option value="' + ri['DOORNO'] + '">' + ri['FCODE'] + '</option>';
			          }
			       }
			    var sel =  $('#door2');
			    emptyAndReset(sel);	      
			    sel.append(s);  
			});
		};
		
		var oldInfo2 = function(obj){
			_doorno2 = obj.value;//门牌
			if(_doorno2=='') return;
			emptyVal2();
			$.get($path_base + '/sys/todaydata/getChangeMeterData?AREAGUID='+_areaguid2
					+"&BUILDNO="+_buildno2+"&UCODE="+_unitno2+"&FLOORNO="+_floorno2+"&doorno="+_doorno2,
					function(data){
						var obj = jQuery.parseJSON(data);
						appendEle2(obj,'CLIENTNO');
						appendEle2(obj,'TDOOR_METER_METERNO');//旧表号码
						appendEle2(obj,'PRODUSHU',0);//换表前底数
						appendEle2(obj,'TMODIFYMETER_METERID');//新表号码
						appendEle2(obj,'DISHU');//新表底数 
						$('#comMeterSeq2').empty().append('<option>'+obj['TDOOR_METER_METERNO']+'</option>');
						$('#plan_meterno1').val(obj['TDOOR_METER_METERNO']);
						$('#ddlBiaoLeiXing2 option[value="'+obj['DEVICETYPECHILDNO']+'"]').attr('selected',true);
					}
			)
		};
		function emptyVal2(){
			$('#CLIENTNO2').val('');
			$('#TDOOR_METER_METERNO2').val('');
			$('#PRODUSHU2').val('');
			$('#TMODIFYMETER_METERID2').val('');
			$('#DISHU2').val('');
			$('#comMeterSeq2').empty();
			$('#plan_meterno1').val('');
		}
		 function appendEle2(obj,sel,defa){
			var val = obj[sel];
			if(val=='' || val==null){			
				$('#'+sel+"2").val(defa);	
			}else
			$('#'+sel+"2").val(val);
		} 
	
		$(function(){
			$.ajax({
				url : $path_base + '/sys/todaydata/getAreaDownList',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					var response = data;
				      var s = '<option value="">请选择</option>';
				      if (response && response.length) {
				          for (var i = 0, l = response.length; i < l; i++) {
				           var ri = response[i];
				           
				           s += '<option value="' + ri['AREAGUID'] + '">' + ri['AREANAME'] + '</option>';
				          }
				       }
				     $('#community2').append(s);
				     var areaguid2 = _J_getAreaGuid();
				     if(areaguid2=='null'||areaguid2=='') return;
				     $('#community2 option[value="'+areaguid2+'"]').attr('selected',true);
				     var obj = [];
				     obj.value=areaguid2;
				     building2(obj);
				}
			});
			
			$.get($path_base + '/baseinfomanage/meterFaultInfoContr/getMeterFaultInfo',function(response){
				var $data = jQuery.parseJSON(response).rows;
				var strHtml = '<option value="">请选择</option>';
				for(var i=0;i<$data.length;i++){
					var obj = $data[i];
					strHtml += '<option value="'+obj['DEVICECHILDTYPENO']+'">'+obj['DEVICECHILDTYPENAME']+'</option>';
				}
				$('#ddlBiaoLeiXing2').empty().append(strHtml);
			})
		});

		
 var modifyMeter = function(){
		if($('#TDOOR_METER_METERNO').val()==''||$('#TDOOR_METER_METERNO2').val()==''){//之前的表号
			alert("请先选择一个有热表的用户！");
			return;
		}
		if($('#DISHU').val()==''||$('#DISHU2').val()==''){
			alert("请输入底数！");
			return;
		}
		if($('#TMODIFYMETER_METERID').val()==''||$('#TMODIFYMETER_METERID2').val()==''){
			alert("请输入新表号！");
			return; 
		}
		if($('#ddlBiaoLeiXing').val()==''||$('#ddlBiaoLeiXing2').val()==''){
			alert("子表类型未选择，请核实！");
			return; 
		}
		$.ajax({
			url : $path_base + '/baseinfomanage/betweenMeterChangeContr/updateBetweenMeterChange',
			type : 'POST',
			data:$('#form1').serialize(),
			dataType : 'json',
			success : function(data){
				if(data==false){ confirm("换表失败！") };
				if(data==true){ 
					alert("换表成功!");
					}
			}
			
		});
		
	}
		