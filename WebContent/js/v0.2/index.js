$(document).on("pagecreate", ".jqm-demos", function(event){
	var page = $(this);
	$(".jqm-navmenu-panel ul").listview();
	$(".jqm-navmenu-link").on("click", function(){
		page.find(".jqm-navmenu-panel:not(.jqm-panel-page-nav)").panel("open");
	});
	// table隔行变色and鼠标经过样式
	$(".tab_warp tr:even").addClass("even");
	$(".tab_warp tr:odd").addClass("odd");
	$(".tab_warp tr").mouseover(function(){
		$(this).addClass("trhover");
	}).mouseout(function(){
		$(this).removeClass("trhover");
	});
	// 手机右侧导航事件
	$b = $(".ht_sjsub");
	$(".ht_clicka").on({ "click" : function(){
		$b.toggle();
		return false;
	} });
	$(document).on({ "click" : function(e){
		var src = e.target;
		if (src.id && src.id === "b") {
			return false;
		} else {
			$b.hide();
		}
	} });
});