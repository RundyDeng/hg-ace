
$.fn.aceAddtabs = function (options) {
    obj = $(this);
    Addtabs.options = $.extend({
        content: '', //直接指定所有页面TABS内容
        close: true, //是否可以关闭
        monitor: 'body', //监视的区域
        iframeUse: true, //使用iframe还是ajax
        iframeHeight: window.innerHeight - 127, //固定TAB中IFRAME高度,根据需要自己修改
        method: 'init',
        callback: function () { //关闭后回调函数
        }
    }, options || {});


    $(Addtabs.options.monitor).on('click', '[data-addtab]', function () {
        Addtabs.add({
            id: $(this).attr('data-addtab'),
            title: $(this).attr('title') ? $(this).attr('title') : $(this).html(),
            content: Addtabs.options.content ? Addtabs.options.content : $(this).attr('content'),
            url: $(this).attr('url'),
            ajax: $(this).attr('ajax') ? true : false
        });
    });

    obj.on('click', '.close-tab', function () {
        var id = $(this).prev("a").attr("aria-controls");
        Addtabs.close(id);
    });
    //obj上禁用右键菜单
    obj.on('contextmenu', 'li[role=presentation]', function () {
        var id = $(this).children('a').attr('aria-controls');
        Addtabs.pop(id, $(this));
        return false;
    });

    //刷新页面
    obj.on('click', 'ul.rightMenu a[data-right=refresh]', function () {
        var id = $(this).parent('ul').attr("aria-controls").substring(4);
        var url=$(this).parent('ul').attr('aria-url');
        Addtabs.add({'id':id,'url':url});
        $('#popMenu').fadeOut();
    });

    //关闭自身
    obj.on('click', 'ul.rightMenu a[data-right=remove]', function () {
        var id = $(this).parent("ul").attr("aria-controls");
        Addtabs.close(id);
        Addtabs.drop();
        $('#popMenu').fadeOut();
    });

    //关闭其他
    obj.on('click', 'ul.rightMenu a[data-right=remove-circle]', function () {
        var tab_id = $(this).parent('ul').attr("aria-controls");
        obj.children('#breadcrumbs ').children('ul.nav').find('li').each(function () {
            var id = $(this).attr('id');
            if (id && id != 'tab_' + tab_id) {
                Addtabs.close($(this).children('a').attr('aria-controls'));
            }
        });
        Addtabs.drop();
        $('#popMenu').fadeOut();
    });

    //关闭左侧
    obj.on('click', 'ul.rightMenu a[data-right=remove-left]', function () {
        var tab_id = $(this).parent('ul').attr("aria-controls");
        $('#tab_' + tab_id).prevUntil().each(function () {
            var id = $(this).attr('id');
            if (id && id != 'tab_' + tab_id) {
                Addtabs.close($(this).children('a').attr('aria-controls'));
            }
        });
        Addtabs.drop();
        $('#popMenu').fadeOut();
    });

    //关闭右侧
    obj.on('click', 'ul.rightMenu a[data-right=remove-right]', function () {
        var tab_id = $(this).parent('ul').attr("aria-controls");
        $('#tab_' + tab_id).nextUntil().each(function () {
            var id = $(this).attr('id');
            if (id && id != 'tab_' + tab_id) {
                Addtabs.close($(this).children('a').attr('aria-controls'));
            }
        });
        Addtabs.drop();
        $('#popMenu').fadeOut();
    });

    obj.on('mouseover', 'li[role = "presentation"]', function () {
        $(this).find('.close-tab').show();
    });

    obj.on('mouseleave', 'li[role = "presentation"]', function () {
        $(this).find('.close-tab').hide();
    });

    $(window).resize(function () {
        obj.find('iframe').attr('height', Addtabs.options.iframeHeight);
        Addtabs.drop();
    });

};

window.Addtabs = {
    options: {},
    add: function (opts) {
        var id = 'tab_' + opts.id;
        $('li[role = "presentation"].active').removeClass('active');
        $('div[role = "tabpanel"].active').removeClass('active');
        //如果TAB不存在，创建一个新的TAB
        if (!$("#" + id)[0]) {
            //创建新TAB的title
        	/*
        	Addtabs.previous = $('.tab-pane.page-content-area');  //之前页面的内容
*/        	
        	
        	$('.tab-pane.page-content-area').removeClass("page-content-area");
        	
        	var title = $('<li>', {
                'role': 'presentation',
                'id': 'tab_' + id,
                'aria-url':opts.url
            }).append(
                $('<a>', {
                    'href': '#' + id,
                    'aria-controls': id,
                    'role': 'tab',
                    'data-toggle': 'tab'
                }).html(opts.title)
            );

            //是否允许关闭
            if (Addtabs.options.close) {
                title.append(
                    $('<i>', {'class': 'close-tab glyphicon glyphicon-remove'})
                );
            }
            //创建新TAB的内容
            var content = $('<div>', {
            	'class': 'tab-pane page-content-area',
                'data-ajax-content': true,
                'id': id,
                'role': 'tabpanel'
            });

            //加入TABS
            obj.children('.breadcrumbs').children('.nav-tabs').append(title);
            obj.children('.page-content').children(".page-content-area-t").append(content);
        } else {
            var content = $('#' + id);
            content.html('');
        }

        //是否指定TAB内容
        if (opts.content) {
            content.append(opts.content);
        } else if (Addtabs.options.iframeUse && !opts.ajax) {//没有内容，使用IFRAME打开链接
        	/*var winParentLoad = '<script>\
					        	        var linkList = window.parent.document.getElementsByTagName("link"); \
					        	        var head = document.getElementsByTagName("head").item(0);  \
							        		for (var i = 0; i < linkList.length; i++) { \
							                var l = document.createElement("link"); \
											l.rel = \'stylesheet\'; \
							                l.type = \'text/css\'; \
							                l.href = linkList[i].href; \
							                head.appendChild(l); \
							            } \
					        		alert("iframe script loadcompl"); \
					        	 </script>';*/
        		/*
        		 * for (var i = 0; i < linkList.length; i++) { \
		                var l = document.createElement("link"); \
        				l.rel = \'stylesheet\'; \
		                l.type = \'text/css\'; \
		                l.href = linkList[i].href; \
		                head.appendChild(l); \
		            } \
        		 * */
        	
        	var iframe_e = $('<iframe>', {
				                'class': 'iframeClass',
				                'height': Addtabs.options.iframeHeight,
				                'frameborder': "no",
				                'border': "0",
				                'id': opts.url,
				                'src': "baseframe"
				            });
        	iframe_e.css('margin-top','8px');
            content.append(iframe_e)
           /* var childDocument = content.find('iframe')[0].contentWindow.document.getElementsByTagName("html").item(0);
            $(childDocument).append(winParentLoad);
            */
            //.appendChild(winParentLoad);
        } else {
            $.get(opts.url, function (data) {
            	//<script src="/ace/static/pages/js/baseinfomanage/clientinfo.js"></script>
            	if(typeof data === 'string'){
            		var mat = data.match(/<script\s+src=\"(\S+\/static\/pages\/js\/\S+)\"\D+<\/script>/im);
            		mat!=null&&mat.length>1 
            			? 
            			(function(){
            				var XMLHttp;
            				function createXMLHttpRequest(){
            					if(window.XMLHttpRequest){
            						XMLHttp = new XMLHttpRequest();
            					}else if(window.ActiveObject)
            					XMLHttp = new ActiveObject("Microsoft.XMLHTTP");
            				}
            				function callback(){
            			   		if(XMLHttp.readyState == 4){
            						if(XMLHttp.status == 200){ 
            							var scriptCode = XMLHttp.responseText;
            							data = data.replace(/<script\s+src=\"\/\S+\/static\/pages\/js\/\S+\"\D+<\/script>/im,"");
                        				if(scriptCode!=''||scriptCode!=null){
                        					scriptCode = "<script>(function(){" 
		                        						+ scriptCode.replace("$('.page-content-area')", "$('#tab_" + id + "')") 
		                        						+ "})()</script>";
                        					data = data.concat(scriptCode);
                        				}
                        				content.append(data);
            						}
            					}
            				}
        					createXMLHttpRequest();
        					XMLHttp.onreadystatechange=callback;
        					XMLHttp.open("GET",mat[1]);
        					XMLHttp.send(null); 
            				
            				/*$.get(mat[1],function(scriptCode){
                				data = data.replace(/<script\s+src=\"\/\S+\/static\/pages\/js\/\S+\"\D+<\/script>/im,"");
                				if(scriptCode!=''||scriptCode!=null){
                					scriptCode = "<script>" + scriptCode.replace("$('.page-content-area')", "$('#tab_" + id + "')") + "</script>";
                					data = data.concat(scriptCode);
                				}
                				content.append(data);
                			})*/
            			})() 
            			: 
            			content.append(data.replace("$('.page-content-area')", "$('#tab_" + id + "')"));
            			
            		//data.indexOf("/static/pages/js/") == -1 ? _script_source="" : $.get("")
            	} 
            });
        }

        //激活TAB
        $('#tab_' + id).addClass('active');
        $('#' + id).addClass('active');
        $('#breadcrumbs').removeClass('home-backimg')
        Addtabs.drop();
        //$('.tab-pane.page-content-area').removeClass("page-content-area");
    },
    pop: function (id,e) {
        $('body').find('#popMenu').remove();
        var pop = $('<ul>', {'aria-controls': id, 'class': 'rightMenu list-group', id: 'popMenu','aria-url':e.attr('url')});
        id=='home' ? 
		pop.append('<a href="javascript:void(0);" class="list-group-item" data-right="remove-circle"><i class="glyphicon glyphicon-remove-circle orange"></i> 关闭其他标签</a>'):pop.append(
            '<a href="javascript:void(0);" class="list-group-item" data-right="remove"><i class="glyphicon glyphicon-remove red"></i> 关闭此标签</a>' +
            '<a href="javascript:void(0);" class="list-group-item" data-right="remove-circle"><i class="glyphicon glyphicon-remove-circle orange"></i> 关闭其他标签</a>' +
            '<a href="javascript:void(0);" class="list-group-item" data-right="remove-left"><i class="glyphicon glyphicon-chevron-left green"></i> 关闭左侧标签</a>' +
            '<a href="javascript:void(0);" class="list-group-item" data-right="remove-right"><i class="glyphicon glyphicon-chevron-right green"></i> 关闭右侧标签</a>'
        );
        pop.css({
            'top': e.context.offsetHeight + $('#navbar')[0].offsetHeight + 2 + 'px',
            'left': e.context.offsetLeft + $('#sidebar')[0].offsetWidth + 'px'
        });
        pop.appendTo(obj).fadeIn('slow');
        pop.mouseleave(function () {
            $(this).fadeOut('slow');
        });
    },
    close: function (id) {
        //如果关闭的是当前激活的TAB，激活他的前一个TAB
        if (obj.find("li.active").attr('id') === "tab_" + id) {
            var $tabChe = $("#tab_" + id).prev();
            $tabChe.addClass('active');
            $tabChe.children("a").attr("aria-controls") == 'home' ? $('#breadcrumbs').addClass('home-backimg') : $('#breadcrumbs').removeClass('home-backimg');
            $("#" + id).prev().addClass('active');
        }
        if(id !== 'home'){
        	$("#tab_" + id).remove();
            $("#" + id).remove();
        }
        Addtabs.drop();
        Addtabs.options.callback();
    },
    closeAll: function () {
        $.each(obj.find('li[id]'), function () {
            var id = $(this).children('a').attr('aria-controls');
            if(id !== 'home'){
            	$("#tab_" + id).remove();
                $("#" + id).remove();
            }
        });
        obj.find('li[role = "presentation"]').first().addClass('active');
        var firstID=obj.find('li[role = "presentation"]').first().children('a').attr('aria-controls');
        $('#'+firstID).addClass('active');
        Addtabs.drop();
    },
    drop: function () {
        element = obj.find('.nav-tabs');
        //创建下拉标签
        var dropdown = $('<li>', {
            'class': 'dropdown pull-right hide tabdrop tab-drop'
        }).append(
            $('<a>', {
                'class': 'dropdown-toggle',
                'data-toggle': 'dropdown',
                'href': '#'
            }).append(
                $('<i>', {'class': "glyphicon glyphicon-align-justify"})
            ).append(
                $('<b>', {'class': 'caret'})
            )
        ).append(
            $('<ul>', {'class': "dropdown-menu"})
        )

        //检测是否已增加
        if (!$('.tabdrop').html()) {
            dropdown.prependTo(element);
        } else {
            dropdown = element.find('.tabdrop');
        }
        //检测是否有下拉样式
        if (element.parent().is('.tabs-below')) {
            dropdown.addClass('dropup');
        }
        var collection = 0;

        //检查超过一行的标签页
        element.append(dropdown.find('li'))
            .find('>li')
            .not('.tabdrop')
            .each(function () {
                if (this.offsetTop > 0 || element.width() - $(this).position().left - $(this).width() < 83) {
                    dropdown.find('ul').append($(this));
                    collection++;
                }
            });

        //如果有超出的，显示下拉标签
        if (collection > 0) {
            dropdown.removeClass('hide');
            if (dropdown.find('.active').length == 1) {
                dropdown.addClass('active');
            } else {
                dropdown.removeClass('active');
            }
        } else {
            dropdown.addClass('hide');
        }
    }
}   