(function($) {
	// 插件的定义
	$.fn.modelDiv = function(config) {

		var defaultConfig = { headHtml : '',

		};
		var configs = $.extend(defaultConfig, config);

		// 定义一组特殊的标签,必要的时候需要隐藏
		var spTags = new Array("applet", "iframe", "select", "object", "embed");

		// alert($(this).html());
	};
})(jQuery);
