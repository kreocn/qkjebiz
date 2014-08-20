// JavaScript Document USE 'UTF-8' Code
/*
 * For Example:
 *	var md = new modelDiv();
 *	md.setBottom_HTML("");
 *	md.createModelDivByUrl(580,260,"code.html",16);
 */
function modelDiv() {
	/*
	 * var obj = document.createElement("div"); obj.setAttribute("id","opmsgDiv"); obj.style.backgroundColor =
	 * "#363636"; obj.style.height = "180px"; document.body.appendChild(obj);
	 */
	var __sWidth, __sHeight, __scrollX, __scrollY;
	// var wWidth,wHeight;
	__sWidth = document.body.offsetWidth;
	__sHeight = Math.min(document.body.clientHeight, screen.height);

	if (window.innerHeight) {
		__scrollX = window.pageXOffset;
		__scrollY = window.pageYOffset;
	} else if (document.documentElement && document.documentElement.scrollTop) {
		__scrollX = document.documentElement.scrollLeft;
		__scrollY = document.documentElement.scrollTop;
	} else if (document.body) {
		__scrollX = document.body.scrollLeft;
		__scrollY = document.body.scrollTop;
	}

	// wWidth = screen.width;
	// wHeight = screen.height;

	// 去掉一些特殊的tag,防止z-index无效
	this.tags = new Array("applet", "iframe", "select", "object", "embed");
	// 全屏div对象变量(使全屏的元素不可编辑,从而可以模拟出模式对话框的效果)
	this.BgDiv = null;
	// 模式对话框div对象变量
	this.ModelDiv = null;

	// 用变量md作为对象的名称,如modelDiv md = new modelDiv();
	this.Title_HTML = "<div style=\"height:16px; text-align:right; background-color:#eef7fe\">"
			+ "<input type=\"button\" value=\"&#215;\" onclick=\"md.dropModelDiv();\""
			+ " style=\"width:16px; height:16px; font-size:13px;\" /></div>";
	this.Bottom_HTML = "<div style=\"text-align:center;\">"
			+ "<input type=\"button\" value=\"&#x786E;&#x5B9A;\" onclick=\"md.dropModelDiv();\" "
			+ "style=\"width:50px; height:20px; font-size:14px;\" /></div>";

	// 返回值变量
	var returnValue = null;

	/*
	 * 如果想自己设置Title_HTML和Bottom_HTML,请使用此函数
	 */
	this.setTitle_HTML = function(__Title_HTML_Content) {
		this.Title_HTML = __Title_HTML_Content;
	}
	this.setBottom_HTML = function(__Bottom_HTML_Content) {
		this.Bottom_HTML = __Bottom_HTML_Content
	}

	/*
	 * 创建模式对话框, 其中的参数,width为宽度,height为高度,HTML_Context为div中插入的HTML内容(用直接写入HTML内容来创建) z-Index = 10001,div_id = ModelDiv
	 */
	this.createModelDivByContent = function(__width, __height, HTML_Context) {
		this.createBgDiv();
		this.ModelDiv = document.createElement("div");
		__width = Math.min(__width, __sWidth - 10);
		__height = Math.min(__height, __sHeight - 10);

		with (this.ModelDiv) {
			setAttribute('id', 'ModelDiv');
			style.position = "absolute";
			style.left = __scrollX + (__sWidth - __width) / 2;
			style.top = __scrollY + (__sHeight - __height) / 2;
			style.width = __width + "px";
			style.height = __height + "px";
			// style.overflow = "auto";
			// style.border = "#000000 solid 1px";
			style.zIndex = "10001";
			style.backgroundColor = "#FFF";
			innerHTML = this.Title_HTML + HTML_Context + this.Bottom_HTML;
		}

		// alert("id:" + this.ModelDiv.id);
		// alert("left:" + this.ModelDiv.style.left);
		// alert("top:" + this.ModelDiv.style.top);
		// alert("border:" + this.ModelDiv.style.border);
		// alert("width:" + this.ModelDiv.style.width);

		document.body.appendChild(this.ModelDiv);
		if (!this.ModelDiv.style.left || this.ModelDiv.style.left == null || this.ModelDiv.style.left == "")
			toWinCenter(this.ModelDiv.id); // 不支持IE6
	}

	/*
	 * 创建模式对话框,使用页面中已经有的div来创建(其实就是原有的div重新定位) 其中的参数,width为宽度,height为高度 div_id为已存在的div_id z-Index = 10001,div_id =
	 * ModelDiv
	 */
	this.createModelDivByExistDiv = function(__width, __height, div_id) {
		this.createBgDiv();
		this.ModelDiv = document.getElementById(div_id);
		__width = Math.min(__width, __sWidth - 10);
		__height = Math.min(__height, __sHeight - 10);
		with (this.ModelDiv) {
			style.position = "absolute";
			style.left = __scrollX + (__sWidth - __width) / 2;
			style.top = __scrollY + (__sHeight - __height) / 2;
			style.width = __width + "px";
			style.height = __height + "px";
			// style.overflow = "auto";
			//style.border = "#000000 solid 1px";
			style.zIndex = "10001";
			style.backgroundColor = "#FFF";
			style.display = "";
		}

		if (!this.ModelDiv.style.left || this.ModelDiv.style.left == null || this.ModelDiv.style.left == "")
			toWinCenter(this.ModelDiv.id); // 不支持IE6
	}

	/*
	 * 删除模拟div对话框(专门针对createModelDivByExistDiv,其他不适用)
	 */
	this.dropModelDivByExistDiv = function() {
		this.dropBgDiv();
	}

	/*
	 * 创建模式对话框, 其中的参数,width为宽度,height为高度,用url来创建, __used_height为已经使用的height(即是Title和Bottom的Height之和) z-Index =
	 * 10001,div_id = ModelDiv
	 */
	this.createModelDivByUrl = function(__width, __height, __url, __used_height) {
		this.createBgDiv();
		this.ModelDiv = document.createElement("div");
		__width = Math.min(__width, __sWidth - 10);
		__height = Math.min(__height, __sHeight - 10);
		__used_height = __used_height || 36;
		var __HTML_Context = "<div style=\"text-align:center;\">"
				+ "<iframe  id=\"modeldiv_iframe_id\" name=\"modeldiv_iframe_name\" style=\"border:none; overflow:auto; " + "width:" + __width + "px;"
				+ "height:"+(__height+__used_height)+"px; marginwidth=\"0\" marginheight=\"0\"" // 36为Title_HTML的Height+Buttom_HTML的Height
				+ "\" frameborder=\"0\"" + "src=\"" + __url + "\"></iframe>" + "</div>";
		with (this.ModelDiv) {
			setAttribute('id', 'ModelDiv');
			style.position = "absolute";
			style.left = __scrollX + (__sWidth - __width) / 2;
			style.top = __scrollY + (__sHeight - __height) / 2;
			// style.width = __width + "px";
			// style.height = __height + "px";
			// style.overflow = "auto";
			// style.border = "#000000 solid 1px";
			style.zIndex = "10001";
			style.backgroundColor = "#FFF";
			// 一般都在url里面自己加,使用top.函数名,如top.md.dropBgDiv()
			innerHTML = this.Title_HTML + __HTML_Context;
			// + this.Bottom_HTML
		}
		// overflow: hidden;
		document.body.appendChild(this.ModelDiv);

		if (!this.ModelDiv.style.left || this.ModelDiv.style.left == null || this.ModelDiv.style.left == "") {
			//alert(this.ModelDiv.id);
			toWinCenter(this.ModelDiv.id); // 不支持IE6
		}
	}

	/*
	 * 创建模式对话框,但是不创建背景div,而且需要用特殊的删除函数 其中的参数,width为宽度,height为高度,用url来创建,
	 * __used_height为已经使用的height(即是Title和Bottom的Height之和) z-Index = 10001,div_id = ModelDiv
	 */
	this.createModelDivByUrl2 = function(__width, __height, __url, __used_height) {
		this.hideAllSelect();
		this.ModelDiv = document.createElement("div");
		__width = Math.min(__width, __sWidth - 10);
		__height = Math.min(__height, __sHeight - 10);
		var __HTML_Context = "<div style=\"text-align:center;\">"
				+ "<iframe id=\"modeldiv_id\" scrolling=\"no\" style=\"border:none; overflow:hidden; " + "width:100%;"
				+ "height:" + (__height - __used_height) + "px;" // 36为Title_HTML的Height+Buttom_HTML的Height
				+ "\" frameborder=\"0\"" + "src=\"" + __url + "\"></iframe>" + "</div>";
		with (this.ModelDiv) {
			setAttribute('id', 'ModelDiv');
			style.position = "absolute";
			style.left = __scrollX + (__sWidth - __width) / 2;
			style.top = __scrollY + (__sHeight - __height) / 2;
			style.width = __width + "px";
			style.height = __height + "px";
			// style.overflow = "auto";
			// style.border = "#000000 solid 1px";
			style.zIndex = "10001";
			style.backgroundColor = "#FFF";
			// 一般都在url里面自己加,使用top.函数名,如top.md.dropBgDiv()
			innerHTML = this.Title_HTML + __HTML_Context;
			// + this.Bottom_HTML
		}
		document.body.appendChild(this.ModelDiv);

		if (!this.ModelDiv.style.left || this.ModelDiv.style.left == null || this.ModelDiv.style.left == "")
			toWinCenter(this.ModelDiv.id); // 不支持IE6
	}

	/*
	 * 删除模拟div对话框2, 针对特殊的createModelDivByUrl2而写
	 */
	this.dropModelDiv2 = function() {
		if (this.ModelDiv) {
			this.ModelDiv.parentNode.removeChild(this.ModelDiv);
		}
		this.resetAllSelect();
	}

	/*
	 * 删除模拟div对话框
	 */
	this.dropModelDiv = function() {
		if (this.ModelDiv) {
			this.ModelDiv.parentNode.removeChild(this.ModelDiv);
		}
		this.dropBgDiv();
	}
	/*
	 * 创建一个覆盖全屏的div,并隐藏滚动条等,以达到无法编辑的效果 z-Index = 10000,div_id = BgDiv
	 */
	this.createBgDiv = function() {
		this.hideAllSelect();
		this.BgDiv = document.createElement("div");
		with (this.BgDiv) {
			setAttribute('id', 'BgDiv');
			style.position = "absolute";
			style.left = __scrollX;
			style.top = __scrollY;
			style.right = "0";
			style.bottom = "0";
			style.background = "#fff";
			style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75)";
			style.opacity = "0.6";
			style.width = "100%";
			style.height = __sHeight + "px";
			style.zIndex = "10000";
		}
		document.body.appendChild(this.BgDiv);
		document.body.style.overflow = "hidden";
		window.scrollTo(__scrollX, __scrollY);
	}
	/*
	 * 删除覆盖全屏的div,一般在上面函数用过之后使用
	 */
	this.dropBgDiv = function() {
		if (this.BgDiv) {
			this.BgDiv.parentNode.removeChild(this.BgDiv);
		}
		this.resetAllSelect();
		document.body.style.overflow = "auto";
	}

	this.hideAllSelect = function() {
		for ( var k = 0; k < this.tags.length; k++) {
			var selects = document.getElementsByTagName(this.tags[k]);
			for ( var i = 0; i < selects.length; i++) {
				selects[i].setAttribute("oldStyleDisplay", selects[i].style.visibility);
				selects[i].style.visibility = "hidden";
			}
		}
	}

	this.resetAllSelect = function() {
		for ( var k = 0; k < this.tags.length; k++) {
			var selects = document.getElementsByTagName(this.tags[k]);
			for ( var i = 0; i < selects.length; i++) {
				if (selects[i].getAttribute("oldStyleDisplay") != null)
					selects[i].style.visibility = selects[i].getAttribute("oldStyleDisplay");
			}
		}
	}
	/*
	 * 设置返回值的参数,如果是用URL作为对话框内容,则在URL中使用top.md.setReturnValue来设置 这里假设md是对象名
	 */
	this.setReturnValue = function(__obj) {
		returnValue = __obj;
	}

	/*
	 * 得到返回值函数,可以在需要的时候调用
	 */
	this.getReturnValue = function() {
		return returnValue;
	}
}

/***********************************************************************************************************************
 * 取窗口滚动条高度
 **********************************************************************************************************************/
function getScrollTop() {
	var scrollTop = 0;
	if (document.documentElement && document.documentElement.scrollTop) {
		scrollTop = document.documentElement.scrollTop;
	} else if (document.body) {
		scrollTop = document.body.scrollTop;
	}
	return scrollTop;
}

/***********************************************************************************************************************
 * 取窗口可视范围的高度
 **********************************************************************************************************************/
function getClientHeight() {
	var clientHeight = 0;
	if (document.body.clientHeight && document.documentElement.clientHeight) {
		var clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ?

		document.body.clientHeight : document.documentElement.clientHeight;
	} else {
		var clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ?

		document.body.clientHeight : document.documentElement.clientHeight;
	}
	return clientHeight;
}

/***********************************************************************************************************************
 * 取文档内容实际高度
 **********************************************************************************************************************/
function getScrollHeight() {
	return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
}

/***********************************************************************************************************************
 * 取坐标位置
 **********************************************************************************************************************/
function statusreport() {
	var tempx = event.clientX + document.body.scrollLeft;
	var tempy = event.clientY + document.body.scrollTop;
	status = '在整个页面中的X, Y坐标 : (' + tempx + ', ' + tempy + ') ; 在当前窗口中的X, Y坐标 : ( ' + event.clientX + ', '
			+ event.clientY + ')';
}

/***********************************************************************************************************************
 * 置id为绝对中间位置
 **********************************************************************************************************************/
function toWinCenter(id) {
	if (typeof($) == "undefined") {  
		var obj = document.getElementById(id);	
		var top = document.body.scrollTop + (window.innerHeight || document.body.offsetHeight) / 2 - obj.offsetHeight / 2;
		var left = (window.innerWidth || document.body.offsetWidth) / 2 - obj.offsetWidth / 2;
		obj.style["left"] = left + "px";
		obj.style["top"] = top + "px";
	} else {
		$('#'+id).css({
			position:'absolute',
			left: ($(window).width() - $('#'+id).outerWidth())/2,
			top: ($(window).height() - $('#'+id).outerHeight())/2 + $(document).scrollTop()
		});	
	}	
}

function toWinCenter2(id) {
	var obj = document.getElementById(id);
	// window.screen.availHeight
	// document.body.offsetHeight
	//var top = document.body.scrollTop + (window.innerHeight || document.body.offsetHeight) / 2 - obj.offsetHeight / 2;
	//var left = (window.innerWidth || document.body.offsetWidth) / 2 - obj.offsetWidth / 2;
	obj.style["left"] = "100px";
	obj.style["top"] = "0px";
}