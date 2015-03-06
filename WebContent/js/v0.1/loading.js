$(document).ready(function(){
	// table隔行变色and鼠标经过样式
	table_move_init();
	// 生成左侧菜单
	getMenus();
	// 初始化日期
	$(".datepicker").datepicker();
	// 添加基本样式
	$(".main,.idialog,.tab_right>.tab_warp").addClass("input-a");
	/* 查看详情专用 */
	$("#infoDetail").dialog({ autoOpen : false,
	modal : true });
	/* 表单验证专用 */
	$(".validForm").validationEngine({ promptPosition : "bottomRight" });
	$(".validFormDialog").validationEngine({ promptPosition : "bottomLeft" }); // dialog的特殊性导致只能显示在表单下部
	/* 表单提示专用 */
	$(".inputNote").inputNote();
	/* 生成编辑框 */
	createHtmlEditor(".xheditorArea");
	/* 设置"更多条件" */
	conCookie("#serachForm .label_hang", "search_mcondition");
	/* textArea 换行 */
	$(".textBreak").textBreak();
	/* 鼠标触摸事件 */
	MyTouchEvent();
});

/* 获取触摸事件代码开始 */
var pageTouch = { sPageX : 0,
sPageY : 0,
mPageX : 0,
mPageY : 0,
ePageX : 0,
ePageY : 0,
touchPosition : "" };

var MyTouchEvent = function(){
	var movedistance = 60;
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
	});

	document.body.addEventListener('touchend', function(e){
		// var th = e.touches[0];
		pageTouch.ePageX = e.changedTouches[0].pageX;
		pageTouch.ePageY = e.changedTouches[0].pageY;
		// 判断位移,只要大于50,便确定移动
		if (Math.abs(pageTouch.sPageX - pageTouch.ePageX) >= Math.abs(pageTouch.sPageY - pageTouch.ePageY)) {// X的位移大于Y,说明是横向移动
			if ((pageTouch.sPageX - pageTouch.ePageX) > movedistance) {
				pageTouch.touchPosition = "left";
			} else if ((pageTouch.sPageX - pageTouch.ePageX) < (0 - movedistance)) {
				pageTouch.touchPosition = "right";
			} else {
				pageTouch.touchPosition = "";
			}
		} else {
			if ((pageTouch.sPageY - pageTouch.ePageY) > movedistance) {
				pageTouch.touchPosition = "up";
			} else if ((pageTouch.sPageY - pageTouch.ePageY) < (0 - movedistance)) {
				pageTouch.touchPosition = "down";
			} else {
				pageTouch.touchPosition = "";
			}
		}
		if (pageTouch.touchPosition != "") touchMoveEvent();
	});
};

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
	var ths = $("#coltr th");
	var $s = $("#" + trid);
	// showtr123
	var uid = trid.substr(6);
	var d_id = "detailtr" + uid;
	// alert(trid.substr(6));
	if ($("#" + d_id).length == 0) {
		var _h = '<tr id="' + d_id + '" class="detailtr"><td colspan="20" class="idialog"><div class="label_main op-area detail-content">';
		$s.find("td").each(function(i, n){
			if (i == ths.length - 1) { return; }
			if (!$(this).hasClass("nsd")) {
				// var cc = "label_rwben";
				// if ($(this).hasClass("longnote") || $(this).hasClass("op-area")) {
				// cc = "label_rwbenx";
				// }
				_h += '<div class="label_hang">';
				_h += '<div class="label_ltit">' + ths[i].innerHTML + ':</div>';
				// _h += '<div class="' + cc + '">' + n.innerHTML + '</div>';
				_h += '<div class="label_rwbenx">' + n.innerHTML + '</div>';
				_h += '</div>';
			}
		});
		_h += '</div>	</td></tr>';
		$s.after(_h);
	}
	var $d = $("#" + d_id);
	if (!$cu.isVisible($d)) {
		$d.siblings(".detailtr").hide();
		$d.slideDown();
	} else {
		$d.hide();
	}
}
/* 查看详情专用函数结束 */
/* 判断移动平台 */
var navType = function(){
	if (/android/i.test(navigator.userAgent)) {
		// todo : android
		return "android";
	} else if (/ipad|iphone|mac/i.test(navigator.userAgent)) {
		// todo : ios
		return "ios";
	} else {
		return "pc";
	}
};
/* 顶部导航菜单事件 */
function top_change(){
	$b = $(".ht_sjsub");
	if ($b.hasClass("subHide")) {
		$b.removeClass("subHide");
	} else {
		$b.addClass("subHide");
	};
}
/* 顶部导航菜单事件 */
function left_change(){
	$lbar = $(".ht_left");
	if ($lbar.hasClass("subHide")) {
		$lbar.removeClass("subHide");
	} else {
		$lbar.removeClass("bounceInLeft animated").addClass("subHide");
	};
}

// 顶部导航初始化
var top_nav_init = function(){
	// 手机右侧导航事件
	top_change();
	$(".ht_clicka").on({ "click" : function(){
		top_change();
		return false;
	} });
	$(document).on({ "click" : function(e){
		var src = e.target;
		if (src.id && src.id === "b") {
			return false;
		} else {
			$b.addClass("subHide");
		}
	} });
	$(".ht_sjsub a").click(function(){
		$(".ht_sjsub a").removeClass("sjhv");
		$(this).addClass("sjhv");
	});
};

// 左侧导航初始化
var left_nav_init = function(){
	// 左侧菜单---出子菜单
	var mli = $(".ht_lnav li>p");
	mli.each(function(i){
		$(this).click(function(){
			$(this).parent().toggleClass("active");
		});
	});
	// 屏幕缩小，左侧点击事件
	left_change();
	$(".ht_lmenu").click(function(){
		left_change();
		$(".ht_left").addClass("bounceInLeft animated");
	});
	$(".ht_rhide").click(function(){
		$lbar = $(".ht_left");
		if ($lbar.css("display") == "block") {
			$lbar.removeClass("bounceInLeft animated").addClass("subHide");
		}
	});
	//屏幕缩小，点击空白地方，左侧菜单消失
	$(".tab_right").on({"click":function(){
			if($lbar.css("display")=="block"){
				$lbar.addClass("subHide");
			}
		}
	});
};

/* top首页加载的模块函数 */
var module_toggle = function(module_no){
	if (typeof (module_no) == "undefined" || module_no < 0) {
		$(".prvg-module").show();
	} else if (module_no == 99) {
		moduleCookie(module_no);
		$(".prvg-module").show();
	} else {
		moduleCookie(module_no);
		$(".prvg-module").hide();
		$(".prvg-module-" + module_no).show();
	}
};

var table_move_init = function(){
	// table隔行变色and鼠标经过样式
	$(".tab_warp tr:even").addClass("even");
	$(".tab_warp tr:odd").addClass("odd");
	$(".tab_warp tr").mouseover(function(){
		$(this).addClass("trhover");
	}).mouseout(function(){
		$(this).removeClass("trhover");
	});
};

function mLink(url){
	if ("javascript" == url.substr(0, 10)) {
		return false;
	} else {
		location.href = app_path + url;
	}
}

var getMenus = function(){
	if ($("#ht_left_menu").length > 0) {
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url;
		ajax.addParameter("work", "GetMenus");
		// ajax.addParameter("parameters", "product_type=" + nodeId);
		ajax.config._success = function(data, textStatus){
			createMenu(data);
		};
		ajax.sendAjax();
	}
};

var createMenu = function(prvgs){
	var _m = $("#ht_left_menu");
	var _m_str = '<ul class="ht_lnav">';
	// _m_str += '<li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>';
	// 开始循环
	$.each(prvgs, function(i, p1){
		// 找出一级菜单
		if (p1['parent_privilege'] == 0) {
			_m_str += '<li  id="M' + p1['uuid'] + '" class="prvg-module prvg-module-' + p1['module'] + '"><p><a href="javascript:;">' + p1['privilege_name'] + '</a></p>';
			// 找出二级菜单 remove ui-collapsible-content-collapsed
			_m_str += '<dl class="ht_sbar">';
			$.each(prvgs, function(j, p2){
				if (p1['privilege_id'] == p2['parent_privilege']) {
					_m_str += '<dd><a href="javascript:;" onClick="mLink(\'' + p2['menu_url'] + '\')">' + p2['privilege_name'] + '</a></dd>';
				}
			});
			_m_str += "</dl>";
			_m_str += "</li>";
		}
	});
	_m_str += "</ul>";
	_m.append(_m_str);
	// 顶部导航初始化
	top_nav_init();
	// 左侧导航初始化
	left_nav_init();
	// 初始化左侧菜单显示显示模块信息
	module_toggle(moduleCookie());
	// Cookie记录打开关闭状态
	leftMenuCookie();
};

var printPagination = function(did, currPage, recCount, pageSize){
	if ($("#" + did).length > 0) {
		var p = new ShowPage(currPage);
		$("#" + did).html(p.show_html(recCount, pageSize, 2));
	}
};