var myLayout;
$(document).ready(function(){
	myLayout = $('body').layout({
	// reference only - these options are NOT required because 'true' is the default
	closable : true, // pane can open & close
	resizable : true, // when open, pane can be resized
	slidable : true, // when closed, pane can 'slide' open over other panes - closes on mouse-out
	livePaneResizing : true,
	maskContents : true, // IMPORTANT - enable iframe masking - all panes in this case
	// , onopen: loadIframePage // same callback for ALL borderPanes
	// north setting
	north__slidable : false, // 是否播放动画
	north__togglerLength_closed : '100%', // 当缩小时,可以点击的边框大小(100%表示全部可以点)
	north__spacing_closed : 0, // 当缩小时,可以点击的边框高度
	north__spacing_open : 0,// 初始点击框大小,0表示不能点击
	north__resizable : false,
	north__size : 45, // north默认高度
	north__initClosed : false, // 初始关闭
	north__initHidden : false, // 初始隐藏
	// south setting
	south__size : 24,
	south__initClosed : false,
	south__initHidden : false,
	south__resizable : false, // OVERRIDE the pane-default of 'resizable=true'
	south__spacing_open : 0, // no resizer-bar when open (zero height)
	south__spacing_closed : 10, // big resizer-bar when open (zero height)
	// west setting
	west__size : 180,
	west__initClosed : false,
	west__initHidden : false,
	west__minSize : 100,
	west__togglerLength_closed : '100%', // 当缩小时,可以点击的边框大小(100%表示全部可以点)
	west__spacing_closed : 10, // 当缩小时,可以点击的边框高度
	west__resizable : false,
	west__spacing_open : 0,
	// , west__showOverflowOnHover: true
	// east setting
	east__size : 0,
	east__initClosed : true,
	east__initHidden : true,
	// center setting
	center__minWidth : 100,
	stateManagement__enabled : true // 是否启用Cookie保存框架位置信息
	});

	loadDefaultPage();
	//CommonUtil.scrollIframeForIOS("mainFrame");

	$(".ui-layout-west").blur(function(){
	// menuHide();
	// alert("blur");
	});
});

function loadDefaultPage(){
	$("iframe").each(function(i){
		var $this = $(this);
		var src = $this.attr('src');
		var page = $this.attr('longdesc');
		if (page && src != page) $this.attr('src', page);
	});
}

function resetAllLayout(){
	myLayout.loadState({ north__size : 45,
	north__initClosed : false,
	north__initHidden : false,
	south__size : 24,
	south__initClosed : false,
	south__initHidden : false,
	west__size : 180,
	west__initClosed : false,
	west__initHidden : false,
	east__size : 0,
	east__initClosed : true,
	east__initHidden : true }, true);
}

function togglePane(pane){
	myLayout.toggle(pane);
}

function closePane(pane){
	myLayout.close(pane);
}

function openPane(pane){
	myLayout.open(pane);
}

function showPane(pane){
	myLayout.show(pane);
}

function hidePane(pane){
	myLayout.hide(pane);
}

function toggleWorkSpacePane(){
	togglePane("north");
	togglePane("west");
}

function autoToggle(w){
	if (w <= 960) {
		hidePane("west");
	} else {
		showPane("west");
	}
}

$(function(){
	$("#lMenuToggle").click(function(){
		toggleMenu();
	});
});

function toggleMenu(){
	if ($cu.isVisible($(".ui-layout-west"))) {
		menuHide();
	} else {
		menuShow();
	}
}

function menuShow(){
	if ($(top).width() <= 960) {
		if (!$cu.isVisible($(".ui-layout-west"))) {
			removeExClass();
			$(".ui-layout-west").addClass("ui-layout-pane-show bounceInLeft animated");
		}
	}
}

function menuHide(){
	// alert($(top).width());
	if ($(top).width() <= 960) {
		if ($cu.isVisible($(".ui-layout-west"))) {
			$(".ui-layout-west").addClass("ui-layout-pane-show");
			$(".ui-layout-west").addClass("bounceOutLeft animated");
			$(".ui-layout-west").fadeOut(500, function(){
				removeExClass();
			});
		}
	}
}

function removeExClass(){
	$(".ui-layout-west").removeClass("bounceInLeft bounceOutLeft animated ui-layout-pane-show ");
}
