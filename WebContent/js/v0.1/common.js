/**
 * common_lite.js和common_listtable.js结合版,适合在edit界面还有listtable的情况
 */

var toHTML = { on : function(str){
	var a = [], i = 0;
	for (; i < str.length;)
		a[i] = str.charCodeAt(i++);
	return "&#" + a.join(";&#") + ";";
},
un : function(str){
	return str.replace(/&#(x)?([^&]{1,5});?/g, function(a, b, c){
		return String.fromCharCode(parseInt(c, b ? 16 : 10));
	});
} };

// to Unicode only
var toUN = { on : function(str){
	var a = [], i = 0;
	for (; i < str.length;)
		a[i] = ("00" + str.charCodeAt(i++).toString(16)).slice(-4);
	return "\\u" + a.join("\\u");
},
un : function(str){
	return unescape(str.replace(/\\/g, "%"));
} };

/**
 * 带原来get参数的跳转
 */
function linkurl(url){
	window.location.href = url;
}

/**
 * 无参数跳转,去除所有请求信息的跳转
 * 
 * @param url
 * @return
 */
function linkurl2(url){
	window.location.href = clearUrl2(url);
}

function linkurl3(url, target){
	window.open(url, target);
}

/**
 * clear Url last indexOf #? 去除Url最后的 #和?
 * 
 * @return
 */
function clearUrl(urls){
	var url = urls;
	if (url.indexOf("#") != -1) {
		url = url.substring(0, url.indexOf("#"));
	}
	while (url.lastIndexOf("?") == url.length - 1) {
		url = url.substring(0, url.length - 1);
	}
	return url;
}

/**
 * 去除urls中所有的get请求信息
 * 
 * @param urls
 * @return
 */
function clearUrl2(urls){
	var url = urls;
	if (url.indexOf("#") != -1) {
		url = url.substring(0, url.indexOf("#"));
	}
	if (url.indexOf("?") != -1) {
		url = url.substring(0, url.indexOf("?"));
	}
	return url;
}

/**
 * 给URL加上一个get参数
 * 
 * @param url
 * @param param_name
 * @param param_value
 * @return
 */
function urlAddParam(url, param_name, param_value){
	url = clearUrl(url);
	var p = "&";
	if (url.indexOf("?") == -1) {
		p = "?";
	}
	return url + p + param_name + '=' + param_value;
}

/**
 * 打开打印页面(在原页面后增加viewFlag=print参数)
 */
var printPage = function(t){
	var time = t || 1000;
	var w = window.open();
	setTimeout(function(){
		w.location = urlAddParam(window.location.toString(), "viewFlag", "print");
	}, time);
	return false;
};

/**
 * 全选checkbox
 * 
 * @param objName
 *            checkbox name
 * @return
 */
function checkAll(objName){
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "";
	for (i = 0; i < objs.length; i++) {
		objs[i].checked = true;
	}
}

function checkAllInTable(table_id){
	var trs = $(table_id).getElementsByTagName("tr");
	for (var i = 0; i < trs.length; i++) {
		if (typeof trs[i].onclick == 'function') {
			if (trs[i].onclick.toString().indexOf("pickrow") != -1) {
				checkrow(trs[i]);
			}
		}
	}
}

/**
 * 
 */

/**
 * 取消选择checkbox
 * 
 * @param objName
 *            checkbox name
 * @return
 */
function uncheckAll(objName){
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "";
	for (i = 0; i < objs.length; i++) {
		objs[i].checked = false;
	}
}

/**
 * 反选checkbox
 * 
 * @param objName
 *            checkbox name
 * @return
 */
function oppositeAll(objName){
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "";
	for (i = 0; i < objs.length; i++) {
		objs[i].checked = !objs[i].checked;
	}
}

function oppositeAllInTable(table_id){
	var trs = $(table_id).getElementsByTagName("tr");
	for (var i = 0; i < trs.length; i++) {
		if (typeof trs[i].onclick == 'function') {
			if (trs[i].onclick.toString().indexOf("pickrow") != -1) {
				pickrow(trs[i]);
			}
		}
	}
}

/**
 * 反选对象内的checkbox,需要在内部所有checkbox中加入onclick="this.checked=!this.checked;"事件(是为了FF的兼容性,本来可以用event)
 * 
 * @param row
 * @return
 */
function pickrow(row){
	var x = row.getElementsByTagName("input");
	for (var j = 0; j < x.length; j++) {
		if (x[j].type = "checkbox") {
			x[j].checked = !x[j].checked;
			if (x[j].checked) {
				row.style.backgroundColor = "#D7D9FF"; // 设定反选时,当tr被选中时的背景色
			} else {
				row.style.backgroundColor = "";
			}
		}
	}
}

/**
 * 使用一个主checkbox控制所有的checkbox的选择和取消选择
 * 
 * @param obj
 *            主checkbox 对象
 * @param objName
 *            checkbox Name
 */
function pickCheck(obj, objName){
	if (obj.checked) {
		checkAll(objName);
	} else {
		uncheckAll(objName);
	}
}

/**
 * 选中对象内的checkbox,需要在内部所有checkbox中加入onclick="this.checked=!this.checked;"事件(是为了FF的兼容性,本来可以用event)
 * 
 * @param row
 * @return
 */
function checkrow(row){
	var x = row.getElementsByTagName("input");
	for (var j = 0; j < x.length; j++) {
		if (x[j].type = "checkbox") {
			x[j].checked = true;
			row.style.backgroundColor = "#D7D9FF"; // 当tr被选中时的背景色
		}
	}
}

function uncheckrow(row){
	var x = row.getElementsByTagName("input");
	for (var j = 0; j < x.length; j++) {
		if (x[j].type = "checkbox") {
			x[j].checked = false;
			row.style.backgroundColor = ""; // 当tr被选中时的背景色
		}
	}
}

/**
 * 设置table中< tr>的mouse事件(变色),需在css中定义oddStyle,evenStyle,focusStyle 3种样式,并且设置了oddStyle或evenStyle样式的才会起作用 <br />
 * 此脚本需在文件中加载,比如放在< /body>前
 * 
 * @param tabel_id
 * @return
 */
function setStyle(tabel_id){
	var trs = document.getElementById(tabel_id).getElementsByTagName("tr");
	for (var i = 0; i < trs.length; i++) {
		if (trs[i].className == "oddStyle") {
			trs[i].onmousemove = function(){
				this.className = "focusStyle";
			};
			trs[i].onmouseout = function(){
				this.className = "oddStyle";
			};
		}
		if (trs[i].className == "evenStyle") {
			trs[i].onmousemove = function(){
				this.className = "focusStyle";
			};
			trs[i].onmouseout = function(){
				this.className = "evenStyle";
			};
		}
	}
}

/**
 * forward到指定url,并用get方式带入checkbox的值
 * 
 * @param url
 *            指定url
 * @param checkbox_name
 *            checkbox name
 * @param param_str
 *            checkbox值的名称
 * @param is_permit_multiple
 *            是否允许checkbox多选(如多选,则值以','隔开)
 * @return
 */
function forward(url, checkbox_name, param_str, is_permit_multiple){
	url = clearUrl(url);
	if (url.indexOf('?') == -1) param_sep_str = "?";
	else param_sep_str = "&";
	var value = getCheckBox(checkbox_name);
	if (value[0] == 0) {
		alert("你没有选择任何记录!");
		return false;
	} else if (value[0] > 1 && !is_permit_multiple) {
		alert("此操作不允许多选记录!");
		return false;
	} else {
		location.href = url + param_sep_str + param_str + "=" + value[1];
		return true;
	}
}

/**
 * forward到指定url,并用get方式带入checkbox的值
 * 
 * @param url
 *            指定url
 * @param checkbox_name
 *            checkbox name
 * @param param_str
 *            checkbox值的名称
 * @param is_permit_multiple
 *            是否允许checkbox多选(如多选,则值以','隔开)
 * @return
 */
function forward_blank(url, checkbox_name, param_str, is_permit_multiple){
	url = clearUrl(url);
	if (url.indexOf('?') == -1) param_sep_str = "?";
	else param_sep_str = "&";
	var value = getCheckBox(checkbox_name);
	if (value[0] == 0) {
		alert("你没有选择任何记录!");
		return false;
	} else if (value[0] > 1 && !is_permit_multiple) {
		alert("此操作不允许多选记录!");
		return false;
	} else {
		window.open(url + param_sep_str + param_str + "=" + value[1]);
		return true;
	}
}

/**
 * @param objName
 *            checkbox name
 * @return Array(3):result[0]=被选中的数目 result[1]=被选中的值,用','隔开 result[2]=被选中的title用','隔开
 */
function getCheckBox(objName){
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "", title = "";
	for (i = 0; i < objs.length; i++) {
		if (objs[i].checked) {
			length++;
			keys += objs[i].value + ",";
			title += objs[i].title + ",";
		}
	}
	var result = new Array(3);
	result[0] = length;
	result[1] = keys.substring(0, keys.length - 1);
	result[2] = title.substring(0, title.length - 1);
	return result;
}

/**
 * 用valueList的值来选中checkbox
 * 
 * @param objName
 *            checkbox name
 * @param valueList
 *            用','隔开的值,只要符合就使得checkbox.checked=true;
 * @return
 */
function setCheckBox(objName, valueList){
	var objs = document.getElementsByName(objName);
	var values = valueList.split(",");
	for (i = 0; i < objs.length; i++) {
		for (var j = 0; j < values.length; j++) {
			if (objs[i].value == values[j]) {
				objs[i].checked = true;
				break;
			}
			// 如无符合,则原来选中的checkbox也要取消选择
			objs[i].checked = false;
		}
	}
}

/**
 * 得到Radio的值
 * 
 * @param objName
 *            Radio Name
 * @return str
 */
function getRadio(objName){
	var obj;
	obj = document.getElementsByName(objName);
	if (obj != null) {
		var i;
		for (i = 0; i < obj.length; i++) {
			if (obj[i].checked) { return obj[i].value; }
		}
	}
	return null;
}

/**
 * 用value的值来选中Radio(如有多个Radio值相同,则选中第一个)
 * 
 * @param objName
 *            Radio Name
 * @param value
 *            需选中的Radio值
 * @return
 */
function setRadio(objName, value){
	var obj;
	obj = document.getElementsByName(objName);
	if (obj != null) {
		var i;
		for (i = 0; i < obj.length; i++) {
			if (obj[i].value == value) {
				obj[i].checked = true;
				break;
			}
		}
	}
}

/**
 * 使用valueList把对应的CheckBox选中
 * 
 * @param objName
 * @param valueList
 * @return
 */
function setCheckBoxInTable(objName, valueList){
	var objs = document.getElementsByName(objName);
	var values = valueList.split(",");
	for (i = 0; i < objs.length; i++) {
		for (var j = 0; j < values.length; j++) {
			if (objs[i].value == values[j]) {
				checkrow(findFirstParent(objs[i], "TR"));
				break;
			}
			uncheckrow(findFirstParent(objs[i], "TR"));
		}
	}
}

/**
 * findForm 加强版,可以得到任何obj的第一个名为parentNoteName的parentNote,比如findFirstParent(obj,"TR");
 * 
 * @param obj
 * @param parentNoteName
 * @return
 */
function findFirstParent(obj, parentNoteName){
	_obj = obj.parentNode;
	p_parentNoteName = parentNoteName.toUpperCase();
	while (_obj.tagName.toUpperCase() != p_parentNoteName) {
		_obj = _obj.parentNode;
		if (_obj.tagName.toUpperCase() == "BODY") {
			_obj = null;
			break;
		}
	}
	return _obj;
}

function isDel(p_m){
	var m = p_m || "是否真的要删除记录?";
	return window.confirm(m);
}

function isOp(msg){
	return window.confirm(msg);
}

/**
 * 把JSON中附带的Date类型转成 yyyy-MM-dd HH:mm:ss 形式
 * 
 * @param d
 *            "JSON Date Format"
 * @return
 */
function formatDate(d){
	if (d && typeof d == "object") return (d.year + 1900) + "-" + (d.month + 1) + "-" + d.date + " " + d.hours + ":" + d.minutes + ":" + d.seconds;
	else return "&nbsp;";
}

/**
 * 格式化数字保留N为小数
 * 
 * @param src
 *            原始数据
 * @param pos
 *            保留位数
 * @return
 */
function formatFloat(src, pos){
	return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
}

/**
 * 把str中{}包含字符中的HTML转义字符转回HTML普通字符,比如 & quot;==>" 适用于返回的是对象(map或者bean)
 * 
 * @param str
 * @return
 */
function getCHTML(str){
	// str = "(" + str + ")";
	str = U2A_RegExp(str); // json版本更新后,中文变成unicode编码,所以需转换
	var start = str.indexOf("{");
	var end = str.lastIndexOf("}");
	str = str.substring(start, end + 1);
	str = str.replace(/&quot;/gm, "\""); // replaceAll效果,g代表全局,m代表多行
	str = str.replace(/&amp;/gm, "\&");
	str = str.replace(/&lt;/gm, "\<");
	str = str.replace(/&gt;/gm, "\>");
	return str;
}

/**
 * 适合list<string>
 * 
 * @param str
 * @return
 */
function getJson_list_CHTML(str){
	// str = "(" + str + ")";
	var start = str.indexOf("[");
	var end = str.lastIndexOf("]");
	str = str.substring(start, end + 1);
	str = str.replace(/&quot;/gm, "\""); // replaceAll效果,g代表全局,m代表多行
	str = str.replace(/&amp;/gm, "\&");
	str = str.replace(/&lt;/gm, "\<");
	str = str.replace(/&gt;/gm, "\>");
	return str;
}

/**
 * 返回从1970-1-1到现在的毫秒数
 * 
 * @return
 */
function getCurrentTimeMillis(){
	return (new Date()) - (new Date(0));
}

/**
 * 代替Jquery的:visible,效率高
 * 
 * @param element(jquery对象)
 * @returns {boolean}
 */
function isVisible(element){
	var rect = element[0].getBoundingClientRect();
	return !!(rect.bottom - rect.top);
}

/**
 * 测试函数,查看字段的属性值
 * 
 * @param obj
 * @param con_id
 */
function view(obj, con_id){
	var str = "";
	for ( var i in obj) {
		str += i + "\t";
	}
	$('#' + con_id).html(str);
}