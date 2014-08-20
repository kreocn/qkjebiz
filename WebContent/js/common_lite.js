/**
 * common.js的简化版 为以后jQuery代入做准备
 */

function isDel(tx) {
	var txx = tx || "是否真的要删除记录?";
	return window.confirm(txx);
}

var toHTML = { on : function(str) {
	var a = [], i = 0;
	for (; i < str.length;)
		a[i] = str.charCodeAt(i++);
	return "&#" + a.join(";&#") + ";";
}, un : function(str) {
	return str.replace(/&#(x)?([^&]{1,5});?/g, function(a, b, c) {
		return String.fromCharCode(parseInt(c, b ? 16 : 10));
	});
} };

// to Unicode only
var toUN = { on : function(str) {
	var a = [], i = 0;
	for (; i < str.length;)
		a[i] = ("00" + str.charCodeAt(i++).toString(16)).slice(-4);
	return "\\u" + a.join("\\u");
}, un : function(str) {
	return unescape(str.replace(/\\/g, "%"));
} };

/**
 * 带原来get参数的跳转
 */
function linkurl(url) {
	window.location.href = url;
}

/**
 * 无参数跳转,去除所有请求信息的跳转
 * 
 * @param url
 * @return
 */
function linkurl2(url) {
	window.location.href = clearUrl2(url);
}

function linkurl3(url, target) {
	window.open(url, target);
}

/**
 * clear Url last indexOf #? 去除Url最后的 #和?
 * 
 * @return
 */
function clearUrl(urls) {
	var url = urls;
	if (url.indexOf("#") != -1) {
		url = url.substring(0, url.indexOf("#"));
	}
	while (url.lastIndexOf("?") == url.length - 1) {
		url = url.substring(0, url.length - 1);
	}
	return url;
}