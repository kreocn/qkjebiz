/**
 * 需要jquery1.8以上支持
 */
var CommonUtil = {
	// 选择tr就选中tr中的checkbox
	pickrow : function(table_id){
		$("#" + table_id + " tr[type='pickrow']").bind({ click : function(){
			var checkboxObj = $($(this).find(":checkbox").get(0));
			if (checkboxObj.length > 0) {
				if (checkboxObj.is(":checked")) {
					$(this).css("background-color", "");
					checkboxObj.removeAttr("checked");
				} else {
					$(this).css("background-color", "#CFD3FE");
					checkboxObj.attr("checked", "checked");
				}
			}
		},
		mouseenter : function(){
			$(this).addClass("focusStyle");
		},
		mouseleave : function(){
			$(this).removeClass("focusStyle");
		} });

		$("#" + table_id + " tr[type='pickrow']").find(":checkbox").bind("click", function(){
			if ($(this).is(":checked")) {
				$(this).removeAttr("checked");
			} else {
				$(this).attr("checked", "checked");
			}
		});
	},
	// 全选/取消全选的简单实现
	pickrowAll : function(table_id, sCheckboxName){
		$("#" + table_id + " :checkbox[name='" + sCheckboxName + "']").click(function(){
			$("#" + table_id + " tr[type='pickrow']").click();
		});
	},
	// 全选CheckBox
	checkAll : function(con_id, sCheckboxName){
		$("#" + con_id + " :checkbox[name='" + sCheckboxName + "']").attr("checked", "checked");
	},
	// 取消选择CheckBox
	uncheckAll : function(con_id, sCheckboxName){
		$("#" + con_id + " :checkbox[name='" + sCheckboxName + "']").removeAttr("checked");
	},
	// 格式化JSON字符串 mode为空或者0(yyyy-MM-dd HH:mm:ss),1(yyyy-MM-dd)
	formatJSONDate : function(d, mode){
		mode = mode || 0;
		if (d && typeof d == "object") return (d.year + 1900) + "-" + CommonUtil.pad(d.month + 1, 2) + "-" + CommonUtil.pad(d.date, 2) + (mode == 0 ? " " + CommonUtil
				.pad(d.hours, 2) + ":" + CommonUtil.pad(d.minutes, 2) + ":" + CommonUtil.pad(d.seconds, 2) : "");
		else return "";
	},// 数字前面补0
	pad : function(num, n){
		var len = num.toString().length;
		while (len < n) {
			num = "0" + num;
			len++;
		}
		return num;
	},
	/**
	 * 获取url中,参数名为name的param字符串
	 * 
	 * @param mode方式
	 *            0/无:只获得参数值,1:获得整个参数字符串 比如aa=aaa&bb=bbb,getUrlParamStr('bb') mode=0或mode不存在 则返回bbb;mode=1则返回bb=bbb
	 */
	getUrlParam : function(url, name, mode){
		if (url.indexOf("?") > -1) {
			// 提取search字符串
			var urlsearch = url.substr(url.indexOf("?") + 1);
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
			var r = urlsearch.match(reg);
			if (r != null) {
				if (mode == 1) return name + "=" + unescape(r[2]);
				else return unescape(r[2]);
			}
		}
		return null;
	},
	// clear Url last indexOf #? 去除Url最后的 #和?
	clearUrl : function(p_url){
		var url = p_url;
		if (url.indexOf("#") != -1) {
			url = url.substring(0, url.indexOf("#"));
		}
		while (url.lastIndexOf("?") == url.length - 1) {
			url = url.substring(0, url.length - 1);
		}
		return url;
	},
	// url增加参数
	urlAddParam : function(url, param_name, param_value){
		url = CommonUtil.clearUrl(url);
		var p = "&";
		if (url.indexOf("?") == -1) {
			p = "?";
		}
		return url + p + param_name + '=' + param_value;
	},
	// 打开普通打印页面(替换/新增页面参数 viewFlag=print)
	printPage : function(t){
		var time = t || 1000;
		var curl = clearUrl(window.location.toString());
		var viewFlagStr = CommonUtil.getUrlParam(curl, "viewFlag", 1);
		var to_url;
		if (viewFlagStr == null) {
			to_url = CommonUtil.urlAddParam(curl, "viewFlag", "print");
		} else {
			to_url = curl.replace(viewFlagStr, "viewFlag=print");
		}
		var w = window.open();
		setTimeout(function(){
			w.location = to_url;
		}, time);
	},
	// 打开普通打印页面(替换/新增页面参数 printFlag=true)
	printPage2 : function(t){
		var time = t || 1000;
		var curl = clearUrl(window.location.toString());
		var viewFlagStr = CommonUtil.getUrlParam(curl, "printFlag", 1);
		var to_url;
		if (viewFlagStr == null) {
			to_url = CommonUtil.urlAddParam(curl, "printFlag", "true");
		} else {
			to_url = curl.replace(viewFlagStr, "printFlag=true");
		}
		var w = window.open();
		setTimeout(function(){
			w.location = to_url;
		}, time);
	},
	/**
	 * 专门为IPAD实现滚动功能
	 * 
	 * @param iframeID
	 *            iframe的id或者iframeElement[Doc Object]
	 * @param iframeWrapper
	 *            用于包装iframe的元素
	 */
	scrollIframeForIOS : function(iframe, iframeWrapper){
		if (!navigator.userAgent.match(/iPad|iPhone/i)) { return false; }
		var touchY = 0, touchX = 0;
		iframe = typeof (iframe) == "string" ? document.getElementById(iframe) : iframe;
		iframe.onload = function(){
			var ifrWin = iframe.contentWindow, ifrDoc = ifrWin.document;
			// iframe的上一级节点
			iframeWrapper = iframeWrapper || ifrWin.frameElement.parentNode;
			// 记录手指按下的位置
			ifrDoc.body.addEventListener("touchstart", function(event){
				touchX = event.targetTouches[0].pageX;
				touchY = event.targetTouches[0].pageY;
			});
			ifrDoc.body.addEventListener("touchmove", function(event){
				event.preventDefault();
				iframeWrapper.scrollLeft += (touchX - event.targetTouches[0].pageX);
				iframeWrapper.scrollTop += (touchY - event.targetTouches[0].pageY);
			});
		};
		return true;
	},
	// 判断函数,window.confirm
	isOp : function(msg){
		return window.confirm(msg);
	},
	// 框架iframe内的链接,需要在主窗口打开的
	topwinLink : function(url){
		var win = window.top ? window.top : window;
		win.location.href = url;
	},
	// 替代jQuery.is(":visible"),效率至少提高10倍
	isVisible : function(element){
		var rect = element[0].getBoundingClientRect();
		return !!(rect.bottom - rect.top);
	},
	// 快速查询,把inputID赋值value,然后提交表单
	quickSearch : function(inputID, value, formID){
		formID = formID || "form_serach";
		$("#" + inputID).val(value);
		$("#" + formID).submit();
	},
	// 转换HTML操作
	htmlOn : function(str){
		var a = [], i = 0;
		for (; i < str.length;)
			a[i] = str.charCodeAt(i++);
		return "&#" + a.join(";&#") + ";";
	},
	htmlUn : function(str){
		return str.replace(/&#(x)?([^&]{1,5});?/g, function(a, b, c){
			return String.fromCharCode(parseInt(c, b ? 16 : 10));
		});
	},
	/**
	 * 转换textarea文本,解决直接显示textarea的换行问题
	 * 
	 * @param oid
	 *            textarea的id或者包含内容的标签id
	 * @param tag
	 *            用什么标签包含段落,如空,则直接用br来换行
	 */
	rtextarea : function(p_id, p_tag){
		var dd = $("#" + p_id).val() || $("#" + p_id).text();
		var tag = p_tag || "";
		if (tag != "") {
			dd = "<" + tag + ">" + dd;
			dd = dd.replace(/\n/g, "</" + tag + ">" + "<" + tag + ">");
			dd = dd.replace(/ /g, "&nbsp;");
			dd += "</" + tag + ">";
		} else {
			dd = dd.replace(/\n/g, "<br>");
			dd = dd.replace(/ /g, "&nbsp;");
		}
		return dd;
	},
	// 半角转换为全角
	todbc : function(str){
		var tmp = "";
		for (var i = 0; i < str.length; i++) {
			if (str.charCodeAt(i) == 32) {
				tmp = tmp + String.fromCharCode(12288);
			}
			if (str.charCodeAt(i) < 127) {
				tmp = tmp + String.fromCharCode(str.charCodeAt(i) + 65248);
			}
		}
		return tmp;
	},
	// 全角转换为半角函
	tocdb : function(str){
		var tmp = "";
		for (var i = 0; i < str.length; i++) {
			if (str.charCodeAt(i) > 65248 && str.charCodeAt(i) < 65375) {
				tmp += String.fromCharCode(str.charCodeAt(i) - 65248);
			} else {
				tmp += String.fromCharCode(str.charCodeAt(i));
			}
		}
		return tmp;
	}
// undifined
};

var _cmu = CommonUtil;
var $cu = CommonUtil;
