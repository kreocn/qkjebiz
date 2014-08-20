var widget_textarea = function(config) {
	var selfobj = this;

	var textareaid = "editor1";
	var conid = "widget_textarea_" + textareaid;
	var iframeid = "iframe_widget_textarea_" + textareaid;
	var iframeobj = null;
	this.defaultConfig = { width : "100%", height : "500px", src : "/ckframe/widget_textarea.jsp" };
	this.option = {};

	$.extend(this.option, this.defaultConfig, config);

	var checkInterval;

	this.init = function(oid) {
		textareaid = oid;
		// 设定控件ID
		conid = "widget_textarea_" + textareaid;
		// 设定iframeID
		iframeid = 'iframe_widget_textarea' + textareaid;
		// 隐藏textarea
		$("#" + textareaid).hide();
		// 绑定form的submit事件,当submit时,赋值给当前表单的textarea
		$("#" + textareaid).parents("form").bind("submit", function(event) {
			$("#" + textareaid).val(selfobj.getValue());
		});
		// 创建iframe
		selfobj.create();
		// 巡查机制,检查是否加载完成,加载完成之后,结束巡查
		checkInterval = window.setInterval(function() {
			selfobj.checkLoad();
		}, 100);
	};

	this.checkLoad = function() {
		// 从赋值情况来判断是否载入完全
		if (typeof (iframeobj.getckValue) == 'function') {
			window.clearInterval(checkInterval);
			$("#" + conid + "loading").hide();
			$("#" + iframeid).fadeIn();
			selfobj.setValue($("#" + textareaid).val());
		}
	};

	this.create = function() {
		var h = '<div id="' + conid + '"><div id="' + conid
				+ 'loading" class="ui-loading-16">正在载入控件...</div><iframe id="' + iframeid
				+ '" scrolling="no" frameborder="0"></iframe></div>';
		$("#" + textareaid).parent().append(h);
		$("#" + iframeid).hide();// 先隐藏,等检测到载入完全,再显示
		$("#" + iframeid).attr("src", selfobj.option.src);
		$("#" + iframeid).css(
				{ width : selfobj.option.width, height : selfobj.option.height, background : "transparent" });
		iframeobj = document.getElementById(iframeid).contentWindow;
	};

	this.getValue = function() {
		var obj = document.getElementById(iframeid).contentWindow;
		return obj.getckValue();
	};

	this.setValue = function(val) {
		var obj = document.getElementById(iframeid).contentWindow;
		return obj.setckValue(val);
	};
};

var widget_button = function(config) {
	var selfobj = this;

	this.defaultConfig = { inputid : "inputid", width : "80%", height : "500px", src : "/ckframe/widget_button.jsp",
		objname : "widget_buttonid" };
	this.option = {};
	$.extend(this.option, this.defaultConfig, config);

	var conid = "widget_button_" + selfobj.option.inputid;
	var iframeid = "iframe_widget_button_" + selfobj.option.inputid;

	// $()

	// 初始化
	this.init = function() {
		$("#" + selfobj.option.inputid).after(
				'<input id="' + selfobj.option.inputid + '_click" type="button" value="选择文件" />');
		$("#" + selfobj.option.inputid + '_click').bind("click", function() {
			// 首次创建
			if ($("#" + conid).length == 0) {
				selfobj.create();
			}
			selfobj.open();
		});
	};

	this.create = function() {
		var h = '<div id="' + conid + '"><iframe id="' + iframeid + '" scrolling="no" frameborder="0"></iframe></div>';
		$("body").parent().append(h);
		$("#" + conid).css({ width : selfobj.option.width, height : selfobj.option.height, overflow : "hidden" });
		$("#" + iframeid).css(
				{ width : "100%", height : selfobj.option.height, background : "transparent" });
		$("#" + iframeid).attr("src", selfobj.option.src + "?objname=" + selfobj.option.objname);
		
		var cwidth = $("#" + conid).width();
		var chight = $("#" + conid).height();
		
		$("#" + conid).dialog(
				{ autoOpen : false, height : chight, width : cwidth, modal : true });
	};

	// 打开选择框
	this.open = function() {
		$("#" + conid).dialog("open");
	};

	// 关闭选择框
	this.close = function() {
		$("#" + conid).dialog("close");
	};

	// 写入值到inputid
	this.setValue = function(val) {
		$("#" + selfobj.option.inputid).val(val);
	};
};