// 8小时的Cookie
// 已用键值 d i
var spCo = new HttpCookie("sc");
spCo.setExpires(7200);
spCo.save();

// 一星期的Cookie
// 已用键值 m
var wCo = new HttpCookie("wc");
wCo.setExpires(604800);
wCo.save();

/**
 * 页面显示隐藏查询条件(需HttpCookie插件)
 * 
 * @param condition_selector
 *            需要隐藏的区域selector
 * @param checkbox_id
 *            执行隐藏显示的checkboxid
 */
function conCookie(condition_selector, checkbox_id){
	if ($(condition_selector + " #" + checkbox_id).length == 0) { return; }
	if (spCo.isExisted() && spCo.values.getValues("d") == "h") { // d:dispaly h:hide b:block
		$("#" + checkbox_id).removeAttr("checked");
	} else {
		$("#" + checkbox_id).attr("checked", "checked");
	}
	var toggleCondition = function(){
		$(condition_selector).each(function(i){
			var $this = $(this);
			var hv = false;
			$this.find(":input").each(function(){
				if ($(this).attr("type") == "checkbox") {
					if ($(this).is(":checked")) {
						hv = true;
						return false;
					}
				} else if ($(this).attr("type") != "hidden" && $(this).val() != '') {
					hv = true;
					return false;
				}
			});
			if ($("#" + checkbox_id).is(":checked")) $this.fadeIn();
			else if (!hv) $this.hide();
		});
	};
	toggleCondition();
	$("#" + checkbox_id).on("click", function(){
		if ($(this).is(":checked")) spCo.values.set("d", "b");
		else spCo.values.set("d", "h");
		spCo.save();
		toggleCondition();
	});
}
/* 页面显示隐藏查询条件结束 */

/* 记录左侧菜单打开或关闭的状态开始 */
function leftMenuCookie(){
	$(".prvg-module>p").mouseup(function(){
		var $module = $(this).parent(".prvg-module");
		var tid = $module.attr("id");
		if ($module.hasClass("active")) {// true 是打开 -> 关闭 状态
			if (spCo.isExisted()) {
				for (var i = 0, tids = spCo.values.getValues("i"), n = tids.length; i < n; i++) {
					if (tid == tids[i]) {
						tids.splice(i, 1);
						break;
					}
				}
			}
		} else {// false 是关闭 -> 打开状态
			if (!spCo.isExisted() || (spCo.isExisted() && (spCo.values.get("i") == null || spCo.values.get("i").indexOf(tid) == -1))) {
				spCo.values.add("i", tid);
			}
		}
		spCo.save();
	});
	// 一级菜单show/hide事件 flag=ture->展开 false->收缩
	var MenuCollapsed = function(id, flag){
		if (flag) {
			$("#" + id).addClass('active');
		} else {
			$("#" + id).removeClass('active');
		}
	};
	if (spCo.isExisted()) {
		var tidxs = spCo.values.getValues("i");
		if (tidxs != null) for (var i = 0, tidxs = spCo.values.getValues("i"), n = tidxs.length; i < n; i++) {
			if (tidxs[i] != '') MenuCollapsed(tidxs[i], true);
		}
	}
}
/* 记录左侧菜单打开或关闭的状态结束 */

/* 默认打开模块开始 */
function moduleCookie(module_no){
	// 如果没有参数或者参数小于0,则直接返回当前的module_no
	if (typeof (module_no) == "undefined" || module_no < 0) {
		// alert("mValue:" + wCo.values.getValues("m"));
		if (wCo.isExisted() && !(wCo == null || typeof (wCo.values) == 'undefined' || typeof (wCo.values.getValues("m")) == 'undefined' || wCo.values.getValues("m") == null)) {
			return wCo.values.getValues("m");
		} else {
			wCo.values.set("m", module_no + "");
			wCo.save();
			return "0";
		};
	} else {// 设定新的module_no
		wCo.values.set("m", module_no + ""); // 设定的值不能是数字,所以要转换成字符串
		wCo.save();
		return module_no;
	}
}

/* 默认打开模块关闭 */

/* Cookie测试函数 */
function showCookie(coo){
	var keys = coo.values.allKeys();
	for (var i = 0, j = keys.length; i < j; i++) {
		alert("key=" + keys[i] + "; value=" + coo.values.get(keys[i]));
	}
}