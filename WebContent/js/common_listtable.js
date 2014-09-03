/**
 * 全选checkbox
 * 
 * @param objName
 *            checkbox name
 * @return
 */
function checkAll(objName) {
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "";
	for (i = 0; i < objs.length; i++) {
		objs[i].checked = true;
	}
}

function checkAllInTable(table_id) {
	var trs = $(table_id).getElementsByTagName("tr");
	for ( var i = 0; i < trs.length; i++) {
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
function uncheckAll(objName) {
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
function oppositeAll(objName) {
	var objs = document.getElementsByName(objName);
	var length = 0, keys = "";
	for (i = 0; i < objs.length; i++) {
		objs[i].checked = !objs[i].checked;
	}
}

function oppositeAllInTable(table_id) {
	var trs = $(table_id).getElementsByTagName("tr");
	for ( var i = 0; i < trs.length; i++) {
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
function pickrow(row) {
	var x = row.getElementsByTagName("input");
	for ( var j = 0; j < x.length; j++) {
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
 * @param obj 主checkbox 对象
 * @param objName checkbox Name
 */
function pickCheck(obj,objName) {
	if(obj.checked) {
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
function checkrow(row) {
	var x = row.getElementsByTagName("input");
	for ( var j = 0; j < x.length; j++) {
		if (x[j].type = "checkbox") {
			x[j].checked = true;
			row.style.backgroundColor = "#D7D9FF"; // 当tr被选中时的背景色
		}
	}
}

function uncheckrow(row) {
	var x = row.getElementsByTagName("input");
	for ( var j = 0; j < x.length; j++) {
		if (x[j].type = "checkbox") {
			x[j].checked = false;
			row.style.backgroundColor = ""; // 当tr被选中时的背景色
		}
	}
}

/**
 * 设置table中< tr>的mouse事件(变色),需在css中定义oddStyle,evenStyle,focusStyle
 * 3种样式,并且设置了oddStyle或evenStyle样式的才会起作用 <br />
 * 此脚本需在文件中加载,比如放在< /body>前
 * 
 * @param tabel_id
 * @return
 */
function setStyle(tabel_id) {
	var trs = document.getElementById(tabel_id).getElementsByTagName("tr");
	for ( var i = 0; i < trs.length; i++) {
		if (trs[i].className == "oddStyle") {
			trs[i].onmousemove = function() {
				this.className = "focusStyle";
			};
			trs[i].onmouseout = function() {
				this.className = "oddStyle";
			};
		}
		if (trs[i].className == "evenStyle") {
			trs[i].onmousemove = function() {
				this.className = "focusStyle";
			};
			trs[i].onmouseout = function() {
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
function forward(url, checkbox_name, param_str, is_permit_multiple) {
	url = clearUrl(url);
	if (url.indexOf('?') == -1)
		param_sep_str = "?";
	else
		param_sep_str = "&";
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
function forward_blank(url, checkbox_name, param_str, is_permit_multiple) {
	url = clearUrl(url);
	if (url.indexOf('?') == -1)
		param_sep_str = "?";
	else
		param_sep_str = "&";
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

function linkurl(url) {
	window.location.href = url;
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

/**
 * 
 * @param objName
 *            checkbox name
 * @return Array(3):result[0]=被选中的数目 result[1]=被选中的值,用','隔开
 *         result[2]=被选中的title用','隔开
 */
function getCheckBox(objName) {
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

function isDel(p_m) {
	var m = p_m || "是否真的要删除记录?";
	return window.confirm(m);
}
