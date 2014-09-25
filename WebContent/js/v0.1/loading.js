var ajax_url = "/common_ajax/json_ajax";
$(document).ready(function(){
	// table隔行变色and鼠标经过样式
	$(".tab_warp tr:even").addClass("even");
	$(".tab_warp tr:odd").addClass("odd");
	$(".tab_warp tr").mouseover(function(){
		$(this).addClass("trhover");
	}).mouseout(function(){
		$(this).removeClass("trhover");
	});
	// 初始化日期
	$(".datepicker").datepicker();
	$(".main,.idialog").addClass("input-a");
	/* 查看详情专用 */
	$("#infoDetail").dialog({ autoOpen : false,
	modal : true });
	/* 表单验证专用 */
	$(".validForm").validationEngine();
	$(".validFormDialog").validationEngine({ promptPosition : "bottomLeft" }); // dialog的特殊性导致只能显示在表单下部
	/* 表单提示专用 */
	$(".inputNote").inputNote();
	/* 生成编辑框 */
	createHtmlEditor(".xheditorArea");
	/* 设置"更多条件" */
	conCookie("#serachForm .label_hang", "search_mcondition");
	/* textArea 换行 */
	$(".textBreak").textBreak();
});

/* 获取触摸事件代码开始 */
var pageTouch = { sPageX : 0,
sPageY : 0,
mPageX : 0,
mPageY : 0,
ePageX : 0,
ePageY : 0,
touchPosition : "" };

$(document).ready(function(){
	document.body.addEventListener('touchstart', function(e){
		var th = e.touches[0];
		pageTouch.sPageX = th.pageX;
		pageTouch.sPageY = th.pageY;
		touchStartEvent();
	});

	document.body.addEventListener('touchmove', function(e){
		var th = e.touches[0];
		pageTouch.ePageX = th.pageX;
		pageTouch.ePageY = th.pageY;
		// 判断位移,只要大于50,便确定移动
		if (Math.abs(pageTouch.sPageX - pageTouch.ePageX) >= Math.abs(pageTouch.sPageY - pageTouch.ePageY)) {// X的位移大于Y,说明是横向移动
			if ((pageTouch.sPageX - pageTouch.ePageX) > 50) {
				pageTouch.touchPosition = "left";
			} else if ((pageTouch.sPageX - pageTouch.ePageX) < -50) {
				pageTouch.touchPosition = "right";
			} else {
				pageTouch.touchPosition = "";
			}
		} else {
			if ((pageTouch.sPageY - pageTouch.ePageY) > 50) {
				pageTouch.touchPosition = "up";
			} else if ((pageTouch.sPageY - pageTouch.ePageY) < -50) {
				pageTouch.touchPosition = "down";
			} else {
				pageTouch.touchPosition = "";
			}
		}
		if (pageTouch.touchPosition != "") touchMoveEvent();
	});

	document.body.addEventListener('touchend', function(e){
		pageTouch.ePageX = e.changedTouches[0].pageX;
		pageTouch.ePageY = e.changedTouches[0].pageY;
	});
});

function touchStartEvent(){
	window.top.menuHide();
}

function touchMoveEvent(){
	if (pageTouch.touchPosition == "right") {
		window.top.menuShow();
	}
}
/* 触摸事件代码结束 */
/* 全屏loading js控件开始 */
var _spinner = new Spinner();
function SpinStart(){
	if (_spinner) {
		_spinner.spin();
		document.body.appendChild(_spinner.el);
	}
}
function SpinStop(){
	if (_spinner) _spinner.stop();
}
/* 全屏loading js控件结束 */
/* 查看详情专用函数开始 */
function showDetail(trid){
	var _h = "";
	var ths = $("#coltr th");
	$("#" + trid + " td").each(function(i, n){
		if (i == ths.length - 1) { return; }
		var cc = "label_rwben";
		if ($(this).hasClass("longnote")) {
			cc = "";
		}
		_h += '<div class="label_hang">';
		_h += '<div class="label_ltit">' + ths[i].innerHTML + ':</div>';
		_h += '<div class="' + cc + '">' + n.innerHTML + '</div>';
		_h += '</div>';
	});

	$("#detailMain").empty().append(_h);
	$("#infoDetail").dialog("open");
}
/* 查看详情专用函数结束 */
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
	var spCo = new HttpCookie("sc");// Serach Condition
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