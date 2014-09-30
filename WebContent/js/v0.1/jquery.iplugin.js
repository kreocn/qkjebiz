/**
 * 专为输入框提示文本的插件
 */
(function($){
	$.fn.inputNote = function(options){
		var opts = $.extend({ noteClass : "message_prompt" }, options);
		return this.each(function(){
			var $this = $(this);
			var nNode = $this.siblings("." + opts.noteClass);
			nNode.css({ "position" : "absolute",
			"line-height" : "32px",
			"left" : "10px",
			"color" : "#AAA",
			"overflow" : "hidden",
			"height" : "32px",
			"cursor" : "text" });
			// 判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
			if ($this.val() != "") {
				nNode.hide();
			} else {
				nNode.show();
			}
			// 聚焦时输入框验证
			$this.focus(function(){
				nNode.hide();
			}).blur(function(){
				var val = $this.val();
				if (val != "") {
					nNode.hide();
				} else {
					nNode.show();
				}
			});
			nNode.click(function(){
				$this.focus();
			});
		});
	};
})(jQuery);

/**
 * textarea换行插件,直接显示textarea的内容时,解决换行问题
 */
(function($){
	$.fn.textBreak = function(options){
		var opts = $.extend({ tag : "br" }, options);
		return this.each(function(){
			var $this = $(this);
			var dd = $this.html();
			if (opts.tag == "br" || opts.tag == "") {
				dd = dd.replace(/\n/g, "<br>");
				dd = dd.replace(/ /g, "&nbsp;");
			} else {
				dd = "<" + opts.tag + ">" + dd;
				dd = dd.replace(/\n/g, "</" + opts.tag + ">" + "<" + opts.tag + ">");
				dd = dd.replace(/ /g, "&nbsp;");
				dd += "</" + opts.tag + ">";
			}
			$this.html(dd);
		});
	};
})(jQuery);