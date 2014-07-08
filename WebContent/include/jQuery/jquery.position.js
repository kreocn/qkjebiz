/**
 * jQuery Plugins elementFixed v1205
 * 
 * @see 作者：螞蟻 Email : yi-admin@163.com blog : http://yi-admin.blog.163.com/
 * @see 使用说明：
 * @see $('#div1').elementFixed({position:"leftTop"}); //定位左上
 * @see $('#div2').elementFixed({position:"leftBottom"}); //定位左下
 * @see $('#div3').elementFixed({position:"rightTop"}); //定位右上
 * @see $('#div4').elementFixed({position:"rightBottom"}); //定位右下
 * @see $('#div5').elementFixed({position:"leftCenter"}); //定位左中
 * @see $('#div6').elementFixed({position:"rightCenter"}); //定位右中
 * @see $('#div7').elementFixed({position:"topCenter"}); //定位上居中
 * @see $('#div8').elementFixed({position:"bottomCenter"}); //定位底居中
 * @see $('#div9').elementFixed({position:"center"}); //定位居中
 * @see $('#div4').elementFixed(); //不给参数默认定位为右下
 */
jQuery.fn.elementFixed = function(options) {
	var own = this;
	var settings = {
		position : "rightBottom"
	};
	jQuery.extend(settings, options);
	own.css({
		position : "absolute",
		left : 0,
		top : 0,
		zIndex : 1000
	});
	$(window).bind("scroll resize load", function() {
		var left = 0;
		var top = 0;
		if (settings.position == "leftTop") {
			left = $(window).scrollLeft();
			top = $(window).scrollTop();
		} else if (settings.position == "rightTop") {
			left = $(window).width() + $(window).scrollLeft() - own.outerWidth();
			top = $(window).scrollTop();
		} else if (settings.position == "leftBottom") {
			left = $(window).scrollLeft();
			top = $(window).height() + $(window).scrollTop() - own.outerHeight();
		} else if (settings.position == "rightBottom") {
			left = $(window).width() + $(window).scrollLeft() - own.outerWidth();
			top = $(window).height() + $(window).scrollTop() - own.outerHeight();
		} else if (settings.position == "leftCenter") {
			left = $(window).scrollLeft();
			top = $(window).height() * 0.5 + $(window).scrollTop() - own.outerHeight() * 0.5;
		} else if (settings.position == "rightCenter") {
			left = $(window).width() + $(window).scrollLeft() - own.outerWidth();
			top = $(window).height() * 0.5 + $(window).scrollTop() - own.outerHeight() * 0.5;
		} else if (settings.position == "topCenter") {
			left = $(window).width() * 0.5 + $(window).scrollLeft() - own.outerWidth() * 0.5;
			top = $(window).scrollTop();
		} else if (settings.position == "bottomCenter") {
			left = $(window).width() * 0.5 + $(window).scrollLeft() - own.outerWidth() * 0.5;
			top = $(window).height() + $(window).scrollTop() - own.outerHeight();
		} else if (settings.position == "center") {
			left = $(window).width() * 0.5 + $(window).scrollLeft() - own.outerWidth() * 0.5;
			top = $(window).height() * 0.5 + $(window).scrollTop() - own.outerHeight() * 0.5;
		}
		own.stop(true, false).animate({
			left : left,
			top : top
		});
	});
};