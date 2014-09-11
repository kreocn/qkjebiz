// JavaScript Document
$(document).ready(function(){
	// 点击tr 选中tr
	$(".tab_warp tr").click(function(){
		$(this).toggleClass("trbg");
		if ($(this).hasClass("trbg")) {
			$(this).find("[type='checkbox']").attr("checked", true);
		} else {
			$(this).find("[type='checkbox']").attr("checked", false);
		}
	});
	// table隔行变色and鼠标经过样式
	$(".tab_warp tr:even").addClass("even");
	$(".tab_warp tr:odd").addClass("odd");
	$(".tab_warp tr").mouseover(function(){
		$(this).addClass("trhover");
	}).mouseout(function(){
		$(this).removeClass("trhover");
	});
	// 查看详情
	$(".detail").click(function(){
		var t = $(this).index('.detail');
		var le = $('tr:eq(0)').children().length;
		var str = '';
		for (var i = 0; i < le - 2; i++) {
			var n = i + 1;
			var th = $('tr:eq(0) th:eq(' + n + ')').text();
			var m = t + 1;
			if (i == le - 3) {
				var td = $('tr:eq(' + m + ') td:eq(' + n + ')').html();
			} else {
				var td = $('tr:eq(' + m + ') td:eq(' + n + ')').text();
			}
			str += '<tr><td align="right" width="40%"><b>' + th + '：</b></td><td width="60%">' + td + '</td></tr>';
		}
		document.getElementById('innertabel').innerHTML = str;
	});
});

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
		// alert(pageTouch.sPageX + "," +pageTouch.sPageY);
		touchStartEvent();
	});

	document.body.addEventListener('touchmove', function(e){
		var th = e.touches[0];
		// pageTouch.mPageX = th.pageX;
		// pageTouch.mPageY = th.pageY;
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
		//alert(pageTouch.ePageX + "," + pageTouch.ePageY);
		//$("#message").html($("#message").html() + pageTouch.ePageX + "," + pageTouch.ePageY + "<br />");
		if (pageTouch.touchPosition != "") touchMoveEvent();
	});

	document.body.addEventListener('touchend', function(e){
		pageTouch.ePageX = e.changedTouches[0].pageX;
		pageTouch.ePageY = e.changedTouches[0].pageY;
		// alert((sPageX - ePageX) + "," + (sPageY - ePageY));
		// alert((pageTouch.sPageX - pageTouch.ePageX) + "," + (pageTouch.sPageY - pageTouch.ePageY) + ":" + pageTouch.touchPosition);
	});
});

function touchStartEvent(){
	window.top.menuHide();
}

function touchMoveEvent(){
	if(pageTouch.touchPosition == "right") {
		window.top.menuShow();
	}
}