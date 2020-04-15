<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>小区图形</title>

</head>
<style>
#tree ul[class="list-group"]:first-child {
	margin-left: 0px;
	margin-right: 3px;
	margin-left: -10px;
}
.page-content {
	padding-left: 0px; 
	padding-right: 0px;
}
.page-content-area {
	overflow-x: hidden;
	padding-left: 0px; 
	margin-right: 10px;"
}
.list-group-item.node-tree{
	overflow-x: hidden;
	white-space: nowrap;
}

</style>
<body>
	<div id="tree" style="width: 16%; float: left; height: 500px; overflow: auto;border: 1px solid rgb(221, 221, 221);"></div>  
			
	<form style="width: 84%; float: right;">
		<div style="WIDTH: 800px; HEIGHT: 500px;" id="dialogEditHES"
			title="换热站">
			<table border=0 cellSpacing=0 cellPadding=0 width="100%">
				<tbody>
					<tr vAlign="top" id="grid-table">
						  <th>序号</th>
					      <th>用户编码</th>
					      <th>地址</th>
					      <th>表编号</th>
					      <th>热表状态</th>
					      <th>瞬时热量(KW)</th>
					      <th>累计热量(KWH)</th>
					      <th>瞬时流量(t/h)</th>
					      <th>累计流量(t)</th>
					      <th>进水温度</th>
					      <th>回水温度</th>
					      <th>温差</th>
					      <th>问题说明</th>
					</tr>
				</tbody>
			</table>
		</div>

	</form>

</body>
</html>

<script>
	var basePath = '${contextPath}';
</script>

<script src="${contextPath}/static/pages/js/bootstrap-treeview.js"></script>
<script>
$('.page-content-area').ace_ajax('loadScripts',[],function() {
	var curAreaName = $(window.parent.document.getElementById('sidebar')).find('a[data-addtab="areagif"]').attr("data-oth");
	$.post('${contextPath}/homePage/getAreaTree', {areaName: curAreaName} , function(response){
		var tree = jQuery.parseJSON(response);
		$('#tree').treeview({
			data: tree,
			//levels: 2,
			enableLinks: false,
			onNodeSelected: function(event, data) {
				var curNodeId = data.nodeId;
				if(data.nodes==null){
				//	window.location.href= $path_base + "/sys/sysuser/areainfo";
					 var no = (Math.random() * 3 + 1).toString().replace(/\.\S+/,'');
					$('tr[vAlign="top"]').empty().append(eval("th"));
					$('#gif-areaname').html(data.text); 
				}else{
					 $('#tree').treeview('expandNode', [ curNodeId, { levels: 1, silent: true } ]); 
				}
			},
		});       
		var _cur_nodeid = $('.node-checked').attr('data-nodeid');
		$('li[data-nodeid="'+_cur_nodeid+'"]').click();
		/* var _cur_nodeid = $('.node-checked.node-selected').attr('data-nodeid');
		$('#tree').treeview('toggleNodeSelected', [ _cur_nodeid, { silent: true } ]); */
		$(window.parent.document.getElementById('sidebar')).find('a[data-addtab="areagif"]').attr("data-oth","");
		
	});

	/*  */
	var scripts = [ null,'${contextPath}/static/assets/js/jquery-ui.js',
	                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
	                "${contextPath}/static/pageclock/compiled/flipclock.js",null ];
	var page = 1;    
	var pagesize=20;
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		   	
		$.get('${contextPath}/sys/todaydata/getAreaDownList',function(data){
			var areaguid = '<%=(String)request.getSession().getAttribute("areaGuids") %>';
			var flagName = '';
				var response = jQuery.parseJSON(data);
			      var s = '<option value="">请选择</option>';
			      if (response && response.length) {
			          for (var i = 0, l = response.length; i < l; i++) {
				           var ri = response[i];
				           if(ri['AREAGUID']==areaguid){
				        	   flagName = ri['AREANAME'];
				           }
			        	   s += '<option value="' + ri['AREANAME'] + '">' + ri['AREANAME'] + '</option>';   
			          }
			       }
			      
			      //if(flagName!=''){
			    	 // s += "<script>$('select option[value=\""+flagName+"\"]').change().attr('selected',true);</sc"+"ript>  ";
			    //}
			  
			      $('#search_areaname').empty().append(s);
		})
		
		$("#input_sel_date").datepicker({
	    		dateFormat: 'yy-mm-dd',
	    		defaultDate : new Date(),
		});
		
		$('#statistic_search').click(function(){
			page = 1;
			getStatisticInfo();
		});
		/*  $('#statistic_new').click(); */  //20171009
		
	});
	$('#statistic_new').click(function(){
		var newdate = '${date }';
		
		$('#input_sel_date').val(newdate);
		page = 1;
		getStatisticInfo();
	});
		var title = '今日运行状态详情';
		
		var go = function(e){
			page = e;
			getStatisticInfo();
		}
		
		var exportExcel = function(){
			var rows = '';
			var row = '';//标题部分
			$('#grid-table thead th').each(function(index,value){
				index ==0 ? row+=value.innerHTML : row += '\t'+value.innerHTML;
			});
			rows += row;
			var $tb_tr = $('#grid-table tbody tr');
			$tb_tr.each(function(index,value){
				rows +='\n';
				
				$(value).find('th').each(function(i,v){
					if(v.innerHTML!=''){
						i==0 ? rows += v.innerHTML : rows += '\t' + v.innerHTML;
					}else{
						i==0 ? rows += v.innerHTML : rows += '\t ';
					}
				});
			});
			if(row==rows){
				alert("没有数据");
				return;
			}
			var form = "<form name='csvexportform' action='${contextPath}/homePage/excelTodayStatus?title="+encodeURIComponent(encodeURIComponent(title))+"' method='post'>";
	    	   form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
	    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
	    	   OpenWindow = window.open('', '导出数据','width=500,height=300');
	    	   OpenWindow.document.write(form);
	    	   OpenWindow.document.close();
		}
		
		var showdialog = function(){
			$("#detail_dialog").dialog({
		    		title : title,
		    		bgiframe: true,
		    	    resizable: true,
		    	    height:600,
		    	    width:1200,
		    	    modal: true,
			    	buttons: {
	   				          '导出': function() {
	   				        			  exportExcel();
			   				              $(this).dialog('destroy');
			   				           	  $("#input_sel_date").datepicker('destroy');
			   				          },
	   				          '关闭': function() {
			   				              $(this).dialog('destroy');
			   				          	  $("#input_sel_date").datepicker('destroy');
			   				          }
	   				      },
	   			focus: function(event, ui) {
	   				
	   				
	   			}
		    }
			);
		}
		
		function roundFix(cellvalue){
			if(cellvalue==''||cellvalue==undefined)
				return 0;
			return cellvalue.toFixed(2);
		}
		
		var loadTable = function(url){
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
			
			$.get(url,function(response){
				var data = jQuery.parseJSON(response);

				var strHtml = ''; 
				for(var i=0 ;i<data.length;i++){
					var obj = data[i];
					
					strHtml += '<tr><th>'+(i+1)+'</th><th>'+obj['CLIENTNO']+'</th><th>'+obj['ADDRESS']+'</th><th>'+obj['METERID']+'</th><th>'+obj['MSNAME']
							+'</th><th>'+roundFix(obj['METERGL'])+'</th><th>'+roundFix(obj['METERNLLJ'])+'</th><th>'+roundFix(obj['METERLS'])
							+'</th><th>'+roundFix(obj['METERTJ'])+'</th><th>'+roundFix(obj['METERJSWD'])+'</th><th>'+roundFix(obj['METERHSWD'])
							+'</th><th>'+roundFix(obj['METERWC'])+'</th><th>';
					if(obj['REMARK']==null||obj['REMARK']==undefined||obj['REMARK']=='null'){
					
					}else{
						strHtml += obj['REMARK'];
					}
							
					strHtml += '</th></tr>';
				}
				
				$('#detail_tbody').empty().append(strHtml);
			});
			
			
			
			showdialog();
		}
		
		var detail = function(SYSSTATUS,AREAGUID,AREANAME){

			if(SYSSTATUS==1){
				title = "今日运行状态详情（未抄表）- "+AREANAME+"小区";
			}
			if(SYSSTATUS==999){
				title = "今日运行状态详情(无反应) - "+AREANAME+"小区";
			}
			var url = '${contextPath}/homePage/getMeterDetail?SYSSTATUS='+SYSSTATUS+'&DDATE='+$('#input_sel_date').val()
					+'&areaguid='+AREAGUID+'&autoid=1';
			loadTable(url);
		}
		
		var getStatisticInfo = function(){
			 var date = $('#input_sel_date').val();
			 var areaName = $('#search_areaname').val();
			 
			 $.get('${contextPath}/dataAnalysis/statisticContr/getStatistic?page='+page+'&date=' + date +'&areaname=' + areaName,function(response){
					var target = jQuery.parseJSON(response);
					var data = target['data'];
					var pageCount = target['pageCount'];
					
					var str = '';
					if(data.length>0){
						for(var i=0 ; i<data.length ; i++){
				
							var obj = data[i];
							if(obj['FACTORYNAME']==null){
								obj['FACTORYNAME']="";
							}
							if(obj['SECTIONNAME']==null){
								obj['SECTIONNAME']="";
							}
							str += '<tr><th>'+(pagesize*(page-1)+i+1)+"</th><th>"+obj['FACTORYNAME']+'</th><th>'+obj['SECTIONNAME']+'</th><th>'+obj['AREANAME']
								+ '</th><th>'+obj['TOTZHSUM']+'</th><th>'+obj['TOTCBSUM']+'</th><th>'+obj['ZCSUM']+'</th>'
								+'<th><a href="javascript:detail(999,'+obj['AREAGUID']+',\''+obj['AREANAME']+'\');">'+obj['WFYSUM']+'</a></th>'
								+'<th><a href="javascript:detail(1,'+obj['AREAGUID']+',\''+obj['AREANAME']+'\');">'+obj['WCBSUM']+'</a></th></tr>';
						}
					}
					$('#statisticTbody').empty();
					$('#statisticTbody').append(str);
					
					var pageHtml = '<nav><ul class="pagination">'
					if(page == 1){
						pageHtml += '<li class="disabled"><a href="javascript:void(0);" aria-label="Previous">';
					}else{
						pageHtml += '<li><a href="javascript:go('+(page-1)+');" aria-label="Previous">';
					}
					pageHtml +=  '<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>';
					for(var i = 0 ;i<pageCount;i++){
						var j = i+1;
						if(page==j){
							pageHtml += '<li class="active"><a href="javascript:void(0);">'+j+' <span class="sr-only">(current)</span></a></li>';
						}else{
							pageHtml += '<li><a href="javascript:go('+j+')">'+j+'</a></li>';
						}
						
					}
					if(page==pageCount){
						pageHtml += '<li class="disabled"><a href="javascript:void(0);" aria-label="Next">'
					}else{
						pageHtml += '<li><a href="javascript:go('+(page+1)+')" aria-label="Next">';
					}
					pageHtml += '<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li></ul></nav>';			
						
					$('#statis_pagination').empty(); 
					if(data.length>0){
						$('#statis_pagination').append(pageHtml); 
					}
				});
		}
	
	
	
	
	
});
</script>

